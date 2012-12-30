--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ]]

include("sb/classes/ResourceContainer.lua")

-- Lua Specific
local type      = type
local pairs     = pairs
local math      = math
-- Gmod specific
local Entity    = Entity
local CurTime   = CurTime
local net       = net
-- Class Specific
local C         = CLASS
local sb        = sb;
local core = sb.core

local funcRef = {
	isA = C.isA,
	init = C.init,
	supplyResource = C.supplyResource,
	consumeResource = C.consumeResource,
	getResourceAmount = C.getResourceAmount,
	getMaxResourceAmount = C.getMaxResourceAmount,
    sendContent = C._sendContent,
	receiveSignal = C.receive,
    onSave = C.onSave,
    onLoad = C.onLoad,
    applyDupeInfo = C.applyDupeInfo
}

function C:isA(className)
	return funcRef.isA(self, className) or className == "ResourceNetwork"
end


function C:init(entID)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceNetwork") end
	funcRef.init(self, entID)
	self.containers = {}
	self.networks = {}
	self.busy = false;
    self.containersmodified = CurTime()
    self.networksmodified = CurTime()
end

-- Are we already using this network (prevent loops when looking up)
function C:isBusy()
	return self.busy;
end


function C:supplyResource(name, amount)
	local to_much = funcRef.supplyResource(self, name, amount)
	if to_much > 0 then
		self.busy = true;
		for k, v in pairs(self.networks) do
			if not v:isBusy() then
				to_much = v:supplyResource(name, to_much)
			end
			if to_much == 0 then
				break;
			end
		end
		self.busy = false;
	end
	return to_much
end

function C:consumeResource(name, amount)
	local to_little = funcRef.consumeResource(self, name, amount)
	if to_little > 0 then
		self.busy = true;
		for k, v in pairs(self.networks) do
			if not v:isBusy() then
				to_little = v:consumeResource(name, to_little)
			end
			if to_little == 0 then
				break;
			end
		end
		self.busy = false;
	end
	return to_little
end

function C:getResourceAmount(name, visited)
	visited = visited or {}
	local amount, tmp = funcRef.getResourceAmount(self, name), nil;
	self.busy = true;
	for k, v in pairs(self.networks) do
		if not v:isBusy() and not visited[v:getID()] then
			tmp, visited = v:getResourceAmount(name, visited)
			amount = amount + tmp;
			visited[v:getID()] = v;
		end
	end
	self.busy = false;
	return amount, visited
end

function C:getMaxResourceAmount(name, visited)
	visited = visited or {}
	local amount, tmp = funcRef.getMaxResourceAmount(self, name), nil;
	self.busy = true;
	for k, v in pairs(self.networks) do
		if not v:isBusy() and not visited[v:getID()] then
			tmp, visited = v:getMaxResourceAmount(name, visited)
			amount = amount + tmp;
			visited[v:getID()] = v;
		end
	end
	self.busy = false;
	return amount, visited
end

function C:link(container, dont_link)
	if not self:canLink(container) then return end
	if container:isA("ResourceNetwork") then
        if self.networks[container:getID()] then return end
		self.networks[container:getID()] = container
        self.networksmodified = CurTime()
    else
        if self.containers[container:getID()] then return end
		self.containers[container:getID()] = container
		for k, v in pairs(container:getResources()) do
			self:addResource(k, v:getMaxAmount(), v:getAmount())
        end
        self.containersmodified = CurTime()
	end
	if not dont_link then
		container:link(self, true);
	end
	self.modified = CurTime()
end

function C:unlink(container, dont_unlink)
    if not container then
       for k, v in pairs(self.containers) do
          v:unlink(self, true)
       end
       for k, v in pairs(self.networks) do
          v:unlink(self, true)
       end
       self.networksmodified = CurTime()
       self.containersmodified = CurTime()
    else
        if not self:canLink(container) then return end
        if not dont_unlink then
            container:unlink(self, true);
        end
        if container:isA("ResourceNetwork") then
            if not self.networks[container:getID()] then return end
            self.networks[container:getID()] = nil
            self.networksmodified = CurTime()
        else
            if not self.containers[container:getID()] then return end
            self.containers[container:getID()] = nil
            local percent, amount = 0, 0
            for k, v in pairs(container:getResources()) do
                percent = v:getMaxAmount() / self:getMaxResourceAmount(k)
                amount = math.Round(self:getResourceAmount(k) * percent)
                container:supplyResource(k, amount)
                self:removeResource(k, v:getMaxAmount(), amount)
            end
            self.containersmodified = CurTime()
        end
    end
	self.modified = CurTime()
end

function C:canLink(container)
	return self ~= container and container.isA and (container:isA("ResourceNetwork") or (container:isA("ResourceEntity") and container:getNetwork() == nil ))
end

function C:_sendContent(modified)
    if self.containersmodified > modified then
        core.net.writeBool(true)
        core.net.writeShort(table.Count(self.containers))
        for k, _ in pairs(self.containers) do
           core.net.writeShort(k)
        end
    else
        core.net.writeBool(false)
    end
    if self.networksmodified > modified then
        core.net.writeBool(true)
        core.net.writeShort(table.Count(self.networks))
        for k, _ in pairs(self.networks) do
            core.net.writeShort(k)
        end
    else
        core.net.writeBool(false)
    end
    funcRef.sendContent(self, modified);
end

function C:receive()
    local hasContainerUpdate = core.net.readBool()
    if hasContainerUpdate then
        local nrofcontainers = core.net.readShort()
        self.containers = {}
        local am, id
        for am = 1, nrofcontainers do
            id = core.net.readShort()
            self.containers[id] = sb.getDeviceInfo(id)
        end
    end
    local hasNetworksUpdate = core.net.readBool()
    if hasNetworksUpdate then
        local nrofnetworks = core.net.readShort()
        self.networks = {}
        local am, id
        for am = 1, nrofnetworks do
            id = core.net.readShort()
            self.networks[id] = sb.getDeviceInfo(id)
        end
    end
	funcRef.receiveSignal(self)
end

-- Start Save/Load functions

function C:applyDupeInfo(data, newent, CreatedEntities)
    --funcRef.applyDupeInfo(self, data, newent, CreatedEntities) -- Don't restore resource info, this will happen by relinking below
    for k, v in pairs(data.networks) do
        self:link(sb.getDeviceInfo(CreatedEntities[k]:EntIndex()))
    end
    for k, v in pairs(data.containers) do
        self:link(sb.getDeviceInfo(CreatedEntities[k]:EntIndex()))
    end
end

function C:onLoad(data)
    funcRef.onLoad(self, data)
    local ent = self
    timer.Simple(0.1, function()
        for k, v in pairs(data.networks) do
          ent.networks[v] = sb.getDeviceInfo(k)
        end
        for k, v in pairs(data.containers) do
            ent.containers[v] = sb.getDeviceInfo(k)
        end
    end)
end

-- End Save/Load functions

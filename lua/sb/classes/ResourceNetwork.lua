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
	receiveSignal = C.receive

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
	if not container.isA or not container:isA("ResourceContainer") then error("We can only link ResourceContainer (and derivate) classes") end
	if container:isA("ResourceNetwork") then
		self.networks[container:getID()] = container
	else
		self.containers[container:getID()] = container
		for k, v in pairs(container:getResources()) do
			self:addResource(k, v:getMaxAmount(), v:getAmount())
		end
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
    else
        if not container.isA or not container:isA("ResourceContainer") then error("We can only unlink ResourceContainer (and derivate) classes") end
        if not dont_unlink then
            container:unlink(self, true);
        end
        if container:isA("ResourceNetwork") then
            self.networks[container:getID()] = nil
        else
            self.containers[container:getID()] = nil
            local percent, amount = 0, 0
            for k, v in pairs(container:getResources()) do
                percent = v:getMaxAmount() / self:getMaxResourceAmount(k)
                amount = math.Round(self:getResourceAmount(k) * percent)
                container:supplyResource(k, amount)
                self:removeResource(k, v:getMaxAmount(), amount)
            end
        end
    end
	self.modified = CurTime()
end

function C:canLink(container)
	return container.isA and (container:isA("ResourceNetwork") or container:isA("ResourceEntity"))
end

function C:_sendContent(modified)
    --TODO send link info (containers + networks)
    core.net.writeShort(table.Count(self.containers))
    for k, _ in pairs(self.containers) do
       core.net.writeShort(k)
    end
    core.net.writeShort(table.Count(self.networks))
    for k, _ in pairs(self.networks) do
        core.net.writeShort(k)
    end
    funcRef.sendContent(self, modified);
end

function C:receive()
    local nrofcontainers = core.net.readShort()
    self.containers = {}
    local am, id
    for am = 1, nrofcontainers do
        id = core.net.readShort()
        self.containers[id] = sb.getDeviceInfo(id)
    end
    local nrofnetworks = core.net.readShort()
    self.networks = {}
    for am = 1, nrofnetworks do
        id = core.net.readShort()
        self.networks[id] = sb.getDeviceInfo(id)
    end
	funcRef.receiveSignal(self)
end

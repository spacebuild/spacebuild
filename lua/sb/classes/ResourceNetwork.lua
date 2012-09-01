---
-- Project: SB Core
-- User: Stijn
-- Date: 17/09/11
-- Time: 16:39
-- License: http://creativecommons.org/licenses/by-sa/3.0/
---

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


local oldisA = C.isA
function C:isA(className)
	return oldisA(self, className) or className == "ResourceNetwork"
end

local oldinit = C.init
function C:init(entID)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceNetwork") end
	oldinit(self)
	self.containers = {}
	self.entID = entID
	self.networks = {}
	self.busy = false;
end

-- Are we already using this network (prevent loops when looking up)
function C:isBusy()
	return self.busy;
end

local oldsupplyResource = C.supplyResource;
function C:supplyResource(name, amount)
	local to_much = oldsupplyResource(self, name, amount)
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

local oldconsumeResource = C.consumeResource;
function C:consumeResource(name, amount)
	local to_little = oldconsumeResource(self, name, amount)
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

local oldgetResourceAmount = C.getResourceAmount;
function C:getResourceAmount(name, visited)
	visited = visited or {}
	local amount, tmp = oldgetResourceAmount(self, name), nil;
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

local oldgetMaxResourceAmount = C.getMaxResourceAmount;
function C:getMaxResourceAmount(name, visited)
	visited = visited or {}
	local amount, tmp = oldgetMaxResourceAmount(self, name), nil;
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
	self.modified = CurTime()
end

function C:canLink(container)
	return container.isA and container:isA("ResourceContainer")
end

function C:getEntity()
	return self.entID and Entity(self.entID);
end

local oldSend = C.send
function C:send(modified, ply, partial)
	if not partial then
		net.Start("SBRU")
		net.WriteString("ResourceNetwork")
		net.WriteShort(self.syncid)
		net.WriteShort(self.entID)
	end
	oldSend(self, modified, ply, true);
	-- Add specific class code here
	if not partial then
		if ply then
			net.Send(ply)
			--net.Broadcast()
		else
		    net.Broadcast()
		end
	end
end

local oldReceive = C.receive
function C:receive(um)
	self.entID = net.ReadShort()
	oldReceive(self, um)
end

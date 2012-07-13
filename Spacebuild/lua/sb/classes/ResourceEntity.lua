---
-- Project: SB Core
-- User: Stijn Vlaes
-- Date: 18/09/11
-- Time: 1:22
-- License: http://creativecommons.org/licenses/by-sa/3.0/
---

include("sb/classes/ResourceContainer.lua")

-- Lua Specific
local type  = type

-- Gmod specific
local Entity    = Entity
local CurTime   = CurTime
local net       = net

-- Class Specific
local C = CLASS
local sb = sb;

local oldisA = C.isA
function C:isA(className)
	return oldisA(self, className) or className == "ResourceEntity"
end

local oldinit = C.init
function C:init(entID)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceEntity") end
	oldinit(self)
	self.entID = entID
	self.network = nil
end

local oldaddResource = C.addResource;
function C:addResource(name, maxAmount, amount)
	oldaddResource(self, name, maxAmount, amount)
	if self.network then
		self.network:addResource(name, maxAmount, amount)
	end
end

local oldremoveResource = C.removeResource;
function C:removeResource(name, maxAmount, amount)
	oldremoveResource(self, name, maxAmount, amount)
	if self.network then
		self.network:removeResource(name, maxAmount, amount)
	end
end

local oldsupplyResource = C.supplyResource;
function C:supplyResource(name, amount)
	if self.network then
		return self.network:supplyResource(name, amount)
	end
	return oldsupplyResource(self, name, amount)
end

local oldconsumeResource = C.consumeResource;
function C:consumeResource(name, amount)
	if self.network then
		return self.network:consumeResource(name, amount)
	end
	return oldconsumeResource(self, name, amount)
end

local oldgetResourceAmount = C.getResourceAmount;
function C:getResourceAmount(name)
	if self.network then
		return self.network:getResourceAmount(name)
	end
	return oldgetResourceAmount(self, name);
end

local oldgetMaxResourceAmount = C.getMaxResourceAmount;
function C:getMaxResourceAmount(name, visited)
	if self.network then
		return self.network:getMaxResourceAmount(name, visited)
	end
	return oldgetMaxResourceAmount(self, name)
end

function C:link(container, dont_link)
	if not container.isA or not container:isA("ResourceContainer") then error("We can only link ResourceContainer (and derivate) classes") end
	if not container:isA("ResourceNetwork") then
		error("ResourceEntity: We only support links between entities and networks atm!")
	end
	self.network = container;
	if not dont_link then
		container:link(self, true);
	end
	self.modified = CurTime()
end

function C:unlink(container, dont_unlink)
	if not container.isA or not container:isA("ResourceContainer") then error("We can only unlink ResourceContainer (and derivate) classes") end
	if not container:isA("ResourceNetwork") then
		error("ResourceEntity: We only support links between entities and networks atm!")
	end
	self.network = nil
	if not dont_unlink then
		container:unlink(self, true);
	end
	self.modified = CurTime()
end

function C:canLink(container)
	return container.isA and container:isA("ResourceNetwork")
end

function C:getEntity()
	return self.entID and Entity(self.entID);
end

function C:getNetwork()
	return self.network
end

local oldSend = C.send
function C:send(modified, ply, partial)
	if not partial then
		net.Start("SBRU")
		net.WriteString("ResourceEntity")
		net.WriteShort(self.syncid)
		net.WriteShort(self.entID)
	end
	oldSend(self, modified, ply, true);
	-- Add specific class code here
	if not partial then
		if ply then
		    net.Send(ply )
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

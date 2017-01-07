-- Copyright 2016 SB Dev Team (http://github.com/spacebuild)
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.


include("resourcecontainer.lua")

local SB = SPACEBUILD
local log = SB.log

-- Lua Specific
local type = type

-- Gmod specific
local CurTime = CurTime
require("sbnet")
local net = sbnet

-- Class Specific
local C = CLASS

-- Function Refs
local funcRef = {
	isA = C.isA,
	init = C.init,
	addResource = C.addResource,
	removeResource = C.removeResource,
	supplyResource = C.supplyResource,
	consumeResource = C.consumeResource,
	getResourceAmount = C.getResourceAmount,
	getMaxResourceAmount = C.getMaxResourceAmount,
	sendContent = C._sendContent,
	receiveSignal = C.receive,
	onSave = C.onSave,
	onLoad = C.onLoad
}

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "ResourceEntity"
end

--- Constructor for this container class
-- @param entID The entity id we will be using for linking and syncing
-- @param resourceRegistry The resource registry which contains all resource data.
--
function C:init(entID, rdtype, resourceRegistry)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceEntity") end
	funcRef.init(self, entID, rdtype, resourceRegistry)
	self.network = nil
end

function C:removeBeams()
	if self.network then self.network:removeBeam(self:getID()) end
	self.beams = {}
	self.beamsmodified = CurTime()
end

function C:addResource(name, maxAmount, amount)
	local res = funcRef.addResource(self, name, maxAmount, amount)
	if self.network then
		self.network:addResource(name, maxAmount, amount)
	end
	return res
end

function C:removeResource(name, maxAmount, amount)
	funcRef.removeResource(self, name, maxAmount, amount)
	if self.network then
		self.network:removeResource(name, maxAmount, amount)
	end
end

--- Supply a certain amount of resources
-- @param name The resource to use
-- @param amount The amount to supply, must be a number > 0
-- @return the amount that wasn't able to be supplied to the network
--
function C:supplyResource(name, amount)
	if self.network then
		return self.network:supplyResource(name, amount)
	end
	return funcRef.supplyResource(self, name, amount)
end

--- Consume a certain amount of resources
-- @param name The resource to use
-- @param amount The amount to use, must be a number > 0
-- @return the amount that wasn't able to be used
--
function C:consumeResource(name, amount)
	if self.network then
		return self.network:consumeResource(name, amount)
	end
	return funcRef.consumeResource(self, name, amount)
end

--- Retrieve the resource amount this container or its network actually has of a specified resource
-- @param name The resource to check
-- @param visited a table of visited nodes, internal use!
--
function C:getResourceAmount(name)
	if self.network then
		return self.network:getResourceAmount(name)
	end
	return funcRef.getResourceAmount(self, name)
end

--- Retrieve the max resource amount this container or its network can hold of a specified resource
-- @param name The resource to check
-- @param visited a table of visited nodes, internal use!
--
function C:getMaxResourceAmount(name, visited)
	if self.network then
		return self.network:getMaxResourceAmount(name, visited)
	end
	return funcRef.getMaxResourceAmount(self, name)
end

--- Link a device to this network
-- @param container a resource device (container or network) or nil to disconnect all
-- @param dont_unlink don't call the other device's unlink method, prevents infinite loops, used internally!
--
function C:link(container, dont_link)
	if not self:canLink(container) then return end
	if not dont_link then
		container:link(self, true)
	end
	-- Link to the new
	self.network = container
	self.modified = CurTime()
end

--- Unlink a device (or all devices) from this container
-- @param container a resource device (container or network) or nil to disconnect all
-- @param dont_unlink don't call the other device's unlink method, prevents infinite loops, used internally!
--
function C:unlink(container, dont_unlink)
	if not self.network then return end -- no network, so no reason to unlink anything
	if not container then
		self.network:unlink(self, true)
	elseif self.network == container then
		self.network = nil
		if not dont_unlink then
			container:unlink(self, true)
		end
	end
	self.modified = CurTime()
end

--- Can the specified container connect to this container?
-- @param container an rd container/network
--
function C:canLink(container)
	return container ~= nil and self ~= container and self:getNetwork() == nil and container.isA and container:isA("ResourceNetwork")
end

--- Get the network connected to this device
-- @return a ResourceNetwork or nil
--
function C:getNetwork()
	return self.network
end

--- Sync function to send data from the client to the server, contains the specific data transfer
-- @param modified timestamp the client received information about this environment last
--
function C:_sendContent(modified)
	if self.network then
		net.writeShort(self.network:getID())
	else
		net.writeShort(0)
	end
	funcRef.sendContent(self, modified)
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	self.network = SB:getDeviceInfo(net.readShort())
	funcRef.receiveSignal(self)
end

-- Duplicator methods
if SERVER then
	local function buildInfo(ent, data)
		return {}
	end
	local function applyInfo(ent, createdEntities, data)

	end
	local function restoreInfo(ent, data)

	end
	timer.Simple(0.1, function() SB:registerDupeFunctions("rd/ResourceEntity", buildInfo, applyInfo, restoreInfo) end)
end

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

function C:init(entID, resourceRegistry)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceEntity") end
	funcRef.init(self, entID, resourceRegistry)
	self.network = nil
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

function C:supplyResource(name, amount)
	if self.network then
		return self.network:supplyResource(name, amount)
	end
	return funcRef.supplyResource(self, name, amount)
end

function C:consumeResource(name, amount)
	if self.network then
		return self.network:consumeResource(name, amount)
	end
	return funcRef.consumeResource(self, name, amount)
end

function C:getResourceAmount(name)
	if self.network then
		return self.network:getResourceAmount(name)
	end
	return funcRef.getResourceAmount(self, name)
end

function C:getMaxResourceAmount(name, visited)
	if self.network then
		return self.network:getMaxResourceAmount(name, visited)
	end
	return funcRef.getMaxResourceAmount(self, name)
end

function C:link(container, dont_link)
	if not self:canLink(container) then return end
	if not dont_link then
		container:link(self, true)
	end
	-- Link to the new
	self.network = container
	self.modified = CurTime()
end

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

function C:canLink(container)
	return container ~= nil and self ~= container and self:getNetwork() == nil and container.isA and container:isA("ResourceNetwork")
end

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
	self.network = self.resourceRegistry:getDeviceInfo(net.readShort())
	funcRef.receiveSignal(self)
end

-- Start Save/Load functions

function C:onLoad(data)
	funcRef.onLoad(self, data)
	local ent = self
	timer.Simple(0.1, function()
		ent.network = self.resourceRegistry:getDeviceInfo(data.network.syncid)
	end)
end

-- End Save/Load functions

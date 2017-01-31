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
-- Lua Specific
local type = type
local pairs = pairs
local math = math
-- Gmod specific
local Entity = Entity
local CurTime = CurTime
require("sbnet")
local net = sbnet
-- Class Specific
local C = CLASS

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
	applyDupeInfo = C.applyDupeInfo,
	consumeResourceByAttribute = C.consumeResourceByAttribute,
	getResourceAmountByAttribute = C.getResourceAmountByAttribute
}

--- General class function to check is this class is of a certain type
-- @param className [string] the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "ResourceNetwork"
end

--- Constructor for this network class
-- @param entID [number] The entity id we will be using for linking and syncing
-- @param resourceRegistry [ResourceRegistry] The resource registry which contains all resource data.
--
function C:init(entID, resourceRegistry)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceNetwork") end
	funcRef.init(self, entID, SB.RDTYPES.NETWORK, resourceRegistry)
	self.containers = {}
	self.networks = {}
	self.busy = false
	self.containersmodified = CurTime()
	self.networksmodified = CurTime()
end

function C:removeBeams()
	for k, v in pairs(self.containers) do
		v:removeBeam(self:getID())
	end
	for k, v in pairs(self.networks) do
		v:removeBeam(self:getID())
	end
	self.beams = {}
	self.beamsmodified = CurTime()
end

--- Are we already using this network (prevent loops when looking up), internal method!
-- @return boolean
function C:isBusy()
	return self.busy
end

--- Supply a certain amount of resources
-- @param name [String] The resource to use
-- @param amount [number] The amount to supply, must be a number > 0
-- @return [number] the amount that wasn't able to be supplied to the network
--
function C:supplyResource(name, amount)
	local to_much = funcRef.supplyResource(self, name, amount)
	if to_much > 0 then
		self.busy = true
		for k, v in pairs(self.networks) do
			if not v:isBusy() then
				to_much = v:supplyResource(name, to_much)
			end
			if to_much == 0 then
				break
			end
		end
		self.busy = false
	end
	return to_much
end

--- Consume a certain amount of resources
-- @param name [string] The resource to use
-- @param amount [number] The amount to use, must be a number > 0
-- @return [number] the amount that wasn't able to be used
--
function C:consumeResource(name, amount)
	local to_little = funcRef.consumeResource(self, name, amount)
	if to_little > 0 then
		self.busy = true
		for k, v in pairs(self.networks) do
			if not v:isBusy() then
				to_little = v:consumeResource(name, to_little)
			end
			if to_little == 0 then
				break
			end
		end
		self.busy = false
	end
	return to_little
end

--- Retrieve the resource amount this network actually has of a specified resource
-- @param name [string] The resource to check
-- @param visited [table:ResourceContainer] a table of visited nodes, internal use!
-- @return [number] the amount of this resource that is available
--
function C:getResourceAmount(name, visited)
	visited = visited or {}
	local amount, tmp = funcRef.getResourceAmount(self, name), nil
	self.busy = true
	for k, v in pairs(self.networks) do
		if not v:isBusy() and not visited[v:getID()] then
			tmp, visited = v:getResourceAmount(name, visited)
			amount = amount + tmp
			visited[v:getID()] = v
		end
	end
	self.busy = false
	return amount, visited
end

function C:consumeResourceByAttribute(attribute, amount)
	local to_little = funcRef.consumeResourceByAttribute(self, attribute, amount)
	if to_little > 0 then
		self.busy = true
		for k, v in pairs(self.networks) do
			if not v:isBusy() then
				to_little = v:consumeResourceByAttribute(attribute, to_little)
			end
			if to_little == 0 then
				break
			end
		end
		self.busy = false
	end
	return to_little
end

function C:getResourceAmountByAttribute(attribute, visited)
	visited = visited or {}
	local amount, tmp = funcRef.getResourceAmountByAttribute(self, attribute), nil
	self.busy = true
	for k, v in pairs(self.networks) do
		if not v:isBusy() and not visited[v:getID()] then
			tmp, visited = v:getResourceAmountByAttribute(attribute, visited)
			amount = amount + tmp
			visited[v:getID()] = v
		end
	end
	self.busy = false
	return amount, visited
end

--- Retrieve the max resource amount this network can hold of a specified resource
-- @param name [string] The resource to check
-- @param visited [table:ResourceContainer] a table of visited nodes, internal use!
-- @return [number] the max amount of this resource that can be stored
--
function C:getMaxResourceAmount(name, visited)
	visited = visited or {}
	local amount, tmp = funcRef.getMaxResourceAmount(self, name), nil
	self.busy = true
	for k, v in pairs(self.networks) do
		if not v:isBusy() and not visited[v:getID()] then
			tmp, visited = v:getMaxResourceAmount(name, visited)
			amount = amount + tmp
			visited[v:getID()] = v
		end
	end
	self.busy = false
	return amount, visited
end

--- Link a device to this network
-- @param container [ResourceContainer] a resource device (container or network) or nil to disconnect all
-- @param dont_unlink [boolean] don't call the other device's unlink method, prevents infinite loops, used internally!
--
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
		SB.log.debug("linking entity from network")
		container:link(self, true)
	end
	self.modified = CurTime()
end

--- Unlink a device (or all devices) from this network
-- @param container [ResourceContainer] a resource device (container or network) or nil to disconnect all
-- @param dont_unlink [boolean] don't call the other device's unlink method, prevents infinite loops, used internally!
--
function C:unlink(container, dont_unlink)
	-- We are not unlinking a specific device, unlink ALL!
	if not container then
		-- unlink from each container device seperatly
		for k, v in pairs(self.containers) do
			v:unlink(self, true)
		end
		self.containers = {}
		-- unlink from each network device seperatly
		for k, v in pairs(self.networks) do
			v:unlink(self, true)
		end
		self.networks = {}
		-- update modified times
		self.networksmodified = CurTime()
		self.containersmodified = CurTime()
	else --unlink a specific device
		if not self:canLink(container, true) then return end
		-- call unlink on the container (if needed)
		if not dont_unlink then
			container:unlink(self, true)
		end
		-- if the device is a resource network
		if container:isA("ResourceNetwork") then
			if not self.networks[container:getID()] then return end
			self.networks[container:getID()] = nil
			self.networksmodified = CurTime()
		else -- if the device is not a resource network but a container
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

--- Retrieve all connected networks
-- @return [table:ResourceNetwork] the table of network devices connected to this network
--
function C:getConnectedNetworks()
	return self.networks
end

--- Retrieve all connected containers
-- @return [table:ResourceContainer|not ResourceNetwork]the table of container devices connected to this network
--
function C:getConnectedEntities()
	return self.containers
end

--- Can the specified container connect to this network?
-- @param container [ResourceContainer] an rd container/network
-- @param checkforSelf [boolean] also check if the current network is the network of the container
--
function C:canLink(container, checkforSelf)
	return container ~= nil and self ~= container and container.isA and (container:isA("ResourceNetwork") or (container:isA("ResourceEntity") and (container:getNetwork() == nil or (checkforSelf and container:getNetwork() == self))))
end

--- Sync function to send data from the client to the server, contains the specific data transfer
-- @param modified [number] the client received information about this environment last
--
function C:_sendContent(modified)
	if self.containersmodified > modified then
		net.WriteBool(true)
		net.writeShort(table.Count(self.containers))
		for k, _ in pairs(self.containers) do
			net.writeShort(k)
		end
	else
		net.WriteBool(false)
	end
	if self.networksmodified > modified then
		net.WriteBool(true)
		net.writeShort(table.Count(self.networks))
		for k, _ in pairs(self.networks) do
			net.writeShort(k)
		end
	else
		net.WriteBool(false)
	end
	funcRef.sendContent(self, modified)
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	local hasContainerUpdate = net.ReadBool()
	if hasContainerUpdate then
		local nrofcontainers = net.readShort()
		self.containers = {}
		local am, id
		for am = 1, nrofcontainers do
			id = net.readShort()
			--TODO how to get this
			self.containers[id] = SB:getDeviceInfo(id)
		end
	end
	local hasNetworksUpdate = net.ReadBool()
	if hasNetworksUpdate then
		local nrofnetworks = net.readShort()
		self.networks = {}
		local am, id
		for am = 1, nrofnetworks do
			id = net.readShort()
			-- TODO how to get this
			self.networks[id] = SB:getDeviceInfo(id)
		end
	end
	funcRef.receiveSignal(self)
end

-- Duplicator methods
if SERVER then
	local function buildInfo(ent, data)
		return {}
	end
	local function applyInfo(ent, createdEntities, data)
		if not ent.rdobject then
			SB:registerDevice(ent, SB.RDTYPES.NETWORK)
		end
		--TODO process data generated by buildInfo
	end
	local function restoreInfo(ent, data)
		--TODO, we don't need to register anymore once we use the new ent base!
		SB:registerDevice(ent, SB.RDTYPES.NETWORK)
		--TODO process old rdobject data
	end
	timer.Simple(0.1, function() SB:registerDupeFunctions("rd/ResourceNetwork", buildInfo, applyInfo, restoreInfo) end)
end

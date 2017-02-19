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


include("resourceentity.lua")

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
	sendContent = C._sendContent,
	receiveSignal = C.receive,
	onSave = C.onSave,
	onLoad = C.onLoad
}

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "ResourceGenerator"
end

--- Constructor for this container class
-- @param entID The entity id we will be using for linking and syncing
-- @param resourceRegistry The resource registry which contains all resource data.
--
function C:init(entID, resourceRegistry)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceEntity") end
	funcRef.init(self, entID, SB.RDTYPES.GENERATOR, resourceRegistry)
	self.network = nil
	self.generates = {}
	self.requires = {}
end

function C:generatorResources()
	return self.generates
end

function C:requiresResources()
	return self.requires
end

function C:generatesResource(name, maxAmount, minAmount)
	if not name then error("ResourceContainer:generatesResource requires a name!") end
	name = tostring(name)
	if not minAmount or type(minAmount) ~= "number" or minAmount < 0 then minAmount = 0 end
	if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = minAmount end
	local res = self.generates[name]
	if not res then
		res = self.classLoader.new("rd/Resource", name, maxAmount, minAmount, self.resourceRegistry)
		self.generates[name] = res
	else
		res:setMaxAmount(res:getMaxAmount() + maxAmount)
		res:supply(minAmount)
	end
	if self.modified < res:getModified() then
		self.modified = res:getModified()
	end
	return res
end

function C:requiresResource(name, maxAmount, minAmount)
	if not name then error("ResourceContainer:requiresResource requires a name!") end
	name = tostring(name)
	if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then error("ResourceContainer:requiresResource requires a maxAmount > 0!") end
	if not minAmount or type(minAmount) ~= "number" or minAmount < 0 then minAmount = maxAmount end
	local res = self.requires[name]
	if not res then
		res = self.classLoader.new("rd/Resource", name, maxAmount, minAmount, self.resourceRegistry)
		self.requires[name] = res
	else
		res:setMaxAmount(res:getMaxAmount() + maxAmount)
		res:supply(minAmount)
	end
	if self.modified < res:getModified() then
		self.modified = res:getModified()
	end
	return res
end

--- Sync function to send data from the client to the server, contains the specific data transfer
-- @param modified timestamp the client received information about this environment last
--
function C:_sendContent(modified)
	funcRef.sendContent(self, modified)
	net.writeTiny(table.Count(self.generates))
	for _, v in pairs(self.generates) do
		v:send(modified)
	end
	net.writeTiny(table.Count(self.requires))
	for _, v in pairs(self.requires) do
		v:send(modified)
	end
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	funcRef.receiveSignal(self)
	local nrRes = net.readTiny()
	local am
	local name
	local id
	for am = 1, nrRes do
		id = net.readTiny()
		name = self.resourceRegistry:getResourceInfoFromID(id):getName()
		if not self.generates[name] then
			self:generatesResource(name, 0, 0)
		end
		self.generates[name]:receive()
	end
	nrRes = net.readTiny()
	for am = 1, nrRes do
		id = net.readTiny()
		name = self.resourceRegistry:getResourceInfoFromID(id):getName()
		if not self.requires[name] then
			self:requiresResource(name, 0, 0)
		end
		self.requires[name]:receive()
	end
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
	timer.Simple(0.1, function() SB:registerDupeFunctions("rd/ResourceGenerator", buildInfo, applyInfo, restoreInfo) end)
end

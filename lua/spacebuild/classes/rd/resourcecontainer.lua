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

-- Lua specific
local type = type
local tostring = tostring
local pairs = pairs
local table = table

-- Gmod Specific
local CurTime = CurTime
require("sbnet")
local net = sbnet

-- Class specific
local C = CLASS

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return className == "ResourceContainer"
end

function C:init(syncid, rdtype, resourceRegistry)
	if not syncid then error("syncid is required") end
	if not rdtype then error("Requires an RDType") end
	if not resourceRegistry then error("Resource requires a reference to the resourceRegistry!") end
	self.resourceRegistry = resourceRegistry
	self.syncid = syncid
	self.resources = {}
	self.delta = 0
	self.rdtype = rdtype
	self.modified = CurTime()
	self.beamsmodified = CurTime()
	self.beams = {}
end

function C:addBeam(target, material, width, color)
	for k, beam in pairs(self.beams) do
		if beam:getTarget() == target then
			return beam
		end
	end
	-- Only add a beam if we don't have an existing beam yet
	local beam = self.classLoader.new("rd/Beam", target, material, width, color)
	table.insert(self.beams, beam)
	self.beamsmodified = CurTime()
	return beam
end

function C:removeBeam(target)
	local foundBeam
	for k, beam in pairs(self.beams) do
		if beam:getTarget() == target then
			foundBeam = beam
			break
		end
	end
	if foundBeam then
		table.RemoveByValue( self.beams, foundBeam )
		self.beamsmodified = CurTime()
	end
end

function C:removeBeams()
	self.beams = {}
	self.beamsmodified = CurTime()
end

function C:getBeams()
	return self.beams
end

function C:getID()
	return self.syncid
end

function C:addResources(resources)
	for k, v in pairs(resources) do
		self:addResource(v.name, v.maxamount, v.amount)
	end
end

function C:containsResource(name)
	return self.resources[name] ~= nil
end

function C:addResource(name, maxAmount, amount)
	if not name then error("ResourceContainer:addResource requires a name!") end
	name = tostring(name)
	if not amount or type(amount) ~= "number" or amount < 0 then amount = 0 end
	if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = amount end
	local res = self:getResource(name)
	if not res then
		res = self.classLoader.new("rd/Resource", name, maxAmount, amount, self.resourceRegistry)
		self.resources[name] = res
	else
		res:setMaxAmount(res:getMaxAmount() + maxAmount)
		res:supply(amount)
	end
	if self.modified < res:getModified() then
		self.modified = res:getModified()
	end
	return res
end

function C:removeResource(name, maxAmount, amount)
	if not name then error("ResourceContainer:removeResource requires a name!") end
	name = tostring(name)
	if not amount or type(amount) ~= "number" or amount < 0 then amount = 0 end
	if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = amount end
	if not self:containsResource(name) then error("ResourceContainer:removeResource couldn't find the resource") end

	local res = self:getResource(name)
	res:consume(amount)
	res:setMaxAmount(res:getMaxAmount() - maxAmount)

	if self.modified < res:getModified() then
		self.modified = res:getModified()
	end
end

local res, ret

function C:supplyResource(name, amount)
	if not self:containsResource(name) then return amount end
	res = self:getResource(name)
	ret = res:supply(amount)
	if self.modified < res:getModified() then
		self.modified = res:getModified()
	end
	return ret
end

function C:consumeResource(name, amount)
	if not self:containsResource(name) then return amount end
	res = self:getResource(name)
	ret = res:consume(amount)
	if self.modified < res:getModified() then
		self.modified = res:getModified()
	end
	return ret
end

function C:consumeResourceByAttribute(attribute, amount)
	for k, v in pairs(self.resources) do
		if v:getResourceInfo():hasAttribute(attribute) then
			local multiplier = v:getResourceInfo():getAttributeMultiplier(attribute)
			local amountToUse = math.ceil(amount/multiplier)
			amountToUse = self:consumeResource(v:getName(), amountToUse)
			amount = math.ceil(amountToUse * multiplier)
			if amount == 0 then
				break
			end
		end
	end
	return amount -- the amount we couldn't consume
end

function C:getResourceAmountByAttribute(attribute)
	local amount = 0
	for k, v in pairs(self.resources) do
		if v:getResourceInfo():hasAttribute(attribute) then
			local multiplier = v:getResourceInfo():getAttributeMultiplier(attribute)
			amount = amount + math.floor(self:getResourceAmount(v:getName()) * multiplier)
		end
	end
	return amount -- the amount we can use of this attribute in total, calculated based on the mutlipliers
end

function C:getResource(name)
	return self.resources[name]
end

function C:getResources()
	return self.resources
end

function C:getResourceAmount(name)
	if not self:containsResource(name) then return 0 end
	return self:getResource(name):getAmount()
end

function C:getMaxResourceAmount(name)
	if not self:containsResource(name) then return 0 end
	return self:getResource(name):getMaxAmount()
end

function C:link(container, dont_link)
	error("ResourceContainer:link is not supported")
end

function C:unlink(container, dont_unlink)
	error("ResourceContainer:unlink is not supported")
end

function C:canLink(container)
	return false
end

function C:getEntity()
	return self.syncid and Entity(self.syncid)
end

--- Sync function to send data to the client from the server
-- @param modified timestamp the client received information about this environment last
-- @param ply the client to send this information to; if nil send to all clients
--
function C:send(modified, ply)
	if self.modified > modified then
		net.Start("sbru")
		net.writeShort(self.syncid)
		net.writeShort(self.rdtype)
		self:_sendContent(modified)
		if ply then
			net.Send(ply)
		else
			net.Broadcast()
		end
	end
end

--- Sync function to send data from the client to the server, contains the specific data transfer
-- @param modified timestamp the client received information about this environment last
--
function C:_sendContent(modified)
	net.writeTiny(table.Count(self.resources))
	for _, v in pairs(self.resources) do
		v:send(modified)
	end
	if self.beamsmodified > modified then
		net.WriteBool(true)
		net.writeShort(table.Count(self.beams))
		for _, v in pairs(self.beams) do
			v:send(modified)
		end
	else
		net.WriteBool(false)
	end

end

--- Sync function to receive data from the server to this client
--
function C:receive()
	local nrRes = net.readTiny()
	local am
	local name
	local id
	for am = 1, nrRes do
		id = net.readTiny()
		name = self.resourceRegistry:getResourceInfoFromID(id):getName()
		if not self:containsResource(name) then
			self:addResource(name, 0, 0)
		end
		self:getResource(name):receive()
	end
	local beamUpdate = net.ReadBool()
	if beamUpdate then
		self.beams = {}
		local beam
		local nrBeams = net.readShort()
		for am = 1, nrBeams do
			beam = self:addBeam()
			beam:receive()
		end
	end
end

function C:getModified()
	return self.modified
end

function C:getDelta()
	return self.delta
end

function C:setDeleta(data)
	self.delta = data
end

function C:calcDelta(resource)
	local blah
end
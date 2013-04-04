--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 27/12/12
-- Time: 23:29
-- To change this template use File | Settings | File Templates.
--

--Lua specific
local error = error
local tostring = tostring
local type = type

-- Gmod specific
local CurTime = CurTime
require("sbnet")
local net = sbnet
-- Class specific
local C = CLASS

local GM = GM
local class = GM.class

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return className == "BaseEnvironment"
end

--- Initialize function of this class
-- @param entid the (Entity) id to link this Environment to (and to sync it with)
-- @param data the basic data used for populating this environment (or reset it with)
--
function C:init(entid, data)
	self.entid = entid
	self.data = data

	self.temperature = 0
	self.gravity = 0
	self.atmosphere = 0

	self.resources = {}
	self.attributes = {}

	self.modified = CurTime()
end

--- Adds an attribute to the Environment
-- @param attribute String containing the attribute name
--
function C:addAttribute(attribute)
	table.insert(self.attributes, attribute)
	self.modified = CurTime()
end

--- Gets the id of this environment
-- @return an integer value
function C:getID()
	return self.entid
end

--- Set the environment id
-- @param id
--
function C:setID(id)
	self.entid = id
end

--- Gets the Entity linked to this environment
-- @return nil or Entity
function C:getEntity()
	return self.entid and Entity(self.entid) or nil
end

--- Gets the temperature on this environment for the given entity
-- @return an integer
function C:getTemperature()
	return self.temperature
end

--- Gets the gravity on this environment
-- @return a float
function C:getGravity()
	return self.gravity
end

--- Gets the atmosphere on this environment
-- @return a float
function C:getAtmosphere()
	return self.atmosphere
end

--- Gets the pressure on this environment
-- @return a float
function C:getPressure()
	return self:getGravity() * self:getAtmosphere()
end

--- Gets the volume on this environment
-- @return a integer
function C:getVolume()
	return 0
end

--- Gets the color modification object for this environment
-- @return an EnvironmentColor object
function C:getEnvironmentColor()
	return nil
end

--- Gets the bloom modification object for this environment
-- @return an EnvironmentBloom object
function C:getEnvironmentBloom()
	return nil
end

--- Does this environment have a name?
-- @return boolean
function C:hasName()
	return false
end

--- Gets the name of the environment
-- @return a String
function C:getName()
	return ""
end

-- Resource stuff

--- Gets the resource amount of a given resource
-- @param resource the resource name
-- @return an integer value
function C:getResourceAmount(resource)
	return (self.resources[resource] and self.resources[resource]:getAmount()) or 0
end

--- Gets the resource percentage of a given resource in this environment
-- @param resource the resource name
-- @return a float value (rounded to 2 numbers behind the comma)
function C:getResourcePercentage(resource)
	local am = self:getResourceAmount(resource)
	local max = self:getMaxAmountOfResources()
	if max > 0 then
		return math.Round((am / max) * 10000) / 100 --round to 2 decimals after the ,
	end
	return 0
end

--- Gets the maximum amount of units can be stored in total for all resources in this environment
-- @return an integer
function C:getMaxAmountOfResources()
	return math.ceil(self:getVolume() * self:getAtmosphere())
end

--- Gets the amount of resource units left that can be stored in this environment
-- @return an integer
function C:getUnusedResourceAmountInEnvironment()
	local max = self:getMaxAmountOfResources()
	for k, v in pairs(self.resources) do
		max = max - v:getAmount()
	end
	return max
end

--- Converts a given amount of units of resource from, to resource to
-- This function won't allow to convert more resources then there are available in the from resource
-- @param from the resource name to take the given amount of units from; if nil this is counted as the "unused" resource
-- @param to the resource name to give the given amount of units to; if nil this is counted as the unused resource
-- @param amount the amount of units to convert
-- @return an integer with the amount of units that couldn't be converted
function C:convertResource(from, to, amount)
	local res_to = self.resources[to]
	local not_enough = 0
	if not res_to then
		res_to = class.new("Resource", to, self:getMaxAmountOfResources(), 0)
		self.resources[to] = res_to
	end
	if not from then
		local max = self:getUnusedResourceAmountInEnvironment()
		if max < amount then
			not_enough = amount - max
			amount = max
		end
		if amount > 0 then
			res_to:setAmount(amount)
			self.modified = CurTime()
		end
	elseif self.resources[from] then
		not_enough = self.resources[from]:consume(amount)
		if not_enough < amount then
			res_to:supply(amount - not_enough)
			self.modified = CurTime()
		end
	else
		not_enough = amount
	end
	return not_enough
end

--- Does this environment have enough oxygen?
-- @return boolean
function C:hasEnoughOxygen()
	return self:getResourcePercentage("oxygen") > 5
end

-- Environment checking

--- Applies the environment data to all the entities that are currently in this environment
--
function C:updateEnvironmentOnEntities() --TODO call this when certain things get updated (gravity, ...)
	for k, v in pairs(self.entities) do
		self:updateEnvironmentOnEntity(v)
	end
end

--- Apply the environment data on a single entity found in this environment
-- @param ent the entity to apply the data to
--
function C:updateEnvironmentOnEntity(ent)
	if ent.environment == self then
		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then -- the physobject can become NULL somehow :s
			if self.gravity <= 0 then
				ent:SetGravity(0.00001) -- if gravity is 0, put gravity to 0.00001
			else
				ent:SetGravity(self.gravity) -- if gravity is 0, put gravity to 0.00001
			end
			if self.gravity > 0.01 then
				phys:EnableGravity(true)
			else
				phys:EnableGravity(false)
			end
			if self:getPressure() > 0.1 then
				phys:EnableDrag(true)
			else
				phys:EnableDrag(false)
			end
		end
	end
end

-- Sync stuff
--- Sync function to send data to the client from the server
-- @param modified timestamp the client received information about this environment last
-- @param ply the client to send this information to; if nil send to all clients
--
function C:send(modified, ply)
	if self.modified > modified then
		net.Start("SBEU")
		net.WriteString(self:getClass())
		net.writeShort(self.entid)
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
	net.writeShort(self.temperature)
	net.WriteFloat(self.gravity)
	net.WriteFloat(self.atmosphere)
	net.writeTiny(table.Count(self.resources))
	for k, v in pairs(self.resources) do
		v:send(modified)
	end
	net.writeTiny(#self.attributes)
	for k, v in pairs(self.attributes) do
		net.WriteString(v)
	end
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	self.temperature = net.readShort()
	self.gravity = net.ReadFloat()
	self.atmosphere = net.ReadFloat()
	local nrRes = net.readTiny()
	local am
	local name
	local id
	for am = 1, nrRes do
		id = net.readTiny()
		name = GM:getResourceInfoFromID(id):getName()
		if not self.resources[name] then
			self.resources[name] = class.new("Resource", name)
		end
		self.resources[name]:receive()
	end
	local nrAttributes = net.readTiny()
	for am = 1, nrAttributes do
		self:addAttribute(net.ReadString())
	end
end






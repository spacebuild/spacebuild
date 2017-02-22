--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

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

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return className == "Resource"
end

function C:init(name, maxAmount, amount, resourceRegistry)
	if not name then error("Resource requires a name!") end
	if not amount then error("Resource requires an amount!") end
	if not maxAmount then error("Resource requires a max amount!") end
	if not resourceRegistry then error("Resource requires a reference to the resourceRegistry!") end
	name = tostring(name)
	if type(amount) ~= "number" or amount < 0 then amount = 0 end
	if type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = amount end
	if amount > maxAmount then
		amount = maxAmount
	end
	self.name = name
	self.amount = amount
	self.maxAmount = maxAmount
	self.resourceRegistry = resourceRegistry
	self.resourceInfo = resourceRegistry:getResourceInfoFromName(name)
	self.modified = CurTime()
	self.modifiedMaxAmount = CurTime()
end

function C:supply(amount)
	if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:supply requires a number >= 0") end
	if amount == 0 then return 0 end -- don't do anything if amount = 0
	if self.amount == self.maxAmount then return amount end -- don't do anything if we reached the max amount already
	local to_much = 0
	self.amount = self.amount + amount
	if self.amount > self.maxAmount then
		to_much = self.amount - self.maxAmount
		self.amount = self.maxAmount
	end
	self.modified = CurTime()
	return to_much
end

function C:consume(amount)
	if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:consume requires a number >= 0") end
	if amount == 0 then return 0 end -- don't do anything if amount = 0
	if self.amount == 0 then return amount end -- don't do anything if we have 0 resources
	local to_little = 0
	self.amount = self.amount - amount
	if self.amount < 0 then
		to_little = math.abs(self.amount)
		self.amount = 0
	end
	self.modified = CurTime()
	return to_little
end

function C:getResourceInfo()
	return self.resourceInfo
end

function C:getDisplayName()
	return self:getResourceInfo():getDisplayName()
end

function C:getUnit()
	return self:getResourceInfo():getUnit()
end

function C:getMaxAmount()
	return self.maxAmount
end

function C:setMaxAmount(amount)
	if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:setMaxamount requires a number >= 0") end
	if self.maxAmount ~= amount then
		self.maxAmount = amount
		if self.amount > self.maxAmount then
			self.amount = self.maxAmount
			self.modified = CurTime()
		end
		self.modifiedMaxAmount = CurTime()
	end
end

function C:getAmount()
	return self.amount
end

function C:setAmount(amount)
	if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:setAmount requires a number >= 0") end
	self.amount = amount
	if self.amount > self.maxAmount then
		self.amount = self.maxAmount
	end
	self.modified = CurTime()
end

function C:getName()
	return self.name
end

--- Sync function to send data to the client from the server
-- @param modified timestamp the client received information about this environment last
--
function C:send(modified)
	net.writeTiny(self.resourceInfo:getID())
	if self.modified > modified then
		net.WriteBool(true)
		net.writeAmount(self.amount)
	else
		net.WriteBool(false) --not modified since last update
	end
	if self.modifiedMaxAmount > modified then
		net.WriteBool(true)
		net.writeAmount(self.maxAmount)
	else
		net.WriteBool(false) --not modified since last update
	end
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	if net.ReadBool() then
		self.amount = net.readAmount()
	end
	if net.ReadBool() then
		self.maxAmount = net.readAmount()
	end
end

function C:getModified()
	return self.modified
end

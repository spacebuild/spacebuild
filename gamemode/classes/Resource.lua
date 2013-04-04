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

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return className == "Resource"
end

function C:init(name, maxAmount, amount)
	if not name then error("Resource requires a name!") end
	name = tostring(name)
	if not amount or type(amount) ~= "number" or amount < 0 then amount = 0 end
	if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = amount end
	self.name = name
	self.amount = amount
	self.maxAmount = maxAmount
	self.resourceInfo = GM:getResourceInfoFromName(name)
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
		net.writeBool(true)
		net.writeAmount(self.amount)
	else
		net.writeBool(false) --not modified since last update
	end
	if self.modifiedMaxAmount > modified then
		net.writeBool(true)
		net.writeAmount(self.maxAmount)
	else
		net.writeBool(false) --not modified since last update
	end
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	if net.readBool() then
		self.amount = net.readAmount()
	end
	if net.readBool() then
		self.maxAmount = net.readAmount()
	end
end

function C:getModified()
	return self.modified
end

-- Start Save/Load functions

function C:onSave()
	return self
end

function C:onLoad(data)
	self.name = data.name
	self.amount = data.amount
	self.maxAmount = data.maxAmount
	self.resourceInfo = GM:getResourceInfoFromName(self.name)
	self.modified = CurTime()
	self.modifiedMaxAmount = CurTime()
end

-- End Save/Load functions

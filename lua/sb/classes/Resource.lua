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
local net = net
-- Class specific
local C = CLASS
local sb = sb;
local core = sb.core


function C:isA(className)
    return className == "Resource"
end

function C:init(name, maxAmount, amount)
    if not name then error("Resource requires a name!") end
    name = tostring(name)
    if not amount or type(amount) ~= "number" or amount < 0 then amount = 0 end
    if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = amount end
    self.name = name;
    self.amount = amount;
    self.maxAmount = maxAmount;
    self.resourceInfo = sb.getResourceInfoFromName(name)
    self.modified = CurTime();
    self.modifiedMaxAmount = CurTime()
end

function C:supply(amount)
    if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:supply requires a number >= 0") end
    if amount == 0 then return 0 end -- don't do anything if amount = 0
    if self.amount == self.maxAmount then return amount end -- don't do anything if we reached the max amount already
    local to_much = 0;
    self.amount = self.amount + amount;
    if self.amount > self.maxAmount then
        to_much = self.amount - self.maxAmount
        self.amount = self.maxAmount
    end
    self.modified = CurTime();
    return to_much;
end

function C:consume(amount)
    if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:consume requires a number >= 0") end
    if amount == 0 then return 0 end -- don't do anything if amount = 0
    if self.amount == 0 then return amount end -- don't do anything if we have 0 resources
    local to_little = 0;
    self.amount = self.amount - amount
    if self.amount < 0 then
        to_little = math.abs(self.amount)
        self.amount = 0
    end
    self.modified = CurTime();
    return to_little
end

function C:getMaxAmount()
    return self.maxAmount
end

function C:setMaxAmount(amount)
    if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:setMaxamount requires a number >= 0") end
    self.maxAmount = amount
    if self.amount > self.maxAmount then
        self.amount = self.maxAmount
        self.modified = CurTime();
    end
    self.modifiedMaxAmount = CurTime()
end

function C:getAmount()
    return self.amount;
end

function C:setAmount(amount)
    if not amount or type(amount) ~= "number" or amount < 0 then error("Resource:setAmount requires a number >= 0") end
    self.amount = amount
    if self.amount > self.maxAmount then
        self.amount = self.maxAmount
    end
    self.modified = CurTime();
end

function C:getName()
    return self.name;
end

--Always partial!! 
function C:send(modified)
    core.net.writeTiny(self.resourceInfo:getID())
    if self.modified > modified then
        core.net.writeBool(true)
        core.net.writeAmount(self.amount)
    else
        core.net.writeBool(false) --not modified since last update
    end
    if self.modifiedMaxAmount > modified then
        core.net.writeBool(true)
        core.net.writeAmount(self.maxAmount)
    else
        core.net.writeBool(false) --not modified since last update
    end
end

function C:receive()
    if core.net.readBool() then
        self.amount = core.net.readAmount()
    end
    if core.net.readBool() then
        self.maxAmount = core.net.readAmount()
    end
end

function C:getModified()
    return self.modified;
end

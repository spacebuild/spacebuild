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

include("sb/classes/ResourceContainer.lua")

-- Lua Specific
local type = type

-- Gmod specific
local Entity = Entity
local CurTime = CurTime
local net = net

-- Class Specific
local C = CLASS
local sb = sb;
local core = sb.core

local base_amount = 0

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
    receiveSignal = C.receive
}

function C:init(ply)
    funcRef.init(self, ply)
    self:addResource("oxygen", 1000, base_amount)
    self:addResource("coolant", 1000, base_amount)
    self:addResource("energy", 1000, base_amount)
    self:addResource("temperature", 9999, 0)
    self:addResource("gravity", 9999, 0)
end

function C:send(modified, _)
    if self.modified > modified then
        net.Start("SBRPU")
        self:_sendContent(modified)
        net.Send(self.syncid)
    end
end

function C:reset()
    self:setResourceAmount("oxygen", base_amount)
    self:setResourceAmount("coolant", base_amount)
    self:setResourceAmount("energy", base_amount)
end

local res

function C:setResourceAmount(name, amount)
    if not self:containsResource(name) then error("Trying to set a value on a resource not available in the suit") end
    res = self.resources[name]
    res:setAmount(amount)
    if self.modified < res:getModified() then
        self.modified = res:getModified()
    end
end
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

-- Gmod specific
local CurTime = CurTime
local net = net

-- Class Specific
local C = CLASS
local sb = sb;
local core = sb.core

function C:init(ply)
    self.ply = ply
    self:reset()
end

function C:reset()
    self.environment = nil
    self.active = false
    self.oxygen = 0
    self.coolant = 0
    self.energy = 0
    self.modified = CurTime()
end

function C:setEnvironment(environment)
    self.environment = environment
end

function C:getEnvironment()
    return self.environment
end

function C:setActive(active)
    self.active = active
end

function C:getActive()
    return self.active
end

function C:setOxygen(oxygen)
    self.oxygen = oxygen
end

function C:getOxygen()
    return self.oxygen
end

function C:setCoolant(coolant)
    self.coolant = coolant
end

function C:getCoolant()
    return self.coolant
end

function C:setEnergy(energy)
    self.energy = energy
end

function C:getEnergy()
    return self.energy
end

function C:send(modified)
    if self.modified > modified then
        net.Start("SBRPU")
        core.net.writeBool(self.active)
        if self.active then
            core.net.writeShort(self.oxygen)
            core.net.writeShort(self.coolant)
            core.net.writeShort(self.energy)
        end
        if self.environment then
            core.net.writeBool(true)
            core.net.writeShort(self.environment:getID())
        else
            core.net.writeBool(false)
        end
        net.Send(self.ply)
    end
end

function C:receive()
    self.active = core.net.readBool()
    if self.active then
        self.oxygen = core.net.readShort()
        self.coolant = core.net.readShort()
        self.energy = core.net.readShort()
    end
    local hasenvironment = core.net.readBool()
    if hasenvironment then
        self.environment = sb.getEnvironment(core.net.readShort())
    end
end
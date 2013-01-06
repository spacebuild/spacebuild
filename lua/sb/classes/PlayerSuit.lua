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
local const = sb.core.const

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
    self.temperature = 293
    self.modified = CurTime()
end

function C:setEnvironment(environment)
    self.environment = environment
    self.modified = CurTime()
end

function C:getEnvironment()
    return self.environment
end

function C:setActive(active)
    self.active = active
    self.modified = CurTime()
end

function C:getActive()
    return self.active
end

function C:isActive()
    return self:getActive()
end

function C:setOxygen(oxygen)
    self.oxygen = oxygen
    self.modified = CurTime()
end

function C:getOxygen()
    return self.oxygen
end

function C:setCoolant(coolant)
    self.coolant = coolant
    self.modified = CurTime()
end

function C:getCoolant()
    return self.coolant
end

function C:setEnergy(energy)
    self.energy = energy
    self.modified = CurTime()
end

function C:getEnergy()
    return self.energy
end

function C:setTemperature(temperature)
   self.temperature = temperature
end

function C:getTemperature()
   return self.temperature
end

local env, req_oxygen, env_temperature, req_energy, req_coolant, suit_temp

function C:processEnvironment()
   if self:isActive() then
       env = self:getEnvironment()
       req_oxygen = sb.core.util.calculateOxygenRequired((env and env:getPressure()) or 0)
       if sb.isSBMap() and env then
          env_temperature =  env:getTemperature(self.ply);
          suit_temp = self:getTemperature()
          if suit_temp ~= env_temperature then
              --const.SUIT_THERMAL_CONDUCTIVITY

          end
       end
   else

   end
end

function C:send(modified)
    if self.modified > modified then
        net.Start("SBRPU")
        core.net.writeBool(self.active)
        if self.active then
            core.net.writeShort(self.oxygen)
            core.net.writeShort(self.coolant)
            core.net.writeShort(self.energy)
            core.net.writeShort(self.temperature)
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
        self.temperature = core.net.readShort()
    end
    local hasenvironment = core.net.readBool()
    if hasenvironment then
        self.environment = sb.getEnvironment(core.net.readShort())
    end
end
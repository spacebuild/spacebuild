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
    self.breath = 100
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

function C:getBreath()
   return self.breath
end

function C:setBreath(breath)
    self.breath = breath
end

local env, req_oxygen, env_temperature, req_energy, req_coolant, suit_temp, diff_temp, used_energy

function C:processEnvironment()
   if self:isActive() then
       env = self:getEnvironment()
       req_oxygen = sb.core.util.calculateOxygenRequired((env and env:getPressure()) or 0)
       if sb.onSBMap() and env then
           env_temperature =  env:getTemperature(self.ply);
           suit_temp = self:getTemperature()
           if suit_temp ~= env_temperature then
               diff_temp = env_temperature - suit_temp
               diff_temp = math.floor(diff_temp * const.SUIT_THERMAL_CONDUCTIVITY)
               suit_temp = suit_temp + diff_temp
               self:setTemperature(suit_temp)
           end
           req_energy = sb.core.util.calculateEnergyRequired(suit_temp)
           req_coolant = sb.core.util.calculateCoolantRequired(suit_temp)
       else
           req_energy = sb.core.util.calculateEnergyRequired(const.TEMPERATURE_SAFE_MIN)
           req_coolant = 0 --sb.core.util.calculateCoolantRequired(const.TEMPERATURE_SAFE_MAX)
       end
       if req_energy > 0 then
           if self:getEnergy() >= req_energy then
               self:setEnergy(self:getEnergy() - req_energy)
               used_energy = true
           elseif self:getEnergy() > 0 then
               self:TakeDamage( (req_energy - self:getEnergy()) * sb.core.const.BASE_LS_DAMAGE , 0 )
               self:setEnergy(0)
               used_energy = true
           else
               self:TakeDamage( req_energy * sb.core.const.BASE_LS_DAMAGE , 0 )
           end
       end
       if req_coolant > 0 then
           if self:getCoolant() >= req_coolant then
               self:setCoolant(self:getCoolant() - req_coolant)
           elseif self:getCoolant() > 0 then
               self:TakeDamage( (req_coolant - self:getCoolant()) * sb.core.const.BASE_LS_DAMAGE , 0 )
               self:setCoolant(0)
           else
               self:TakeDamage( req_coolant * sb.core.const.BASE_LS_DAMAGE , 0 )
           end
       end
       if req_oxygen > 0 then
           if self:getOxygen() >= req_oxygen then
               self:setOxygen(self:getOxygen() - req_oxygen)
           elseif self:getOxygen() > 0 then
               self:TakeDamage( (req_oxygen - self:getOxygen()) * sb.core.const.BASE_LS_DAMAGE , 0 )
               self:setOxygen(0)
           else
               self:TakeDamage( req_oxygen * sb.core.const.BASE_LS_DAMAGE , 0 )
           end
       end
       if self:getOxygen() < 100 and used_energy then
           self.ply:EmitSound( "common/warning.wav" )
       end
   else
      if self.ply:WaterLevel()  == 3 then
         if self:getBreath() >=5 then
             self:setBreath(self:getBreath() - 5)
         elseif self:getBreath() > 0 then
            self:setBreath(0)
         else
             self:TakeDamage( sb.core.const.BASE_LS_DAMAGE , 0 )
         end
      else
          if self:getBreath() <= 95 then
              self:setBreath(self:getBreath() + 5)
          elseif self:getBreath() < 100 then
              self:setBreath(100)
          end
      end
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
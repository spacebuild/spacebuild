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
require("sbnet")
local net = sbnet

-- Class Specific
local C = CLASS
local GM = GM
local const = GM.constants
local util = GM.util

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return className == "PlayerSuit"
end

function C:init(ply)
	self.ply = ply
	self:reset()
	self.firstSync = true
end

function C:reset()
	self.environment = nil
	self.active = false
	self.oxygen = 0
	self.breath = 100
	self.maxbreath = 100
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
	self.modified = CurTime()
end

function C:getTemperature()
	return self.temperature
end

function C:getBreath()
	return self.breath
end

function C:setBreath(breath)
	self.breath = breath
	self.modified = CurTime()
end

function C:getMaxBreath()
	return self.maxbreath
end

local env, req_oxygen, env_temperature, req_energy, req_coolant, suit_temp, diff_temp, used_energy

local calcQ_radiation = function(body_temp,env_temp)
	--local t1 = (body_temp*body_temp)+(env_temp*env_temp)
	--local t2 = (body_temp)+(env_temp)
	--local tt = t1*t2
	--local hr = const.BOLTZMAN * ((const.EMISSIVITY.aluminium*0.2)+(const.EMISSIVITY.plastic*0.8)) * tt
	return ( const.BOLTZMANN * (body_temp*body_temp*body_temp*body_temp) * const.BODY_SURFACE_AREA ) * const.EMISSIVITY.plastic * (500000/(body_temp-env_temp))  -- Last part is constant tweaks.
	--return hr * const.BODY_SURFACE_AREA  * (body_temp - env_temp)
end

local calcdT_radiation = function(self)
	local rtnQ = calcQ_radiation(self:getTemperature(), self:getEnvironment():getTemperature(self.ply)) / (const.PLY_MASS * const.SPECIFIC_HEAT_CAPACITY.aluminium)
	if rtnQ >= 0 then
		return calcQ_radiation(self:getTemperature(), self:getEnvironment():getTemperature(self.ply)) / (const.PLY_MASS * const.SPECIFIC_HEAT_CAPACITY.aluminium)
	else
		return 0
	end
end

function C:processEnvironment()
	if not self.ply:Alive() then return end
	env = self:getEnvironment()
	if self:isActive() then
		req_oxygen = util.calculateOxygenRequired((env and env:getPressure()) or 0)
		if GM:onSBMap() and env then
			env_temperature = env:getTemperature()
			suit_temp = self:getTemperature()
			if env == GM:getSpace() and suit_temp ~= env_temperature then -- Use radiation
				local T = calcdT_radiation(self) -- Ramp up the value as we're not actually in real life here ...
				suit_temp = suit_temp - T
				self:setTemperature(suit_temp)
			else -- Use convection/conduction
				diff_temp = env_temperature - suit_temp
				diff_temp = math.floor(diff_temp * const.SUIT_THERMAL_CONDUCTIVITY)
				suit_temp = suit_temp + diff_temp
				self:setTemperature(suit_temp)
			end
			req_energy = util.calculateEnergyRequired(suit_temp)
			req_coolant = util.calculateCoolantRequired(suit_temp)
		else
			req_energy = util.calculateEnergyRequired(const.TEMPERATURE_SAFE_MIN)
			req_coolant = 0 --sb.core.util.calculateCoolantRequired(const.TEMPERATURE_SAFE_MAX)
		end
		if req_energy > 0 then
			if self:getEnergy() >= req_energy then
				self:setEnergy(self:getEnergy() - req_energy)
				used_energy = true
			elseif self:getEnergy() > 0 then
				self.ply:TakeDamage((req_energy - self:getEnergy()) * const.BASE_LS_DAMAGE, 0)
				self:setEnergy(0)
				used_energy = true
			else
				self.ply:TakeDamage(req_energy * const.BASE_LS_DAMAGE, 0)
			end
		end
		if req_coolant > 0 then
			if self:getCoolant() >= req_coolant then
				self:setCoolant(self:getCoolant() - req_coolant)
			elseif self:getCoolant() > 0 then
				self.ply:TakeDamage((req_coolant - self:getCoolant()) * const.BASE_LS_DAMAGE, 0)
				self:setCoolant(0)
			else
				self.ply:TakeDamage(req_coolant * const.BASE_LS_DAMAGE, 0)
			end
		end
		if req_oxygen > 0 then
			if self.ply:WaterLevel() < 3 and (GM:onSBMap() and env and env:hasEnoughOxygen()) then
				req_oxygen = const.suit.MAX_OXYGEN - self:getOxygen()
				if  req_oxygen > 0  then
					self:setOxygen(self:getOxygen() + req_oxygen - env:convertResource("oxygen", "co2", req_oxygen))
				end
			else
				if self:getOxygen() >= req_oxygen then
					self:setOxygen(self:getOxygen() - req_oxygen)
					if self:getBreath() <= self:getMaxBreath() - req_oxygen then
						self:setBreath(self:getBreath() + req_oxygen)
					elseif self:getBreath() < self:getMaxBreath() then
						self:setBreath(self:getMaxBreath())
					end
				elseif self:getOxygen() > 0 then
					self.ply:TakeDamage((req_oxygen - self:getOxygen()) * sb.core.const.BASE_LS_DAMAGE, 0)
					if self:getBreath() <= self:getMaxBreath() - (req_oxygen - self:getOxygen()) then
						self:setBreath(self:getBreath() + (req_oxygen - self:getOxygen()))
					elseif self:getBreath() < self:getMaxBreath() then
						self:setBreath(self:getMaxBreath())
					end
					self:setOxygen(0)
				else
					if self:getBreath() >= req_oxygen then
						self:setBreath(self:getBreath() - req_oxygen)
					elseif self:getBreath() > 0 then
						self:setBreath(0)
					else
						self.ply:EmitSound("Player.DrownStart")
						self.ply:TakeDamage(req_oxygen * const.BASE_LS_DAMAGE, 0)
					end
				end
			end
		end
		if self:getOxygen() < 100 and used_energy then
			self.ply:EmitSound("common/warning.wav")
		end
	else
		if env and env == GM:getSpace() then --If in space, we'll deduct a random amount between 20 and 70
			local rand = math.random(20, 70)
			if self:getBreath() >= rand then
				self:setBreath(self:getBreath() - rand)
			elseif self:getBreath() > 0 then
				self:setBreath(0)
			end
		elseif self.ply:WaterLevel() == 3 or (GM:onSBMap() and env and not env:hasEnoughOxygen()) then
			if self:getBreath() >= 5 then
				self:setBreath(self:getBreath() - 5)
			elseif self:getBreath() > 0 then
				self:setBreath(0)
			else
				self.ply:EmitSound("Player.DrownStart")
				self.ply:TakeDamage(const.BASE_LS_DAMAGE, 0)
			end
		else
			local rand = math.random(1, 25)
			if self:getBreath() <= self:getMaxBreath() - rand then
				self:setBreath(self:getBreath() + rand)
			elseif self:getBreath() < self:getMaxBreath() then
				self:setBreath(self:getMaxBreath())
			end
		end
		if GM:onSBMap() and env then
			env_temperature = env:getTemperature(self.ply)
			req_energy = util.calculateEnergyRequired(env_temperature) - const.BASE_ENERGY_USE
			req_coolant = util.calculateCoolantRequired(env_temperature) - const.BASE_COOLANT_USE
			if req_energy > 0 then
				self.ply:TakeDamage(req_energy * const.BASE_LS_DAMAGE, 0)
			end
			if req_coolant > 0 then
				self.ply:TakeDamage(req_coolant * const.BASE_LS_DAMAGE, 0)
			end
		end
	end
end

--- Sync function to send data to the client from the server
-- @param modified timestamp the client received information about this environment last
--
function C:send(modified)
	if self.modified > modified then
		self.firstSync = false
		net.Start("SBRPU")
		net.writeBool(self.active)
		net.writeTiny(self.breath)
		if self.active then
			net.writeShort(self.oxygen)
			net.writeShort(self.coolant)
			net.writeShort(self.energy)
			net.writeShort(self.temperature)
		end
		if self.environment then
			net.writeBool(true)
			net.writeShort(self.environment:getID())
		else
			net.writeBool(false)
		end
		net.Send(self.ply)
	end
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	self.active = net.readBool()
	self.breath = net.readTiny()
	if self.active then
		self.oxygen = net.readShort()
		self.coolant = net.readShort()
		self.energy = net.readShort()
		self.temperature = net.readShort()
	end
	local hasenvironment = net.readBool()
	if hasenvironment then
		self.environment = GM:getEnvironment(net.readShort())
	end
end
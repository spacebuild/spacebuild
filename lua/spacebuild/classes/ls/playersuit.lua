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

-- Gmod specific
local CurTime = CurTime
require("sbnet")
local net = sbnet

-- Class Specific
local C = CLASS
local GM = SPACEBUILD
local log = GM.log
local const = GM.constants

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
	-- is the helmet on, meaning the suit is active an can do it's job
	self.active = false
	self.oxygen = const.suit.MAX_OXYGEN
	self.breath = 100
	self.maxbreath = 100
	self.coolant = const.suit.MAX_COOLANT
	self.energy = const.suit.MAX_ENERGY
	self.temperature = const.TEMPERATURE_SAFE_MIN
	self.environmentTemperature = const.TEMPERATURE_SAFE_MIN
	self.modified = CurTime()
end

function C:getEnvironment()
	return self.ply.environment
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

function C:setEnvironmentTemperature(temperature)
	self.environmentTemperature = temperature
	self.modified = CurTime()
end

function C:getEnvironmentTemperature()
	return self.environmentTemperature
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

local function calculateOxygenRequired(pressure)
	local required = 5
	if pressure > 0 then

	end
	return required
end

local function calculateSuitTemperature(suitTemperature, environmentTemperature)
	if suitTemperature ~= environmentTemperature then
		local dif = suitTemperature - environmentTemperature
		suitTemperature = suitTemperature - (dif * 0.05) -- 5% temperature difference every update
	end
	return suitTemperature
end

local function calculateEnergyRequired(suitTemperature)
	local required = 0
	if suitTemperature < const.TEMPERATURE_SAFE_MIN then
		required = 5
	end
	return required
end

local function calculateCoolantRequired(suitTemperature)
	local required = 0
	if suitTemperature > const.TEMPERATURE_SAFE_MAX then
		required = 5
	end
	return required
end

-- TODO add support for environmental devices: air regulators, temperature regulators, ...
-- TODO add support for vehicles (= pod)
function C:processEnvironment()
	local env, pod, req_oxygen, env_temperature, req_energy, req_coolant, suit_temp, diff_temp, used_energy
	if not self.ply:Alive() then return end
	env = self:getEnvironment()
	pod = self.ply:GetParent()
	if GM:isValidRDEntity(pod) then
		pod = pod.rdobject
	else
		pod = nil
	end
	if self:isActive() then
		req_oxygen = calculateOxygenRequired((env and env:getPressure()) or 0)
		if GM:onSBMap() and env then
			env_temperature = env:getTemperature(self.ply)
			suit_temp = self:getTemperature()
			suit_temp = calculateSuitTemperature(suit_temp, env_temperature)
			self:setTemperature(suit_temp)
			self:setEnvironmentTemperature(env_temperature)
			req_energy = calculateEnergyRequired(suit_temp)
			req_coolant = calculateCoolantRequired(suit_temp)
		else
			req_energy = calculateEnergyRequired(const.TEMPERATURE_SAFE_MIN)
			req_coolant = 0
		end
		--log.debug("Required for player: oxygen=", req_oxygen, ", energy=", req_energy, ", coolant=", req_coolant)
		--log.debug("Available resources: oxygen=", self:getOxygen(), ", energy=",  self:getEnergy(), ", coolant=", self:getCoolant())
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
					self:setOxygen(self:getOxygen() + req_oxygen - env:convertResource("oxygen", "carbon dioxide", req_oxygen))
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
					self.ply:TakeDamage((req_oxygen - self:getOxygen()) * const.BASE_LS_DAMAGE, 0)
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
	else -- no active suit, means we can only hold our breath for a little bit
		if env and env:isSpace() then --If in space, we'll deduct a random amount between 20 and 70
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
			-- Take temperature damage if the outside temperature is unsafe
			if env_temperature < const.TEMPERATURE_SAFE_MIN or env_temperature > const.TEMPERATURE_SAFE_MAX then
				req_energy = calculateEnergyRequired(env_temperature) - const.BASE_ENERGY_USE
				req_coolant = calculateCoolantRequired(env_temperature) - const.BASE_COOLANT_USE
				if req_energy > 0 then
					self.ply:TakeDamage(req_energy * const.BASE_LS_DAMAGE, 0)
				end
				if req_coolant > 0 then
					self.ply:TakeDamage(req_coolant * const.BASE_LS_DAMAGE, 0)
				end
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
		net.Start("sbrpu")
		net.WriteBool(self.active)
		net.writeTiny(self.breath)
		if self.active then
			net.writeShort(self.oxygen)
			net.writeShort(self.coolant)
			net.writeShort(self.energy)
			net.writeShort(self.temperature)
		end
		net.Send(self.ply)
	end
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	self.active = net.ReadBool()
	self.breath = net.readTiny()
	if self.active then
		self.oxygen = net.readShort()
		self.coolant = net.readShort()
		self.energy = net.readShort()
		self.temperature = net.readShort()
	end
end
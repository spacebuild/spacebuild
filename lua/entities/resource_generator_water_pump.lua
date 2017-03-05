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

AddCSLuaFile()

local baseClass = baseclass.Get("base_resource_generator")

ENT.PrintName = "Water Generator Pump"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""
ENT.Category        = "Spacebuild"
ENT.AutomaticFrameAdvance = true --Enable animations

ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD

function ENT:Initialize()
	baseClass.Initialize(self)
	if SERVER then
		self.rdobject:generatesResource("water", 0, 0)
		self.rdobject:requiresResource("energy", 0, 0)
		self.active = false
		self.rate = 0
	end
end

if SERVER then

	function ENT:doSequence(spinrate, active)
		if active ~= nil then
			local newStateIsRunning = active
			if self.isRunning == nil or newStateIsRunning ~= self.isRunning then
				if newStateIsRunning then
					self.sequence = self:LookupSequence("walk")
					self:EmitSound("Airboat_engine_idle")
				else
					self.sequence = self:LookupSequence("idle")
					self:StopSound("Airboat_engine_idle")
				end
				if self.sequence and self.sequence ~= -1 then
					self:SetSequence(self.sequence)
					self:SetPlaybackRate(spinrate)
				end
				self.isRunning = newStateIsRunning
			end
		end
		if self.sequence and self.sequence ~= -1 then
			self:ResetSequence(self.sequence)
			self:SetPlaybackRate(spinrate)
		end
	end

	function ENT:getRate()
		local waterlevel, water, energy, waterToGet, leftOver, temperature = 0, self.rdobject:getGeneratorResource("water"), self.rdobject:getRequiresResource("energy"), 0, 0, 300
		if self.rdobject:getResourceAmount("energy") < energy:getAmount() then
			self:turnOff() --Not enough power
			return 0
		end
		leftOver = self.rdobject:consumeResource("energy", energy:getMaxAmount())
		waterToGet = water:getMaxAmount();
		if leftOver > 0 then
			waterToGet = water:getAmount();
		end
		if self.WaterLevel2 then
			waterlevel = self:WaterLevel2()
		elseif self.WaterLevel then
			waterlevel = self:WaterLevel()
		end
		if self.environment then
			temperature = self.environment:getTemperature(self) --Check to see if it's in lava or ice
		end
		-- We are either not in water or  in frozen water or in lava, damage the pump and return 0, 273 = freezing point
		if waterlevel == 0 or temperature < 253 or temperature > 1000 then
			SB.util.damage.doDamage(self, math.random(2, 3))
			return 0
		elseif waterlevel == 1 then
			waterToGet = math.Round(waterToGet/2)
		end
		return waterToGet
	end

	function ENT:canTurnOn()
		return self.rdobject:getResourceAmount("energy") >= self.rdobject:getRequiresResource("energy"):getAmount()
	end

	function ENT:performAnimationUpdate(time)
		baseClass.performAnimationUpdate(self, time)
		self:doSequence(1, self.active)
	end

	function ENT:performUpdate(time)
		baseClass.performUpdate(self, time)
		self.rate = 0
		if self.active then
			self.rate = self:getRate()
			self.rdobject:supplyResource("water", self.rate)
		end
	end

	-- wire ouput method
	function ENT:getEnergyRate()
		return self.rdobject:getRequiresResource("energy"):getMaxAmount()
	end
	function ENT:getWaterRate()
		return self.rate
	end
	-- end wire output method
end



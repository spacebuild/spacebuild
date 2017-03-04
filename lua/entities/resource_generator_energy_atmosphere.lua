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

ENT.PrintName = "Energy Generator Atmosphere"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""
ENT.Category        = "Spacebuild"
ENT.AutomaticFrameAdvance = true --Enable animations

ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_generator_energy_atmosphere")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/props_phx/life_support/panel_medium.mdl")
	ent:Spawn()

	ent.rdobject:generatesResource("energy", 15, 0)
	return ent
end

function ENT:Initialize()
	baseClass.Initialize(self)
	if SERVER then
		self.rdobject:generatesResource("energy", 0, 0)
		self.active = true
		self.spinrate = 0
		self.rate = 0
	end
end

if SERVER then

	function ENT:doSequence(spinrate, rate)
		if rate ~= nil then
			local newStateIsRunning = rate > 0
			if self.isRunning == nil or newStateIsRunning ~= self.isRunning then
				if newStateIsRunning then
					self.sequence = self:LookupSequence("rotate")
				else
					self.sequence = self:LookupSequence("idle")
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
		local res = self.rdobject:getGeneratorResource("energy")
		if self.environment and not self.environment:isSpace() then
			return math.Round(res:getMaxAmount() * self.environment:getAtmosphere()), self.environment:getAtmosphere()
		elseif self.environment then
			return res:getAmount(), 0
		else
			return res:getMaxAmount(), 1
		end
	end

	function ENT:performAnimationUpdate(time)
		baseClass.performAnimationUpdate(self, time)
		self:doSequence(self.spinrate or 0)
	end

	function ENT:performUpdate(time)
		baseClass.performUpdate(self, time)
		if self:WaterLevel() > 1 then
			self.active = false
		else
			self.active = true
		end

		self.rate = 0
		if self.active then
			self.rate, self.spinrate = self:getRate()
			self.rdobject:supplyResource("energy", self.rate)
		end
		self:doSequence(self.spinrate, self.rate)
		self.thinkcount = 0
	end

	-- wire ouput method
	function ENT:getEnergyRate()
		return self.rate
	end
	-- end wire output method
end



function ENT:AcceptInput(name, activator, caller)
	-- Do nothing, it's a wind gen
end

function ENT:TriggerInput(name, value)
	-- Do nothing, it's a wind gen
end

function ENT:turnOn(caller)
	-- Do nothing, it's a wind gen
end

function ENT:turnOff(caller)
	-- Do nothing, it's a wind gen
end

function ENT:toggle(caller)
	-- Do nothing, it's a wind gen
end



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

ENT.PrintName = "Spacebuild probe"
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
		self.rdobject:requiresResource("energy", 0, 0)
		self.active = false
		self.rate = 0
	end
end

if SERVER then

	function ENT:canTurnOn()
		return self.rdobject:getResourceAmount("energy") >= self.rdobject:getRequiresResource("energy"):getAmount()
	end

	function ENT:performUpdate(time)
		baseClass.performUpdate(self, time)
		local energy = self.rdobject:getRequiresResource("energy")
		if self.active then
			if  self.rdobject:getResourceAmount("energy") < energy:getAmount() then
				self:turnOff() --Not enough power
				return
			end
			self.rdobject:consumeResource("energy", energy:getMaxAmount())
		end
	end

	-- wire ouput method
	function ENT:getEnergyRate()
		return (self.active and self.rdobject:getRequiresResource("energy"):getMaxAmount()) or 0
	end
	function ENT:getPressure()
		return (self.active and self.environment and self.environment:getPressure()) or 0
	end
	function ENT:getTemperature()
		return (self.active and self.environment and self.environment:getTemperature(self)) or 0
	end
	function ENT:getGravity()
		return (self.active and self.environment and self.environment:getGravity()) or 0
	end
	function ENT:getOxygenPercentage()
		return (self.active and self.environment and self.environment:getResourcePercentage("oxygen")) or 0
	end
	-- end wire output method
end



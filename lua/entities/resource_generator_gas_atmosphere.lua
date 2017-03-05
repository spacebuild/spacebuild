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

ENT.PrintName = "Gas Generator Pump - Atmosphere extractor"
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
	end
end

if SERVER then

	function ENT:canTurnOn()
		return self.rdobject:getResourceAmount("energy") >= self.rdobject:getRequiresResource("energy"):getAmount()
	end

	function ENT:performUpdate(time)
		baseClass.performUpdate(self, time)
		if self.active then
			local waterlevel, resources, energy, toGet, leftOver, notEnough = 0, self.rdobject:generatorResources(), self.rdobject:getRequiresResource("energy"), 0, 0, 0
			if self.rdobject:getResourceAmount("energy") < energy:getAmount() then
				self:turnOff() --Not enough power
				return 0
			end
			leftOver = self.rdobject:consumeResource("energy", energy:getMaxAmount())

			if self.WaterLevel2 then
				waterlevel = self:WaterLevel2()
			elseif self.WaterLevel then
				waterlevel = self:WaterLevel()
			end

			if waterlevel > 1 then
				SB.util.damage.doDamage(self, math.random(2, 3))
			else
				for k, v in pairs(resources) do
					toGet = v:getMaxAmount()
					if leftOver > 0 then
						toGet = v:getAmount()
					end
					if waterlevel > 0 then
						toGet = math.Round(toGet/2)
					end
					notEnough = 0
					if self.environment then
						if not self.environment:isSpace() then
							--Extract gas from the atmosphere and store what we couldn't extract from it
							notEnough = self.environment:convertResource(k, "vacuum", toGet)
							--Supply the amount of gas we took from the atmosphere
							notEnough = self.rdobject:supplyResource(k, toGet - notEnough)
							--Return to the atmosphere what we couldn't supply
							if notEnough > 0 then
								notEnough = self.environment:convertResource("vacuum", k, notEnough)
							end
						end

					else -- No spacebuild map, so just supply what was asked
						self.rdobject:supplyResource(k, toGet)
					end
				end
			end
		end
	end

	-- wire ouput method
	function ENT:getEnergyRate()
		return self.rdobject:getRequiresResource("energy"):getMaxAmount()
	end
	-- end wire output method
end



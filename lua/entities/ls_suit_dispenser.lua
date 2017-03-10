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

ENT.PrintName = "LS Suit Dispenser"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD

function ENT:Initialize()
	baseClass.Initialize(self)
	if SERVER then
		self.rdobject:requiresResource("energy", 0, 0)
		self.rdobject:requiresResource("oxygen", 0, 0)
		for _, res in pairs(SB:getResourceRegistry():getRegisteredCoolants()) do
			self.rdobject:requiresResource(res, 0, 0)
		end
		self.active = false
	end
end

function ENT:AcceptInput(name, activator, ply)
	if name == "Use" and ply:IsPlayer() and ply:KeyDownLast(IN_USE) == false and ply.suit then
		local res = {
			SB.constants.suit.MAX_ENERGY - ply.suit:getEnergy(),
			SB.constants.suit.MAX_OXYGEN - ply.suit:getOxygen(),
			SB.constants.suit.MAX_COOLANT - ply.suit:getCoolant()
		}
		local notEnough = {
			self.rdobject:consumeResource("energy", res[1]),
			self.rdobject:consumeResource("oxygen", res[2]),
			self.rdobject:consumeResourceByAttribute(SB.RESTYPES.COOLANT, res[3]),
		}

		ply.suit:setOxygen(ply.suit:getOxygen() + res[2] - notEnough[2])
		ply.suit:setCoolant(ply.suit:getCoolant() + res[3] - notEnough[3])
		ply.suit:setEnergy(ply.suit:getEnergy() + res[1] - notEnough[1])
	end
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



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
			if not self.flashlight then
				self.flashlight = ents.Create("env_projectedtexture")
				self.flashlight:SetParent(self)

				-- The local positions are the offsets from parent..
				self.flashlight:SetLocalPos(self.lightpos or  Vector(0, 0, 0))
				self.flashlight:SetLocalAngles(self.lightangle or Angle(90, 90, 90))

				-- Looks like only one flashlight can have shadows enabled!
				self.flashlight:SetKeyValue("enableshadows", 1)
				self.flashlight:SetKeyValue("farz", 2048)
				self.flashlight:SetKeyValue("nearz", 8)

				--the size of the light
				self.flashlight:SetKeyValue("lightfov", 50)

				-- Color.. white is default
				self.flashlight:SetKeyValue("lightcolor", "255 255 255")
				self.flashlight:Spawn()
				self.flashlight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001")
			end
		elseif self.flashlight then
			SafeRemoveEntity(self.flashlight)
			self.flashlight = nil
		end
	end

	-- wire ouput method
	function ENT:getEnergyRate()
		return (self.active and self.rdobject:getRequiresResource("energy"):getMaxAmount()) or 0
	end
	-- end wire output method
end



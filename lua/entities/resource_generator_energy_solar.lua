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

ENT.PrintName = "Energy Generator Solar"
ENT.Author = "SnakeSVx & Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""
ENT.Category        = "Spacebuild"

ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_generator_energy_solar")
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
	end
end

if SERVER then

	function ENT:getBlocked(up, sun)

		local trace = {}
		local util = util
		local up = up or self:GetAngles():Up() or nil
		local sun = sun or SB:getSun() or nil

		if up == nil or sun == nil then return true end

		if sun ~= nil then
			trace = util.QuickTrace(sun:getPosition(), self:GetPos() - sun:getPosition(), nil) -- Don't filter
			if trace.Hit and trace.Entity == self then
				return false
			else
				return true
			end
		else
			local sunAngle = Vector(0, 0, -1)

			local n = sunAngle:DotProduct(up * -1)
			if n > 0 then
				return true
			end
		end

		return false
	end

	function ENT:getRate()

		local up = self:GetAngles():Up()
		local sun = SB:getSun() or nil

		local sunAngle = Vector(0, 0, -1)

		if sun ~= nil then
			sunAngle = (self:GetPos() - sun:getPosition()) -- DO NOT ADD :Normalize() BECOMES NIL!
			sunAngle:Normalize() --Normalising doesn't work normally for some reason, hack implemented.
		end

		local n = sunAngle:DotProduct(up * -1)

		local res = self.rdobject:getGeneratorResource("energy")

		if n >= 0 and not self:getBlocked(up, sun) then
			return math.Round(res:getMaxAmount() * n)
		else
			return res:getAmount()
		end
	end

	function ENT:Think()
		baseClass.Think(self)
		if self:WaterLevel() > 0 then
			self.active = false
		else
			self.active = true
		end

		if self.active then
			self.rdobject:supplyResource("energy", self:getRate() or 0)
		end

		self:NextThink(CurTime() + 1)
		return true
	end
end

function ENT:AcceptInput(name, activator, caller)
	-- Do nothing, it's a solar panel
end

function ENT:turnOn(caller)
	-- Do nothing, it's a solar panel
end

function ENT:turnOff(caller)
	-- Do nothing, it's a solar panel
end

function ENT:toggle(caller)
	-- Do nothing, it's a solar panel
end



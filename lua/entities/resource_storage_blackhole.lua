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

DEFINE_BASECLASS("base_resource_entity")

ENT.PrintName = "Blackhole Cache"
ENT.Author = "Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.vent = false

function ENT:Initialize()
	BaseClass.Initialize(self)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self.Entity:SetUseType(SIMPLE_USE)

		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		self.rdobject:addResource("energy", 50000, 50000)
		self.rdobject:addResource("oxygen", 50000, 50000)
		self.rdobject:addResource("water", 50000, 50000)
	end
end

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_storage_blackhole")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/ce_ls3additional/resource_cache/resource_cache_small.mdl")
	ent:Spawn()

	return ent
end

if SERVER then

	function ENT:ventResources()

		if self.vent == true then

			for k, v in pairs(self.rdobject:getResources()) do
				self.rdobject:consumeResource(k, 1000)
			end
		end
	end


	function ENT:Use()

		self.vent = not self.vent
		self:EmitSound(Sound("/common/warning.wav"))
	end



	function ENT:Think()

		if self.vent == true then
			self:ventResources()
		end

		self:NextThink(CurTime() + 2)
	end
end



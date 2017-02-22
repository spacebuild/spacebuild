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

local baseClass = baseclass.Get("base_resource_entity")

ENT.PrintName = "Energy storage"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""
ENT.Category        = "Spacebuild"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:Initialize()
	baseClass.Initialize(self)
	if SERVER then
		self.rdobject:addResource("energy", 500, 0)
		self.energygen = 8
		self.active = true
	end
end

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_storage_energy")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/ce_ls3additional/resource_cache/resource_cache_small.mdl")
	ent:SetHealth(100)
	ent:SetMaxHealth(100)
	ent:Spawn()

	return ent
end



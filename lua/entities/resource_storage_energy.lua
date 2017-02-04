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



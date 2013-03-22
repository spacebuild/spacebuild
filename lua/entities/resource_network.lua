AddCSLuaFile()

DEFINE_BASECLASS("base_resource_network")

ENT.PrintName = "Small Resource Network"
ENT.Author = "SnakeSVx & Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminOnly = false

ENT.hud = {
	vector = Vector(-32.5, 17.5, 5.2),
	scale = 0.1
}

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_network")
	ent:SetModel("models/ce_ls3additional/screens/small_screen.mdl") --Only have to set it serverside
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:Spawn()

	return ent
end



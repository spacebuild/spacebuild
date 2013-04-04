AddCSLuaFile()

DEFINE_BASECLASS("base_resource_entity")

ENT.PrintName = "Oxygen Storage"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:Initialize()
	BaseClass.Initialize(self)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		self.rdobject:addResource("oxygen", 500, 0)
		--self:PhysWake()
	end
end

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_storage_oxygen")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/ce_ls3additional/resource_cache/resource_cache_small.mdl")
	ent:Spawn()

	return ent
end



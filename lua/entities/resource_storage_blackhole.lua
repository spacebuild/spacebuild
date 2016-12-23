--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 30/12/12
-- Time: 00:01
-- To change this template use File | Settings | File Templates.
--

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



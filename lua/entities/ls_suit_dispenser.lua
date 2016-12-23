AddCSLuaFile()

DEFINE_BASECLASS("base_resource_generator")

ENT.PrintName = "LS Suit Dispenser"
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

		self.rdobject:addResource("energy", 0, 0)
		self.rdobject:addResource("oxygen", 0, 0)
		for _, res in pairs(GAMEMODE:getRegisteredCoolants()) do
			self.rdobject:addResource(res, 0, 0)
		end
		self.energygen = 8
		self.active = true
	end
end

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("ls_suit_dispenser")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/hunter/blocks/cube1x1x1.mdl")
	ent:Spawn()

	return ent
end

function ENT:Use(ply)
	if ply:IsPlayer() and ply.ls_suit then
		ply.ls_suit:setActive(true)
		ply.ls_suit:setOxygen(GAMEMODE.constants.suit.MAX_OXYGEN)
		ply.ls_suit:setCoolant(GAMEMODE.constants.suit.MAX_COOLANT)
		ply.ls_suit:setEnergy(GAMEMODE.constants.suit.MAX_ENERGY)
	end
end



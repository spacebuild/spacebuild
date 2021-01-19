AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
DEFINE_BASECLASS("base_sb_environment")

function ENT:Initialize(skipCompatibility)
	BaseClass.Initialize(self)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetNotSolid(true)
	self:DrawShadow(false)

	if CAF then
		self.caf = self.caf or {}
		self.caf.custom = self.caf.custom or {}
		self.caf.custom.canreceivedamage = false
		self.caf.custom.canreceiveheatdamage = false
	end

	if not skipCompatibility then
		self.sbenvironment.temperature2 = 0
		self.sbenvironment.temperature3 = 0
	end
end

function ENT:TryApplyPlayerDamage(ent)
	if not ent:IsPlayer() then return end
	local pos = ent:GetPos()
	local entpos = ent:GetPos()
	local SunAngle = (entpos - pos)
	SunAngle:Normalize()

	local tr = util.TraceLine({
		start = entpos - (SunAngle * 4096),
		endpos = entpos + Vector(0, 0, 30)
	})

	--TODO: This logic should not live in `GetTemperature`
	if tr.Hit and tr == ent.Entity and ent:IsPlayer() and ent:Health() > 0 then
		ent:TakeDamage(5, 0)
		ent:EmitSound("HL2Player.BurnPain")
	end
end

function ENT:GetTemperature(ent)
	if not ent then return end
	self:TryApplyPlayerDamage(ent)
	local dist = pos:Distance(self:GetPos())
	local size = self:GetSize()
	if dist < size / 6 then return self.sbenvironment.temperature end
	if dist < size * 1 / 3 then return self.sbenvironment.temperature * 2 / 3 end
	if dist < size * 1 / 2 then return self.sbenvironment.temperature / 3 end
	if dist < size * 2 / 3 then return self.sbenvironment.temperature / 6 end
	if self.sbenvironment.temperature / 12 <= 14 then return 14 end --Check that it isn't colder then Space, else return Space temperature
	--All other checks failed, player is the farest away from the star, but temp is still warmer then space, return that temperature

	return self.sbenvironment.temperature / 12
end

function ENT:CreateEnvironment(radius)
	if radius and type(radius) == "number" then
		if radius < 0 then
			radius = 0
		end

		self.sbenvironment.size = radius * 2
	end

	BaseClass.CreateEnvironment(self, 0, 100, 100000, 0, 0, 100, 0, "Star")
	self:SendSunBeam()
end

function ENT:UpdateEnvironment(radius)
	if radius and type(radius) == "number" then
		self:UpdateSize(self.sbenvironment.size, radius)
	end

	self:SendSunBeam()
end

function ENT:GetPriority()
	return 2
end

function ENT:IsStar()
	return true
end

function ENT:CanTool()
	return false
end

function ENT:GravGunPunt()
	return false
end

function ENT:GravGunPickupAllowed()
	return false
end

function ENT:Remove()
	BaseClass.Remove(self)
	table.remove(TrueSun, self:GetPos())
end

function ENT:SendSunBeam(ply)
	net.Start("AddStar")
	net.WriteEntity(self)
	net.WriteString(self:GetName())
	net.WriteFloat(self.sbenvironment.size)

	if ply then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

util.AddNetworkString("AddStar")
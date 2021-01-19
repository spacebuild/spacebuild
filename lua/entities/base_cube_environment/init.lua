AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
require("caf_util")
DEFINE_BASECLASS("base_sb_environment")

function ENT:Initialize()
	BaseClass.Initialize(self)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self.sbenvironment.temperature2 = 0
	self.sbenvironment.sunburn = false
	self.sbenvironment.unstable = false
	self:SetNotSolid(true)
	self:DrawShadow(false)

	if CAF then
		self.caf = self.caf or {}
		self.caf.custom = self.caf.custom or {}
		self.caf.custom.canreceivedamage = false
		self.caf.custom.canreceiveheatdamage = false
	end
end

function ENT:GetSunburn()
	return self.sbenvironment.sunburn
end

function ENT:GetUnstable()
	return self.sbenvironment.unstable
end

function ENT:SetFlags(flags)
	if not flags or type(flags) ~= "number" then return end
	self.sbenvironment.unstable = caf_util.isBitSet(flags, 1)
	self.sbenvironment.sunburn = caf_util.isBitSet(flags, 2)
end

function ENT:GetTemperature(ent)
	if not ent then return end
	local entpos = ent:GetPos()
	local lit = false
	local SunAngle2 = SunAngle
	local SunAngle

	for k, v in pairs(TrueSun) do
		SunAngle = (entpos - v)
		SunAngle:Normalize()

		local tr = util.TraceLine({
			start = entpos - (SunAngle * 4096),
			endpos = entpos -- + Vector(0,0,30)
		})

		if not tr.Hit then
			lit = true
			continue
		end

		if (tr.Entity ~= ent) then continue end
		lit = true

		if self.sbenvironment.sunburn and ent:IsPlayer() and ent:Health() > 0 then
			ent:TakeDamage(5, 0)
			ent:EmitSound("HL2Player.BurnPain")
		end
	end

	local tr = util.TraceLine({
		start = entpos - (SunAngle2 * 4096),
		entpos
	})

	-- + Vector(0,0,30)
	if tr.Hit then
		if tr.Entity == ent then
			lit = true

			if self.sbenvironment.sunburn and ent:IsPlayer() and ent:Health() > 0 then
				ent:TakeDamage(5, 0)
				ent:EmitSound("HL2Player.BurnPain")
			end
		end
	else
		lit = true
	end

	if lit and self.sbenvironment.temperature2 then return self.sbenvironment.temperature2 + ((self.sbenvironment.temperature2 * ((self:GetCO2Percentage() - self.sbenvironment.air.co2per) / 100)) / 2) end
	if not self.sbenvironment.temperature then return 0 end

	return self.sbenvironment.temperature + ((self.sbenvironment.temperature * ((self:GetCO2Percentage() - self.sbenvironment.air.co2per) / 100)) / 2)
end

function ENT:Unstable()
	if self.sbenvironment.unstable then
		if (math.random(1, 20) < 2) then end --self:GetParent():Fire("invalue", "shake", "0") --self:GetParent():Fire("invalue", "rumble", "0")
	end
end

function ENT:GetPriority()
	return 1
end

function ENT:CreateEnvironment(ent, radius, gravity, atmosphere, pressure, temperature, temperature2, o2, co2, n, h, flags, name)
	--needs a parent!
	if not ent then
		self:Remove()
	end

	self:SetParent(ent)
	self:SetFlags(flags)

	--set Radius if one is given
	if radius and type(radius) == "number" then
		if radius < 0 then
			radius = 0
		end

		self.sbenvironment.size = radius
	end

	--set temperature2 if given
	if temperature2 and type(temperature2) == "number" then
		self.sbenvironment.temperature2 = temperature2
	end

	BaseClass.CreateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n, h, name)
end

function ENT:UpdateEnvironment(radius, gravity, atmosphere, pressure, temperature, o2, co2, n, h, temperature2, flags)
	if radius and type(radius) == "number" then
		self:SetFlags(flags)
		self:UpdateSize(self.sbenvironment.size, radius)
	end

	--set temperature2 if given
	if temperature2 and type(temperature2) == "number" then
		self.sbenvironment.temperature2 = temperature2
	end

	BaseClass.UpdateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n, h)
end

function ENT:IsPlanet()
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

function ENT:Think()
	self:Unstable()
	self:NextThink(CurTime() + 1)

	return true
end

function ENT:OnEnvironment(ent, environment, space)
	if not ent then return end
	if ent == self then return end
	local pos = ent:GetPos()
	local cen = self:GetPos()
	local size = self:GetSize()

	--local dist = pos:Distance(self:GetPos())
	if (pos.x < cen.x + size and pos.x > cen.x - size) and (pos.y < cen.y + size and pos.y > cen.y - size) and (pos.z < cen.z + size and pos.z > cen.z - size) then
		--if dist < (self:GetSize()*1.5) then
		--	local min = pos - Vector(self:GetSize(),self:GetSize(),self:GetSize())
		--	local max = pos + Vector(self:GetSize(),self:GetSize(),self:GetSize())
		--	if table.HasValue(ents.FindInBox( min, max ), ent) then
		if environment == space then
			environment = self
		else
			if environment:GetPriority() < self:GetPriority() then
				environment = self
			elseif environment:GetPriority() == self:GetPriority() then
				if environment:GetSize() ~= 0 then
					if self:GetSize() <= environment:GetSize() then
						environment = self
					else
						if dist < pos:Distance(environment:GetPos()) then
							environment = self
						end
					end
				else
					environment = self
				end
			end
		end
		--end
	end

	return environment
end

function ENT:PosInEnvironment(pos, other)
	if other and other == self then return other end
	local pos = ent:GetPos()

	if (pos.x < cen.x + size and pos.x > cen.x - size) and (pos.y < cen.y + size and pos.y > cen.y - size) and (pos.z < cen.z + size and pos.z > cen.z - size) then
		if other then
			if other:GetPriority() < self:GetPriority() then
				return self
			elseif other:GetPriority() == self:GetPriority() then
				if self:GetSize() > other:GetSize() then return other end
			else
				return other
			end
		end

		return self
	end

	return other
end
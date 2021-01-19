AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
require("caf_util")
DEFINE_BASECLASS("base_sb_environment")

function ENT:Initialize(skipCompatibility)
	BaseClass.Initialize(self)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self.sbenvironment.temperature2 = 0
	self.sbenvironment.sunburn = false
	self.sbenvironment.unstable = false
	self:SetNotSolid(true)
	self:DrawShadow(false)

	if not skipCompatibility then
		self.sbenvironment.color = {}
		self.sbenvironment.bloom = {}
	end

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

function ENT:Unstable()
	if self.sbenvironment.unstable then
		if (math.random(1, 20) < 2) then end --self:GetParent():Fire("invalue", "shake", "0") --self:GetParent():Fire("invalue", "rumble", "0")
	end
end

function ENT:GetUnstable()
	return self.sbenvironment.unstable
end

function ENT:SetFlags(flags)
	if not flags or type(flags) ~= "number" then return end
	self.sbenvironment.habitat = caf_util.isBitSet(flags, 1)
	self.sbenvironment.unstable = caf_util.isBitSet(flags, 2)
	self.sbenvironment.sunburn = caf_util.isBitSet(flags, 3)
end

function ENT:GetTemperature(ent)
	if not ent then return end
	local entpos = ent:GetPos()
	local lit = false

	local tr = util.TraceLine({
		start = entpos - (SunAngle * 4096),
		endpos = entpos -- + Vector(0,0,30)
	})

	if not tr.Hit or tr.Entity == ent then
		lit = true
	end

	if not lit then
		for k, v in pairs(TrueSun) do
			local TrueSunAngle = (entpos - v)
			TrueSunAngle:Normalize()

			local tr2 = util.TraceLine({
				start = entpos - (TrueSunAngle * 4096),
				endpos = entpos -- + Vector(0,0,30)
			})

			if not tr2.Hit or tr2.Entity == ent then
				lit = true
				break
			end
		end
	end

	if lit and self.sbenvironment.sunburn and ent:IsPlayer() and ent:Health() > 0 then
		ent:TakeDamage(5, 0)
		ent:EmitSound("HL2Player.BurnPain")
	end

	local temperature = self.sbenvironment.temperature

	if lit and self.sbenvironment.temperature2 then
		temperature = self.sbenvironment.temperature2
	end

	if not temperature then return 0 end

	return temperature + ((temperature * ((self:GetCO2Percentage() - self.sbenvironment.air.co2per) / 100)) / 2)
end

function ENT:GetPriority()
	return 1
end

function ENT:CreateEnvironment(radius, gravity, atmosphere, temperature, temperature2, flags)
	self:SetFlags(flags)
	local o2 = 0
	local co2 = 0
	local n = 0
	local h = 0
	local pressure = atmosphere

	--set Radius if one is given
	if radius and type(radius) == "number" then
		if radius < 0 then
			radius = 0
		end

		self.sbenvironment.size = radius
	end

	--set temperature2 if given
	--Based on values for earth
	if self.sbenvironment.habitat then
		o2 = 21
		co2 = 0.45
		n = 78
		h = 0.55
	else --Based on values for Venus
		o2 = 0
		co2 = 96.5
		n = 3.5
		h = 0
	end

	if temperature2 and type(temperature2) == "number" then
		self.sbenvironment.temperature2 = temperature2
	end

	BaseClass.CreateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n, h, "Planet " .. tostring(self:GetEnvironmentID()))
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

function ENT:SendData(ply)
	net.Start("AddPlanet")
	net.WriteEntity(self) --planet.num
	net.WriteString(self:GetEnvironmentName())
	net.WriteFloat(self.sbenvironment.size)

	if self.sbenvironment.bloom ~= nil then
		net.WriteBool(true)
		net.WriteInt(self.sbenvironment.bloom.Col_r, 16)
		net.WriteInt(self.sbenvironment.bloom.Col_g, 16)
		net.WriteInt(self.sbenvironment.bloom.Col_b, 16)
		net.WriteFloat(self.sbenvironment.bloom.SizeX)
		net.WriteFloat(self.sbenvironment.bloom.SizeY)
		net.WriteFloat(self.sbenvironment.bloom.Passes)
		net.WriteFloat(self.sbenvironment.bloom.Darken)
		net.WriteFloat(self.sbenvironment.bloom.Multiply)
		net.WriteFloat(self.sbenvironment.bloom.Color)
	else
		net.WriteBool(false)
	end

	if self.sbenvironment.color ~= nil then
		net.WriteBool(true)
		net.WriteInt(self.sbenvironment.color.AddColor_r, 16)
		net.WriteInt(self.sbenvironment.color.AddColor_g, 16)
		net.WriteInt(self.sbenvironment.color.AddColor_b, 16)
		net.WriteInt(self.sbenvironment.color.MulColor_r, 16)
		net.WriteInt(self.sbenvironment.color.MulColor_g, 16)
		net.WriteInt(self.sbenvironment.color.MulColor_b, 16)
		net.WriteFloat(self.sbenvironment.color.Brightness)
		net.WriteFloat(self.sbenvironment.color.Contrast)
		net.WriteFloat(self.sbenvironment.color.Color)
	else
		net.WriteBool(false)
	end

	if ply then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

function ENT:BloomEffect(Col_r, Col_g, Col_b, SizeX, SizeY, Passes, Darken, Multiply, Color)
	if SB_DEBUG then
		Msg("Col_r/b/g: " .. tostring(Col_r) .. "/" .. tostring(Col_b) .. "/" .. tostring(Col_g) .. "\n")
		Msg("SizeX/Y: " .. tostring(SizeX) .. "/" .. tostring(SizeY) .. "\n")
		Msg("Passes: " .. tostring(Passes) .. "\n")
		Msg("Darken: " .. tostring(Darken) .. "\n")
		Msg("Multiply: " .. tostring(Multiply) .. "\n")
		Msg("Color: " .. tostring(Color) .. "\n")
	end

	if Col_r then
		self.sbenvironment.bloom.Col_r = Col_r
	end

	if Col_g then
		self.sbenvironment.bloom.Col_g = Col_g
	end

	if Col_b then
		self.sbenvironment.bloom.Col_b = Col_b
	end

	if SizeX then
		self.sbenvironment.bloom.SizeX = SizeX
	end

	if SizeY then
		self.sbenvironment.bloom.SizeY = SizeY
	end

	if Passes then
		self.sbenvironment.bloom.Passes = Passes
	end

	if Darken then
		self.sbenvironment.bloom.Darken = Darken
	end

	if Multiply then
		self.sbenvironment.bloom.Multiply = Multiply
	end

	if Color then
		self.sbenvironment.bloom.Color = Color
	end

	Msg("Sending bloom update\n")
	self:SendData()
end

function ENT:ColorEffect(AddColor_r, AddColor_g, AddColor_b, MulColor_r, MulColor_g, MulColor_b, Brightness, Contrast, Color)
	if SB_DEBUG then
		Msg("AddColor_r/b/g: " .. tostring(AddColor_r) .. "/" .. tostring(AddColor_b) .. "/" .. tostring(AddColor_g) .. "\n")
		Msg("AddColor_r/b/g: " .. tostring(MulColor_r) .. "/" .. tostring(MulColor_b) .. "/" .. tostring(MulColor_g) .. "\n")
		Msg("Brightness: " .. tostring(Brightness) .. "\n")
		Msg("Contrast: " .. tostring(Contrast) .. "\n")
		Msg("Color: " .. tostring(Color) .. "\n")
	end

	if AddColor_r then
		self.sbenvironment.color.AddColor_r = AddColor_r
	end

	if AddColor_g then
		self.sbenvironment.color.AddColor_g = AddColor_g
	end

	if AddColor_b then
		self.sbenvironment.color.AddColor_b = AddColor_b
	end

	if MulColor_r then
		self.sbenvironment.color.MulColor_r = MulColor_r
	end

	if MulColor_g then
		self.sbenvironment.color.MulColor_g = MulColor_g
	end

	if MulColor_b then
		self.sbenvironment.color.MulColor_b = MulColor_b
	end

	if Brightness then
		self.sbenvironment.color.Brightness = Brightness
	end

	if Contrast then
		self.sbenvironment.color.Contrast = Contrast
	end

	if Color then
		self.sbenvironment.color.Color = Color
	end

	Msg("Sending color update\n")
	self:SendData()
end

util.AddNetworkString("AddPlanet")
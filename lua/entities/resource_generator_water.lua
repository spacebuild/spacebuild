AddCSLuaFile()

DEFINE_BASECLASS("base_resource_generator")

ENT.PrintName = "Water Generator"
ENT.Author = "SnakeSVx & Radon"
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
		self.Entity:SetUseType(SIMPLE_USE)

		self.mute = false
		self.active = false
		self.thinkcount = 0

		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		self.rdobject:addResource("water", 0, 0)
		--self:PhysWake()
	end
end

function ENT:mute()
	if not self.mute then
		self.mute = true
	end
end

function ENT:unmute()
	if self.mute then
		self.mute = false
	end
end


function ENT:turnOn()
	BaseClass.turnOn(self)

	if not self.mute then
		self:EmitSound("Airboat_engine_idle")
	end

	self.sequence = self:LookupSequence("walk")
	if self.sequence and self.sequence ~= -1 then
		self:SetSequence(self.sequence)
		self:ResetSequence(self.sequence)
		self:SetPlaybackRate(1)
	end

	self.active = true
end

function ENT:turnOff()
	BaseClass.turnOff(self)

	if not self.mute then
		self:StopSound("Airboat_engine_idle")
		self:EmitSound("Airboat_engine_stop")
		self:StopSound("apc_engine_start")
	end

	self.sequence = self:LookupSequence("idle")
	if self.sequence and self.sequence ~= -1 then
		self:SetSequence(self.sequence)
		self:ResetSequence(self.sequence)
		self:SetPlaybackRate(1)
	end

	self.active = false
end

function ENT:toggle()
	if self.active then
		self:turnOff()
	else
		self:turnOn()
	end
end

function ENT:Use()
	self:toggle()
end

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_generator_water")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/props_phx/life_support/gen_water.mdl")
	ent:Spawn()

	return ent
end

function ENT:getRate()

	local waterlevel = self:WaterLevel()
	local n = 0

	if waterlevel > 2 then
		n = 3
	elseif waterlevel > 0 then
		n = 2
	end

	return n
end


if SERVER then

	function ENT:Think()
		if self.active and self.thinkcount >= 10 then
			self.rdobject:supplyResource("water", math.Round(self:getRate()))
			self.thinkcount = 0
		end

		self.thinkcount = self.thinkcount + 1

		if self.sequence and self.sequence ~= -1 then
			self:ResetSequence(self.sequence)
			self:SetPlaybackRate(1)
		end

		self:NextThink(CurTime() + 0.1)
		return true
	end
end



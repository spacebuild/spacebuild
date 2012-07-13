AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "ambient.steam01" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Air", "Energy", "Coolant", "Max Air", "Max Energy", "Max Coolant" })
	end
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
		self:EmitSound( "PhysicsCannister.ThrusterLoop" )
		self:EmitSound( "ambient.steam01" )
	end
end

function ENT:Repair()
	self:SetColor(Color(255, 255, 255, 255))
	self.health = self.maxhealth
	self.damaged = 0
	self:StopSound( "PhysicsCannister.ThrusterLoop" )
	self:StopSound( "ambient.steam01" )
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self:StopSound( "PhysicsCannister.ThrusterLoop" )
	self:StopSound( "ambient.steam01" )
end

function ENT:Leak()
	local air = RD_GetResourceAmount(self, "air")
	local energy = RD_GetResourceAmount(self, "energy")
	local coolant = RD_GetResourceAmount(self, "coolant")
	if (air > 0) then
		if (air >= 100) then
			RD_ConsumeResource(self, "air", 100)
		else
			RD_ConsumeResource(self, "air", air)
			self:StopSound( "PhysicsCannister.ThrusterLoop" )
		end
	end
	if (energy > 0) then
		if (self.environment.inwater == 0) then
			zapme(self:GetPos(), 1)
			local tmp = ents.FindInSphere(self:GetPos(), 600)
			for _, ply in ipairs( tmp ) do
				if (ply:IsPlayer() and ply.suit.inwater > 0) then --??? wont that be zaping any player in any water??? should do a dist check first and have damage based on dist
					zapme(ply:GetPos(), 1)
					ply:TakeDamage((ply.suit.inwater * energy / 100), 0)
				end
			end
			self.maxenergy = RD_GetUnitCapacity(self, "energy")
			if (energy >= self.maxenergy) then --??? loose all energy on net when damaged and in water??? that sounds crazy to me
				RD_ConsumeResource(self, "energy", self.maxenergy)
			else
				RD_ConsumeResource(self, "energy", energy)
			end
		else
			if (math.random(1, 10) < 2) then
				zapme(self:GetPos(), 1)
				local dec = math.random(200, 2000)
				if (energy > dec) then
					RD_ConsumeResource(self, "energy", dec)
				else
					RD_ConsumeResource(self, "energy", energy)
				end
			end
		end
	end
	if (coolant > 0) then
		if (coolant >= 100) then
			RD_ConsumeResource(self, "coolant", 100)
		else
			RD_ConsumeResource(self, "coolant", coolant)
			self:StopSound( "ambient.steam01" )
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if (self.damaged == 1) then  --should these leak relitive to damage?
		self:Leak()
	end
	
	if not (WireAddon == nil) then 
		self:UpdateWireOutput()
	end
	
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:UpdateWireOutput()
	local air = RD_GetResourceAmount(self, "air")
	local energy = RD_GetResourceAmount(self, "energy")
	local coolant = RD_GetResourceAmount(self, "coolant")
	local maxair = RD_GetNetworkCapacity(self, "air")
	local maxcoolant = RD_GetNetworkCapacity(self, "coolant")
	local maxenergy = RD_GetNetworkCapacity(self, "energy")
	
	Wire_TriggerOutput(self, "Air", air)
	Wire_TriggerOutput(self, "Energy", energy)
	Wire_TriggerOutput(self, "Coolant", coolant)
	Wire_TriggerOutput(self, "Max Air", maxair)
	Wire_TriggerOutput(self, "Max Energy", maxenergy)
	Wire_TriggerOutput(self, "Max Coolant", maxcoolant)
end

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.energy = 0
	self.damaged = 0
	LS_RegisterEnt(self, "Storage")
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Energy", "Max Energy" })
	end
end

function ENT:Damage()
	if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:Repair()
	self:SetColor(Color(255, 255, 255, 255))
	self.health = self.maxhealth
	self.damaged = 0
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:Leak()
	local energy = RD_GetResourceAmount(self, "energy")
	if (self.environment.inwater == 0) then
		zapme(self:GetPos(), 1)
		local tmp = ents.FindInSphere(self:GetPos(), 600)
		for _, ply in ipairs( tmp ) do
			if (ply:IsPlayer()) then
				if (ply.suit.inwater > 0) then
					zapme(ply:GetPos(), 1)
					ply:TakeDamage( (ply.suit.inwater * energy / 100), 0 )
				end
			end
		end
		RD_ConsumeResource(self, "energy", energy)
	else
		if (math.random(1, 10) < 2) then
			zapme(self:GetPos(), 1)
			local dec = math.random(200, 2000)
			RD_ConsumeResource(self, "energy", dec)
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if ((self.damaged == 1) and (self.energy > 0)) then
		self:Leak()
	end
	
	if not (WireAddon == nil) then
		self:UpdateWireOutput()
	end
	
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:UpdateWireOutput()
	local energy = RD_GetResourceAmount(self, "energy")
	local maxenergy = RD_GetUnitCapacity(self, "energy")
	Wire_TriggerOutput(self, "Energy", energy)
	Wire_TriggerOutput(self, "Max Energy", maxenergy)
end

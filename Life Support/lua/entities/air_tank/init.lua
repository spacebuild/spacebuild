AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Air", "Max Air" })
	end
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self:StopSound( "PhysicsCannister.ThrusterLoop" )
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
		self:EmitSound( "PhysicsCannister.ThrusterLoop" )
	end
end

function ENT:Repair()
	self.health = self.maxhealth
	self.damaged = 0
	self:StopSound( "PhysicsCannister.ThrusterLoop" )
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:Leak()
	local air = RD_GetResourceAmount(self, "air")
	if (air >= 100) then
		RD_ConsumeResource(self, "air", 100)
	else
		RD_ConsumeResource(self, "air", air)
		self:StopSound( "PhysicsCannister.ThrusterLoop" )
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if (self.damaged == 1) then
		self:Leak()
	end
	
	if not (WireAddon == nil) then
		self:UpdateWireOutput()
	end
	
	self:NextThink( CurTime() +  1 )
	return true
end

function ENT:UpdateWireOutput()
	local air = RD_GetResourceAmount(self, "air")
	local maxair = RD_GetNetworkCapacity(self, "air")
	Wire_TriggerOutput(self, "Air", air)
	Wire_TriggerOutput(self, "Max Air", maxair)
end

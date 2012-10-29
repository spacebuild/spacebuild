AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Coolant", "Max Coolant" })
	end
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
		self:EmitSound( "PhysicsCannister.ThrusterLoop" )
	end
end

function ENT:Repair()
	self:SetColor(Color(255, 255, 255, 255))
	self.health = self.max_health
	self.damaged = 0
	self:StopSound( "PhysicsCannister.ThrusterLoop" )
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self:StopSound( "PhysicsCannister.ThrusterLoop" )
end

function ENT:Leak()
	local coolant = RD_GetResourceAmount(self, "coolant")
	if (coolant >= 100) then
		RD_ConsumeResource(self, "coolant", 100)
	else
		RD_ConsumeResource(self, "coolant", coolant)
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
	
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:UpdateWireOutput()
	local coolant = RD_GetResourceAmount(self, "coolant")
	local maxcoolant = RD_GetNetworkCapacity(self, "coolant")
	Wire_TriggerOutput(self, "Coolant", coolant)
	Wire_TriggerOutput(self, "Max Coolant", maxcoolant)
end

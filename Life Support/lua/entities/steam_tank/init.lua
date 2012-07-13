AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	self.time = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self.Entity, { "Steam", "Max Steam" })
	end
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self.Entity:StopSound( "PhysicsCannister.ThrusterLoop" )
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
		self.Entity:EmitSound( "PhysicsCannister.ThrusterLoop" )
	end
end

function ENT:Repair()
	self.health = self.maxhealth
	self.damaged = 0
	self.Entity:StopSound( "PhysicsCannister.ThrusterLoop" )
end

function ENT:Destruct()
	LS_Destruct( self.Entity, true )
end

function ENT:Leak()
	local steam = RD_GetResourceAmount(self, "steam")
	if (steam >= 100) then
		RD_ConsumeResource(self, "steam", 100)
	else
		RD_ConsumeResource(self, "steam", steam)
		self.Entity:StopSound( "PhysicsCannister.ThrusterLoop" )
	end
end

function ENT:Cooldown()
	local steam = RD_GetResourceAmount(self, "steam")
	if (steam >= 5) then
		RD_ConsumeResource(self, "steam", 5)
		RD_SupplyResource(self, "water", 5 )
	else
		RD_ConsumeResource(self, "steam", steam)
		RD_SupplyResource(self, "water", math.Round( steam ))
	end
	self.time = 0
end

function ENT:Think()
	self.BaseClass.Think(self)
	if self.time > 10 then
		self:Cooldown()
	else
		self.time = self.time + 1
	end
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
	local steam = RD_GetResourceAmount(self, "steam")
	local maxsteam = RD_GetNetworkCapacity(self, "steam")
	Wire_TriggerOutput(self.Entity, "Steam", steam)
	Wire_TriggerOutput(self.Entity, "Max Steam", maxsteam)
end

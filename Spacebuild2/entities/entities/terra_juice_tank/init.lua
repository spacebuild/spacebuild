AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Terra Juice", "Max Terra Juice" })
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
	self:SetColor(Color(255, 255, 255, 255))
	self.health = self.max_health
	self.damaged = 0
	self:StopSound( "PhysicsCannister.ThrusterLoop" )
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:Leak()
	local terrajuice = RD_GetResourceAmount(self, "terrajuice")
	if (terrajuice >= 100) then
		RD_ConsumeResource(self, "terrajuice", 100)
	else
		RD_ConsumeResource(self, "terrajuice", terrajuice)
		self:StopSound( "PhysicsCannister.ThrusterLoop" )
	end
end

function ENT:UpdateMass()
	--change mass
	if(!self.mass) then return end
	local mass = self.mass  + (RD_GetResourceAmount(self, "terrajuice") * 1.25)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		if phys:GetMass() ~= mass then
			phys:SetMass(mass)
			phys:Wake()
		end
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
	
	self:UpdateMass()
	
	self:NextThink(CurTime() + 1)
	return true
end

function ENT:UpdateWireOutput()
	local terrajuice = RD_GetResourceAmount(self, "terrajuice")
	local maxterrajuice = RD_GetNetworkCapacity(self, "terrajuice")
	Wire_TriggerOutput(self, "Terra Juice", terrajuice)
	Wire_TriggerOutput(self, "Max Terra Juice", maxterrajuice)
end

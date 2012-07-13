AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	self.vent = false
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self.Entity, { "Vent" })
		self.Outputs = Wire_CreateOutputs(self.Entity, { "Hot Liquid Nitrogen", "Max Hot Liquid Nitrogen" })
	else
		self.Inputs = {{Name="Vent"}}
	end
	self.caf.custom.masschangeoverride = true
end

function ENT:TriggerInput(iname, value)
	if (iname == "Vent") then
		if (value ~= 1) then
			self.vent = false
		else
			self.vent = true
		end
	end
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
		self.Entity:EmitSound( "PhysicsCannister.ThrusterLoop" )--Change to a new Liquid Vent/Escaping Sound
	end
end

function ENT:Repair()
	self.BaseClass.Repair(self)
	self.Entity:SetColor(255, 255, 255, 255)
	self.Entity:StopSound( "PhysicsCannister.ThrusterLoop" )--Change to a new air Vent/Escaping Sound
	self.damaged = 0
end

function ENT:Destruct()
	if CAF and CAF.GetAddon("Life Support") then
		CAF.GetAddon("Life Support").Destruct( self.Entity, true )
	end
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self.Entity:StopSound( "PhysicsCannister.ThrusterLoop" )--Change to a new Liquid Vent/Escaping Sound
end

function ENT:Leak()
	local coolant = self:GetResourceAmount("hot liquid nitrogen")
	if (coolant >= 100) then
		self:ConsumeResource("hot liquid nitrogen", 100)
	else
		self:ConsumeResource("hot liquid nitrogen", coolant)
		self.Entity:StopSound( "PhysicsCannister.ThrusterLoop" )--Change to a new Liquid Vent/Escaping Sound
	end
end

function ENT:UpdateMass()
	local mul = 0.12
	local div = math.Round(self:GetNetworkCapacity("hot liquid nitrogen")/self.MAXRESOURCE)
	local mass = self.mass + ((self:GetResourceAmount("hot liquid nitrogen") * mul)/div) -- self.mass = default mass + need a good multiplier
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		if phys:GetMass() ~= mass then
			phys:SetMass(mass)
			phys:Wake()
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	if (self.damaged == 1 or self.vent) then
		self:Leak()
	end
	if not (WireAddon == nil) then
		self:UpdateWireOutput()
	end
	self:UpdateMass()
	self.Entity:NextThink(CurTime() + 1)
	return true
end

function ENT:UpdateWireOutput()
	local coolant =  self:GetResourceAmount("hot liquid nitrogen")
	local maxcoolant = self:GetNetworkCapacity("hot liquid nitrogen")
	Wire_TriggerOutput(self.Entity, "Hot Liquid Nitrogen", coolant)
	Wire_TriggerOutput(self.Entity, "Max Hot Liquid Nitrogen", maxcoolant)
end

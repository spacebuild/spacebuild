AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "apc_engine_start" )
util.PrecacheSound( "apc_engine_stop" )
util.PrecacheSound( "common/warning.wav" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.terrajuice = 0
	self.energy = 0
	self.damaged = 0
	self.time = 0
	self.broken = false
	LS_RegisterEnt(self, "TerraForm")
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self, { "On" })
		self.Outputs = Wire_CreateOutputs(self, { "On" })
	end
	self.lifetime = math.random(1800,2600)		--Generate a lifespan
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self:EmitSound( "apc_engine_start" )
		self.Active = 1
		self:SetOOO(self.Active)
		if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", 1) end
	end
end

function ENT:TurnOff() --do we really what to be able to turn it off so easily, or at all?
	if (self.Active == 1) then
		self:StopSound( "apc_engine_start" )
		self:EmitSound( "apc_engine_stop" )
		self.Active = 0
		self.time = 0
		self:SetOOO(self.Active)
		if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", 0) end
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive(value)
	end
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
	end
	if ((self.Active == 1) and (math.random(1, 10) <= 3)) then
		self:TurnOff()
	end
end

function ENT:Repair()
	if self.Active == 1 then return end -- cannot be repaired while on!.
	self.health = self.maxhealth
	self.terrajuice = 0
	self.energy = 0
	self.damaged = 0
	self.time = 0 
	self.lifetime = math.random(1800,2600)		--Generate a lifespan
	self.broken = false
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	if self.planet and SB_GetTerraformer(self.planet) and SB_GetTerraformer(self.planet) == self then 
		SB_Terraform_UnStep(self, self.planet)
		SB_RemTerraformer(self.planet, self)
	end
	self:StopSound( "apc_engine_start" )
end

function ENT:Terra_Form()
	self.terrajuice = RD_GetResourceAmount(self, "terrajuice")
	self.energy = RD_GetResourceAmount(self, "energy")
	self.time = self.time + 1
	if self.energy <= 0 or self.time > self.lifetime or not self.planet or not self.onplanet or (not SB_GetTerraformer(self.planet) or not SB_GetTerraformer(self.planet) == self) or self.terrajuice <= 0 then
		self.broken = true
		self:TurnOff()
		return
	end
	local valid, planet, _ , radius, gravity, habitat, atmosphere, ltemperature, stemperature, sunburn = SB_Get_Environment_Info(self.planet)
	if not valid or not planet then self:TurnOff() return end
	RD_ConsumeResource(self, "energy",math.ceil(radius/64))
	RD_ConsumeResource(self, "terrajuice",math.ceil(radius/128))
	self.terrajuice = RD_GetResourceAmount(self, "terrajuice")
	self.energy = RD_GetResourceAmount(self, "energy")														//12 before
	if self.Active == 1 and (self.energy <= (math.ceil(radius/64)*180) or self.terrajuice <= (math.ceil(radius/512)*180)) then
		self:EmitSound( "common/warning.wav" )
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if not self.planet or not self.onplanet or self.broken then 
		self:TurnOff()
	end
	
	if self.Active == 1 then
		self:Terra_Form()
	end
	
	self:NextThink(CurTime() + 1)
	return true
end



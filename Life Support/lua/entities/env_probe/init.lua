AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

util.PrecacheSound( "Buttons.snd17" )

include('shared.lua')

local Energy_Increment = 4
local BeepCount = 3

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	self.gravity2 = 1
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self, { "On" })
		self.Outputs = Wire_CreateOutputs(self, { "Habitat", "Pressure", "Temperature", "Gravity", "On" })
	end
	--self:ShowOutput()
end

function ENT:TurnOn()
	self:EmitSound( "Buttons.snd17" )
	self.Active = 1
	self:SetOOO(1)
	self:Sense()
	self:ShowOutput()
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", 1) end
end

function ENT:TurnOff(warn)
	if (!warn) then self:EmitSound( "Buttons.snd17" ) end
	self.Active = 0
	self:SetOOO(0)
	self:ShowOutput()
	if not (WireAddon == nil) then
		Wire_TriggerOutput(self, "On", 0)
		Wire_TriggerOutput(self, "Habitat", 0)
		Wire_TriggerOutput(self, "Pressure", 0)
		Wire_TriggerOutput(self, "Temperature", 0)
		Wire_TriggerOutput(self, "Gravity", 0)
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive( value )
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

function ENT:Sense()
	if (RD_GetResourceAmount(self, "energy") <= 0) then
		self:EmitSound( "common/warning.wav" )
		self:TurnOff(true)
		return
	else
		if (BeepCount > 0) then
			BeepCount = BeepCount - 1
		else
			self:EmitSound( "Buttons.snd17" )
			BeepCount = 20 --30 was a little long, 3 times a minute is ok
		end
	end
	if self.planet then
		self.gravity2 = self.gravity
	else
		self.gravity2 = 0
	end
	if (self.damaged == 1) then
		local test = math.random(1, 10)
		if (test <= 2) then
			self.environment.habitat = math.random(0, 1)
		elseif (test <= 3) then
			self.environment.atmosphere = self.environment.atmosphere + math.random(-100, 100)
		elseif (test <= 4) then
			self.environment.temperature = self.environment.temperature + math.random((1 - self.environment.temperature), self.environment.temperature)
		elseif (test <= 5) then
			self.gravity2 = self.gravity + math.random(-1, 1)
		end
	end
	self.gravity2 = self.gravity2 * 100
	if not (WireAddon == nil) then
		Wire_TriggerOutput(self, "Habitat", self.environment.habitat)
		Wire_TriggerOutput(self, "Pressure", self.environment.atmosphere)
		Wire_TriggerOutput(self, "Temperature", self.environment.temperature)
		Wire_TriggerOutput(self, "Gravity", self.gravity2)
	end
	RD_ConsumeResource(self, "energy", Energy_Increment)
end

function ENT:ShowOutput()

	self.dt.Habitable = self.environment.habitat
	self.dt.Pressure = self.environment.atmosphere
	self.dt.Temperature = self.environment.temperature
	self.dt.Gravity = self.gravity or 0
	
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if (self.Active == 1) then
		self:Sense()
		self:ShowOutput()
	end
	
	self:NextThink(CurTime() + 1)
	return true
end

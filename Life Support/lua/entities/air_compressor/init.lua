AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "Airboat_engine_idle" )
util.PrecacheSound( "Airboat_engine_stop" )
util.PrecacheSound( "apc_engine_start" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Pressure_Increment = 80
local Energy_Increment = 10

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.overdrive = 0
	self.damaged = 0
	self.lastused = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self, { "On", "Overdrive" })
		self.Outputs = Wire_CreateOutputs(self, {"On", "Overdrive" })
	end
end

function ENT:TurnOn()
	self:EmitSound( "Airboat_engine_idle" )
	self.Active = 1
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
	if ( self.overdrive == 1 ) then
		self:TurnOnOverdrive()
	else
		self:SetOOO(1)
	end
end

function ENT:TurnOff()
	self:StopSound( "Airboat_engine_idle" )
	self:EmitSound( "Airboat_engine_stop" )
	self:StopSound( "apc_engine_start" )
	self.Active = 0
	self.overdrive = 0
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
	self:SetOOO(0)
end

function ENT:TurnOnOverdrive()
	if ( self.Active == 1 ) then
		self:StopSound( "Airboat_engine_idle" )
		self:EmitSound( "Airboat_engine_idle" )
		self:EmitSound( "apc_engine_start" )
		self:SetOOO(2)
	end
	self.overdrive = 1
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Overdrive", self.overdrive) end
end

function ENT:TurnOffOverdrive()
	if ( self.Active == 1 ) then
		self:StopSound( "Airboat_engine_idle" )
		self:EmitSound( "Airboat_engine_idle" )
		self:StopSound( "apc_engine_start" )
		self:SetOOO(1)
	end
	self.overdrive = 0
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Overdrive", self.overdrive) end
end

function ENT:SetActive( value )
	if not (value == nil) then
		if (value ~= 0 and self.Active == 0 ) then
			self:TurnOn()
		elseif (value == 0 and self.Active == 1 ) then
			self:TurnOff()
		end
	else
		if ( self.Active == 0 ) then
			self.lastused = CurTime()
			self:TurnOn()
		else
			if ((( CurTime() - self.lastused) < 2 ) and ( self.overdrive == 0 )) then
				self:TurnOnOverdrive()
			else
				self.overdrive = 0
				self:TurnOff()
			end
		end
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive(value)
	elseif (iname == "Overdrive") then
		if (value > 0) then
			self:TurnOnOverdrive()
		else
			self:TurnOffOverdrive()
		end
	end
end

function ENT:Damage()
	if (self.damaged == 0) then self.damaged = 1 end
	if ((self.Active == 1) and (math.random(1, 10) <= 4)) then
		self:TurnOff()
	end
end

function ENT:Repair()
	self:SetColor(Color(255, 255, 255, 255))
	self.health = self.maxhealth
	self.damaged = 0
end

function ENT:Destruct()
	LS_Destruct( self )
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self:StopSound( "Airboat_engine_idle" )
end

function ENT:Pump_Air()
	self.energy = RD_GetResourceAmount(self, "energy")
	local div = 1
	if not self.onplanet then
		div = 2
	end
	local einc = Energy_Increment + (self.overdrive*Energy_Increment)
	if (self.energy >= einc) then
		local ainc = Pressure_Increment/div
		if ( self.overdrive == 1 ) then
			ainc = ainc * 2
			DamageLS(self, math.random(2, 3))
		end
		RD_ConsumeResource(self, "energy", einc)
		RD_SupplyResource(self, "air", ainc)
	else
		self:TurnOff()
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if ( self.Active == 1 ) then
		if (self.environment.inwater == 1) then
			self:SetColor(Color(50, 50, 50, 255))
			self:TurnOff()
			self:Destruct()
		elseif (self.environment.habitat == 0) then
			self:TurnOff()
		else
			self:Pump_Air()
		end
	end
	
	self:NextThink( CurTime() + 1 )
	return true
end

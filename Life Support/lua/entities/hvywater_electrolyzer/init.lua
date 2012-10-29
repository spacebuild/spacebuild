AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "apc_engine_start" )
util.PrecacheSound( "apc_engine_stop" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Energy_Increment = 320
local Water_Increment = 640
local HW_Increment = 1

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
	self:EmitSound( "apc_engine_start" )
	self.Active = 1
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
	if ( self.overdrive == 1 ) then
		self:TurnOnOverdrive()
	else
		self:SetOOO(1)
	end
end

function ENT:TurnOff()
	self:StopSound( "apc_engine_start" )
	self:EmitSound( "apc_engine_stop" )
	self.Active = 0
	self.overdrive = 0
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
	self:SetOOO(0)
end

function ENT:TurnOnOverdrive()
	if ( self.Active == 1 ) then
		self:StopSound( "apc_engine_start" )
		self:EmitSound( "apc_engine_start" )
		self:SetOOO(2)
	end
	self.overdrive = 1
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Overdrive", self.overdrive) end
end

function ENT:TurnOffOverdrive()
	if ( self.Active == 1 ) then
		self:StopSound( "apc_engine_start" )
		self:EmitSound( "apc_engine_start" )
		self:SetOOO(1)
	end
	self.overdrive = 0
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Overdrive", self.overdrive) end
end

function ENT:SetActive( value )
	if (value) then
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
		if (value ~= 0) then
			self:TurnOnOverdrive()
		else
			self:TurnOffOverdrive()
		end
	end
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
	end
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
	LS_Destruct( self, true )
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self:StopSound( "apc_engine_start" )
end

function ENT:Proc_Water()
	local energy = RD_GetResourceAmount(self, "energy")
	local water = RD_GetResourceAmount(self, "water")
	local einc = Energy_Increment + (self.overdrive*Energy_Increment*3)
	local winc = Water_Increment + (self.overdrive*Water_Increment*3)

	if (energy >= einc and water >= winc) then
		if ( self.overdrive == 1 ) then
			DamageLS(self, math.random(2, 3))
		end
		RD_ConsumeResource(self, "energy", einc)
		RD_ConsumeResource(self, "water", winc)

		-- 1 in 5 chance of producing heavy water (slightly higher when in overdrive mode)
		local wchance = math.random(1,5)
		if (wchance <= 1+(self.overdrive)) then 
			RD_SupplyResource(self, "heavy water", HW_Increment)
		end
	else
		self:TurnOff()
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if ( self.Active == 1 ) then self:Proc_Water() end
	
	self:NextThink( CurTime() + 1 )
	return true
end


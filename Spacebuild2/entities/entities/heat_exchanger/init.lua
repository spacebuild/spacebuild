AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "apc_engine_start" )
util.PrecacheSound( "apc_engine_stop" )
util.PrecacheSound( "common/warning.wav" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Energy_Increment = 5
local Coolant_Increment = 5

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self, { "On" })
		self.Outputs = Wire_CreateOutputs(self, { "Out" })
	end
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self:EmitSound( "apc_engine_start" )
		self.Active = 1
		self.HasHeat = true
		if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", self.Active) end
		self:SetOOO(self.Active)
	end
end

function ENT:TurnOff()
	if (self.Active == 1) then
		self:StopSound( "apc_engine_start" )
		self:EmitSound( "apc_engine_stop" )
		self.Active = 0
		self.HasHeat = false
		if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", self.Active) end
		self:SetOOO(self.Active)
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive( value )
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

function ENT:Pump_Heat()
	if not self.environment then return end
	self.coolant = RD_GetResourceAmount(self, "coolant")
	self.energy = RD_GetResourceAmount(self, "energy")
	
	if (((self.coolant <= 0) and (self.environment.temperature > FairTemp_Max)) or ((self.energy <= 0) and (self.environment.temperature < FairTemp_Min))) then
		self.HasHeat = false
	else
		self.HasHeat = true
	end
	
	--this should work faster than FindInSphere
	if (self.HasHeat) then
		local MyPos = self:GetPos()
		for _, ply in pairs( player.GetAll() ) do
			local dist = (ply:GetPos() - MyPos):Length()
			if (dist <= self.environment.radius) then
				if self.environment.temperature < FairTemp_Min then
					RD_ConsumeResource(self, "energy", Energy_Increment)
				elseif self.environment.temperature > FairTemp_Max then
					RD_ConsumeResource(self, "coolant", Coolant_Increment)
				end
				if (ply.suit.energy < 100) then
					if ( (100 - ply.suit.energy) < self.energy ) then
						RD_ConsumeResource(self, "energy", 100 - ply.suit.energy)
						ply.suit.energy = 100
					elseif (self.energy > 0) then
						ply.suit.energy = ( ply.suit.energy + self.energy )
						RD_ConsumeResource(self, "energy", self.energy)
						self.HasHeat = false
					end
					RD_ConsumeResource(self, "energy", Energy_Increment)
				end
				if (ply.suit.coolant < 100) then
					if ( (100 - ply.suit.coolant) < self.coolant ) then
						RD_ConsumeResource(self, "coolant", 100 - ply.suit.coolant)
						ply.suit.coolant = 100
					elseif (self.coolant > 0) then
						ply.suit.coolant = ( ply.suit.coolant + self.coolant )
						RD_ConsumeResource(self, "coolant", self.coolant)
						self.HasHeat = false
					end
					RD_ConsumeResource(self, "coolant", Coolant_Increment)
				end
			end
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if ( self.Active == 1 ) then self:Pump_Heat() end
	
	self:NextThink(CurTime() + 1)
	return true
end


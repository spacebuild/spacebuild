AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "apc_engine_start" )
util.PrecacheSound( "apc_engine_stop" )
util.PrecacheSound( "common/warning.wav" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Energy_Increment = 5
local Air_Increment = 5

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
	self:EmitSound( "apc_engine_start" )
	self.Active = 1
	self.HasAir = true
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", self.Active) end
	self:SetOOO(1)
end

function ENT:TurnOff()
	self:StopSound( "apc_engine_start" )
	self:EmitSound( "apc_engine_stop" )
	self.Active = 0
	self.HasAir = false
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", self.Active) end
	self:SetOOO(0)
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

function ENT:Pump_Air()
	if not self.environment then return end
	self.air = RD_GetResourceAmount(self, "air")
	self.energy = RD_GetResourceAmount(self, "energy")
	if ((self.air <= 0) or (self.energy <= 0)) then
		self.HasAir = false
	else
		self.HasAir = true
	end
	--this should work faster than FindInSphere
	if (self.Active == 1) and (self.HasAir) then
		local MyPos = self:GetPos()
		for _, ply in pairs( player.GetAll() ) do
			local dist = (ply:GetPos() - MyPos):Length()
			if (dist <= self.environment.radius) then
				if ((self.environment.habitat == 0) or (ply.suit.inwater > 2)) then
					if (ply.suit.air < 100) then
						if ( (100 - ply.suit.air) < self.air ) then
							RD_ConsumeResource(self, "air", 100 - ply.suit.air)
							ply.suit.air = 100
						elseif (self.air > 0) then
							ply.suit.air = ( ply.suit.air + self.air )
							RD_ConsumeResource(self, "air", self.air)
						end
					end
					RD_ConsumeResource(self, "energy", Energy_Increment)
					if self.environment.atmosphere > 1 then
						RD_ConsumeResource(self, "air", Air_Increment + ((self.environment.atmosphere-1)* Air_Increment))
					else
						RD_ConsumeResource(self, "air", Air_Increment)
					end
				end
			end
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if ( self.Active == 1 ) then self:Pump_Air() end
	
	self:NextThink( CurTime() +  1 )
	return true
end

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "common/warning.wav" )
util.PrecacheSound( "Buttons.snd17" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Pressure_Increment = 3
local Energy_Increment = 5

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	self.Active = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self.Entity, { "On" })
		self.Outputs = Wire_CreateOutputs(self.Entity, { "Out" })
	end
end

function ENT:TurnOn()
	self.Entity:EmitSound( "Buttons.snd17" )
	self.Active = 1
	self:SetOOO(1)
	if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Out", self.Active) end
end
function ENT:TurnOff()
	self.Entity:EmitSound( "Buttons.snd17" )
	self.Active = 0
	self:SetOOO(0)
	if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Out", self.Active) end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive(value)
	end
end

function ENT:Damage()
	if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:Repair()
	self.health = self.maxhealth
	self.damaged = 0
end

function ENT:Destruct()
	LS_Destruct( self.Entity, true )
end

function ENT:Pump_Air()
	self.energy = RD_GetResourceAmount(self, "energy")
	if (self.energy >= Energy_Increment) then
		local inc = 0
		if (self.damaged == 0) or (math.random(1, 10) > 4) then
			if (self.environment.atmosphere > 0) then inc = math.random(1, Pressure_Increment) end
			--TODO: dont use findinsphere
			if self.environment.inwater == 1 then
				inc = inc + 10
			else
				local tmp = ents.FindInSphere(self.Entity:GetPos(), self.radius)
				for _, ent in ipairs( tmp ) do
					if ent:IsPlayer() or (ent.environment and ent.environment.type and ent.environment.type == "Hydro_Air") then
						if not ent.water or ent.water > 1 then
							Msg("found working plant")
							inc = inc + math.random(3)
						end
					end
				end
			end
		end
		if (inc > 0) then
			RD_SupplyResource(self, "air", inc)
		end
		RD_ConsumeResource(self, "energy", Energy_Increment)
		if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Out", inc) end
	else
		self.Entity:EmitSound( "common/warning.wav" )
		if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Out", 0) end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	if ( self.Active == 1 ) then self:Pump_Air() end
	self:NextThink( CurTime() +  1)
	return true
end

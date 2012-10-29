AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "Airboat_engine_idle" )
util.PrecacheSound( "Airboat_engine_stop" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Energy_Increment = 60

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Out" })
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

function ENT:Extract_Energy()
	RD_SupplyResource(self, "energy", Energy_Increment)
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", Energy_Increment) end
end

function ENT:GenEnergy()
	if (self.environment.inwater == 1) then
		if (self.Active == 0) then
			self.Active = 1
			self:SetOOO(1)
		end
		if (self.damaged == 1) then
			if (math.random(1, 10) < 6) then self:Extract_Energy() end
		else
			self:Extract_Energy()
		end
	else
		if (self.Active == 1) then
			self.Active = 0
			self:SetOOO(0)
			if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", 0) end
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	self:GenEnergy()
	
	self:NextThink(CurTime() + 1) --0.8??? why not 1 like the rest?
	return true
end

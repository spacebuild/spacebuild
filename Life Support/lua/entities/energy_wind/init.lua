AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Energy_Increment = 40  --randomize for weather

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Out" })
	end
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self.Active = 1
		self:SetOOO(1)
	end
end

function ENT:TurnOff()
	if (self.Active == 1) then
		self.Active = 0
		self:SetOOO(0)
		if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", 0) end
	end
end

function ENT:SetActive() --disable use, lol
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
	LS_Destruct( self )
end

function ENT:Extract_Energy()
	local inc = 0
	if (self.damaged == 0) or (math.random(1, 10) < 6) then
		if self.environment.atmosphere > 0.2 then
			inc = math.random(1, (Energy_Increment * self.environment.atmosphere))
		end
		if (inc > 0) then
			if (inc > Energy_Increment) then inc = Energy_Increment end
			RD_SupplyResource(self, "energy", inc)
		end
	end
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", inc) end
end

function ENT:GenEnergy()
	if (self.environment.inwater == 1) then
		self:SetColor(Color(50, 50, 50, 255))
		self:TurnOff()
		self:Destruct()
	else
		self:Extract_Energy()
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if (self.environment.atmosphere > 0) then
		self:TurnOn()
	elseif (self.environment.atmosphere == 0) then
		self:TurnOff()
	end
	
	if (self.Active == 1) then
		self:GenEnergy()
	end
	
	self:NextThink(CurTime() + 1)
	return true
end

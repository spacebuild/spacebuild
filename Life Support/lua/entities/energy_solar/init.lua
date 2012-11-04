AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Energy_Increment = 20

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Outputs = Wire_CreateOutputs(self, { "Out" })
	end
	self:SetColor(Color( 10, 96, 180, 255 ))
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self.Active = 1
		if (self.damaged == 0) then self:SetColor(Color( 10, 96, 255, 255 )) end --light up blue when on
		self:SetOOO(1)
	end
end

function ENT:TurnOff()
	if (self.Active == 1) then
		self.Active = 0
		if (self.damaged == 0) then self:SetColor(Color( 10, 96, 180, 255 )) end --go dark when off
		self:SetOOO(0)
		if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", 0) end
	end
end

function ENT:Damage()
	if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:Repair()
	self:SetColor(Color( 10, 96, 255, 255 ))
	self.health = self.maxhealth
	self.damaged = 0
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:Extract_Energy()
	local inc = math.ceil(Energy_Increment / ((self.atmosphere or 1) + 1))
	if (self.damaged == 1) then inc = math.ceil(inc / 2) end
	if (inc > 0) then
		RD_SupplyResource(self, "energy", inc)
	end
	if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", inc) end
end


function ENT:GenEnergy()
	if (self.environment.inwater == 1) then
		self:TurnOff()
	else
		local entpos = self:GetPos()
		local trace = {}
		if not ( TrueSun == nil ) then
			SunAngle = (entpos - TrueSun)
			SunAngle:Normalize()
		end
		local startpos = (entpos - (SunAngle * 4096))
		trace.start = startpos
		trace.endpos = entpos
		trace.filter = self
		local tr = util.TraceLine( trace )
		if (tr.Hit) and (tr.Entity:IsValid()) then
			self:TurnOff()
		else
			self:TurnOn()
			self:Extract_Energy()
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	self:GenEnergy()
	
	self:NextThink(CurTime() + 1)
	return true
end

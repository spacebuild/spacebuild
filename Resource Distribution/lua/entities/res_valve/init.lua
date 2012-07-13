AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

util.PrecacheSound( "Buttons.snd17" )

ENT.OverlayDelay = 0

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	
	if not (WireAddon == nil) then 
		self.Inputs = Wire_CreateInputs(self.Entity, { "Open" })
		self.Outputs = Wire_CreateOutputs(self.Entity, { "Open" }) 
	end
	
	self.Active = 0
	self.resources2 = {}
	self.is_valve = true --makes it a valve
	RD_ValveState(self.Entity, 0)
	self:SetOverlayText( "Cutoff Valve(Closed)" )
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self.Active = 1
		RD_ValveState(self, 1)
		self.Entity:EmitSound( "Buttons.snd17" )
		self:SetOverlayText( "Cutoff Valve(Open)" )
		if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Open", 1) end
	end
end

function ENT:TurnOff()
	if (self.Active == 1) then
		self.Active = 0
		RD_ValveState(self, 0)
		self.Entity:EmitSound( "Buttons.snd17" )
		self:SetOverlayText( "Cutoff Valve(Closed)" )
		if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Open", 0) end
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "Open") then
		self:SetActive(value)
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if (self.Active == 1) then
		RD2_EqualizeNets( self )
	end
	
	self.Entity:NextThink( CurTime() + 1 ) 
end


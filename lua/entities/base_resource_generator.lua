AddCSLuaFile()

local baseClass = baseclass.Get("base_resource_entity")

ENT.PrintName = "Base Resource Generator"

local SB = SPACEBUILD

function ENT:Initialize()
	baseClass.Initialize(self)
	self.active = false
end

function ENT:registerDevice()
	SB:registerDevice(self, SB.RDTYPES.GENERATOR)
end

function ENT:AcceptInput(name, activator, caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		self:toggle(caller)
	end
end

function ENT:turnOn(caller)
	if not self.active then
		self.active = true
	end
end

function ENT:turnOff(caller)
	if self.active then
		self.active = false
	end
end

function ENT:toggle(caller)
	if not self.active then
		self:turnOn(caller)
	else
		self:turnOff(caller)
	end
end
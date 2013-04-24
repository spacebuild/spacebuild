AddCSLuaFile()

DEFINE_BASECLASS("base_resource_entity")

ENT.PrintName = "Base Resource Generator"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false

local class = GAMEMODE.class
local const = GAMEMODE.constants


function ENT:Initialize()
	GAMEMODE:registerDevice(self, GAMEMODE.RDTYPES.GENERATOR)
end

if (CLIENT) then

	local width, height
	local scrW = ScrW()
	local scrH = ScrH()
	if scrW > 1650 then
		width = 200
	elseif scrW > 1024 then
		width = 150
	else
		width = 100
	end
	if scrH > 900 then
		height = 36
	elseif scrH > 750 then
		height = 24
	else
		height = 16
	end

	function ENT:Draw()
		if self.rdobject then
			local lookedAt, lookedAtSomewhat = self:BeingLookedAtByLocalPlayer(), self:BeingLookedAtByLocalPlayerSomewhat()

			if lookedAt or lookedAtSomewhat then

				local resources = self.rdobject:getResources()
				local elementTable = {}

				table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, self.PrintName) )

				table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, "Resources: ") )

				for _, v in pairs(resources) do
					table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, v:getDisplayName().. ": " .. tostring(self.rdobject:getResourceAmount(v:getName())) .. "/" .. tostring(self.rdobject:getMaxResourceAmount(v:getName()))) )
				end

				if lookedAtSomewhat then
					GAMEMODE:AddWorldTip(self:EntIndex(), nil, 0.5, self:GetPos(), self)
				end

				if lookedAt then
					GAMEMODE:AddHudTip(self:EntIndex(), elementTable, 0.5, self:GetPos(), self)
				end

			end
		end


		self:DrawModel()
	end
end

function ENT:turnOn(newself)
	self = newself or self
	if not self.active then
		self.active = true
	end
end

function ENT:turnOff(newself)
	self = newself or self
	if self.active then
		self.active = false
	end
end

function ENT:toggle(newself)
	newself = newself or self
	self.active = not self.active

	if self.active then
		self:turnOn()
	else
		self:turnOff()
	end
end

function ENT:OnRestore()
	self.oldrdobject = self.rdobject
	GAMEMODE:registerDevice(self, GAMEMODE.RDTYPES.GENERATOR)
	self.rdobject:onRestore(self)
end
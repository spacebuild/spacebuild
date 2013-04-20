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

--[[ if (CLIENT) then
	function ENT:Draw()
		if self.rdobject then
			local elementTable = {}

			local width, height --- TODO look for a way to not make this every draw call, and perhaps a way to inherit panel width or sutin or largest child width.
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

			table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, self.PrintName) )
			table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, "Resources: ") )

			--MsgN("Before: ",#elementTable)

			local resources = self.rdobject:getResources()
			MsgN("Type resources: ",type(resources))

			--MsgN("Length of Resources: ",#resources)

			for _, v in pairs(self.rdobject:getResources()) do  --- TODO See why this won't add to elementTable :/
				local str = v:getDisplayName()
				table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, str) )
			end

			--MsgN("After: ",#elementTable)

			if self:BeingLookedAtByLocalPlayerSomewhat() then
				GAMEMODE:AddWorldTip(self:EntIndex(), nil, 0.5, self:GetPos(), self)
			end
			if self:BeingLookedAtByLocalPlayer() then
				GAMEMODE:AddHudTip(self:EntIndex(), elementTable, 0.5, self:GetPos(), self)
			end
		end


		self:DrawModel()
	end
end ]]

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
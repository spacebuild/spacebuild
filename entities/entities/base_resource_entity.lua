AddCSLuaFile()

DEFINE_BASECLASS("base_anim")

ENT.PrintName = "Base Resource Entity"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false

local class = GAMEMODE.class
local const = GAMEMODE.constants

function ENT:Initialize()
	GAMEMODE:registerDevice(self, GAMEMODE.RDTYPES.STORAGE)
end


function ENT:OnRemove()
	GAMEMODE:removeDevice(self)
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

	function ENT:BeingLookedAtByLocalPlayer()

		if (LocalPlayer():GetEyeTrace().Entity ~= self) then return false end
		if (EyePos():Distance(self:GetPos()) > 256) then return false end

		return true
	end

	-- A sort of fuzzy cute version of BeingLookedAtByLocalPlayer
	function ENT:BeingLookedAtByLocalPlayerSomewhat()
		local lookedAt = self:BeingLookedAtByLocalPlayer()

		if not lookedAt then
			local head = LocalPlayer():LookupBone("ValveBiped.Bip01_Head1")
			local headpos,_ = LocalPlayer():GetBonePosition(head)

			local vec = self:GetPos() - ( headpos )
			vec:Normalize()

			local aimVec = LocalPlayer():GetAimVector()
			aimVec:Normalize()

			if aimVec:DotProduct( vec ) > 0.95 and EyePos():Distance(self:GetPos()) < 512 then
				return true
			else
				return false
			end
		else
			return lookedAt
		end

	end



	function ENT:Draw()
		if self.rdobject then
			local resources = self.rdobject:getResources()    --- TODO Fix why this only works with Terran -.-
			local elementTable = {}

			table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, self.PrintName) )

			table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, "Resources: ") )

			for _, v in pairs(resources) do
				table.insert( elementTable, class.new("TextElement", 0, 0, width, height, const.colors.white, v:getDisplayName()) )
			end

			if self:BeingLookedAtByLocalPlayerSomewhat() then
				GAMEMODE:AddWorldTip(self:EntIndex(), nil, 0.5, self:GetPos(), self)
			end
			if self:BeingLookedAtByLocalPlayer() then
				GAMEMODE:AddHudTip(self:EntIndex(), elementTable, 0.5, self:GetPos(), self)
			end
		end

		self:DrawModel()
	end
end

function ENT:AddResource(resource, maxamount, defaultvalue)
	return self.rdobject:addResource(resource, maxamount, defaultvalue)
end

function ENT:ConsumeResource(resource, amount)
	return self.rdobject:consumeResource(resource, amount)
end

function ENT:SupplyResource(resource, amount)
	return self.rdobject:supplyResource(resource, amount)
end

function ENT:GetResourceAmount(resource)
	return self.rdobject:getResourceAmount(resource)
end


function ENT:GetMaxResourceAmount(resource)
	return self.rdobject:getMaxResourceAmount(resource)
end

function ENT:OnRestore()
	self.oldrdobject = self.rdobject
	self:Initialize()
	self.rdobject:onRestore(self)
end

if SERVER then

	local RD_TABLE = "SB4_RESOURCE_INFO"


	function ENT:PreEntityCopy()
		duplicator.StoreEntityModifier(self, RD_TABLE, self.rdobject:onSave())
	end

	function ENT:PostEntityPaste(Player, Ent, CreatedEntities)
		if self.EntityMods and self.EntityMods[RD_TABLE] then
			self.rdobject:applyDupeInfo(self.EntityMods[RD_TABLE], self, CreatedEntities)
			self.EntityMods[RD_TABLE] = nil -- Remove the data
		end
	end
end



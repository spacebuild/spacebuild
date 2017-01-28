AddCSLuaFile()
ENT.Type = "anim"
local baseClass
if WireLib and GAMEMODE.IsSandboxDerived then
	baseClass = baseclass.Get( "base_wire_entity" )
else
	baseClass = baseclass.Get( "base_anim" )
end

ENT.PrintName = "Base Resource Entity"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD

function ENT:Initialize()
	baseClass.Initialize(self)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end
	self:registerDevice()
end

function ENT:registerDevice()
	SB:registerDevice(self, SB.RDTYPES.STORAGE)
end

function ENT:OnRemove()
	baseClass.OnRemove(self)
	SB:removeDevice(self)
end

if SERVER then

	function ENT:Repair()
		SB.util.damage.repair(self)
	end

	function ENT:OnTakeDamage(DmgInfo)
		SB.util.damage.doDamage(self, DmgInfo:GetDamage())
	end

	function ENT:OnRestore()
		baseClass.OnRestore(self)
		SB:onRestore(self)
	end

	function ENT:PreEntityCopy()
		baseClass.PreEntityCopy(self)
		SB:buildDupeInfo(self)
	end

	function ENT:PostEntityPaste(Player, Ent, CreatedEntities)
		baseClass.PostEntityPaste(self, Player, Ent, CreatedEntities)
		SB:applyDupeInfo(Ent, CreatedEntities)
	end

end

if CLIENT then

	function ENT:Draw()
		baseClass.Draw(self)
		SB:drawBeams(self)
		self:drawScreen()
	end

	function ENT:drawScreen()
		-- do nothing
	end

end

function ENT:addResource(resource, maxamount, defaultvalue)
	return self.rdobject:addResource(resource, maxamount, defaultvalue)
end

function ENT:consumeResource(resource, amount)
	return self.rdobject:consumeResource(resource, amount)
end

function ENT:supplyResource(resource, amount)
	return self.rdobject:supplyResource(resource, amount)
end

function ENT:getResourceAmount(resource)
	return self.rdobject:getResourceAmount(resource)
end


function ENT:getMaxResourceAmount(resource)
	return self.rdobject:getMaxResourceAmount(resource)
end



AddCSLuaFile()

DEFINE_BASECLASS("base_anim")

ENT.PrintName = "Base Environment Entity"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:Initialize()
	--sb.addEnvironment(self)
end


function ENT:OnRemove()
	GAMEMODE:removeEnvironmentFromEntity(self)
end

function ENT:OnRestore()
	self.oldenvobject = self.envobject
	self:Initialize()
	self.envobject:onRestore(self)
end



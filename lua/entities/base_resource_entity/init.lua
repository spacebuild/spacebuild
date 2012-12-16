--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 14/12/12
-- Time: 19:22
-- To change this template use File | Settings | File Templates.
--

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    --self.BaseClass.Initialize(self) --use this in all ents
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
end

function ENT:OnRestore()
    --self.BaseClass.OnRestore(self) --use this if you have to use OnRestore
    self.rdobject:onRestore(self)
end

function ENT:PreEntityCopy()
    --self.BaseClass.PreEntityCopy(self) --use this if you have to use PreEntityCopy
    self.rdobject:buildDupeInfo(self)
end

function ENT:PostEntityPaste(Player, ent, createdentities)
    --self.BaseClass.PostEntityPaste(self, Player, Ent, CreatedEntities ) --use this if you have to use PostEntityPaste
    self.rdobject:applyDupeInfo(self, ent, createdentities)
end
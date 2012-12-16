--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 14/12/12
-- Time: 19:22
-- To change this template use File | Settings | File Templates.
--

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Spacebuild 4 resource entity"
ENT.Author = "SnakeSVx"
ENT.Purpose = "Base for all RD Sents"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:OnRemove()
    --self.BaseClass.OnRemove(self) --use this if you have to use OnRemove
    self.rdobject:unlink()
    sb.removeDevice(self)
end
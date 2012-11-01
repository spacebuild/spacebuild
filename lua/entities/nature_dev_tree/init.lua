AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.rate = 0
end

function ENT:AcceptInput(name, activator, caller)
end

function ENT:SetRate(rate, setmodel)
    --Add Various models depending on the rate!
    rate = rate or 0
    --
    if setmodel then
        self:SetModel("models/ce_ls3additional/plants/plantfull.mdl")
    end
    --
    self.rate = rate
end

function ENT:OnTakeDamage(DmgInfo)
    --Don't take damage?
end

function ENT:Think()
    if self.rate > 0 and self.environment then
        local left = self.environment:Convert(1, 0, self.rate)
        if left > 0 then
            left = self.environment:Convert(-1, 0, left)
            if left > 0 and self.environment:GetO2Percentage() < 10 then
                left = self.environment:Convert(2, 0, left)
                if left > 0 and self.environment:GetO2Percentage() < 10 then
                    left = self.environment:Convert(3, 0, left)
                end
            end
        end
    end
    self:NextThink(CurTime() + 1)
    return true
end

function ENT:CanTool()
    return false
end

function ENT:GravGunPunt()
    return false
end

function ENT:GravGunPickupAllowed()
    return false
end

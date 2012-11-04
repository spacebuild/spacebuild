AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_NONE)
    self:SetNotSolid(true)
    self:DrawShadow(false)
    if CAF then
        self.caf = self.caf or {}
        self.caf.custom = self.caf.custom or {}
        self.caf.custom.canreceivedamage = false
        self.caf.custom.canreceiveheatdamage = false
    end
end

function ENT:GetTemperature(ent)
    if not ent then return end
    local pos = ent:GetPos()
    local entpos = ent:GetPos()
    local SunAngle = (entpos - pos)
    SunAngle:Normalize()
    local startpos = (entpos - (SunAngle * 4096))
    local trace = {}
    trace.start = startpos
    trace.endpos = entpos + Vector(0, 0, 30)
    local tr = util.TraceLine(trace)
    if (tr.Hit) then
        if (tr == ent) then
            if (ent:IsPlayer()) then
                if (ent:Health() > 0) then
                    ent:TakeDamage(5, 0)
                    ent:EmitSound("HL2Player.BurnPain")
                end
            end
        end
    end
    local dist = pos:Distance(self:GetPos())
    if dist < self:GetSize() / 6 then
        return self.sbenvironment.temperature
    elseif dist < self:GetSize() * 1 / 3 then
        return self.sbenvironment.temperature * 2 / 3
    elseif dist < self:GetSize() * 1 / 2 then
        return self.sbenvironment.temperature / 3
    elseif dist < self:GetSize() * 2 / 3 then
        return self.sbenvironment.temperature / 6
    elseif self.sbenvironment.temperature / 12 <= 14 then --Check that it isn't colder then Space, else return Space temperature
        return 14
    end
    return self.sbenvironment.temperature / 12 --All other checks failed, player is the farest away from the star, but temp is still warmer then space, return that temperature
end

function ENT:GetPriority()
    return 2
end

local function SendSunBeam(ent)
    for k, ply in pairs(player.GetAll()) do
        umsg.Start("AddStar", ply)
        --umsg.Entity( ent ) --planet.num
        umsg.Short(ent:EntIndex())
        umsg.Vector(ent:GetPos()) --planet.num
        umsg.Float(ent.sbenvironment.size)
        umsg.End()
    end
end

function ENT:CreateEnvironment(radius)
    if radius and type(radius) == "number" then
        if radius < 0 then
            radius = 0
        end
        self.sbenvironment.size = radius * 2
    end
    self.BaseClass.CreateEnvironment(self, 0, 100, 100000, 0, 0, 100, 0, "Star")
    SendSunBeam(self)
end

function ENT:UpdateEnvironment(radius)
    if radius and type(radius) == "number" then
        self:UpdateSize(self.sbenvironment.size, radius)
    end
    SendSunBeam(self)
end

function ENT:IsStar()
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

function ENT:Remove()
    self.BaseClass.Remove(self)
    table.remove(TrueSun, self:GetPos())
end

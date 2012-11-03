AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_NONE)
    self.sbenvironment.temperature2 = 0
    self.sbenvironment.temperature3 = 0
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
        return self.sbenvironment.temperature2
    elseif dist < self:GetSize() * 1 / 2 then
        return self.sbenvironment.temperature3
    elseif dist < self:GetSize() * 2 / 3 then
        return self.sbenvironment.temperature3 / 2
    elseif self.sbenvironment.temperature3 / 4 <= 14 then --Check that it isn't colder then Space, else return Space temperature
        return 14
    end
    return self.sbenvironment.temperature3 / 4 --All other checks failed, player is the farest away from the star, but temp is still warmer then space, return that temperature
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

function ENT:CreateEnvironment(radius, temp1, temp2, temp3, name)
    if radius and type(radius) == "number" then
        if radius < 0 then
            radius = 0
        end
        self.sbenvironment.size = radius
    end
    if temp2 and type(temp2) == "number" then
        if temp2 < 0 then
            temp2 = 0
        end
        self.sbenvironment.temperature2 = temp2
    end
    if temp3 and type(temp3) == "number" then
        if temp3 < 0 then
            temp3 = 0
        end
        self.sbenvironment.temperature3 = temp3
    end
    self.BaseClass.CreateEnvironment(self, 0, 100, temp1, 0, 0, 100, 0, name)
    SendSunBeam(self)
end

function ENT:UpdateEnvironment(radius, temp1, temp2, temp3)
    if radius and type(radius) == "number" then
        self:UpdateSize(self.sbenvironment.size, radius)
    end
    if temp1 and type(temp1) == "number" then
        self.sbenvironment.temperature = temp1
    end
    if temp2 and type(temp2) == "number" then
        self.sbenvironment.temperature2 = temp2
    end
    if temp3 and type(temp3) == "number" then
        self.sbenvironment.temperature3 = temp3
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

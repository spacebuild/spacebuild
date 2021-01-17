AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_NONE)
    self.sbenvironment.temperature2 = 0
    self.sbenvironment.sunburn = false
    self.sbenvironment.unstable = false
    self:SetNotSolid(true)
    self:DrawShadow(false)
    self.sbenvironment.color = {}
    self.sbenvironment.bloom = {}
    if CAF then
        self.caf = self.caf or {}
        self.caf.custom = self.caf.custom or {}
        self.caf.custom.canreceivedamage = false
        self.caf.custom.canreceiveheatdamage = false
    end
end

function ENT:GetSunburn()
    return self.sbenvironment.sunburn
end

function ENT:Unstable()
    if self.sbenvironment.unstable then
        if (math.random(1, 20) < 2) then
            --self:GetParent():Fire("invalue", "shake", "0")
            --self:GetParent():Fire("invalue", "rumble", "0")
        end
    end
end

function ENT:GetUnstable()
    return self.sbenvironment.unstable
end

local function Extract_Bit(bit, field)
    if not bit or not field then return false end
    local retval = 0
    if ((field <= 7) and (bit <= 4)) then
        if (field >= 4) then
            field = field - 4
            if (bit == 4) then return true end
        end
        if (field >= 2) then
            field = field - 2
            if (bit == 2) then return true end
        end
        if (field >= 1) then
            field = field - 1
            if (bit == 1) then return true end
        end
    end
    return false
end

function ENT:SetFlags(flags)
    if not flags or type(flags) ~= "number" then return end
    self.sbenvironment.habitat = Extract_Bit(1, flags)
    self.sbenvironment.unstable = Extract_Bit(2, flags)
    self.sbenvironment.sunburn = Extract_Bit(3, flags)
end

function ENT:GetTemperature(ent)
    if not ent then return end
    local entpos = ent:GetPos()
    local trace = {}
    local lit = false
    local SunAngle2 = SunAngle
    local SunAngle
    if table.Count(TrueSun) > 0 then
        for k, v in pairs(TrueSun) do
            SunAngle = (entpos - v)
            SunAngle:Normalize()
            local startpos = (entpos - (SunAngle * 4096))
            trace.start = startpos
            trace.endpos = entpos -- + Vector(0,0,30)
            local tr = util.TraceLine(trace)
            if (tr.Hit) then
                if (tr.Entity == ent) then
                    if (ent:IsPlayer()) then
                        if self.sbenvironment.sunburn then
                            if (ent:Health() > 0) then
                                ent:TakeDamage(5, 0)
                                ent:EmitSound("HL2Player.BurnPain")
                            end
                        end
                    end
                    lit = true
                else
                    --lit = false
                end
            else
                lit = true
            end
        end
    end
    local startpos = (entpos - (SunAngle2 * 4096))
    trace.start = startpos
    trace.endpos = entpos -- + Vector(0,0,30)
    local tr = util.TraceLine(trace)
    if (tr.Hit) then
        if (tr.Entity == ent) then
            if (ent:IsPlayer()) then
                if self.sbenvironment.sunburn then
                    if (ent:Health() > 0) then
                        ent:TakeDamage(5, 0)
                        ent:EmitSound("HL2Player.BurnPain")
                    end
                end
            end
            lit = true
        else
            --lit = false
        end
    else
        lit = true
    end
    if lit then
        if self.sbenvironment.temperature2 then
            return self.sbenvironment.temperature2 + ((self.sbenvironment.temperature2 * ((self:GetCO2Percentage() - self.sbenvironment.air.co2per) / 100)) / 2)
        end
    end
    if not self.sbenvironment.temperature then
        return 0
    end
    return self.sbenvironment.temperature + ((self.sbenvironment.temperature * ((self:GetCO2Percentage() - self.sbenvironment.air.co2per) / 100)) / 2)
end

function ENT:GetPriority()
    return 1
end

function ENT:CreateEnvironment(radius, gravity, atmosphere, temperature, temperature2, flags)
    self:SetFlags(flags)
    local o2 = 0
    local co2 = 0
    local n = 0
    local h = 0
    local pressure = atmosphere
    --set Radius if one is given
    if radius and type(radius) == "number" then
        if radius < 0 then
            radius = 0
        end
        self.sbenvironment.size = radius
    end
    --set temperature2 if given
    if self.sbenvironment.habitat then --Based on values for earth
        o2 = 21
        co2 = 0.45
        n = 78
        h = 0.55
    else --Based on values for Venus
        o2 = 0
        co2 = 96.5
        n = 3.5
        h = 0
    end
    if temperature2 and type(temperature2) == "number" then
        self.sbenvironment.temperature2 = temperature2
    end
    self.BaseClass.CreateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n, h, "Planet " .. tostring(self:GetEnvironmentID()))
end

function ENT:UpdateEnvironment(radius, gravity, atmosphere, pressure, temperature, o2, co2, n, h, temperature2, flags)
    if radius and type(radius) == "number" then
        self:SetFlags(flags)
        self:UpdateSize(self.sbenvironment.size, radius)
    end
    --set temperature2 if given
    if temperature2 and type(temperature2) == "number" then
        self.sbenvironment.temperature2 = temperature2
    end
    self.BaseClass.UpdateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n)
end

function ENT:IsPlanet()
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

function ENT:Think()
    self:Unstable()
    self:NextThink(CurTime() + 1)
    return true
end

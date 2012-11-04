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
    self.sbenvironment.unstable = Extract_Bit(1, flags)
    self.sbenvironment.sunburn = Extract_Bit(2, flags)
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
            trace.endpos = entpos --+ Vector(0,0,30)
            local tr = util.TraceLine(trace)
            if (tr.Hit) then
                if (tr == ent) then
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
    trace.endpos = entpos --+ Vector(0,0,30)
    local tr = util.TraceLine(trace)
    if (tr.Hit) then
        if (tr == ent) then
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

function ENT:Unstable()
    if self.sbenvironment.unstable then
        if (math.random(1, 20) < 2) then
            --self:GetParent():Fire("invalue", "shake", "0")
            --self:GetParent():Fire("invalue", "rumble", "0")
        end
    end
end

function ENT:GetPriority()
    return 1
end

function ENT:CreateEnvironment(radius, gravity, atmosphere, pressure, temperature, temperature2, o2, co2, n, h, flags, name)
    self:SetFlags(flags)
    --set Radius if one is given
    if radius and type(radius) == "number" then
        if radius < 0 then
            radius = 0
        end
        self.sbenvironment.size = radius
    end
    --set temperature2 if given
    if temperature2 and type(temperature2) == "number" then
        self.sbenvironment.temperature2 = temperature2
    end
    self.BaseClass.CreateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n, h, name)
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
    self.BaseClass.UpdateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n, h)
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

local function SendBloom(ent)
    for k, ply in pairs(player.GetAll()) do
        umsg.Start("AddPlanet", ply)
        umsg.Entity(ent) --planet.num
        umsg.Float(ent.sbenvironment.size)
        umsg.Bool(false)
        if (ent.sbenvironment.bloom ~= nil) then
            umsg.Bool(true)
            umsg.Short(ent.sbenvironment.bloom.Col_r)
            umsg.Short(ent.sbenvironment.bloom.Col_g)
            umsg.Short(ent.sbenvironment.bloom.Col_b)
            umsg.Float(ent.sbenvironment.bloom.SizeX)
            umsg.Float(ent.sbenvironment.bloom.SizeY)
            umsg.Float(ent.sbenvironment.bloom.Passes)
            umsg.Float(ent.sbenvironment.bloom.Darken)
            umsg.Float(ent.sbenvironment.bloom.Multiply)
            umsg.Float(ent.sbenvironment.bloom.Color)
        else
            umsg.Bool(false)
        end
        umsg.End()
    end
end

local function SendColor(ent)
    for k, ply in pairs(player.GetAll()) do
        umsg.Start("AddPlanet", ply)
        umsg.Entity(ent) --planet.num
        umsg.Float(ent.sbenvironment.size)
        if ent.sbenvironment.color ~= nil then
            umsg.Bool(true)
            umsg.Short(ent.sbenvironment.color.AddColor_r)
            umsg.Short(ent.sbenvironment.color.AddColor_g)
            umsg.Short(ent.sbenvironment.color.AddColor_b)
            umsg.Short(ent.sbenvironment.color.MulColor_r)
            umsg.Short(ent.sbenvironment.color.MulColor_g)
            umsg.Short(ent.sbenvironment.color.MulColor_b)
            umsg.Float(ent.sbenvironment.color.Brightness)
            umsg.Float(ent.sbenvironment.color.Contrast)
            umsg.Float(ent.sbenvironment.color.Color)
        else
            umsg.Bool(false)
        end
        umsg.Bool(false)
        umsg.End()
    end
end

function ENT:BloomEffect(Col_r, Col_g, Col_b, SizeX, SizeY, Passes, Darken, Multiply, Color)
    if SB_DEBUG then
        Msg("Col_r/b/g: " .. tostring(Col_r) .. "/" .. tostring(Col_b) .. "/" .. tostring(Col_g) .. "\n")
        Msg("SizeX/Y: " .. tostring(SizeX) .. "/" .. tostring(SizeY) .. "\n")
        Msg("Passes: " .. tostring(Passes) .. "\n")
        Msg("Darken: " .. tostring(Darken) .. "\n")
        Msg("Multiply: " .. tostring(Multiply) .. "\n")
        Msg("Color: " .. tostring(Color) .. "\n")
    end
    if Col_r then
        self.sbenvironment.bloom.Col_r = Col_r
    end
    if Col_g then
        self.sbenvironment.bloom.Col_g = Col_g
    end
    if Col_b then
        self.sbenvironment.bloom.Col_b = Col_b
    end
    if SizeX then
        self.sbenvironment.bloom.SizeX = SizeX
    end
    if SizeY then
        self.sbenvironment.bloom.SizeY = SizeY
    end
    if Passes then
        self.sbenvironment.bloom.Passes = Passes
    end
    if Darken then
        self.sbenvironment.bloom.Darken = Darken
    end
    if Multiply then
        self.sbenvironment.bloom.Multiply = Multiply
    end
    if Color then
        self.sbenvironment.bloom.Color = Color
    end
    SendBloom(self)
end

function ENT:ColorEffect(AddColor_r, AddColor_g, AddColor_b, MulColor_r, MulColor_g, MulColor_b, Brightness, Contrast, Color)
    if SB_DEBUG then
        Msg("AddColor_r/b/g: " .. tostring(AddColor_r) .. "/" .. tostring(AddColor_b) .. "/" .. tostring(AddColor_g) .. "\n")
        Msg("AddColor_r/b/g: " .. tostring(MulColor_r) .. "/" .. tostring(MulColor_b) .. "/" .. tostring(MulColor_g) .. "\n")
        Msg("Brightness: " .. tostring(Brightness) .. "\n")
        Msg("Contrast: " .. tostring(Contrast) .. "\n")
        Msg("Color: " .. tostring(Color) .. "\n")
    end
    if AddColor_r then
        self.sbenvironment.color.AddColor_r = AddColor_r
    end
    if AddColor_g then
        self.sbenvironment.color.AddColor_g = AddColor_g
    end
    if AddColor_b then
        self.sbenvironment.color.AddColor_b = AddColor_b
    end
    if MulColor_r then
        self.sbenvironment.color.MulColor_r = MulColor_r
    end
    if MulColor_g then
        self.sbenvironment.color.MulColor_g = MulColor_g
    end
    if MulColor_b then
        self.sbenvironment.color.MulColor_b = MulColor_b
    end
    if Brightness then
        self.sbenvironment.color.Brightness = Brightness
    end
    if Contrast then
        self.sbenvironment.color.Contrast = Contrast
    end
    if Color then
        self.sbenvironment.color.Color = Color
    end
    SendColor(self)
end

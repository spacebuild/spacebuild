AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
util.PrecacheSound("apc_engine_start")
util.PrecacheSound("apc_engine_stop")

include('shared.lua')

local Energy_Increment = 125
local Water_Increment = 200
local Generator_Effect = 1 --Less than one means that this generator "leak" resources

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Active = 0
    self.overdrive = 0
    self.damaged = 0
    self.lastused = 0
    self.Mute = 0
    self.Multiplier = 1
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "On", "Overdrive", "Mute", "Multiplier" })
        self.Outputs = Wire_CreateOutputs(self, { "On", "Overdrive", "EnergyProduction", "HydrogenUsage", "OxygenUsage", "WaterProduction" })
    else
        self.Inputs = { { Name = "On" }, { Name = "Overdrive" } }
    end
end

function ENT:TurnOn()
    if (self.Active == 0) then
        if (self.Mute == 0) then
            self:EmitSound("Airboat_engine_idle")
        end
        self.Active = 1
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
        self:SetOOO(1)
    elseif (self.overdrive == 0) then
        self:TurnOnOverdrive()
    end
end

function ENT:TurnOff()
    if (self.Active == 1) then
        if (self.Mute == 0) then
            self:StopSound("Airboat_engine_idle")
            self:EmitSound("Airboat_engine_stop")
            self:StopSound("apc_engine_start")
        end
        self.Active = 0
        self.overdrive = 0
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
        self:SetOOO(0)
    end
end

function ENT:TurnOnOverdrive()
    if (self.Active == 1) then
        if (self.Mute == 0) then
            self:StopSound("Airboat_engine_idle")
            self:EmitSound("Airboat_engine_idle")
            self:EmitSound("apc_engine_start")
        end
        self:SetOOO(2)
        self.overdrive = 1
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "Overdrive", self.overdrive) end
    end
end

function ENT:TurnOffOverdrive()
    if (self.Active == 1 and self.overdrive == 1) then
        if (self.Mute == 0) then
            self:StopSound("Airboat_engine_idle")
            self:EmitSound("Airboat_engine_idle")
            self:StopSound("apc_engine_start")
        end
        self:SetOOO(1)
        self.overdrive = 0
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "Overdrive", self.overdrive) end
    end
end

function ENT:SetActive(value)
    if (value) then
        if (value ~= 0 and self.Active == 0) then
            self:TurnOn()
        elseif (value == 0 and self.Active == 1) then
            self:TurnOff()
        end
    else
        if (self.Active == 0) then
            self.lastused = CurTime()
            self:TurnOn()
        else
            if (((CurTime() - self.lastused) < 2) and (self.overdrive == 0)) then
                self:TurnOnOverdrive()
            else
                self.overdrive = 0
                self:TurnOff()
            end
        end
    end
end

function ENT:TriggerInput(iname, value)
    if (iname == "On") then
        self:SetActive(value)
    elseif (iname == "Overdrive") then
        if (value ~= 0) then
            self:TurnOnOverdrive()
        else
            self:TurnOffOverdrive()
        end
    end
    if (iname == "Mute") then
        if (value > 0) then
            self.Mute = 1
        else
            self.Mute = 0
        end
    end
    if (iname == "Multiplier") then
        if (value > 0) then
            self.Multiplier = value
        else
            self.Multiplier = 1
        end
    end
end

function ENT:Damage()
    if (self.damaged == 0) then
        self.damaged = 1
    end
    if ((self.Active == 1) and (math.random(1, 10) <= 4)) then
        self:TurnOff()
    end
end

function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self.damaged = 0
end

function ENT:Destruct()
    if CAF and CAF.GetAddon("Life Support") then
        CAF.GetAddon("Life Support").Destruct(self, true)
    end
end

function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    self:StopSound("apc_engine_start")
end

function ENT:Proc_Water()
    local energy = self:GetResourceAmount("energy")
    local o2 = self:GetResourceAmount("oxygen")
    local h = self:GetResourceAmount("hydrogen")
    local einc = Energy_Increment + (self.overdrive * Energy_Increment)
    einc = (math.Round(einc * self:GetMultiplier() * self.Multiplier))
    local winc = Water_Increment + (self.overdrive * Water_Increment)
    winc = (math.Round(winc * self:GetMultiplier()) * self.Multiplier)

    local consumeH = winc * 2
    local consumeO2 = math.Round(winc / 2)
    if (h >= consumeH and o2 >= consumeO2) then
        if (self.overdrive == 1) then
            if CAF and CAF.GetAddon("Life Support") then
                CAF.GetAddon("Life Support").DamageLS(self, math.random(2, 3))
            else
                self:SetHealth(self:Health() - math.Random(2, 3))
                if self:Health() <= 0 then
                    self:Remove()
                end
            end
        end

        self:ConsumeResource("hydrogen", consumeH)
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "HydrogenUsage", consumeH) end

        self:ConsumeResource("oxygen", consumeO2)
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "OxygenUsage", consumeO2) end

        einc = math.Round(einc * Generator_Effect)
        self:SupplyResource("energy", einc)
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "EnergyProduction", einc) end

        winc = math.Round(winc * Generator_Effect)
        self:SupplyResource("water", winc)
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "WaterProduction", winc) end
    else
        self:TurnOff()
    end
end

function ENT:Think()
    self.BaseClass.Think(self)

    if (self.Active == 1) then self:Proc_Water() end

    self:NextThink(CurTime() + 1)
    return true
end


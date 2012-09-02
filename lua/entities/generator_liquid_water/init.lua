AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
util.PrecacheSound("Airboat_engine_idle")
util.PrecacheSound("Airboat_engine_stop")
util.PrecacheSound("apc_engine_start")
include('shared.lua')
local Pressure_Increment = 80
local Energy_Increment = 10

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Active = 0
    self.overdrive = 0
    self.damaged = 0
    self.lastused = 0
    self.sequence = -1
    self.thinkcount = 0
    self.Mute = 0
    self.Multiplier = 1
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "On", "Overdrive", "Mute", "Multiplier" })
        self.Outputs = Wire_CreateOutputs(self, { "On", "Overdrive", "EnergyUsage", "WaterProduction" })
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
        self.sequence = self:LookupSequence("walk")
        if self.sequence and self.sequence ~= -1 then
            self:SetSequence(self.sequence)
            self:ResetSequence(self.sequence)
            self:SetPlaybackRate(1)
        end
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
        self.sequence = self:LookupSequence("idle")
        if self.sequence and self.sequence ~= -1 then
            self:SetSequence(self.sequence)
            self:ResetSequence(self.sequence)
            self:SetPlaybackRate(1)
        end
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
    self:StopSound("Airboat_engine_idle")
end

function ENT:Pump_Water()
    local energy = self:GetResourceAmount("energy")
    local einc = Energy_Increment + (self.overdrive * Energy_Increment * 3)
    local waterlevel = 0
    if CAF then
        waterlevel = self:WaterLevel2()
    else
        waterlevel = self:WaterLevel()
    end
    einc = (math.ceil(einc * self:GetMultiplier())) * self.Multiplier
    if not (WireAddon == nil) then Wire_TriggerOutput(self, "EnergyUsage", math.Round(einc)) end
    if (waterlevel > 0 and energy >= einc) then --seems to be problem when welding(/freezing when not with CAF)
        local winc = (math.ceil(Pressure_Increment * (waterlevel / 3))) * self.Multiplier --Base water generation on the amount it is in the water

        if (self.overdrive == 1) then
            winc = winc * 3
            if CAF and CAF.GetAddon("Life Support") then
                CAF.GetAddon("Life Support").DamageLS(self, math.random(2, 3))
            else
                self:SetHealth(self:Health() - math.Random(2, 3))
                if self:Health() <= 0 then
                    self:Remove()
                end
            end
        end
        winc = math.ceil(winc * self:GetMultiplier())
        self:ConsumeResource("energy", einc)
        self:SupplyResource("water", winc)
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "WaterProduction", math.Round(winc)) end
    else
        self:TurnOff()
    end
end

function ENT:Think()
    self.BaseClass.Think(self)
    if self.sequence and self.sequence ~= -1 then
        self:ResetSequence(self.sequence)
        --self:SetSequence(self.sequence)
        --self:SetPlaybackRate( 10 )
        --self:ResetSequenceInfo( )
        self:SetPlaybackRate(1)
    end
    self.thinkcount = self.thinkcount + 1
    if self.thinkcount == 10 then
        if (self.Active == 1) then self:Pump_Water() end
        self.thinkcount = 0
    end
    self:NextThink(CurTime() + 0.1)
    return true
end


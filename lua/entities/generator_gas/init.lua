AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
util.PrecacheSound("Airboat_engine_idle")
util.PrecacheSound("Airboat_engine_stop")
util.PrecacheSound("apc_engine_start")

include('shared.lua')

local Pressure_Increment = 80
local Energy_Increment = 10

local SB = SPACEBUILD

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
        self.Outputs = Wire_CreateOutputs(self, { "On", "Overdrive", "EnergyUsage", "GasProduction" })
    else
        self.Inputs = { { Name = "On" }, { Name = "Overdrive" } }
    end
    self.resource = "oxygen"
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
    if not (value == nil) then
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
        if (value > 0) then
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
    if (self.damaged == 0) then self.damaged = 1 end
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
    SB.util.damage.destruct(self, true)
end

function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    self:StopSound("Airboat_engine_idle")
end

function ENT:Pump_Air()
    self.energy = self:GetResourceAmount("energy")
    local mul = 1
    local SB = CAF.GetAddon("Spacebuild")
    if SB and SB.GetStatus() and self.environment and (self.environment:isSpace() or self.environment:isStar()) then
        mul = 0 --Make the device still absorb energy, but not produce any gas anymore
    elseif SB and SB.GetStatus() and self.environment and not self.environment:isPlanet() then
        mul = 0.5
    end
    local einc = (Energy_Increment + (self.overdrive * Energy_Increment)) * self.Multiplier
    einc = math.ceil(einc * self:GetMultiplier())
    if not (WireAddon == nil) then Wire_TriggerOutput(self, "EnergyUsage", math.Round(einc)) end
    if (self.energy >= einc) then
        local ainc = math.ceil((Pressure_Increment + (self.overdrive * Pressure_Increment)) * mul * self:GetMultiplier())
        if (self.overdrive == 1) then
            ainc = ainc * 2
            SB.util.damage.doDamage(self, math.random(2, 3))
        end
        self:ConsumeResource("energy", einc)
        if ainc > 0 then
            ainc = (ainc * self:GetMultiplier()) * self.Multiplier
            if not (WireAddon == nil) then Wire_TriggerOutput(self, "GasProduction", math.Round(ainc)) end
            local sb_resources = { "oxygen", "carbon dioxide", "hydrogen", "nitrogen" }
            local SB = CAF.GetAddon("Spacebuild")
            if SB and SB.GetStatus() and table.HasValue(sb_resources, self.resource) then
                local notUsed = ainc;
                if self.environment then
                    notUsed = self.environment:convertResource(self.resource, "vacuum", ainc)
                end
                local left = self:SupplyResource(self.resource, ainc - notUsed)
                if self.environment and left > 0 then
                    self.environment:convertResource("vacuum", self.resource,  left)
                end
            else
                self:SupplyResource(self.resource, ainc)
            end
        end
    else
        self:TurnOff()
    end
end

function ENT:Think()
    self.BaseClass.Think(self)
    if (self.Active == 1) then
        local waterlevel = 0
        if CAF then
            waterlevel = self:WaterLevel2()
        else
            waterlevel = self:WaterLevel()
        end
        if (waterlevel > 1) then
            self:SetColor(Color(50, 50, 50, 255))
            self:TurnOff()
            self:Destruct()
        else
            self:Pump_Air()
        end
    end
    self:NextThink(CurTime() + 1)
    return true
end

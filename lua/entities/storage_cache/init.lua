AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
util.PrecacheSound("ambient.steam01")
--Extra Resources Added by DataSchmuck for the McBuild's Community
include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.damaged = 0
    self.venten = false
    self.ventoxy = false
    self.ventco2 = false
    self.venthyd = false
    self.ventnit = false
    self.ventwat = false
    self.venthwwat = false
    self.ventlnit = false
    self.ventamount = 1000
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "Vent Amount", "Expel Energy", "Vent Oxygen", "Vent Co2", "Vent Hydrogen", "Vent Nitrogen", "Leak Water", "Leak Heavy Water", "Leak Liquid Nitrogen" })
        self.Outputs = Wire_CreateOutputs(self, { "Energy", "Oxygen", "Co2", "Hydrogen", "Nitrogen", "Liquid Nit", "Water", "Hvy Water", "Max Energy", "Max Oxygen", "Max Co2", "Max Hydrogen", "Max Nitrogen", "Max Liquid Nit", "Max Water", "Max Hvy Water" })
    else
        self.Inputs = { { Name = "Vent" } }
    end
    self.caf.custom.masschangeoverride = true
end

function ENT:TriggerInput(iname, value)
    if (iname == "Expel Energy") then
        if (value ~= 1) then
            self.venten = false
        else
            self.venten = true
        end
    elseif (iname == "Vent Oxygen") then
        if (value ~= 1) then
            self.ventoxy = false
        else
            self.ventoxy = true
        end
    elseif (iname == "Vent Co2") then
        if (value ~= 1) then
            self.ventco2 = false
        else
            self.ventco2 = true
        end
    elseif (iname == "Vent Hydrogen") then
        if (value ~= 1) then
            self.venthyd = false
        else
            self.venthyd = true
        end
    elseif (iname == "Vent Nitrogen") then
        if (value ~= 1) then
            self.ventnit = false
        else
            self.ventnit = true
        end
    elseif (iname == "Leak Water") then
        if (value ~= 1) then
            self.ventwat = false
        else
            self.ventwat = true
        end
    elseif (iname == "Leak Heavy Water") then
        if (value ~= 1) then
            self.venthwwat = false
        else
            self.venthwat = true
        end
    elseif (iname == "Leak Liquid Nitrogen") then
        if (value ~= 1) then
            self.ventlnit = false
        else
            self.ventlnit = true
        end
    elseif (iname == "Vent Amount") then
        if (value ~= 0) then
            self.ventamount = math.abs(value)
        else
            self.ventamount = 1000
        end
    end
end

function ENT:Damage()
    if (self.damaged == 0) then
        self.damaged = 1
        self:EmitSound("PhysicsCannister.ThrusterLoop")
        self:EmitSound("ambient.steam01")
    end
end

function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self.damaged = 0
    self:StopSound("PhysicsCannister.ThrusterLoop")
    self:StopSound("ambient.steam01")
end

function ENT:Destruct()
    if CAF and CAF.GetAddon("Life Support") then
        CAF.GetAddon("Life Support").Destruct(self, true)
    end
end

function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    local air = self:GetResourceAmount("oxygen")
    local co2 = self:GetResourceAmount("carbon dioxide")
    local hydrogen = self:GetResourceAmount("hydrogen")
    local nitrogen = self:GetResourceAmount("nitrogen")
    if self.environment then
        self.environment:Convert(-1, 0, air)
        self.environment:Convert(-1, 1, co2)
        self.environment:Convert(-1, 3, hydrogen)
        self.environment:Convert(-1, 2, nitrogen)
    end
    self:StopSound("PhysicsCannister.ThrusterLoop")
    self:StopSound("ambient.steam01")
end

function ENT:LeakHvyWater()
    local heavywater = self:GetResourceAmount("heavy water")
    if (heavywater >= self.ventamount) then
        self:ConsumeResource("heavy water", self.ventamount)
    else
        self:ConsumeResource("heavy water", heavywater)
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new Liquid Vent/Escaping Sound
    end
end

function ENT:LeakLqdNitrogen()
    local liquidnitrogen = self:GetResourceAmount("liquid nitrogen")
    if (liquidnitrogen >= self.ventamount) then
        self:ConsumeResource("liquid nitrogen", self.ventamount)
    else
        self:ConsumeResource("liquid nitrogen", liquidnitrogen)
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new Liquid Vent/Escaping Sound
    end
end

function ENT:VentCo2()
    local co2 = self:GetResourceAmount("carbon dioxide")
    if (co2 >= self.ventamount) then
        self:ConsumeResource("carbon dioxide", self.ventamount)
        if self.environment then
            self.environment:Convert(-1, 1, self.ventamount)
        end
    else
        self:ConsumeResource("carbon dioxide", co2)
        if self.environment then
            self.environment:Convert(-1, 1, co2)
        end
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new co2 Vent/Escaping Sound
    end
end

function ENT:VentO2()
    local air = self:GetResourceAmount("oxygen")
    if (air > 0) then
        if (air >= self.ventamount) then
            self:ConsumeResource("oxygen", self.ventamount)
            if self.environment then
                self.environment:Convert(-1, 0, self.ventamount)
            end
        else
            self:ConsumeResource("oxygen", air)
            if self.environment then
                self.environment:Convert(-1, 0, air)
            end
            self:StopSound("PhysicsCannister.ThrusterLoop")
        end
    end
end

function ENT:VentHydrogen()
    local hydrogen = self:GetResourceAmount("hydrogen")
    if (hydrogen >= self.ventamount) then
        self:ConsumeResource("hydrogen", self.ventamount)
        if self.environment then
            self.environment:Convert(-1, 3, self.ventamount)
        end
    else
        self:ConsumeResource("hydrogen", hydrogen)
        if self.environment then
            self.environment:Convert(-1, 3, hydrogen)
        end
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new air Vent/Escaping Sound
    end
end

function ENT:VentNitrogen()
    local nitrogen = self:GetResourceAmount("nitrogen")
    if (nitrogen >= self.ventamount) then
        self:ConsumeResource("nitrogen", self.ventamount)
        if self.environment then
            self.environment:Convert(-1, 2, self.ventamount)
        end
    else
        self:ConsumeResource("nitrogen", nitrogen)
        if self.environment then
            self.environment:Convert(-1, 2, nitrogen)
        end
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new air Vent/Escaping Sound
    end
end

function ENT:ExpEnergy()
    local energy = self:GetResourceAmount("energy")
    if (energy > 0) then
        local waterlevel = 0
        if CAF then
            waterlevel = self:WaterLevel2()
        else
            waterlevel = self:WaterLevel()
        end
        if (waterlevel > 0) then
            zapme(self:GetPos(), 1)
            local tmp = ents.FindInSphere(self:GetPos(), 600)
            for _, ply in ipairs(tmp) do
                if (ply:IsPlayer() and ply:WaterLevel() > 0) then --??? wont that be zaping any player in any water??? should do a dist check first and have damage based on dist
                    zapme(ply:GetPos(), 1)
                    ply:TakeDamage((ply:WaterLevel() * energy / 100), 0)
                end
            end
            self.maxenergy = self:GetUnitCapacity("energy")
            if (energy >= self.maxenergy) then --??? loose all energy on net when damaged and in water??? that sounds crazy to me
                self:ConsumeResource("energy", self.maxenergy)
            else
                self:ConsumeResource("energy", energy)
            end
        else
            if (energy >= self.ventamount) then
                self:ConsumeResource("energy", self.ventamount)
            else
                self:ConsumeResource("energy", energy)
            end
        end
    end
end

function ENT:LeakWater()
    local water = self:GetResourceAmount("water")
    if (water > 0) then
        if (water >= self.ventamount) then
            self:ConsumeResource("water", self.ventamount)
        else
            self:ConsumeResource("water", water)
            self:StopSound("ambient.steam01")
        end
    end
end

function ENT:UpdateMass()
    --[[local RD = CAF.GetAddon("Resource Distribution")
     local mul = 0.5
     local div = math.Round(RD.GetNetworkCapacity(self, "carbon dioxide")/self.MAXRESOURCE)
     local mass = self.mass + ((RD.GetResourceAmount(self, "carbon dioxide") * mul)/div) -- self.mass = default mass + need a good multiplier
     local phys = self:GetPhysicsObject()
     if (phys:IsValid()) then
         if phys:GetMass() ~= mass then
             phys:SetMass(mass)
             phys:Wake()
         end
     end]]
end

function ENT:Think()
    self.BaseClass.Think(self)

    if (self.damaged == 1 or self.venten) then
        self:ExpEnergy()
    end
    if (self.damaged == 1 or self.ventoxy) then
        self:VentO2()
    end
    if (self.damaged == 1 or self.ventnit) then
        self:VentNitrogen()
    end
    if (self.damaged == 1 or self.venthyd) then
        self:VentHydrogen()
    end
    if (self.damaged == 1 or self.ventco2) then
        self:VentCo2()
    end
    if (self.damaged == 1 or self.ventwat) then
        self:LeakWater()
    end
    if (self.damaged == 1 or self.venthwat) then
        self:LeakHvyWater()
    end
    if (self.damaged == 1 or self.ventlnit) then
        self:LeakLqdNitrogen()
    end

    if not (WireAddon == nil) then
        self:UpdateWireOutput()
    end
    self:UpdateMass()
    self:NextThink(CurTime() + 1)
    return true
end

function ENT:UpdateWireOutput()
    local air = self:GetResourceAmount("oxygen")
    local nitrogen = self:GetResourceAmount("nitrogen")
    local liquidnitrogen = self:GetResourceAmount("liquid nitrogen")
    local hydrogen = self:GetResourceAmount("hydrogen")
    local co2 = self:GetResourceAmount("carbon dioxide")
    local heavywater = self:GetResourceAmount("heavy water")
    local energy = self:GetResourceAmount("energy")
    local coolant = self:GetResourceAmount("water")
    local maxnitrogen = self:GetNetworkCapacity("nitrogen")
    local maxliquidnitrogen = self:GetNetworkCapacity("liquid nitrogen")
    local maxhydrogen = self:GetNetworkCapacity("hydrogen")
    local maxco2 = self:GetNetworkCapacity("carbon dioxide")
    local maxheavywater = self:GetNetworkCapacity("heavy water")
    local maxair = self:GetNetworkCapacity("oxygen")
    local maxcoolant = self:GetNetworkCapacity("water")
    local maxenergy = self:GetNetworkCapacity("energy")
    Wire_TriggerOutput(self, "Hydrogen", hydrogen)
    Wire_TriggerOutput(self, "Co2", co2)
    Wire_TriggerOutput(self, "Nitrogen", nitrogen)
    Wire_TriggerOutput(self, "Liquid Nit", liquidnitrogen)
    Wire_TriggerOutput(self, "Hvy Water", heavywater)
    Wire_TriggerOutput(self, "Oxygen", air)
    Wire_TriggerOutput(self, "Energy", energy)
    Wire_TriggerOutput(self, "Water", coolant)
    Wire_TriggerOutput(self, "Max Oxygen", maxair)
    Wire_TriggerOutput(self, "Max Energy", maxenergy)
    Wire_TriggerOutput(self, "Max Water", maxcoolant)
    Wire_TriggerOutput(self, "Max Hvy Water", maxheavywater)
    Wire_TriggerOutput(self, "Max Co2", maxco2)
    Wire_TriggerOutput(self, "Max Nitrogen", maxnitrogen)
    Wire_TriggerOutput(self, "Max Liquid Nit", maxliquidnitrogen)
    Wire_TriggerOutput(self, "Max Hydrogen", maxhydrogen)
end

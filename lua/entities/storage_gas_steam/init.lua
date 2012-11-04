AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')
--Todo: Add Cooldown? = toWater
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.damaged = 0
    self.vent = false
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "Vent" })
        self.Outputs = Wire_CreateOutputs(self, { "Steam", "Max Steam" })
    else
        self.Inputs = { { Name = "Vent" } }
    end
    self.caf.custom.masschangeoverride = true
end

function ENT:TriggerInput(iname, value)
    if (iname == "Vent") then
        if (value ~= 1) then
            self.vent = false
        else
            self.vent = true
        end
    end
end

function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    local air = self:GetResourceAmount("steam")
    self:ConsumeResource("steam", air);
    if self.environment then
        local O2 = math.Round(air / 2)
        local H = air * 2
        self.environment:Convert(-1, 3, H)
        self.environment:Convert(-1, 0, O2)
    end
    self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new air Vent/Escaping Sound
end

function ENT:Damage()
    if (self.damaged == 0) then
        self.damaged = 1
        self:EmitSound("PhysicsCannister.ThrusterLoop") --Change to a new air Vent/Escaping Sound
    end
end

function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new air Vent/Escaping Sound
    self.damaged = 0
end

function ENT:Destruct()
    if CAF and CAF.GetAddon("Life Support") then
        CAF.GetAddon("Life Support").Destruct(self, true)
    end
end

function ENT:Leak()
    local air = self:GetResourceAmount("steam")
    if (air >= 100) then
        self:ConsumeResource("steam", 100)
        if self.environment then
            self.environment:Convert(-1, 3, 200)
            self.environment:Convert(-1, 0, 50)
        end
    else
        self:ConsumeResource("steam", air)
        if self.environment then
            local O2 = math.Round(air / 2)
            local H = air * 2
            self.environment:Convert(-1, 3, H)
            self.environment:Convert(-1, 0, O2)
        end
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new air Vent/Escaping Sound
    end
end

function ENT:UpdateMass()
    local mul = 0.02
    local div = math.Round(self:GetNetworkCapacity("steam") / self.MAXRESOURCE)
    local mass = self.mass + ((self:GetResourceAmount("steam") * mul) / div) -- self.mass = default mass + need a good multiplier
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        if phys:GetMass() ~= mass then
            phys:SetMass(mass)
            phys:Wake()
        end
    end
end

function ENT:Think()
    self.BaseClass.Think(self)
    if (self.damaged == 1 or self.vent) then
        self:Leak()
    end
    local SB = CAF.GetAddon("Spacebuild")
    if SB and SB.GetStatus() then
        if self.environment then
            local planet = self.environment:IsOnPlanet()
            if (planet and planet:GetTemperature(self) < 350) then
                local dif = 350 - planet:GetTemperature(self);
                dif = math.floor(dif / 30);
                local div = math.Round(self:GetNetworkCapacity("steam") / self.MAXRESOURCE)
                local actual = math.ceil((self:GetResourceAmount("steam")) / div)
                local toremove = math.ceil(math.ceil(0.1 * actual) * dif);
                self:ConsumeResource("steam", toremove);
                self:SupplyResource("water", toremove);
            end
        end
    else
        local dif = 0.5;
        local div = math.Round(self:GetNetworkCapacity("steam") / self.MAXRESOURCE)
        local actual = math.ceil((self:GetResourceAmount("steam")) / div)
        local toremove = math.ceil(math.ceil(0.1 * actual) * dif);
        self:ConsumeResource("steam", toremove);
        self:SupplyResource("water", toremove);
    end
    if not (WireAddon == nil) then
        self:UpdateWireOutput()
    end
    self:UpdateMass()
    self:NextThink(CurTime() + 1)
    return true
end

function ENT:UpdateWireOutput()
    local air = self:GetResourceAmount("steam")
    local maxair = self:GetNetworkCapacity("steam")
    Wire_TriggerOutput(self, "Steam", air)
    Wire_TriggerOutput(self, "Max Steam", maxair)
end

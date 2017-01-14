AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local SB = SPACEBUILD

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.damaged = 0
    self.vent = false
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "Vent" })
        self.Outputs = Wire_CreateOutputs(self, { "Storage", "Max Storage" })
    else
        self.Inputs = { { Name = "Vent" } }
    end
    self.caf.custom.masschangeoverride = true
    self.resource = "oxygen"
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
    local air = self:GetResourceAmount(self.resource)
    if self.environment then
        self.environment:convertResource(nil, self.resource, air)
    end
    self:StopSound("PhysicsCannister.ThrusterLoop")
end

function ENT:Damage()
    if (self.damaged == 0) then
        self.damaged = 1
        self:EmitSound("PhysicsCannister.ThrusterLoop")
    end
end

function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self:StopSound("PhysicsCannister.ThrusterLoop")
    self.damaged = 0
end

function ENT:Destruct()
    SB.util.damage.destruct(self, true)
end

function ENT:Leak()
    local air = self:GetResourceAmount(self.resource)
    local mul = air / self.MAXRESOURCE
    local am = math.Round(mul * 1000);
    if (air >= am) then
        self:ConsumeResource(self.resource, am)
        if self.environment then
            self.environment:convertResource(nil, self.resource, air)
        end
    else
        self:ConsumeResource(self.resource, air)
        if self.environment then
            self.environment:convertResource(nil, self.resource, air)
        end
        self:StopSound("PhysicsCannister.ThrusterLoop")
    end
end

function ENT:UpdateMass()
    local mul = 0.02
    if self.resource == "oxygen" then
        mul = 0.02
    elseif self.resource == "carbon dioxide" then
        mul = 0.02
    elseif self.resource == "hydrogen" then
        mul = 0.02
    elseif self.resource == "nitrogen" then
        mul = 0.02
    end
    local div = math.Round(self:GetNetworkCapacity(self.resource) / self.MAXRESOURCE)
    local mass = self.mass + ((self:GetResourceAmount(self.resource) * mul) / div) -- self.mass = default mass + need a good multiplier
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
    if not (WireAddon == nil) then
        self:UpdateWireOutput()
    end
    self:UpdateMass()
    self:NextThink(CurTime() + 1)
    return true
end

function ENT:UpdateWireOutput()
    local air = self:GetResourceAmount(self.resource)
    local maxair = self:GetNetworkCapacity(self.resource)
    Wire_TriggerOutput(self, "Storage", air)
    Wire_TriggerOutput(self, "Max Storage", maxair)
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.damaged = 0
    self.vent = false
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "Vent" })
        self.Outputs = Wire_CreateOutputs(self, { "Liquid Nitrogen", "Max Liquid Nitrogen" })
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

function ENT:Damage()
    if (self.damaged == 0) then
        self.damaged = 1
        self:EmitSound("PhysicsCannister.ThrusterLoop") --Change to a new Liquid Vent/Escaping Sound
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

function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new Liquid Vent/Escaping Sound
end

function ENT:Leak()
    local coolant = self:GetResourceAmount("liquid nitrogen")
    if (coolant >= 100) then
        self:ConsumeResource("liquid nitrogen", 100)
    else
        self:ConsumeResource("liquid nitrogen", coolant)
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new Liquid Vent/Escaping Sound
    end
end

function ENT:UpdateMass()
    -- Why 0.03?  Because in the liquid nitrogen generator files 4 N = 3 Liquid nitrogen, so the weight of 4N = weight of 3 Liquid Nitrogen.
    local mul = 0.03
    local div = math.Round(self:GetNetworkCapacity("liquid nitrogen") / self.MAXRESOURCE)
    local mass = self.mass + ((self:GetResourceAmount("liquid nitrogen") * mul) / div) -- self.mass = default mass + need a good multiplier
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
    local coolant = self:GetResourceAmount("liquid nitrogen")
    local maxcoolant = self:GetNetworkCapacity("liquid nitrogen")
    Wire_TriggerOutput(self, "Liquid Nitrogen", coolant)
    Wire_TriggerOutput(self, "Max Liquid Nitrogen", maxcoolant)
end

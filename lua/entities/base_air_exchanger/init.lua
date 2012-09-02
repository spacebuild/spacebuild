AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Active = 0
    self.damaged = 0
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "On" })
        self.Outputs = Wire_CreateOutputs(self, { "Out" })
    else
        self.Inputs = { { Name = "On" } }
    end
    if not self.baseresources then
        self:SetDefault()
    end
    CAF.GetAddon("Life Support").AddAirRegulator(self)
end

function ENT:IsActive()
    return util.tobool(self.Active)
end

function ENT:SetStartSound(sound)
    if not sound or type(sound) ~= "string" then return false end
    util.PrecacheSound(sound)
    self.startsound = sound
    return true
end

function ENT:SetStopSound(sound)
    if not sound or type(sound) ~= "string" then return false end
    util.PrecacheSound(sound)
    self.stopsound = sound
    return true
end

function ENT:SetAlarmSound(sound)
    if not sound or type(sound) ~= "string" then return false end
    util.PrecacheSound(sound)
    self.alarmsound = sound
    return true
end

function ENT:SetDefault()
    self:AddBaseResource("energy", 5)
    self:AddUseResource("energy", 5)
    self:AddUseResource("oxygen", 5)
    self:SetAirGiven(5)
    self:SetRange(256)
    self:SetStartSound("apc_engine_start")
    self:SetStopSound("apc_engine_stop")
    self:SetAlarmSound("common/warning.wav")
end

function ENT:SetRange(amount)
    if not amount or type(amount) ~= "number" then return false end
    self.range = amount
    return true
end

function ENT:GetRange()
    return self.range or 0
end

function ENT:SetAirGiven(amount)
    if not amount or type(amount) ~= "number" then return false end
    self.gair = amount
    return true
end

function ENT:UsePerson()
    for k, v in pairs(self.resources) do
        self:ConsumeResource(k, v)
    end
    self:CheckResources()
    self:SupplyResource("carbon dioxide", (self.gair or 0))
    return (self.gair or 0) - 5
end

function ENT:UsePersonPressure(pressure)
    if not pressure or type(pressure) ~= "number" then return end
    if pressure <= 0 then
        return 0
    end
    if pressure >= 25 then
        for k, v in pairs(self.resources) do
            self:ConsumeResource(k, v)
        end
        return pressure - 25
    else
        local tmp = math.Round(pressure / 25)
        for k, v in pairs(self.resources) do
            self:ConsumeResource(k, v * tmp)
        end
        return 0
    end
end

function ENT:GetLSClass()
    return "air exchanger"
end

function ENT:AddBaseResource(resource, amount)
    if not resource or type(resource) ~= "string" or not amount or type(amount) ~= "number" then return false end
    if not self.baseresources then
        self.baseresources = {}
    end
    self:AddResource(resource, 0)
    self.baseresources[resource] = amount
    return true
end

function ENT:AddUseResource(resource, amount)
    if not resource or type(resource) ~= "string" or not amount or type(amount) ~= "number" then return false end
    if not self.resources then
        self.resources = {}
    end
    self:AddResource(resource, 0)
    self.resources[resource] = amount
    return true
end

function ENT:GetBaseResource()
    return self.baseresources or {}
end

function ENT:GetResources()
    return self.resources or {}
end

function ENT:TurnOn()
    if (self.Active == 0) then
        self:EmitSound(self.startsound)
        self.Active = 1
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", self.Active) end
        self:SetOOO(1)
    end
end

function ENT:TurnOff()
    if (self.Active == 1) then
        self:StopSound(self.startsound)
        self:EmitSound(self.stopsound)
        self.Active = 0
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", self.Active) end
        self:SetOOO(0)
    end
end

function ENT:TriggerInput(iname, value)
    if (iname == "On") then
        self.BaseClass.SetActive(self, value)
    end
end

function ENT:Think()
    self.BaseClass.Think(self)
    if (self.Active == 1) then
        self:ConsumeBaseResources()
        self:CheckResources()
    end
    self:NextThink(CurTime() + 1)
    return true
end

function ENT:ConsumeBaseResources()
    for k, v in pairs(self.baseresources) do
        self:ConsumeResource(k, v)
    end
end

function ENT:CheckResources()
    for k, v in pairs(self.baseresources) do
        if self:GetResourceAmount(k) < v then self:TurnOff() return end
    end
    for k, v in pairs(self.resources) do
        if self:GetResourceAmount(k) < v then self:TurnOff() return end
    end
end

--Still need to check
--check
function ENT:Damage()
    if (self.damaged == 0) then
        self.damaged = 1
    end
    if ((self.Active == 1) and (math.random(1, 10) <= 3)) then
        self:TurnOff()
    end
end

--check
function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self.damaged = 0
end

--check 
function ENT:Destruct()
    CAF.GetAddon("Life Support"):LS_Destruct(self, true)
end

--check
function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    self:StopSound("apc_engine_start")
    CAF.GetAddon("Life Support").RemoveAirRegulator(self)
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.damaged = 0
    self.time = 0
    self.water = 100
    self.Active = 1
    self:ShowOutput()
end

function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self.damaged = 0
    self.time = 0
    self.water = 100
    self:ShowOutput()
end

function ENT:SetActive()
    self:Repair()
end

function ENT:Destruct()
    if CAF and CAF.GetAddon("Life Support") then
        CAF.GetAddon("Life Support").Destruct(self, true)
    end
end

function ENT:ShowOutput()
    if self:GetNetworkedInt(1) ~= self.water then
        self:SetNetworkedInt(1, self.water)
    end
end

function ENT:Damage()
    if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:OnRemove()
    --nothing
end

function ENT:Think()
    self.BaseClass.Think(self)
    local waterlevel = 0
    if CAF then
        waterlevel = self:WaterLevel2()
    else
        waterlevel = self:WaterLevel()
    end
    local mul = 1
    if self.environment and self.environment.GetTemperature then
        local temperature = self.environment:GetTemperature(self)
        if temperature < 278 then
            mul = 0
        elseif temperature < 283 then
            mul = 0.25
        elseif temperature < 288 then
            mul = 0.5
        elseif temperature > 303 then
            mul = 0.5
        elseif temperature > 308 then
            mul = 0.25
        elseif temperature > 318 then
            mul = 0
        end
    end
    self.resco2 = self:GetResourceAmount("carbon dioxide")
    self.reswater = self:GetResourceAmount("water")
    if waterlevel > 0 then
        if self.water < 100 then
            if self.Active == 0 then
                self:SetColor(Color(255, 255, 255, 255))
                self.Active = 1
            end
            self.water = self.water + 1
            self:ShowOutput()
        end
    elseif self.reswater > 0 then
        if self.Active == 0 then
            self:SetColor(Color(255, 255, 255, 255))
            self.Active = 1
        end
        self:ConsumeResource("water", 1)
        if self.water < 100 then
            self.water = self.water + 1
        end
        self:ShowOutput()
    elseif self.water > 0 then
        self.water = self.water - 1
        self:ShowOutput()
    else
        self.Active = 0
        self:SetColor(Color(75, 75, 75, 255))
        self:ShowOutput()
    end
    if self.Active == 1 then
        local touse = math.Round(3 * mul)
        if self.environment then
            local left = self.environment:Convert(1, 0, touse)
            if left > 0 then
                local co2left = self:ConsumeResource("carbon dioxide", left)
                self:SupplyResource("oxygen", left - co2left)
            end
        else
            local co2left = self:ConsumeResource("carbon dioxide", touse)
            self:SupplyResource("oxygen", touse - co2left)
        end
    end
    if self:GetNetworkedInt("OOO") ~= self.Active then
        self:SetOOO(self.Active)
    end
    self:NextThink(CurTime() + 1)
    return true
end

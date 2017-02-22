--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local SB = SPACEBUILD

--Was 15, reduced by popular request.
local Energy_Increment = 8

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.damaged = 0
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Outputs = Wire_CreateOutputs(self, { "Out" })
    end
end

function ENT:TurnOn()
    if (self.Active == 0) then
        self.Active = 1
        self:SetOOO(1)
    end
end

function ENT:TurnOff()
    if (self.Active == 1) then
        self.Active = 0
        self:SetOOO(0)
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", 0) end
    end
end

function ENT:SetActive() --disable use, lol
end

function ENT:Damage()
    if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self.damaged = 0
end

function ENT:Destruct()
    SB.util.damage.destruct(self, true)
end

function ENT:Extract_Energy(mul)
    mul = mul or 0;
    if mul == 0 then
        return
    end
    local inc = 0
    local SB = CAF.GetAddon("Spacebuild")
    if SB and SB.GetStatus() then
        if not self.environment then return end
        inc = math.ceil(Energy_Increment / ((self.environment:GetAtmosphere()) + 1))
    else
        inc = math.ceil(Energy_Increment / 2)
    end
    if (self.damaged == 1) then inc = math.ceil(inc / 2) end
    if (inc > 0) then
        inc = math.ceil(inc * self:GetMultiplier() * mul)
        self:SupplyResource("energy", inc)
    end
    if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", inc) end
end


function ENT:getBlocked(up, sun)

    local trace = {}
    local util = util
    local up = up or self:GetAngles():Up() or nil
    local sun = sun or SB:getSun() or nil

    if up == nil or sun == nil then return true end

    if sun ~= nil then
        trace = util.QuickTrace(sun:getPosition(), self:GetPos() - sun:getPosition(), nil) -- Don't filter
        if trace.Hit and trace.Entity == self then
            return false
        else
            return true
        end
    else
        local sunAngle = Vector(0, 0, -1)

        local n = sunAngle:DotProduct(up * -1)
        if n > 0 then
            return true
        end
    end

    return false
end

function ENT:getRate()

    local up = self:GetAngles():Up()
    local sun = SB:getSun() or nil

    local sunAngle = Vector(0, 0, -1)

    if sun ~= nil then
        sunAngle = (self:GetPos() - sun:getPosition()) -- DO NOT ADD :Normalize() BECOMES NIL!
        sunAngle:Normalize() --Normalising doesn't work normally for some reason, hack implemented.
    end

    local n = sunAngle:DotProduct(up * -1)

    if n >= 0 and not self:getBlocked(up, sun) then
        return math.Round(self:GetMultiplier() * n)
    else
        return 0
    end
end

function ENT:Think()

    if self:WaterLevel() > 0 then
        self.active = false
    else
        self.active = true
    end

    if self.active then
        self.rdobject:supplyResource("energy", self:getRate() or 0)
    end

    self:NextThink(CurTime() + 1)
    return true
end

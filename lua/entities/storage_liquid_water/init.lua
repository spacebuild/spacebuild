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

--ToDo: Add HeatUP? = toSteam

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.damaged = 0
    self.vent = false
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "Vent" })
        self.Outputs = Wire_CreateOutputs(self, { "Water", "Max Water" })
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
    SB.util.damage.destruct(self, true)
end

function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new Liquid Vent/Escaping Sound
end

function ENT:Leak()
    local coolant = self:GetResourceAmount("water")
    if (coolant >= 100) then
        self:ConsumeResource("water", 100)
    else
        self:ConsumeResource("water", coolant)
        self:StopSound("PhysicsCannister.ThrusterLoop") --Change to a new Liquid Vent/Escaping Sound
    end
end

function ENT:UpdateMass()
    local mul = 0.3
    local div = math.Round(self:GetNetworkCapacity("water") / self.MAXRESOURCE)
    local mass = self.mass + ((self:GetResourceAmount("water") * mul) / div) -- self.mass = default mass + need a good multiplier
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
    local coolant = self:GetResourceAmount("water")
    local maxcoolant = self:GetNetworkCapacity("water")
    Wire_TriggerOutput(self, "Water", coolant)
    Wire_TriggerOutput(self, "Max Water", maxcoolant)
end

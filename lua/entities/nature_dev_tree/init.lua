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

function ENT:Initialize()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.rate = 0
end

function ENT:AcceptInput(name, activator, caller)
end

function ENT:SetRate(rate, setmodel)
    --Add Various models depending on the rate!
    rate = rate or 0
    --
    if setmodel then
        self:SetModel("models/ce_ls3additional/plants/plantfull.mdl")
    end
    --
    self.rate = rate
end

function ENT:OnTakeDamage(DmgInfo)
    --Don't take damage?
end

function ENT:Think()
    if self.rate > 0 and self.environment then
        local left = self.environment:convertResource("carbon dioxide", "oxygen", self.rate)
        if left > 0 then
            left = self.environment:convertResource("vacuum", "oxygen", left)
            if left > 0 and self.environment:getResourcePercentage("oxygen") < 10 then
                left = self.environment:convertResource("nitrogen", "oxygen", left)
                if left > 0 and self.environment:getResourcePercentage("oxygen") < 10 then
                    left = self.environment:convertResource("hydrogen", "oxygen", left)
                end
            end
        end
    end
    self:NextThink(CurTime() + 1)
    return true
end

function ENT:CanTool()
    return false
end

function ENT:GravGunPunt()
    return false
end

function ENT:GravGunPickupAllowed()
    return false
end

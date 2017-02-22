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

local SB = SPACEBUILD

local noClip = CreateConVar("SB_NoClip", "1")
local adminNoClip = CreateConVar("SB_AdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
local superAdminNoClip = CreateConVar("SB_SuperAdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
local planetNoClipOnly = CreateConVar("SB_PlanetNoClipOnly", "1") -- Make it so admins can let players no clip in space.

local enableDrag = CreateConVar("SB_EnableDrag", "1") -- Make it drag also gets affected, on by default.
local infiniteResources = CreateConVar("SB_InfiniteResources", "0") -- Makes it so that a planet can't run out of resources, off by default.
local staticEnvironment = CreateConVar("SB_StaticEnvironment", "0") -- @DEPRECATED, use SB_InfiniteResources instead

-- Orbiting mechanics
local orbitEnable = CreateConVar("SB_OrbitEnable", "0") -- should we enable orbital mechanics?
local orbitGravityMultiplier = CreateConVar("SB_OrbitGravityMultiplier", "0.0024") -- what kind of multiplier do we use for orbiting?
local orbitRadius = CreateConVar("SB_OrbitRadiusMultiplier", "1.8") -- How far away from the planet does orbitting apply? 1.8 = 1.8 x planet radius

SB.config = {
    noclip = {
        get = function() return noClip:GetBool() end,
        set = function(val) noClip:SetBool(val) end
    },
    adminspacenoclip = {
        get = function() return adminNoClip:GetBool() end,
        set = function(val) adminNoClip:SetBool(val) end
    },
    superadminspacenoclip = {
        get = function() return superAdminNoClip:GetBool() end,
        set = function(val) superAdminNoClip:SetBool(val) end
    },
    planetnocliponly = {
        get = function() return planetNoClipOnly:GetBool() end,
        set = function(val) planetNoClipOnly:SetBool(val) end
    },
    drag = {
        get = function() return enableDrag:GetBool() end,
        set = function(val) enableDrag:SetBool(val) end
    },
    resources = {
        get = function() return infiniteResources:GetBool() or staticEnvironment:GetBool() end,
        set = function(val) infiniteResources:SetBool(val) end
    },
    orbit = {
        get = function() return orbitEnable:GetBool(), orbitRadius:GetFloat(), orbitGravityMultiplier:GetFloat() end,
        set = function(enable, radius, multiplier) orbitEnable:SetBool(enable) orbitRadius:SetFloat(radius) orbitGravityMultiplier:SetFloat(multiplier) end
    }

}
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

--if not GAMEMODE.IsSpacebuildDerived then return end

TOOL.Category = "Life Support"
TOOL.Name = "#Terraformers"

TOOL.DeviceName = "Terraformer"
TOOL.DeviceNamePlural = "Terraformers"
TOOL.ClassName = "sb_terraformer"

TOOL.DevSelect = true
TOOL.CCVar_type = "base_terraformer"
TOOL.CCVar_sub_type = "default"
TOOL.CCVar_model = "models/chipstiks_ls3_models/OxygenCompressor/oxygencompressor.mdl"

TOOL.Limited = true
TOOL.LimitName = "sb_teraformers"
TOOL.Limit = 30
TOOL.AdminOnly = true

CAFToolSetup.SetLang("Planet Teraformers", "Create Teraformers attached to any surface.", "Left-Click: Spawn a Device.  Reload: Repair Device.")


TOOL.ExtraCCVars = {
    rate = 0,
}

function TOOL.ExtraCCVarsCP(tool, panel)
    panel:NumSlider("O2 Refresh Rate", "sb_dev_plants_rate", 0, 10000, 0)
end

function TOOL:GetExtraCCVars()
    local Extra_Data = {}
    Extra_Data.rate = self:GetClientNumber("rate")
    return Extra_Data
end

local function gas_generator_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1 --Change to be 0 by default later on
    local base_volume = 284267 --Change to the actual base volume later on
    local base_mass = 200
    local base_health = 600
    CAF.GetAddon("Resource Distribution").RegisterNonStorageDevice(ent)
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        MsgN("Ent Physics Object Volume: ", vol)
        volume_mul = vol / base_volume
    end
    ent:SetMultiplier(volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

TOOL.Devices = {
    base_terraformer = {
        Name = "Planet Teraformer",
        type = "base_terraformer",
        class = "base_terraformer",
        func = gas_generator_func,
        devices = {
            default = {
                Name = "Basic Teraformer",
                model = "models/ce_ls3additional/plants/plantfull.mdl",
            },
        },
    },
}
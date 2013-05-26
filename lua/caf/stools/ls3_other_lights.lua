TOOL.Category = "Life Support"
TOOL.Name = "#Special Devices - Lights"

TOOL.DeviceName = "Special Device"
TOOL.DeviceNamePlural = "Special Devices"
TOOL.ClassName = "ls3_other_lights"

TOOL.DevSelect = true
TOOL.CCVar_type = "other_lamp"
TOOL.CCVar_sub_type = "small"
TOOL.CCVar_model = "models/props_c17/FurnitureBoiler001a.mdl"

TOOL.Limited = true
TOOL.LimitName = "ls3_other_lights"
TOOL.Limit = 10

CAFToolSetup.SetLang("Life Support Special Light Devices", "Create Special Light Devices attached to any surface.", "Left-Click: Spawn a Device.  Reload: Repair Device.")

function TOOL.EnableFunc()
    if not CAF then
        return false;
    end
    if not CAF.GetAddon("Resource Distribution") or not CAF.GetAddon("Resource Distribution").GetStatus() then
        return false;
    end
    return true;
end

TOOL.ExtraCCVars = {}

function TOOL.ExtraCCVarsCP(tool, panel)
end

function TOOL:GetExtraCCVars()
    local Extra_Data = {}
    return Extra_Data
end

local function light_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1 --Change to be 0 by default later on
    local base_volume = 11829 --Change to the actual base volume later on
    local base_mass = 5
    local base_health = 10
    CAF.GetAddon("Resource Distribution").RegisterNonStorageDevice(ent)
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        --MsgN("Ent Physics Object Volume: ",vol)
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end



TOOL.Devices = {
    other_lamp = {
        Name = "LS Lamps",
        type = "other_lamp",
        class = "other_lamp",
        func = light_func,
        devices = {
            small = {
                Name = "Default Lamp",
                model = "models/props_wasteland/light_spotlight01_lamp.mdl",
            },
        }
    },
    other_spotlight = {
        Name = "LS Spotlights",
        type = "other_spotlight",
        class = "other_spotlight",
        func = light_func,
        devices = {
            small = {
                Name = "Default Spotlight",
                model = "models/props_wasteland/light_spotlight01_lamp.mdl",
            },
        }
    },
}


	
	
	

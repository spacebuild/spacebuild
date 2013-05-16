TOOL.Category = "Life Support"
TOOL.Name = "#Special Devices"

TOOL.DeviceName = "Special Device"
TOOL.DeviceNamePlural = "Special Devices"
TOOL.ClassName = "ls3_other"

TOOL.DevSelect = true
TOOL.CCVar_type = "other_screen"
TOOL.CCVar_sub_type = "Small"
TOOL.CCVar_model = "models/SnakeSVx/small_screen_ls_1.mdl"

TOOL.Limited = true
TOOL.LimitName = "ls3_other"
TOOL.Limit = 30

CAFToolSetup.SetLang("Life Support Special Devices", "Create Special Devices attached to any surface.", "Left-Click: Spawn a Device.  Reload: Repair Device.")

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

local function screen_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1 --Change to be 0 by default later on
    local base_volume = 11829 --Change to the actual base volume later on
    local base_mass = 20
    local base_health = 60
    CAF.GetAddon("Resource Distribution").RegisterNonStorageDevice(ent)
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        MsgN("Ent Physics Object Volume: ", vol)
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    ent:SetMultiplier(volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end



TOOL.Devices = {
    other_screen = {
        Name = "LS Info Screens",
        type = "other_screen",
        class = "other_screen",
        func = screen_func,
        devices = {
            s_small = {
                Name = "Tiny Screen",
                model = "models/SnakeSVx/s_small_screen_ls_1.mdl",
            },
            small = {
                Name = "Small Screen",
                model = "models/SnakeSVx/small_screen_ls_1.mdl",
            },
            medium = {
                Name = "Medium Screen",
                model = "models/SnakeSVx/medium_screen_ls_1.mdl",
            },
            large = {
                Name = "Large Screen",
                model = "models/SnakeSVx/large_screen_ls_1.mdl",
            },
        }
    },
}


	
	
	

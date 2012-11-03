TOOL.Category = "Life Support"
TOOL.Name = "#Environmental Control"

TOOL.DeviceName = "Environmental Control"
TOOL.DeviceNamePlural = "Environmental Controls"
TOOL.ClassName = "ls3_environmental_control"

TOOL.DevSelect = true
TOOL.CCVar_type = "other_dispenser"
TOOL.CCVar_sub_type = "default_other_dispenser"
TOOL.CCVar_model = "models/props_combine/combine_emitter01.mdl"

TOOL.Limited = true
TOOL.LimitName = "ls3_environmental_control"
TOOL.Limit = 30

CAFToolSetup.SetLang("Environmental Controls", "Create life support devices attached to any surface.", "Left-Click: Spawn a Device.  Reload: Repair Device.")

function TOOL.EnableFunc()
    if not CAF then
        return false;
    end
    if not CAF.GetAddon("Resource Distribution") or not CAF.GetAddon("Resource Distribution").GetStatus() then
        return false;
    end
    return true;
end

TOOL.ExtraCCVars = {
    extra_num = 0,
    extra_bool = 0,
}

function TOOL.ExtraCCVarsCP(tool, panel)
end

function TOOL:GetExtraCCVars()
    local Extra_Data = {}
    return Extra_Data
end

local function environmental_control_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1 --Change to be 0 by default later on
    local base_volume = 4084 --Change to the actual base volume later on
    local base_mass = 10
    local base_health = 100
    if type == "other_dispenser" then
        base_volume = 4084 --This will need changed
    elseif type == "base_air_exchanger" then
        base_volume = 4084
        base_mass = 100
        base_health = 600
        --TODO: MAke it volume based or a tool setting??
        if (sub_type == "small_air_exchanger") then
            ent:SetRange(256)
        else
            ent:SetRange(768) --right value??
        end
    elseif type == "base_temperature_exchanger" then
        base_volume = 4084 --Change to the actual base volume later on
        base_mass = 100
        base_health = 500
        if (sub_type == "small_temp_exchanger") then
            ent:SetRange(256)
        else
            ent:SetRange(768) --right value??
        end
    elseif type == "base_climate_control" then
        base_volume = 4084
        base_mass = 1200
        base_health = 1000
    elseif type == "other_probe" then
        base_volume = 4084
        base_mass = 20
        base_health = 1000
    elseif type == "base_gravity_control" then
        base_volume = 4084
        base_mass = 1200
        base_health = 1000
    elseif type == "nature_plant" then
        base_volume = 4084
        base_mass = 10
        base_health = 50
    end
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

local function sbCheck()
    local SB = CAF.GetAddon("Spacebuild")
    if SB and SB.GetStatus() then
        return true;
    end
    return false;
end


TOOL.Devices = {
    other_dispenser = {
        Name = "Suit Dispensers",
        type = "other_dispenser",
        class = "other_dispenser",
        func = environmental_control_func,
        devices = {
            default_other_dispenser = {
                Name = "Suit Dispenser",
                model = "models/props_combine/combine_emitter01.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    base_air_exchanger = {
        Name = "Air Exchangers",
        type = "base_air_exchanger",
        class = "base_air_exchanger",
        func = environmental_control_func,
        devices = {
            small_air_exchanger = {
                Name = "Small Air Exchanger",
                model = "models/props_combine/combine_light001a.mdl",
                skin = 0,
                legacy = false,
            },
            large_air_exchanger = {
                Name = "Large Air Exchanger",
                model = "models/props_combine/combine_light001b.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    base_temperature_exchanger = {
        Name = "Heat Exchangers",
        type = "base_temperature_exchanger",
        class = "base_temperature_exchanger",
        func = environmental_control_func,
        EnableFunc = sbCheck,
        devices = {
            small_temp_exchanger = {
                Name = "Small Temperature Exchanger",
                model = "models/props_c17/utilityconnecter006c.mdl",
                skin = 0,
                legacy = false,
            },
            large_temp_exchanger = {
                Name = "Large Temperature Exchanger",
                model = "models/props_c17/substation_transformer01d.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    base_climate_control = {
        Name = "Climate Regulators",
        type = "base_climate_control",
        class = "base_climate_control",
        func = environmental_control_func,
        EnableFunc = sbCheck,
        devices = {
            normal = {
                Name = "Climate Regulator",
                model = "models/props_combine/combine_generator01.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    other_probe = {
        Name = "Atmospheric Probes",
        type = "other_probe",
        class = "other_probe",
        func = environmental_control_func,
        EnableFunc = sbCheck,
        devices = {
            normal = {
                Name = "Atmospheric Probe",
                model = "models/props_combine/combine_mine01.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    base_gravity_control = {
        Name = "Gravity Regulators",
        type = "base_gravity_control",
        class = "base_gravity_control",
        func = environmental_control_func,
        EnableFunc = sbCheck,
        devices = {
            normal = {
                Name = "Gravity Regulator",
                model = "models/props_combine/combine_mine01.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    nature_plant = {
        Name = "Air Hydroponics",
        type = "nature_plant",
        class = "nature_plant",
        func = environmental_control_func,
        devices = {
            normal = {
                Name = "Air Hydroponics",
                model = "models/props/cs_office/plant01.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
}
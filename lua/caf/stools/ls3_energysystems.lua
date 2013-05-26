TOOL.Category = "Life Support"
TOOL.Name = "#Generators"

TOOL.DeviceName = "Generator"
TOOL.DeviceNamePlural = "Generators"
TOOL.ClassName = "ls3_energysystems"

TOOL.DevSelect = true
TOOL.CCVar_type = "generator_gas_o2"
TOOL.CCVar_sub_type = "default_O2"
TOOL.CCVar_model = "models/chipstiks_ls3_models/OxygenCompressor/oxygencompressor.mdl"

TOOL.Limited = true
TOOL.LimitName = "ls3_energysystems"
TOOL.Limit = 30

CAFToolSetup.SetLang("Life Support Generators", "Create Generators attached to any surface.", "Left-Click: Spawn a Device.  Reload: Repair Device.")

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
    panel:NumSlider("Extra Number", "receptacles_extra_num", 0, 10, 0)
    panel:CheckBox("Extra Bool", "receptacles_extra_bool")
end

function TOOL:GetExtraCCVars()
    local Extra_Data = {}
    Extra_Data.extra_num = self:GetClientNumber("extra_num")
    Extra_Data.extra_bool = self:GetClientNumber("extra_bool") == 1
    return Extra_Data
end


TOOL.Renamed = {
    class = {
        air_compressor = "generator_gas_o2",
        coolant_compressor = "generator_liquid_water",
        energy_hydro = "generator_energy_hydro",
        energy_solar = "generator_energy_solar",
        energy_wind = "generator_energy_wind",
        hvywater_electrolyzer = "generator_liquid_hvywater",
        warp_core = "generator_energy_fusion",
        water_air_extractor = "generator_gas_o2h_water",
        water_heater = "generator_gas_steam",
        water_pump = "generator_liquid_water",
    },
    type = {
        air_compressor = "generator_gas_o2",
        coolant_compressor = "generator_liquid_water",
        energy_hydro = "generator_energy_hydro",
        energy_solar = "generator_energy_solar",
        energy_wind = "generator_energy_wind",
        hvywater_electrolyzer = "generator_liquid_hvywater",
        warp_core = "generator_energy_fusion",
        water_air_extractor = "generator_gas_o2h_water",
        water_heater = "generator_gas_steam",
        water_pump = "generator_liquid_water",
    },
}

local function gas_generator_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1 --Change to be 0 by default later on
    local base_volume = 4084
    local base_mass = 200
    local base_health = 600
    local res = ""
    if type == "generator_gas_o2" then
        base_volume = 284267
        res = "oxygen"
    elseif type == "generator_gas_h" then
        base_volume = 284267 --Change to the actual base volume later on
        res = "hydrogen"
    elseif type == "generator_gas_n" then
        base_volume = 284267 --Change to the actual base volume later on
        res = "nitrogen"
    elseif type == "generator_gas_co2" then
        base_volume = 284267 --Change to the actual base volume later on
        res = "carbon dioxide"
    elseif type == "generator_gas_steam" then
        base_volume = 57804 --Change to the actual base volume later on
        base_mass = 150
        base_health = 300
        res = "steam"
    elseif type == "generator_gas_o2h_water" then
        base_volume = 49738 --Change to the actual base volume later on
        base_mass = 120
        base_health = 350
    elseif type == "generator_recycler_nitrogen" then
        base_volume = 284267 --Change to the actual base volume later on
        base_mass = 160
        base_health = 400
    elseif type == "generator_n_ramscoop" then
        res = "nitrogen"
    elseif type == "generator_h_ramscoop" then
        res = "hydrogen"
    end
    ent.caf.custom.resource = res;
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

local function liquid_generator_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1 --Change to be 0 by default later on
    local base_volume = 4084 --Change to the actual base volume later on
    local base_mass = 60
    local base_health = 200
    if type == "generator_liquid_water" then
        base_volume = 18619 --27929
    elseif type == "generator_liquid_water_liquifier" then
        base_volume = 27929
        base_mass = 80
    elseif type == "generator_liquid_hvywater" then
        base_volume = 284267 --Change to the actual base volume later on
        base_mass = 500
        base_health = 800
    elseif type == "generator_liquid_nitrogen" then
        base_volume = 284267
        base_mass = 300
        base_health = 500
    elseif type == "generator_recycler_liq_nitrogen" then
        base_volume = 284267
        base_mass = 300
        base_health = 500
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

local function energy_generator_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1 --Change to be 0 by default later on
    local base_volume = 4084 --Change to the actual base volume later on
    local base_mass = 10
    local base_health = 50
    local phys = ent:GetPhysicsObject()
    local volume = -1;
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        --MsgN("Ent Physics Object Volume: ",vol)
        volume = math.Round(vol)
    end
    if type == "generator_energy_fusion" then
        base_volume = 339933 * 3 --3399325
        if volume ~= -1 then
            volume_mul = volume / base_volume
        end
        base_mass = 1000
        base_health = 1000
        ent:AddResource("energy", math.ceil(volume_mul * 5000));
        ent:AddResource("steam", math.ceil(volume_mul * 0.92 * 45))
        ent:AddResource("water", math.ceil(volume_mul * 0.08 * 45));
    elseif type == "generator_energy_hydro" then
        base_volume = 69897
        if volume ~= -1 then
            volume_mul = volume / base_volume
        end
        local base_mass = 100
        local base_health = 150
        ent:AddResource("energy", math.ceil(volume_mul * 100));
    elseif type == "generator_energy_solar" then
        base_volume = 1982 --2950 --1014
        if volume ~= -1 then
            volume_mul = volume / base_volume
        end
        ent:AddResource("energy", math.ceil(volume_mul * 8));
    elseif type == "generator_energy_wind" then
        base_volume = 34586 --17293 --9882
        if volume ~= -1 then
            volume_mul = volume / base_volume
        end
        base_mass = 200
        base_health = 200
        ent:AddResource("energy", math.ceil(volume_mul * 100));
    elseif type == "generator_energy_steam_turbine" then
        base_volume = 18619 --27929
        if volume ~= -1 then
            volume_mul = volume / base_volume
        end
        base_mass = 150
        base_health = 300
        ent:AddResource("energy", math.ceil(volume_mul * 90));
        ent:AddResource("water", math.ceil(volume_mul * 10));
    end
    --CAF.GetAddon("Resource Distribution").RegisterNonStorageDevice(ent)
    ent:SetMultiplier(volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

TOOL.Devices = {
    generator_gas_o2 = {
        Name = "Oxygen Compressor",
        type = "generator_gas_o2",
        class = "generator_gas",
        func = gas_generator_func,
        devices = {
            default_O2 = {
                Name = "CS Air Compressor",
                model = "models/chipstiks_ls3_models/OxygenCompressor/oxygencompressor.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
        },
    },
    --[[generator_liquid_nitrogen = {
         Name	= "Liquid Nitrogen Generator",
         type	= "generator_liquid_nitrogen",
         class	= "generator_liquid_nitrogen",
         func	= liquid_generator_func,
         devices = {
             default_nitrogen_rec = {
                 Name	= "CS Liquid Nitrogen Generator (Default)",
                 model	= "models/chipstiks_ls3_models/OxygenCompressor/oxygencompressor.mdl",
                 skin	= 0,
                 legacy	= false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
             },
         },
     },]]
    generator_gas_co2 = {
        Name = "Carbon Dioxide Compressor",
        type = "generator_gas_co2",
        class = "generator_gas",
        func = gas_generator_func,
        devices = {
            default_co2 = {
                Name = "CS Carbon Dioxide Compressor",
                model = "models/chipstiks_ls3_models/CO2Comp/co2comp.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
        },
    },
    generator_gas_h = {
        Name = "Hydrogen Compressor",
        type = "generator_gas_h",
        class = "generator_gas",
        func = gas_generator_func,
        devices = {
            default_h = {
                Name = "CS Hydrogen Compressor",
                model = "models/chipstiks_ls3_models/HydrogenCompressor/hydrogencompressor.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
        },
    },
    generator_gas_n = {
        Name = "Nitrogen Compressor",
        type = "generator_gas_n",
        class = "generator_gas",
        func = gas_generator_func,
        devices = {
            default_n = {
                Name = "CS Nitrogen Compressor",
                model = "models/chipstiks_ls3_models/NitrogenCompressor/nitrogencompressor.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
        },
    },
    generator_gas_steam = {
        Name = "Water Heater",
        type = "generator_gas_steam",
        class = "generator_gas_steam",
        func = gas_generator_func,
        devices = {},
    },
    generator_energy_steam_turbine = {
        Name = "Steam Turbine",
        type = "generator_energy_steam_turbine",
        class = "generator_energy_steam_turbine",
        func = energy_generator_func,
        devices = {
            add_one = {
                Name = "CE Small Steam Turbine",
                model = "models/ce_ls3additional/water_heater/water_heater.mdl",
                skin = 0
            },
        },
    },
    generator_gas_o2h_water = {
        Name = "H2O Splitter",
        type = "generator_gas_o2h_water",
        class = "generator_gas_o2h_water",
        func = gas_generator_func,
        devices = {
            large_phx = {
                Name = "Eversmart1",
                model = "models/LifeSupport/Generators/waterairextractor.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    generator_liquid_water2 = {
        Name = "Hydrogen Fuel Cell",
        type = "generator_liquid_water2",
        class = "generator_liquid_water2",
        func = liquid_generator_func,
        devices = {
            large_phx = {
                Name = "Eversmart1",
                model = "models/LifeSupport/Generators/waterairextractor.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    generator_liquid_water = {
        Name = "Water Pump",
        type = "generator_liquid_water",
        class = "generator_liquid_water",
        func = liquid_generator_func,
        devices = {
            small_phx = {
                Name = "Phx Water Pump",
                model = "models/props_phx/life_support/gen_water.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
        },
    },
    generator_liquid_hvywater = {
        Name = "Heay Water Electrolyzor",
        type = "generator_liquid_hvywater",
        class = "generator_liquid_hvywater",
        func = liquid_generator_func,
        devices = {
            small_phx = {
                Name = "Default",
                model = "models/props_wasteland/laundry_washer003.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
        },
    },
    generator_energy_fusion = {
        Name = "Fusion Generator",
        type = "generator_energy_fusion",
        class = "generator_energy_fusion",
        func = energy_generator_func,
        devices = {},
    },
    generator_energy_hydro = {
        Name = "Hydro Energy Generator",
        type = "generator_energy_hydro",
        class = "generator_energy_hydro",
        func = energy_generator_func,
        devices = {
            small_phx = {
                Name = "CS Hydro Gen",
                model = "models/chipstiks_ls3_models/HydroGenerator/hydrogenerator.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
        },
    },
    generator_energy_solar = {
        Name = "Solar Panels",
        type = "generator_energy_solar",
        class = "generator_energy_solar",
        func = energy_generator_func,
        devices = {
            small_phx = {
                Name = "Small Solar Panel (phx)",
                model = "models/props_phx/life_support/panel_small.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Solar Panel (phx)",
                model = "models/props_phx/life_support/panel_medium.mdl",
                skin = 0,
                legacy = false,
            },
            large_phx = {
                Name = "Large Solar Panel (phx)",
                model = "models/props_phx/life_support/panel_large.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    generator_energy_wind = {
        Name = "Wind Generator",
        type = "generator_energy_wind",
        class = "generator_energy_wind",
        func = energy_generator_func,
        devices = {
            large_1 = {
                Name = "Large",
                model = "models/ls_models/cloudstrifexiii/windmill/windmill_large.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_1 = {
                Name = "Medium",
                model = "models/ls_models/cloudstrifexiii/windmill/windmill_medium.mdl",
                skin = 0,
                legacy = false,
            },
            small_1 = {
                Name = "Small",
                model = "models/ls_models/cloudstrifexiii/windmill/windmill_small.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    generator_h_ramscoop = {
        Name = "Hydrogen Ram Scoop",
        type = "generator_h_ramscoop",
        class = "generator_ramscoop",
        func = gas_generator_func,
        devices = {
            normal = {
                Name = "Levy's RamScoop",
                model = "models/LifeSupport/Generators/ramscoop.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            Other = {
                Name = "Other",
                model = "models/props_lab/walllight001a.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            }
        },
    },
    generator_n_ramscoop = {
        Name = "Nitrogen Ram Scoop",
        type = "generator_n_ramscoop",
        class = "generator_ramscoop",
        func = gas_generator_func,
        devices = {
            normal = {
                Name = "Levy's RamScoop",
                model = "models/LifeSupport/Generators/ramscoop.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            Other = {
                Name = "Other",
                model = "models/props_lab/walllight001a.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            }
        },
    },
}


	
	
	

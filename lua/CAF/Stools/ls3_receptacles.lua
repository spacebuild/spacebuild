TOOL.Category = "Life Support"
TOOL.Name = "#Storage Devices"

TOOL.DeviceName = "Storage Device"
TOOL.DeviceNamePlural = "Storage Devices"
TOOL.ClassName = "ls3_receptacles"

TOOL.DevSelect = true
TOOL.CCVar_type = "storage_gas_o2"
TOOL.CCVar_sub_type = "Small (Phx)"
TOOL.CCVar_model = "models/props_phx/life_support/canister_small.mdl"

TOOL.Limited = true
TOOL.LimitName = "ls3_receptacles"
TOOL.Limit = 20

CAFToolSetup.SetLang("Life Support Storage Devices", "Create Storage Devices attached to any surface.", "Left-Click: Spawn a Device.  Reload: Repair Device.")


TOOL.ExtraCCVars = {
    extra_num = 0,
    extra_bool = 0,
}

function TOOL.EnableFunc()
    if not CAF then
        return false;
    end
    if not CAF.GetAddon("Resource Distribution") or not CAF.GetAddon("Resource Distribution").GetStatus() then
        return false;
    end
    return true;
end

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
        air_tank = "storage_gas_o2",
        coolant_tank = "storage_liquid_water",
        energy_cell = "storage_energy",
        steam_tank = "storage_gas_steam",
        water_tank = "storage_liquid_water",
        hvywater_tank = "storage_liquid_hvywater"
    },
    type = {
        air_tank = "storage_gas_o2",
        coolant_tank = "storage_liquid_water",
        energy_cell = "storage_energy",
        steam_tank = "storage_gas_steam",
        water_tank = "storage_liquid_water",
        hvywater_tank = "storage_liquid_hvywater",
    },
}


--[[
	TOOL.AdminOnly 			= true --Make the Stool admin only
	TOOL.EnableFunc  = function(ply) return true or false end (Optional)
	
	
	type = {
		type			= "entity type", --same as key (optional). typically same as class
		class			= "entity class", --entity class used by ents.Create() (optional if type is class)
		Name			= "Print Name used for device catagory in tool",
		legacy		= true, --if _WHOLE_ group contains _ONLY_ ents that are from orginal ls2 (optional) this is for old dupe saves that use model as a sub type
		hide			= true, --if this group should be hidden on the control panel (optional)
		
		MakeFunc		= function(tool, ply, Ang, Pos, type, sub_type, model, frozen, Extra_Data, devinfo) return ent end (optional)
		MakeFuncReturn	= true, --skips rest of make rd2 ent function and returns ent (optional)
		EnableFunc  = function(ply) return true or false end (Optional)
		func			= function(ent,type,sub_type,devinfo,Extra_Data,ent_extras) addres(ent) return mass, maxhealth end (optional)
		AdminOnly		= true/false --Make the Device group Admin only
		devices = {
			sub_type = {
				Name		= "Print Name for this sub_type in tool",
				type		= "entity class", can be different than group type (optional)
				class		= "entity class", --entity class used by ents.Create() (optional if type is class or if same as group.class or group.type)
				model		= "path/to/model",
				skin		= # for skin, (optional)
				res			= {coolant = 4000},
				EnableFunc  = function(ply) return true or false end (Optional)
				maxhealth	= 300,
				mass		= 20,
				legacy	= true, --if ent is from ls2 (optional)
				hide		= true, --if this sub_type should be hidden on the control panel (optional)
				ent_extras	= {}, --table of exra info to copy to ent (optional)
				AdminOnly		= true/false --Make the Device Admin only
			},
			sub_type = {
				Name		= "Print Name for this sub_type in tool",
				model		= "path/to/model",
				material	= "path/to/material", (optional)
				func		= function(ent,type,sub_type,devinfo,Extra_Data,ent_extras) addres(ent) return mass, maxhealth end (optional)
			},
		},
	},
]]


local function gas_tank_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 4084
    local base_mass = 10
    local base_health = 100
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    local res = ""
    if type == "storage_gas_o2" then
        res = "oxygen"
    elseif type == "storage_gas_h" then
        res = "hydrogen"
    elseif type == "storage_gas_n" then
        res = "nitrogen"
    elseif type == "storage_gas_co2" then
        res = "carbon dioxide"
    elseif type == "storage_gas_steam" then
        res = "steam"
    end
    ent.caf.custom.resource = res;
    CAF.GetAddon("Resource Distribution").AddResource(ent, res, math.Round(4600 * volume_mul))
    ent.MAXRESOURCE = math.Round(4600 * volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

local function energy_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 6021
    local base_mass = 5
    local base_health = 200
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    CAF.GetAddon("Resource Distribution").AddResource(ent, "energy", math.Round(3600 * volume_mul))
    ent.MAXRESOURCE = math.Round(3600 * volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

local function liquid_tank_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 4084
    local base_mass = 20
    local base_health = 150
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    CAF.GetAddon("Resource Distribution").AddResource(ent, "water", math.Round(3600 * volume_mul))
    ent.MAXRESOURCE = math.Round(3600 * volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

local function liquid_nitrogen_tank_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 4084
    local base_mass = 20
    local base_health = 200
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    CAF.GetAddon("Resource Distribution").AddResource(ent, "liquid nitrogen", math.Round(3000 * volume_mul))
    ent.MAXRESOURCE = math.Round(3000 * volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

local function hot_liquid_nitrogen_tank_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 4084
    local base_mass = 20
    local base_health = 200
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    CAF.GetAddon("Resource Distribution").AddResource(ent, "hot liquid nitrogen", math.Round(2500 * volume_mul))
    ent.MAXRESOURCE = math.Round(2500 * volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

local function heavywater_tank_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 4084
    local base_mass = 25
    local base_health = 180
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    CAF.GetAddon("Resource Distribution").AddResource(ent, "heavy water", math.Round(3600 * volume_mul))
    ent.MAXRESOURCE = math.Round(3600 * volume_mul)
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

local function cache_func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    local volume_mul = 1
    local base_volume = 4084
    local base_mass = 50
    local base_health = 250
    local phys = ent:GetPhysicsObject()
    if phys:IsValid() and phys.GetVolume then
        local vol = phys:GetVolume()
        vol = math.Round(vol)
        volume_mul = vol / base_volume
    end
    CAF.GetAddon("Resource Distribution").AddResource(ent, "energy", math.Round(5500 * volume_mul))
    CAF.GetAddon("Resource Distribution").AddResource(ent, "oxygen", math.Round(6000 * volume_mul))
    CAF.GetAddon("Resource Distribution").AddResource(ent, "hydrogen", math.Round(3000 * volume_mul))
    CAF.GetAddon("Resource Distribution").AddResource(ent, "carbon dioxide", math.Round(5000 * volume_mul))
    CAF.GetAddon("Resource Distribution").AddResource(ent, "nitrogen", math.Round(7000 * volume_mul))
    CAF.GetAddon("Resource Distribution").AddResource(ent, "liquid nitrogen", math.Round(7000 * volume_mul))
    CAF.GetAddon("Resource Distribution").AddResource(ent, "water", math.Round(4000 * volume_mul))
    CAF.GetAddon("Resource Distribution").AddResource(ent, "heavy water", math.Round(360 * volume_mul))
    local mass = math.Round(base_mass * volume_mul)
    ent.mass = mass
    local maxhealth = math.Round(base_health * volume_mul)
    return mass, maxhealth
end

TOOL.Devices = {
    storage_gas_o2 = {
        Name = "Oxygen Tanks",
        type = "storage_gas_o2",
        class = "storage_gas",
        func = gas_tank_func,
        --EnableFunc = function() return false end,
        devices = {
            small_phx = {
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 0,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 0,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 0,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    storage_gas_co2 = {
        Name = "Carbon Dioxide Tanks",
        type = "storage_gas_co2",
        class = "storage_gas",
        func = gas_tank_func,
        devices = {
            small_phx = {
                --EnableFunc = function() return false end,
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 3,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 3,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 3,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 3,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 3,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 3,
                legacy = false,
            },
        },
    },
    storage_gas_h = {
        Name = "Hydrogen Tanks",
        type = "storage_gas_h",
        class = "storage_gas",
        func = gas_tank_func,
        devices = {
            small_phx = {
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 2,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 2,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 2,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 2,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 2,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 2,
                legacy = false,
            },
        },
    },
    storage_gas_n = {
        Name = "Nitrogen Tanks",
        type = "storage_gas_n",
        class = "storage_gas",
        func = gas_tank_func,
        devices = {
            small_phx = {
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 1,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 1,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 1,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 1,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 1,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 1,
                legacy = false,
            },
        },
    },
    storage_gas_steam = {
        Name = "Steam Tanks",
        type = "storage_gas_steam",
        class = "storage_gas_steam",
        func = gas_tank_func,
        devices = {
            small_phx = {
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 5,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 5,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 5,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 5,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 5,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 5,
                legacy = false,
            },
        },
    },
    storage_liquid_water = {
        Name = "Water Tanks",
        type = "storage_liquid_water",
        class = "storage_liquid_water",
        func = liquid_tank_func,
        devices = {
            small_phx = {
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 4,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 4,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 4,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 4,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 4,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 4,
                legacy = false,
            },
        },
    },
    storage_liquid_hvywater = {
        Name = "Heavy Water Tanks",
        type = "storage_liquid_hvywater",
        class = "storage_liquid_hvywater",
        func = heavywater_tank_func,
        devices = {
            small_phx = {
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 6,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 6,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 6,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 6,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 6,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 6,
                legacy = false,
            },
        },
    },
    storage_energy = {
        Name = "Batteries",
        type = "storage_energy",
        class = "storage_energy",
        func = energy_func,
        devices = {
            small_phx = {
                Name = "Small (Phx)",
                model = "models/props_phx/life_support/battery_small.mdl",
                skin = 0,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium (Phx)",
                model = "models/props_phx/life_support/Battery_medium.mdl",
                skin = 0,
                legacy = false,
            },
            large_phx = {
                Name = "Large (Phx)",
                model = "models/props_phx/life_support/battery_large.mdl",
                skin = 0,
                legacy = false,
            },
        },
    },
    storage_cache = {
        Name = "Resource Caches",
        type = "storage_cache",
        func = cache_func,
        devices = {
            small = {
                Name = "CE Small",
                model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
            },
            medium = {
                Name = "CE Medium",
                model = "models/ce_ls3additional/resource_cache/resource_cache_medium.mdl",
            },
            large = {
                Name = "CE Large",
                model = "models/ce_ls3additional/resource_cache/resource_cache_large.mdl",
            },
            huge = {
                Name = "Levy Canister",
                model = "models/LifeSupport/Storage/CargoCanister.mdl",
            },
        },
    },
    storage_liquid_nitrogen = {
        Name = "Liquid Nitrogen Tanks",
        type = "storage_liquid_nitrogen",
        class = "storage_liquid_nitrogen",
        func = liquid_nitrogen_tank_func,
        devices = {
            small_phx = {
                Name = "Small Canister (Phx)",
                model = "models/props_phx/life_support/canister_small.mdl",
                skin = 7,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            small_phx2 = {
                Name = "Small Tank (Phx)",
                model = "models/props_phx/life_support/tank_small.mdl",
                skin = 7,
                legacy = false, --these two vars must be defined per ent as the old tanks (defined in external file) require different values
            },
            medium_phx = {
                Name = "Medium Canister (Phx)",
                model = "models/props_phx/life_support/canister_medium.mdl",
                skin = 7,
                legacy = false,
            },
            medium_phx2 = {
                Name = "Medium Tank (Phx)",
                model = "models/props_phx/life_support/tank_medium.mdl",
                skin = 7,
                legacy = false,
            },
            large_phx = {
                Name = "Large Canister (Phx)",
                model = "models/props_phx/life_support/canister_large.mdl",
                skin = 7,
                legacy = false,
            },
            large_phx2 = {
                Name = "Large Tank (Phx)",
                model = "models/props_phx/life_support/tank_large.mdl",
                skin = 7,
                legacy = false,
            },
            small = {
                Name = "CE Small",
                model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
            },
            medium = {
                Name = "CE Medium",
                model = "models/ce_ls3additional/resource_cache/resource_cache_medium.mdl",
            },
            large = {
                Name = "CE Large",
                model = "models/ce_ls3additional/resource_cache/resource_cache_large.mdl",
            },
            huge = {
                Name = "Levy Canister",
                model = "models/LifeSupport/Storage/CargoCanister.mdl",
            }
        },
    },
}


	
	
	

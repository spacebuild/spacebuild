--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 30/01/2017
-- Time: 19:55
-- To change this template use File | Settings | File Templates.
--

local devices, SB, defaultIcon = {}, SPACEBUILD, ""

function SB:getCategories()
    return devices
end

function SB:registerCategory(name, icon)
    if not name then error("name is required") end
    if devices[name:lower()] then error("category is already registered") end
    if not icon then icon = defaultIcon end
    devices[name:lower()] = {
        name = name,
        icon = icon,
        devices = {}
    }
end

function SB:registerDeviceInfo(category, name, class, model, spawnFunction, material, icon, skin)
    if not category then error("category is required") end
    if not devices[category:lower()] then error("category is not registered yet") end
    if not name then error("name is required") end
    if devices[category:lower()].devices[name:lower()] then error("name is already registered") end
    if not class then error("class is required") end
    if not model then error("model is required") end
    if not spawnFunction then error("spawnfunction is required") end
    if not skin then skin = 0 end
    if not icon then icon = defaultIcon end
    devices[category:lower()].devices[name:lower()] = {
        name        = name,
        icon        = icon,
        class       = class,
        model       = model,
        material    = material,
        spawnFunction = spawnFunction,
        skin = skin
    }
end

SB:registerCategory("Network")
SB:registerCategory("Storage")
SB:registerCategory("Generators")
SB:registerCategory("Environmental")

SB:registerDeviceInfo(
    "Storage",
    "Battery",
    "base_resource_entity",
    "models/props_phx/life_support/battery_small.mdl",
    function(ent)
        ent:addResource("energy", 500)
    end
)
SB:registerDeviceInfo(
    "Storage",
    "Water tank",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("water", 500)
    end,
    nil,
    nil,
    4
)
SB:registerDeviceInfo(
    "Storage",
    "Oxygen tank",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("oxygen", 500)
    end
)
SB:registerDeviceInfo(
    "Network",
    "Network",
    "base_resource_network",
    "models/SnakeSVx/small_res_node.mdl",
    function(ent)
        ent.range = 512
    end
)




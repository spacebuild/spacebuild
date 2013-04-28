
-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

local GM = GM

local items = {
    hulls = {
        name = "Hulls",
        description = "All kinds of hulls for ship building",
        icon = "icons/128/hulls.png",
        items = {
            hull_1 = {
                name = "Hull Test 1",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvel.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_2 = {
                name = "Hull Test 2",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvem.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_3 = {
                name = "Hull Test 3",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurves.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_4 = {
                name = "Hull Test 4",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhulle05.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_5 = {
                name = "Hull Test 1",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvel.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_6 = {
                name = "Hull Test 2",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvem.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_7 = {
                name = "Hull Test 3",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurves.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_8 = {
                name = "Hull Test 4",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhulle05.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_9 = {
                name = "Hull Test 1",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvel.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_10 = {
                name = "Hull Test 2",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvem.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_11 = {
                name = "Hull Test 3",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurves.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            },
            hull_12 = {
                name = "Hull Test 4",
                description = nil,
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhulle05.mdl",
                health = 100,
                armor = 100,
                class = "prop_physics",
                material = nil,
                skin = nil
            }
        }
    },
    generators = {
        name = "Generators",
        description = "All kinds of generators",
        icon = "icons/128/generators.png",
        items = {
            solar_panel = {
                name = "Test Solar Panel",
                description = "Solar panel used for testing",
                price = 1000,
                model = "models/props_phx/life_support/panel_medium.mdl",
                health = 100,
                armor = 100,
                class = "resource_generator_energy",
                material = nil,
                skin = nil
            },
            oxygen_generator = {
                name = "Test Oxygen generator",
                description = "Oxygen generator used for testing",
                price = 1000,
                model = "models/hunter/blocks/cube1x1x1.mdl",
                health = 100,
                armor = 100,
                class = "resource_generator_oxygen",
                material = nil,
                skin = nil
            },
            water_pump = {
                name = "Test Water Pump",
                description = "Water pump used for testing",
                price = 1000,
                model = "models/props_phx/life_support/gen_water.mdl",
                health = 100,
                armor = 100,
                class = "resource_generator_water",
                material = nil,
                skin = nil
            }

        }
    },
    storages = {
        name = "Storages",
        description = "All kinds of storages",
        icon = "icons/128/storage.png",
        items = {
            energy_storage = {
                name = "Test Energy Storage",
                description = "Test energy storage device",
                price = 1000,
                model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
                health = 100,
                armor = 100,
                class = "resource_storage_energy",
                material = nil,
                skin = nil
            },
            oxygen_storage = {
                name = "Test Oxygen generator",
                description = "Test oxygen storage device",
                price = 1000,
                model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
                health = 100,
                armor = 100,
                class = "resource_storage_oxygen",
                material = nil,
                skin = nil
            },
            water_storage = {
                name = "Test Water Storage",
                description = "Test water storage device",
                price = 1000,
                model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
                health = 100,
                armor = 100,
                class = "resource_storage_water",
                material = nil,
                skin = nil
            },
            blackhole = {
                name = "Test Blackhole Storage",
                description = "Test energy/oxygen/water storage device",
                price = 1000,
                model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
                health = 100,
                armor = 100,
                class = "resource_storage_blackhole",
                material = nil,
                skin = nil
            }
        }
    },
    life_support = {
        name = "Life Support Devices",
        description = "All kinds of life support devices",
        icon = "icons/128/support.png",
        items = {
            suit_dispenser = {
                name = "Suit Dispenser Test",
                description = "Puts resources into the suit",
                price = 1000,
                model = "models/hunter/blocks/cube1x1x1.mdl",
                health = 100,
                armor = 100,
                class = "ls_suit_dispenser",
                material = nil,
                skin = nil
            }
        }
    },
    network = {
        name = "Network devices",
        description = "All kinds of network devices",
        icon = "icons/128/network.png",
        items = {

        }
    },
    mining = {
        name = "Mining devices",
        description = "All kinds of mining devices",
        icon = "icons/128/mining.png",
        items = {

        }
    },
    weapons = {
        name = "Weapons",
        description = "All kinds of weapons",
        icon = "icons/128/weapons.png",
        items = {

        }
    }
}


function GM:getItems()
    return items
end

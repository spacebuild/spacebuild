
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
        items = {
            hull_1 = {
                name = "Hull Test 1",
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvel.mdl",
                health = 100,
                armor = 100
            },
            hull_2 = {
                name = "Hull Test 2",
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurvem.mdl",
                health = 100,
                armor = 100
            },
            hull_3 = {
                name = "Hull Test 3",
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhullcurves.mdl",
                health = 100,
                armor = 100
            },
            hull_4 = {
                name = "Hull Test 4",
                price = 1000,
                model = "models/smallbridge/hulls_sw/sbhulle05.mdl",
                health = 100,
                armor = 100
            }
        }
    },
    generators = {
        name = "Generators",
        description = "All kinds of generators",
        items = {

        }
    },
    storages = {
        name = "Storages",
        description = "All kinds of storages",
        items = {

        }
    },
    life_support = {
        name = "Life Support Devices",
        description = "All kinds of life support devices",
        items = {

        }
    },
    network = {
        name = "Network devices",
        description = "All kinds of network devices",
        items = {

        }
    },
    mining = {
        name = "Mining devices",
        description = "All kinds of mining devices",
        items = {

        }
    },
    weapons = {
        name = "Weapons",
        description = "All kinds of weapons",
        items = {

        }
    }
}


function GM:getItems()
    return items
end

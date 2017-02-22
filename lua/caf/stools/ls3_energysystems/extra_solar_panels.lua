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

DEVICEGROUP.type = "generator_energy_solar"

--[[
	You can also use skin = number here to define a skin to make the Module spawn with
	You can also use material = "path/to/material" to set a material to make it spawn with
]]

DEVICEGROUP.devices = {
    add_one = {
        Name = "CE Small Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_small.mdl",
        skin = 0
    },
    add_two = {
        Name = "CE Medium Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_medium.mdl",
        skin = 0
    },
    add_three = {
        Name = "CE Large Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_large.mdl",
        skin = 0
    },
    add_4 = {
        Name = "CE Huge Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_huge.mdl",
        skin = 0
    },
    add_5 = {
        Name = "CE Small Circle Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_c_small.mdl",
        skin = 0
    },
    add_6 = {
        Name = "CE Medium Circle Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_c_medium.mdl",
        skin = 0
    },
    add_7 = {
        Name = "CE Large Circle Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_c_large.mdl",
        skin = 0
    },
    add_8 = {
        Name = "CE Huge Circle Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_c_huge.mdl",
        skin = 0
    },
    add_9 = {
        Name = "CE Giant Solar Panel",
        model = "models/ce_ls3additional/solar_generator/solar_generator_giant.mdl",
        skin = 0
    },
}


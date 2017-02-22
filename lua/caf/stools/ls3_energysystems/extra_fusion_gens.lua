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

DEVICEGROUP.type = "generator_energy_fusion"

--[[
	You can also use skin = number here to define a skin to make the Module spawn with
	You can also use material = "path/to/material" to set a material to make it spawn with
]]

DEVICEGROUP.devices = {
    add_one = {
        Name = "CE Medium Fusion Gen",
        model = "models/ce_ls3additional/fusion_generator/fusion_generator_medium.mdl",
        skin = 0
    },
    add_two = {
        Name = "Levy Huge Fusion Gen",
        model = "models/LifeSupport/Generators/fusiongen.mdl",
        skin = 0
    },
    -- This one is Purely cosmetic, the texture fades between red and blue on a sine wave, I improved some of the my textures a good bit using proxies. Oh, Also, the selfilium lighting fades as well, on the same curve. :V
    add_again = {
        Name = "Levy Pulsing Fusion Gen",
        model = "models/LifeSupport/Generators/fusiongen.mdl",
        skin = 1
    },
    add_3 = {
        Name = "CE Large Fusion Gen",
        model = "models/ce_ls3additional/fusion_generator/fusion_generator_large.mdl",
        skin = 0
    },
    add_4 = {
        Name = "CE Small Fusion Gen",
        model = "models/ce_ls3additional/fusion_generator/fusion_generator_small.mdl",
        skin = 0
    },
    add_5 = {
        Name = "CE Huge Fusion Gen",
        model = "models/ce_ls3additional/fusion_generator/fusion_generator_huge.mdl",
        skin = 0
    },
}


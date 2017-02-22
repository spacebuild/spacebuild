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

DEVICEGROUP.type = "storage_gas_o2"

--[[
	You can also use skin = number here to define a skin to make the Module spawn with
	You can also use material = "path/to/material" to set a material to make it spawn with
]]

DEVICEGROUP.devices = {
    add_one = {
        Name = "CE Small Oxygen Storage",
        model = "models/ce_ls3additional/canisters/canister_small.mdl",
        skin = 1
    },
    add_2 = {
        Name = "CE Medium Oxygen Storage",
        model = "models/ce_ls3additional/canisters/canister_medium.mdl",
        skin = 1
    },
    add_3 = {
        Name = "CE Large Oxygen Storage",
        model = "models/ce_ls3additional/canisters/canister_large.mdl",
        skin = 1
    },
    add_4 = {
        Name = "CS Small Oxygen Storage",
        model = "models/chipstiks_ls3_models/SmallOxygenTank/smalloxygentank.mdl",
    },
    add_5 = {
        Name = "CS Medium Oxygen Storage",
        model = "models/chipstiks_ls3_models/MediumOxygenTank/mediumoxygentank.mdl",
    },
    add_6 = {
        Name = "CS Large Oxygen Storage",
        model = "models/chipstiks_ls3_models/LargeOxygenTank/largeoxygentank.mdl",
    },
}


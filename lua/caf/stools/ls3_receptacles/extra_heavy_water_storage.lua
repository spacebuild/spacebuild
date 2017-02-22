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

DEVICEGROUP.type = "storage_liquid_hvywater"

--[[
	You can also use skin = number here to define a skin to make the Module spawn with
	You can also use material = "path/to/material" to set a material to make it spawn with
]]

DEVICEGROUP.devices = {
    add_zero = {
        Name = "CE Tiny Heavy Water Storage",
        model = "models/ce_ls3additional/resource_tanks/resource_tank_tiny.mdl",
        skin = 1
    },
    add_one = {
        Name = "CE Small Heavy Water Storage",
        model = "models/ce_ls3additional/resource_tanks/resource_tank_small.mdl",
        skin = 1
    },
    add_2 = {
        Name = "CE Medium Heavy Water Storage",
        model = "models/ce_ls3additional/resource_tanks/resource_tank_medium.mdl",
        skin = 1
    },
    add_3 = {
        Name = "CE Large Heavy Water Storage",
        model = "models/ce_ls3additional/resource_tanks/resource_tank_large.mdl",
        skin = 1
    },
}


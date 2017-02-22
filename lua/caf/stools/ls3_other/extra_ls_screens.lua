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

DEVICEGROUP.type = "other_screen"

--[[
	You can also use skin = number here to define a skin to make the Module spawn with
	You can also use material = "path/to/material" to set a material to make it spawn with
]]

DEVICEGROUP.devices = {
    ls_add_one = {
        Name = "CE Small Black Screen",
        model = "models/ce_ls3additional/screens/small_screen.mdl",
    },
    ls_add_2 = {
        Name = "CE Small Metal Screen",
        model = "models/ce_ls3additional/screens/small_screen.mdl",
        skin = 1,
    },
    ls_add_3 = {
        Name = "CE Tiny Black Screen",
        model = "models/ce_ls3additional/screens/s_small_screen.mdl",
    },
    ls_add_4 = {
        Name = "CE Tiny Metal Screen",
        model = "models/ce_ls3additional/screens/s_small_screen.mdl",
        skin = 1,
    },
    ls_add_5 = {
        Name = "CE Medium Black Screen",
        model = "models/ce_ls3additional/screens/medium_screen.mdl",
    },
    ls_add_6 = {
        Name = "CE Medium Metal Screen",
        model = "models/ce_ls3additional/screens/medium_screen.mdl",
        skin = 1,
    },
    ls_add_7 = {
        Name = "CE Large Black Screen",
        model = "models/ce_ls3additional/screens/large_screen.mdl",
    },
    ls_add_8 = {
        Name = "CE Large Metal Screen",
        model = "models/ce_ls3additional/screens/large_screen.mdl",
        skin = 1,
    },
}


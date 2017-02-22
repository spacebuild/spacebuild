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

local base = "caf/"

-- Modules
AddCSLuaFile("includes/modules/ArrayList.lua")
AddCSLuaFile("includes/modules/HashMap.lua")
AddCSLuaFile("includes/modules/cache.lua")

-- Shared
AddCSLuaFile(base.."core/shared/sh_general_caf.lua")
AddCSLuaFile(base.."core/shared/caf_tools.lua")
AddCSLuaFile(base.."core/shared/tool_helpers.lua")
AddCSLuaFile(base.."core/shared/tool_manifest.lua")
-- Client
AddCSLuaFile(base.."core/client/cl_tab.lua")

-- Addons
AddCSLuaFile(base.."addons/client/resourcedistribution.lua")
AddCSLuaFile(base.."addons/client/lifesupport.lua")
AddCSLuaFile(base.."addons/client/spacebuild.lua")

-- Language
AddCSLuaFile(base.."languagevars/defaults.lua")

-- Other
AddCSLuaFile( "vgui/caf_gui.lua" )
AddCSLuaFile( "vgui/caf_gui_button.lua"	)

-- Send tools
for key, val in pairs(file.Find(base.."stools/*.lua", "LUA")) do
    AddCSLuaFile( base.."stools/"..val )
end

-- Autostart
AddCSLuaFile(base.."autostart/client/cl_caf_autostart.lua")
AddCSLuaFile(base.."autostart/resources_api.lua")

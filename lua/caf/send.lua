--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 7/01/2017
-- Time: 11:43
-- To change this template use File | Settings | File Templates.
--

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

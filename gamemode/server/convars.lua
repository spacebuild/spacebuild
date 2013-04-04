--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 14/03/13
-- Time: 18:44
-- To change this template use File | Settings | File Templates.
--

CreateConVar("SB_NoClip", "1")
CreateConVar("SB_AdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
CreateConVar("SB_SuperAdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
CreateConVar("SB_PlanetNoClipOnly", "1") -- Make it so admins can let players no clip in space.

CreateConVar("SB_LogLevel", "1") -- Set log level to 1, which by default is info.

local sb = sb
local game = game
local GetConVar = GetConVar
local convars = sb.core.convars

convars.sb_noclip = {
	get = function() return GetConVar("SB_NoClip"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_NoClip", val:toNumber()) end
}

convars.sb_adminspacenoclip = {
	get = function() return GetConVar("SB_AdminSpaceNoclip"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_AdminSpaceNoclip", val:toNumber()) end
}

convars.sb_superadminspacenoclip = {
	get = function() return GetConVar("SB_SuperAdminSpaceNoclip"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_SuperAdminSpaceNoclip", val:toNumber()) end
}

convars.sb_planetnocliponly = {
	get = function() return GetConVar("SB_PlanetNoClipOnly"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_PlanetNoClipOnly", val:toNumber()) end
}
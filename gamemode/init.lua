
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

local AddCSLuaFile, include, CreateConVar, game, GetConVar = AddCSLuaFile, include, CreateConVar, game, GetConVar

--Send stuff to the client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared/send.lua") --Send the shared code
include("client/send.lua") --Send the clientside code
include("vgui/send.lua")
include("classes/send.lua")

-- Resources
include("client/resources.lua")

-- Start serverside code
include("shared.lua") --Initialize the shared code first

local BaseClass = GM:GetBaseClass()

local GM = GM

CreateConVar("SB_NoClip", "1")
CreateConVar("SB_AdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
CreateConVar("SB_SuperAdminSpaceNoclip", "1") -- Makes it so admins can no clip in space, defaults to yes
CreateConVar("SB_PlanetNoClipOnly", "1") -- Make it so admins can let players no clip in space.

CreateConVar("SB_EnableDrag", "1") -- Make it drag also gets affected, on by default.
CreateConVar("SB_InfiniteResources", "0") -- Makes it so that a planet can't run out of resources, off by default.

GM.convars.noclip = {
	get = function() return GetConVar("SB_NoClip"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_NoClip", val:toNumber()) end
}

GM.convars.adminspacenoclip = {
	get = function() return GetConVar("SB_AdminSpaceNoclip"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_AdminSpaceNoclip", val:toNumber()) end
}

GM.convars.superadminspacenoclip = {
	get = function() return GetConVar("SB_SuperAdminSpaceNoclip"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_SuperAdminSpaceNoclip", val:toNumber()) end
}

GM.convars.planetnocliponly = {
	get = function() return GetConVar("SB_PlanetNoClipOnly"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_PlanetNoClipOnly", val:toNumber()) end
}

GM.convars.drag = {
	get = function() return GetConVar("SB_EnableDrag"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_EnableDrag", val:toNumber()) end
}

GM.convars.resources = {
	get = function() return GetConVar("SB_InfiniteResources"):GetBool() end,
	set = function(val) game.ConsoleCommand("SB_InfiniteResources", val:toNumber()) end
}

include("server/init.lua")

include("test.lua")

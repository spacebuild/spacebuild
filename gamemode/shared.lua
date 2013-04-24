
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

local DeriveGamemode = DeriveGamemode
local CreateConVar = CreateConVar
local include = include
local GetConVar = GetConVar
local game = game
local tonumber = tonumber

--
-- Make BaseClass available
--
DEFINE_BASECLASS( "gamemode_base" )

local BaseClass = BaseClass

local GM = GM

GM.Name 	= "Spacebuild"
GM.Author 	= "SB Dev Team | INP Games"
GM.Email 	= "spacebuild.dev@gmail.com | admin@inpgames.com"
GM.Website 	= "www.snakesvx.net | www.inpgames.com"
GM.Version 	= "1"

GM.convars 		= {}
GM.constants 	= {}
GM.util 		= {}
GM.wrappers 	= {}
GM.extensions 	= {}
GM.class 		= {}
GM.internal 	= {}

CreateConVar("SB_Log", "1") -- Set log level to 1, which by default is info.

GM.convars.log = {
	get = function() return GetConVar("SB_Log"):GetInt() end,
	set = function(val) game.ConsoleCommand("SB_Log", tonumber(val)) end
}

-- Old stuff

function GM:GetBaseClass()
	return BaseClass
end

include( "player_class/player_terran.lua" )
include( "player_class/player_radijn.lua" )
include( "player_class/player_pendrouge.lua" )
include("shared/wrappers.lua")
include("shared/const.lua")
include("shared/util.lua")
include("classes/class.lua")
include("shared/spacebuild.lua")
include("propertiesmenu.lua")

----- Extension System ----
include("shared/extensions.lua")
--------------------------

----- Part Spawner List ---
include("shared/sb4_model_list.lua")
---------------------------
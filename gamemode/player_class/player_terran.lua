
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


AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local GM = GM
local class = GM.class

local PLAYER = {}

--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400

-- Set a Race specific colour, this will be used as an identifier
PLAYER.RaceColor			= Color(100,150,0,200)
PLAYER.PlayerColor          = Vector( 100/255, 150/255, 0/255 )
PLAYER.WeaponColor          = Vector( "0.30 1.80 2.10" )

-- Specify variable to store Race name
PLAYER.RaceName				= "Terran"


function PLAYER:Init()
   self.Player.ls_suit = class.new("PlayerSuit", self.Player)
end

GM:registerPlayerClass("player_terran", PLAYER)


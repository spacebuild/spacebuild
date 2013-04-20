
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
PLAYER.RaceColor			= Color(150,50,200,200)

function PLAYER:getRaceColor()

	return self.RaceColor

end

-- Specify variable to store Race name
PLAYER.RaceName				= "Radijn"

function PLAYER:getRace()

	return self.RaceName

end


--
-- Set up the network table accessors
--
function PLAYER:SetupDataTables()

	-- as needed.

end

function PLAYER:Init()
   self.Player.ls_suit = class.new("PlayerSuit", self.Player)
end

function PLAYER:Loadout()

	self.Player:RemoveAllAmmo()


	self.Player:GiveAmmo( 256,	"Pistol", 		true )
	self.Player:GiveAmmo( 256,	"SMG1", 		true )
	self.Player:GiveAmmo( 5,	"grenade", 		true )
	self.Player:GiveAmmo( 64,	"Buckshot", 	true )
	self.Player:GiveAmmo( 32,	"357", 			true )
	self.Player:GiveAmmo( 32,	"XBowBolt", 	true )
	self.Player:GiveAmmo( 6,	"AR2AltFire", 	true )
	self.Player:GiveAmmo( 100,	"AR2", 			true )

	self.Player:Give( "weapon_crowbar" )
	self.Player:Give( "weapon_pistol" )
	self.Player:Give( "weapon_smg1" )
	self.Player:Give( "weapon_frag" )
	self.Player:Give( "weapon_physcannon" )
	self.Player:Give( "weapon_crossbow" )
	self.Player:Give( "weapon_shotgun" )
	self.Player:Give( "weapon_357" )
	self.Player:Give( "weapon_rpg" )
	self.Player:Give( "weapon_ar2" )

	self.Player:Give( "weapon_stunstick" )


	self.Player:Give( "gmod_tool" )
	self.Player:Give( "weapon_physgun" )

	self.Player:SwitchToDefaultWeapon()

end

--
-- Called when the player spawns
--
function PLAYER:Spawn()

	self.Player:SetPlayerColor( Vector( "0.24 0.34 0.41" ) )
	self.Player:SetWeaponColor( Vector( "0.30 1.80 2.10" ) )

	self.Player.ls_suit:reset()

	if GM:onSBMap() and self.Player:Team() ~= TEAM_SPECTATOR then
		local ply = self.Player
		timer.Simple(5, function()
			if ply.ls_suit.environment == nil then
				ply.ls_suit:setEnvironment(GM:getSpace())
			end
		end)
	end


end

--
-- Return true to draw local (thirdperson) camera - false to prevent - nothing to use default behaviour
--
function PLAYER:ShouldDrawLocal()

end

--
-- Allow player class to create move
--
function PLAYER:CreateMove( cmd )


end

--
-- Allow changing the player's view
--
function PLAYER:CalcView( view )


	-- Your stuff here

end

player_manager.RegisterClass( "player_radijn", PLAYER, "player_default" )


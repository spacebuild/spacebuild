
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

require("sbnet")
local net = sbnet

local GM = GM
local class = GM.class

local PLAYER = {}

--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400

-- Set a Race specific colour, this will be used as an identifier
PLAYER.RaceColor			= Color(20,120,225,200)
PLAYER.PlayerColor          = Vector( "0.24 0.34 0.41" )
PLAYER.WeaponColor          = Vector( "0.30 1.80 2.10" )

function PLAYER:getRaceColor()

    return self.RaceColor

end

-- Specify variable to store Race name
PLAYER.RaceName				= "Pendrouge"

function PLAYER:getRace()

    return self.RaceName

end

function PLAYER:getCredits()
    return self.credits or 0
end

function PLAYER:setCredits(credits)
    self.credits = credits or 0
    if SERVER then
        net.Start( "CREDITSYNC" )
        net.writeLong( self.credits )
        net.Send(self.Player)
    end
end

if CLIENT then
    net.Receive("CREDITSYNC", function(len)
        player_manager.RunClass( LocalPlayer(), "setCredits", net.readLong() )
    end)
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
    BaseClass.Spawn(self)

    self.Player:SetPlayerColor( self.PlayerColor  )
    self.Player:SetWeaponColor( PLAYER.WeaponColor   )

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

player_manager.RegisterClass( "player_sb_base", PLAYER, "player_default" )



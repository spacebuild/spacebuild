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

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "ghostentity.lua" )
AddCSLuaFile( "object.lua" )
AddCSLuaFile( "stool.lua" )
AddCSLuaFile( "cl_viewscreen.lua" )
AddCSLuaFile( "stool_cl.lua" )

include('shared.lua')

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

--[[---------------------------------------------------------
   Desc: Convenience function to check object limits
-----------------------------------------------------------]]
function SWEP:CheckLimit( str ) 

	local ply = self.Weapon:GetOwner()
	return ply:CheckLimit( str )

end

--[[---------------------------------------------------------
   Name: ShouldDropOnDie
   Desc: Should this weapon be dropped when its owner dies?
-----------------------------------------------------------]]
function SWEP:ShouldDropOnDie()
	return false
end

--[[---------------------------------------------------------
   Name: CC_GMOD_Tool
   Desc: Console Command to switch weapon/toolmode
-----------------------------------------------------------]]
function CC_GMOD_Tool( player, command, arguments )

	if ( arguments[1] == nil ) then return end
	if ( GetConVarNumber( "toolmode_allow_"..arguments[1] ) ~= 1 ) then return end
	
	player:ConCommand( "gmod_toolmode "..arguments[1] )
	
	local activeWep = player:GetActiveWeapon()
	local isTool = (activeWep and activeWep:IsValid() and activeWep:GetClass() == "gmod_tool")
	
	-- Switch weapons
	player:SelectWeapon( "gmod_tool")

	-- Get the weapon and send a fake deploy command
	local wep = player:GetWeapon("gmod_tool")
	
	if (wep:IsValid()) then
	
		-- Hmmmmm???
		if ( not isTool ) then
			wep.wheelModel = nil
		end
		
		-- Holster the old 'tool'
		if ( wep.Holster ) then
			wep:Holster()
		end
		
		wep.Mode = arguments[1]
		
		-- Deplot the new
		if ( wep.Deploy ) then
			wep:Deploy()
		end
		
	end
	
end

concommand.Add( "gmod_tool", CC_GMOD_Tool, nil, nil, { FCVAR_SERVER_CAN_EXECUTE } )

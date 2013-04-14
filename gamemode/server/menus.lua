
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

local GM = GM

--[[---------------------------------------------------------
	Show the default team selection screen    [Shared]
-----------------------------------------------------------]]
function GM:ShowTeam( ply )

	local TimeBetweenSwitches = GAMEMODE.SecondsBetweenTeamSwitches or 10
	if ( ply.LastTeamSwitch and RealTime()-ply.LastTeamSwitch < TimeBetweenSwitches ) then
	ply.LastTeamSwitch = ply.LastTeamSwitch + 1;
	ply:ChatPrint( Format( "Please wait %i more seconds before trying to change team again", (TimeBetweenSwitches - (RealTime()-ply.LastTeamSwitch)) + 1 ) )
		return false
	end

	-- For clientside see cl_pickteam.lua
	ply:SendLua( "GAMEMODE:ShowTeam()" )
end

--[[---------------------------------------------------------
	Hides the default team selection screen    [Shared]
-----------------------------------------------------------]]
function GM:HideTeam(ply)

end

function GM:ShowHelp()
	MsgN("F1 pressed")
end

--[[function GM:ShowTeam()
	MsgN("F2 pressed")
end ]]

function GM:ShowSpare1()
	MsgN("F3 pressed")
end

function GM:ShowSpare2()
	MsgN("F4 pressed")
end


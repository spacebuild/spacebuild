
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

local teamFrame, helpFrame


local function closeFrames()
    GM:HideTeam()
    GM:HideHelp()
end

--[[---------------------------------------------------------
   Name: gamemode:ShowTeam( )
   Desc:
-----------------------------------------------------------]]
function GM:ShowTeam()

	if ( IsValid(teamFrame) ) then return end
    closeFrames()

	teamFrame = vgui.Create('DRacePickMenu')

   	teamFrame:Show()

end

--[[---------------------------------------------------------
   Name: gamemode:HideTeam( )
   Desc:
-----------------------------------------------------------]]
function GM:HideTeam()

	if ( IsValid(teamFrame) ) then
		teamFrame:close()
		teamFrame = nil
	end

end

function GM:ShowHelp()
    if ( IsValid(helpFrame) ) then return end
    closeFrames()

    helpFrame = vgui.Create('DItemMenu')

    helpFrame:Show()
end

function GM:HideHelp()
    if ( IsValid(helpFrame) ) then
        helpFrame:close()
        helpFrame = nil
    end
end
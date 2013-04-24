
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


local PANEL = {}

function PANEL:Init()
	self:setTitle("Race Picker")
	self:setSlogan("Pick your race here")
	self:setByLine("some byline here")

    local x, y = 25, 100;
    local panel = self

    local races =  GAMEMODE:getRaces()
    local DermaButton
    for k, v in pairs(races) do
        DermaButton = vgui.Create( "DButton", self )
        DermaButton:SetText( v.RaceName )
        DermaButton:SetPos( x, y )
        x = x + 100
        DermaButton:SetSize( 96, 48 )
        DermaButton.DoClick = function()
            net.Start( "RACECHANGE" )
            net.WriteString( k )
            net.SendToServer()
            RunConsoleCommand( "say", "Changing to "..tostring(v.RaceName) )
            panel:close()
        end
    end

    -- Reset
    x = 25
    y = y + 50


end

vgui.Register('DRacePickMenu', PANEL, 'DSBMenu')


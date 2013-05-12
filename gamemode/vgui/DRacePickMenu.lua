
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
	self:setByLine("")

    local x, y = 25, 100;
    local panel = self

    local races =  GAMEMODE:getRaces()
    local DermaButton, modelPanel, selectedRace, raceSelectButton, descriptionText
    for k, v in pairs(races) do
        DermaButton = vgui.Create( "DButton", self )
        DermaButton:SetText( v.RaceName )
        DermaButton:SetPos( x, y )
        x = x + 200
        DermaButton:SetSize( 192, 48 )
        DermaButton.DoClick = function()
            selectedRace = k
            raceSelectButton:SetDisabled(false)
            descriptionText:SetText( v.RaceName )
            raceSelectButton:SetText( "Select "..tostring(v.RaceName) )
            function modelPanel.Entity:GetPlayerColor() return v.PlayerColor end --we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.
        end
    end

    -- Reset
    x = 25
    y = y + 60

    modelPanel = vgui.Create("DModelPanel", self)
    modelPanel:SetSize(192, 192)
    modelPanel:SetModel( "models/player/alyx.mdl" ) -- you can only change colors on playermodels
    --function modelPanel:LayoutEntity( Entity ) return end -- disables default rotation
    --function modelPanel.Entity:GetPlayerColor() return v.PlayerColor end --we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.

    modelPanel:SetPos( x, y )

    x = x + 200

    descriptionText = vgui.Create( "DLabel", self )
    descriptionText:SetPos( x, y )
    descriptionText:SetText( "" )

    -- Text and stuff here

    x, y = 25, y + 200

    raceSelectButton = vgui.Create( "DButton", self )
    raceSelectButton:SetText( "No Race Selected" )
    raceSelectButton:SetPos( x, y )
    raceSelectButton:SetSize( 192, 48 )
    raceSelectButton:SetDisabled(true)
    raceSelectButton.DoClick = function()
        if(selectedRace) then
            net.Start( "RACECHANGE" )
                net.WriteString( selectedRace )
                net.SendToServer()
            panel:close()
        end
    end
end

vgui.Register('DRacePickMenu', PANEL, 'DSBMenu')


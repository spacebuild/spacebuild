
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

local RACE = {}

function RACE:init()

	self.AvatarButton = self:Add( "DButton" )
	self.AvatarButton:Dock( LEFT )
	self.AvatarButton:SetSize( 32, 32 )
	self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

	self.Avatar		= vgui.Create( "AvatarImage", self.AvatarButton )
	self.Avatar:SetSize( 32, 32 )
	self.Avatar:SetMouseInputEnabled( false )

end

local PANEL = {}

function PANEL:Init()
	self:setTitle("Race Picker")
	self:setSlogan("Pick your race here")
	self:setByLine("some byline here")
end

vgui.Register('DRacePickMenu', PANEL, 'DSBMenu')


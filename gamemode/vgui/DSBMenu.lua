
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
	self:SetSize( math.Clamp( 1024, 0, ScrW() ), math.Clamp( 768, 0, ScrH() ) )
	self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))

	local closeButton = vgui.Create('DButton', self)
	closeButton:SetFont('marlett')
	closeButton:SetText('r')
	closeButton:SetColor(Color(255, 255, 255))
	closeButton:SetSize(15, 15)
	closeButton:SetDrawBackground(false)
	closeButton:SetPos(self:GetWide() - 25, 10)
	local panel = self
	closeButton.DoClick = function()
		panel:close()
	end

	self.title = "Title"
	self.slogan = "Slogan"
	self.byline = "Byline"
end

function PANEL:close()
	gui.EnableScreenClicker(false)
	self:onClose()
	self:Remove()
end

function PANEL:onClose()
	-- fill this in with custom stuff
end

function PANEL:onShow()
   -- fill this in with custom stuff
end

function PANEL:setTitle(title)
	self.title = title
end

function PANEL:getTitle()
	return self.title or ""
end

function PANEL:setSlogan(slogan)
	self.slogan = slogan
end

function PANEL:getSlogan()
	return self.slogan or ""
end

function PANEL:setByLine(byline)
   self.byline = byline
end

function PANEL:getByLine()
	return self.byline
end

function PANEL:Show()
	gui.EnableScreenClicker(true)
	self:onShow()
end

function PANEL:Paint()
	Derma_DrawBackgroundBlur(self)

	draw.RoundedBox(10, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 150))

	draw.SimpleText(self:getTitle(), 'SB_Menu_Heading', 20, 10, color_white)
	draw.SimpleText(self:getSlogan(), 'SB_Menu_Heading2', 275, 50, color_white)
	draw.SimpleText(self:getByLine(), 'SB_Menu_Heading3', self:GetWide() - 10, 60, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
end

vgui.Register('DSBMenu', PANEL)


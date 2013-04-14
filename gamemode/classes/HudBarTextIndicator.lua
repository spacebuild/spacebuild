--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 19/01/13
-- Time: 21:35
-- To change this template use File | Settings | File Templates.
--

include("HudBarIndicator.lua")
local C = CLASS
local surface = surface

local oldInit = C.init
function C:init(x, y, width, height, value, maxvalue, color, bgcolor, format_text)
	oldInit(self, x, y, width, height, value, maxvalue, color, bgcolor)
	self.format_text = format_text
end

function C:render()
	if self:isVisible() then
		surface.SetDrawColor(self:getColor()) -- Outline of Background of the bar
		surface.DrawOutlinedRect(self:getX(), self:getY(), self:getWidth(), self:getHeight() / 2)

		surface.SetDrawColor(self:getBackgroundColor()) -- Background of Bar
		surface.DrawRect(self:getX(), self:getY(), self:getWidth(), self:getHeight() / 2)

		surface.SetDrawColor(self:getColor()) --Value of Bar
		if self:getValue() / self:getMaxValue() <= 1 then
			surface.DrawRect(self:getX(), self:getY(), self:getWidth() * (self:getValue() / self:getMaxValue()), self:getHeight() / 2)
		else
			surface.DrawRect(self:getX(), self:getY(), self:getWidth(), self:getHeight() / 2)
		end


		if self.format_text then
			self:DrawText(self:getX(), self:getY() + (self:getHeight() - self:getHeight() / 8), self:getWidth(), string.format(self.format_text, math.Round(self:getValue()), "%"), self:getColor())
		end
	end
end

function C:DrawText(x, y, width, text, text_color, font_type)
	if not font_type then surface.SetFont("HudHintTextSmall")
	else surface.SetFont(font_type)
	end

	local Width, _ = surface.GetTextSize(text or " ")
	local Height, _ = surface.GetTextSize("W")
	x = x + width * 0.5 - (Width or 8) * 0.5
	y = y - (Height or 8)

	surface.SetTextColor(text_color)
	surface.SetTextPos(x, y)
	surface.DrawText(text)
end
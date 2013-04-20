--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 27/01/13
-- Time: 17:32
-- To change this template use File | Settings | File Templates.
--

include("HudComponent.lua")
local C = CLASS
local surface = surface
local draw = draw

local oldIsA = C.isA
function C:isA(className)
	return oldIsA(self) or className == "TextElement"
end

local oldInit = C.init
function C:init(x, y, width, height, color, text, font_type, xalign)
	oldInit(self, x, y, width, height)
	self:setColor(color)
	self:setText(text)
	self:setFont(font_type)
	self:setAlign(xalign or TEXT_ALIGN_LEFT)
end

function C:getColor()
	return self.color
end

function C:setColor(color)
	self.color = color
end

function C:getAlpha()
	return self.color.a
end

function C:setAlpha(alpha)
	local Col = self:getColor()
	Col.a = alpha or self:getAlpha()
	self:setColor(Col)
end


function C:getFont()
	return self.font_type
end

function C:setFont(font)
	self.font_type = font
end

function C:getText()
	return self.text
end

function C:setText(text)
	self.text = text
end

function C:getAlign()
	return self.xalign
end

function C:setAlign(align)
	self.xalign = align
end


function C:render()

	if not self:getFont() then self:setFont("HudHintTextSmall") end

	local x = self:getX()
	local y = self:getY()

	local Width, _ = surface.GetTextSize(self:getText() or " ")
	local Height, _ = surface.GetTextSize("W")
	x = x + self:getWidth() * 0.5 - (Width or 8) * 0.5
	y = y + (Height or 8)

	surface.SetTextColor(self:getColor())
	surface.SetTextPos(x, y)
	--surface.DrawText(self:getText())
	draw.DrawText(self:getText(), self:getFont(), x, y, self:getColor(), self:getAlign() )
end
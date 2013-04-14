--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 12/01/13
-- Time: 10:45
-- To change this template use File | Settings | File Templates.
--
include("HudComponent.lua")
local C = CLASS
local surface = surface

local oldIsA = C.isA
function C:isA(className)
	return oldIsA(self) or className == "HudBarIndicator"
end

local oldInit = C.init
function C:init(x, y, width, height, value, maxvalue, color, bgcolor)
	oldInit(self, x, y, width, height)
	self.value = value
	self.maxvalue = maxvalue
	self.color = color
	self.backgroundColor = bgcolor
end

function C:getBackgroundAlpha()
	return self:getBackgroundColor().a
end

function C:setBackgroundAlpha(alpha)
	local Col = self:getBackgroundColor()
	Col.a = alpha or self:getBackgroundAlpha()
	self:setBackgroundColor(Col)
end

function C:getAlpha()
	return self:getColor().a
end

function C:setAlpha(alpha)
	local Col = self:getColor()
	Col.a = alpha or self:getAlpha()
	self:setColor(Col)
end



function C:getValue()
	return self.value
end

function C:setValue(value)
	self.value = value
end

function C:getMaxValue()
	return self.maxvalue
end

function C:setMaxValue(maxvalue)
	self.maxvalue = maxvalue
end

function C:getColor()
	return self.color
end

function C:setColor(color)
	self.color = color
end

function C:getBackgroundColor()
	return self.backgroundColor
end

function C:setBackgroundColor(backgroundColor)
	self.backgroundColor = backgroundColor
end

function C:render()
	if self:isVisible() then
		surface.SetDrawColor(self:getColor()) -- Outline of Background of the bar
		surface.DrawOutlinedRect(self:getX(), self:getY(), self:getWidth(), self:getHeight())

		surface.SetDrawColor(self:getBackgroundColor()) -- Background of Bar
		surface.DrawRect(self:getX(), self:getY(), self:getWidth(), self:getHeight())

		surface.SetDrawColor(self:getColor()) --Value of Bar
		if self:getValue() / self:getMaxValue() <= 1 then
			surface.DrawRect(self:getX(), self:getY(), self.width * (self:getValue() / self:getMaxValue()), self:getHeight())
		else
			surface.DrawRect(self:getX(), self:getY(), self.width, self:getHeight())
		end
	end
end
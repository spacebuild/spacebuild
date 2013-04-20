--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 12/01/13
-- Time: 23:51
-- To change this template use File | Settings | File Templates.
--

include("HudComponent.lua")
local C = CLASS
local surface = surface

local oldIsA = C.isA
function C:isA(className)
	return oldIsA(self) or className == "HudPanel"
end

local oldInit = C.init
function C:init(x, y, width, height, backgroundColor, autosize)
	oldInit(self, x, y, width, height)
	self.base_width = width
	self.base_height = height
	self.base_x = x
	self.base_y = y
	self.children = {}
	self.backgroundColor = backgroundColor
	self.autosize = autosize
end

function C:getAutoSize()
	return self.autosize
end

function C:getBackgroundAlpha()
	return self:getBackgroundColor().a
end

function C:setBackgroundAlpha(alpha)
	local Col = self:getBackgroundColor()
	Col.a = alpha or self:getBackgroundAlpha()
	self:setBackgroundColor(Col)
end

function C:getAlpha() --getAlpha or getBackgroundAlpha should work for panels
	return self:getBackgroundAlpha()
end

function C:setAlpha(alpha)
	self:setBackgroundAlpha(alpha)
end


function C:calculateSize()
	if self.autosize then
		self:setWidth(self.base_width)
		self:setHeight(self.base_height)
		for k, v in pairs(self.children) do
			if v:getWidth() > self:getWidth() then
				self:setWidth(v:getWidth())
			end
			self:setHeight(self:getHeight() + v:getHeight())
		end
		self:setX(self.base_x - math.ceil(self:getWidth() / 2))
		self:setY(self.base_y - math.ceil(self:getHeight() / 2))
	end
end

function C:setAutoSize(autosize)
	self.autosize = autosize
	self:calculateSize()
end

function C:getBackgroundColor()
	return self.backgroundColor
end

function C:setBackgroundColor(backgroundColor)
	self.backgroundColor = backgroundColor
end

local oldRender = C.render
function C:render()
	if self:isVisible() then
		oldRender(self)
		if self.backgroundColor then
			draw.RoundedBox(8, self:getX(), self:getY(), self:getWidth(), self:getHeight(), self:getBackgroundColor())
		end
		for k, v in pairs(self.children) do
			v:render()
		end
	end
end

function C:addChild(component)
	table.insert(self.children, component)
	if component:getParent() ~= self then
		if component:getParent() then
			component:getParent():removeChild(component)
		end
		component:setParent(self)
		self:calculateSize()
	end
	return self
end

function C:getChildren()
	return self.children
end

function C:removeChild(component)
	for k, v in pairs(self.children) do
		if v == component then
			table.remove(k)
			self:calculateSize()
			return true
		end
	end
	return false
end
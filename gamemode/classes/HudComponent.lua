--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 12/01/13
-- Time: 11:09
-- To change this template use File | Settings | File Templates.
--

local C = CLASS
local surface = surface

function C:isA(className)
	return className == "HudComponent"
end

function C:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width or 0
	self.height = height or 0
	self.parent = nil
	self.visible = true
end

function C:setVisible(visible)
	self.visible = visible
end

function C:isVisible()
	return self.visible
end

function C:getParent()
	return self.parent
end

function C:setParent(parent)
	self.parent = parent
end

function C:getX()
	if self.parent then
		return self.parent:getX() + self.x
	end
	return self.x
end

function C:setX(x)
	self.x = x
end

function C:getY()
	if self.parent then
		return self.parent:getY() + self.y
	end
	return self.y
end

function C:setY(y)
	self.y = y
end

function C:getHeight()
	return self.height
end

function C:setHeight(height)
	self.height = height
end

function C:getWidth()
	return self.width
end

function C:setWidth(width)
	self.width = width
end

function C:render()
end

function C:getPlayer()
	return LocalPlayer()
end

function C:copyColor(color)
	return Color(color.r, color.g, color.b, color.a)
end


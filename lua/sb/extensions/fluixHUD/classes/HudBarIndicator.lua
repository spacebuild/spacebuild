--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 12/01/13
-- Time: 10:45
-- To change this template use File | Settings | File Templates.
--
include(fluix.basePath.."classes/HudComponent.lua")
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

local oldRender, color = C.render
function C:render()
    oldRender(self)
    --if not self:getPlayer():Alive() then return end
    --self:smoothValue(self:getValue())
    --maxvalue = self:getMaxValue()
    --value_color = self:getColor(self.value, maxvalue)
    --bg_color = Color( 50,50,50,220)
     color = self:getColor()

    surface.SetDrawColor( color )           -- Outline of Background of the bar
    surface.DrawOutlinedRect( self:getX(), self:getY(), self:getWidth(), self:getHeigth() )

    surface.SetDrawColor( self:getBackgroundColor() )        -- Background of Bar
    surface.DrawRect( self:getX(), self:getY() , self:getWidth() , self:getHeigth() )

    surface.SetDrawColor( color )          --Value of Bar
    surface.DrawRect( self:getX() , self:getY() , self.width * ( self:getValue() / self:getMaxValue() ), self:getHeigth())
    --[[if self.format_string then
        self:DrawText( self:getX(), self:getY() + (self.height - self.height/8), self.width, string.format( self.format_string, math.Round( self.value ), "%" ), value_color )
    end]]
end
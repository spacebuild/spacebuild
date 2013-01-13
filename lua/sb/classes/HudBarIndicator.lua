--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 12/01/13
-- Time: 10:45
-- To change this template use File | Settings | File Templates.
--
include("sb/classes/HudComponent.lua")
local C = CLASS
local surface = surface

local oldIsA = C.isA
function C:isA(className)
    return oldIsA(self) or className == "HudBarIndicator"
end

local oldInit = C.init
function C:init(x, y, width, height, format_string, valueLambda, colorLambda, maxValueLambda)
    oldInit(self, x, y)
    self.width = width
    self.height = height
    self.getValue = valueLambda
    self.getColor = colorLambda
    self.format_string = format_string
    self.getMaxValue = maxValueLambda or function() return 100 end
end

local oldRender, value_color, bg_color, maxvalue = C.render
function C:render()
    oldRender(self)
    if not self:getPlayer():Alive() then return end
    self:smoothValue(self:getValue())
    maxvalue = self:getMaxValue()
    value_color = self:getColor(self.value, maxvalue)
    bg_color = Color( 50,50,50,220)


    surface.SetDrawColor( value_color )           -- Outline of Background of the bar
    surface.DrawOutlinedRect( self:getX() + self.width * 0.05, self:getY() + self.height * 0.2, self.width * 0.9, self.height * 0.4 )

    surface.SetDrawColor( bg_color )        -- Background of Bar
    surface.DrawRect( self:getX() + self.width * 0.05, self:getY()  + self.height * 0.2, self.width * 0.9, self.height * 0.4 )

    surface.SetDrawColor( value_color )          --Value of Bar
    surface.DrawRect( self:getX() + self.width * 0.05, self:getY()  + self.height * 0.2, self.width * ( self.value / maxvalue ) * 0.9, self.height * 0.4 )
    if self.format_string then
        self:DrawText( self:getX(), self:getY() + (self.height - self.height/8), self.width, string.format( self.format_string, math.Round( self.value ), "%" ), value_color )
    end
end
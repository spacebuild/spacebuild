--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 12/01/13
-- Time: 23:51
-- To change this template use File | Settings | File Templates.
--

include("sb/classes/HudComponent.lua")
local C = CLASS
local surface = surface

local oldIsA = C.isA
function C:isA(className)
    return oldIsA(self) or className == "HudPanel"
end

local oldInit = C.init
function C:init(x, y, drawPanel, width, height, backgroundColor)
    oldInit(self, x, y)
    self.children = {}
    self.drawPanel = drawPanel
    self.width = width
    self.height = height
    self.backgroundColor = backgroundColor
end

local oldRender = C.render
function C:render()
    oldRender(self)
    if self.drawPanel then
        draw.RoundedBox( 8, self:getX() , self:getY(), self.width, self.height, self.backgroundColor)
    end
    for k, v in pairs(self.children) do
       v:render()
    end
end

function C:addChild(component)
    table.insert(self.children, component)
    if component:getParent() ~= self then
        if component:getParent() then
            component:getParent():removeChild(component)
        end
        component:setParent(self)
    end
end

function C:removeChild(component)
   for k, v in pairs(self.children) do
      if v == component then
          return table.remove(k) == component
      end
   end
   return false
end
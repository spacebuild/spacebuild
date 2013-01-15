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
function C:init(x, y, width, height, backgroundColor, autosize)
    oldInit(self, x, y, width, height)
    self.children = {}
    self.backgroundColor = backgroundColor
    self.autosize = true
end

function C:getAutoSize()
   return self.autosize
end

function C:setAutoSize(autosize)
   self.autosize = autosize
   if self.autosize then
       self:setY(self:getY() - self:getHeight())
       self:setWidth(0)
       self:setHeight(0)
       for k, v in pairs(self.children) do
           if v:getWidth() > self:getWidth() then
               self:setWidth(v:getWidth())
           end
       end
       self:setY(self:getY() + self:getHeight())
   end
end

function C:getBackgroundColor()
   return self.backgroundColor
end

function C:setBackgroundColor(backgroundColor)
   self.backgroundColor = backgroundColor
end

local oldRender = C.render
function C:render()
    oldRender(self)
    if self.backgroundColor then
        draw.RoundedBox( 8, self:getX() , self:getY(), self:getWidth(), self:getHeight(), self:getBackgroundColor())
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
        if self.autosize then
           self:setHeigth(self:getHeight() + component:getHeight())
           self:setY(self:getY() + component:getHeight())
        end
        component:setParent(self)
    end
end

function C:removeChild(component)
   for k, v in pairs(self.children) do
      if v == component then
          if self.autosize then
              self:setHeigth(self:getHeight() - component:getHeight())
              self:setY(self:getY() - component:getHeight())
          end
          return table.remove(k) == component
      end
   end
   return false
end
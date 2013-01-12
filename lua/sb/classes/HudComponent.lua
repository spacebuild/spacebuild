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

function C:init(x, y)
    self.x = x
    self.y = y
    self.FrameDelay = 0
    self.value = 0
    self.smooth = 0.15
end

function C:render()
    self.FrameDelay = math.Clamp( FrameTime(), 0.0001, 10 )
end

function C:smoothValue(newValue)
   self.value = self.value + ( newValue - self.value ) * self.FrameDelay / self.smooth
end

function C:getPlayer()
   if not self.ply then
     self.ply = LocalPlayer()
   end
   return self.ply
end

function C:copyColor(color)
    return Color(color.r, color.g, color.b, color.a)
end

function C:DrawText( x, y, width, text, text_color, font_type )
    if not font_type then surface.SetFont( "HudHintTextSmall" )
    else surface.SetFont( font_type ) end

    local Width, _ = surface.GetTextSize( text or " " )
    local Height, _ = surface.GetTextSize( "W" )
    x = x + width * 0.5 - ( Width or 8 ) * 0.5
    y = y - ( Height or 8 )

    surface.SetTextColor( text_color )
    surface.SetTextPos( x, y )
    surface.DrawText( text )

end
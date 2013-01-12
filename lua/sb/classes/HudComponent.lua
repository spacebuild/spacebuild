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
end

function C:render()

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
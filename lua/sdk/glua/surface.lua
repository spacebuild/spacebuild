---
-- @description Library surface
 module("surface")

--- surface.CreateFont
-- @usage client_m
-- Creates a new font.
--
-- @param  fontName string  The new font name.
-- @param  fontData table  The font properties. See the FontData structure.
function CreateFont( fontName,  fontData) end

--- surface.DisableClipping
-- @usage client_m
-- Enables or disables the clipping used by the VGUI that limits the drawing operations to a panels bounds.
--
-- @param  disable boolean  True to disable, false to enable the clipping
function DisableClipping( disable) end

--- surface.DrawCircle
-- @usage client_m
-- Draws a hollow circle, made of dots. For a filled circle, see examples for surface.DrawPoly.
--
-- @param  originX number  The center x coordinate.
-- @param  originY number  The center y coordinate.
-- @param  radius number  The radius of the circle.
-- @param  r number  The red value of the color to draw the circle with, or a Color structure.
-- @param  g number  The green value of the color to draw the circle with. Unused if a Color structure was given.
-- @param  b number  The blue value of the color to draw the circle with. Unused if a Color structure was given.
-- @param  a=255 number  The alpha value of the color to draw the circle with. Unused if a Color structure was given.
function DrawCircle( originX,  originY,  radius,  r,  g,  b,  a) end

--- surface.DrawLine
-- @usage client_m
-- Draws a line from one point to another.
--
-- @param  startX number  The start x coordinate.
-- @param  startY number  The start y coordinate.
-- @param  endX number  The end x coordinate.
-- @param  endY number  The end y coordinate.
function DrawLine( startX,  startY,  endX,  endY) end

--- surface.DrawOutlinedRect
-- @usage client_m
-- Draws a hollow box with a border width of 1 px.
--
-- @param  x number  The start x coordinate.
-- @param  y number  The start y coordinate.
-- @param  w number  The width.
-- @param  h number  The height.
function DrawOutlinedRect( x,  y,  w,  h) end

--- surface.DrawPoly
-- @usage client_m
-- Draws a polygon with a maximum of 256 vertices.
--Only works properly with convex polygons. You may try to render concave polygons, but there is no guarantee that things wont get messed up.
--
-- @param  vertices table  A table containing vertices. See the PolygonVertex structure
function DrawPoly( vertices) end

--- surface.DrawRect
-- @usage client_m
-- Draws a solid rectangle on the screen.
--
-- @param  x number  The X co-ordinate.
-- @param  y number  The Y co-ordinate.
-- @param  width number  The width of the rectangle.
-- @param  height number  The height of the rectangle.
function DrawRect( x,  y,  width,  height) end

--- surface.DrawText
-- @usage client_m
-- Draw the specified text on the screen, using the previously set position, font and color.
--
-- @param  text string  The text to be rendered.
function DrawText( text) end

--- surface.DrawTexturedRect
-- @usage client_m
-- Draw a textured rectangle with the given position and dimensions on the screen, using the current active texture.
--
-- @param  x number  The X co-ordinate.
-- @param  y number  The Y co-ordinate.
-- @param  width number  The width of the rectangle.
-- @param  height number  The height of the rectangle.
function DrawTexturedRect( x,  y,  width,  height) end

--- surface.DrawTexturedRectRotated
-- @usage client_m
-- Draw a textured rotated rectangle with the given position and dimensions and angle on the screen, using the current active texture.
--
-- @param  x number  The X co-ordinate, representing the center of the rectangle.
-- @param  y number  The Y co-ordinate, representing the center of the rectangle.
-- @param  width number  The width of the rectangle.
-- @param  height number  The height of the rectangle.
-- @param  rotation number  The rotation of the rectangle, in degrees.
function DrawTexturedRectRotated( x,  y,  width,  height,  rotation) end

--- surface.DrawTexturedRectUV
-- @usage client_m
-- Draws a textured rectangle with a repeated or partial texture.
--
-- @param  x number  The X coordinate.
-- @param  y number  The Y coordinate.
-- @param  width number  The width of the rectangle.
-- @param  height number  The height of the rectangle.
-- @param  startU number  The U texture mapping of the rectangle origin.
-- @param  startV number  The V texture mapping of the rectangle origin.
-- @param  endU number  The U texture mapping of the rectangle end.
-- @param  endV number  The V texture mapping of the rectangle end.
function DrawTexturedRectUV( x,  y,  width,  height,  startU,  startV,  endU,  endV) end

--- surface.GetHUDTexture
-- @usage client
-- Gets the HUD texture with the specified name.
--
-- @param  name string  The name of the texture.
-- @return ITexture text
function GetHUDTexture( name) end

--- surface.GetTextSize
-- @usage client_m
-- Returns the width and height (in pixels) of the given text, but only if the font has been set with surface.SetFont.
--
-- @param  text string  The string to check the size of.
-- @return number Width of the provided text
-- @return number Height of the provided text
function GetTextSize( text) end

--- surface.GetTextureID
-- @usage client_m
-- Returns the texture id of the material with the given name/path.
--
-- @param  name/path string  Name or path of the texture.
-- @return number The texture ID
function GetTextureID( name/path) end

--- surface.GetTextureSize
-- @usage client_m
-- Returns the size of the texture with the associated texture ID.
--
-- @param  textureID number  The texture ID.
-- @return number The texture width.
-- @return number The texture height.
function GetTextureSize( textureID) end

--- surface.PlaySound
-- @usage client_m
-- Play a sound file directly on the client (such as UI sounds, etc).
--
-- @param  soundfile string  The path to the sound file.
function PlaySound( soundfile) end

--- surface.ScreenHeight
-- @usage client_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use ScrH instead.
-- @return number screenHeight
function ScreenHeight() end

--- surface.ScreenWidth
-- @usage client_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use ScrW instead.
-- @return number screenWidth
function ScreenWidth() end

--- surface.SetAlphaMultiplier
-- @usage client_m
-- Sets a multiplier that will influence all upcoming drawing operations.
--
-- @param  multiplier number  The multiplier ranging from 0 to 1.
function SetAlphaMultiplier( multiplier) end

--- surface.SetDrawColor
-- @usage client_m
-- Set the color of any future shapes to be drawn, can be set by either using r, g, b, a as separate values or by a Color structure. Using a color structure is not recommended to be created procedurally.
--
-- @param  r number  The red value of color, or a Color structure.
-- @param  g number  The green value of color. Unused if a Color structure was given.
-- @param  b number  The blue value of color. Unused if a Color structure was given.
-- @param  a=255 number  The alpha value of color. Unused if a Color structure was given.
function SetDrawColor( r,  g,  b,  a) end

--- surface.SetFont
-- @usage client_m
-- Set the current font to be used for text operations later.
--
-- @param  fontName string  The name of the font to use.
function SetFont( fontName) end

--- surface.SetMaterial
-- @usage client_m
-- Sets the material to be used in all upcoming surface draw operations.
--
-- @param  material IMaterial  The material to be used.
function SetMaterial( material) end

--- surface.SetTextColor
-- @usage client_m
-- Set the color of any future text to be drawn, can be set by either using r, g, b, a as separate values or by a Color structure. Using a color structure is not recommended to be created procedurally.
--
-- @param  r number  The red value of color, or a Color structure.
-- @param  g number  The green value of color
-- @param  b number  The blue value of color
-- @param  a=255 number  The alpha value of color
function SetTextColor( r,  g,  b,  a) end

--- surface.SetTextPos
-- @usage client_m
-- Set the position to draw any future text.
--
-- @param  x number  The X co-ordinate.
-- @param  y number  The Y co-ordinate.
function SetTextPos( x,  y) end

--- surface.SetTexture
-- @usage client_m
-- Sets the texture to be used in all upcoming surface draw operations.
--
-- @param  textureID number  The id of the texture to draw with.
function SetTexture( textureID) end

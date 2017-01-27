---
-- @description Library draw
 module("draw")

--- draw.DrawText
-- @usage client_m
-- Simple draw text at position, but this will expand newlines and tabs.
--
-- @param  text string  Text to be drawn.
-- @param  font="DermaDefault" string  Name of font to draw the text in. See surface.CreateFont to create your own, or Default Fonts for a list of default fonts.
-- @param  x=0 number  The X Coordinate.
-- @param  y=0 number  The Y Coordinate.
-- @param  color=Color( 255, 255, 255, 255 ) table  Color to draw the text in. Uses the Color structure.
-- @param  xAlign=TEXT_ALIGN_LEFT number  Where to align the text horizontally. Uses the TEXT_ALIGN_ Enums.
function DrawText( text,  font,  x,  y,  color,  xAlign) end

--- draw.GetFontHeight
-- @usage client_m
-- Returns the height of the specified font in pixels.
--
-- @param  font string  Name of the font to get the height of.
-- @return number fontHeight
function GetFontHeight( font) end

--- draw.NoTexture
-- @usage client_m
-- Sets drawing texture to a default white texture (vgui/white). Useful for resetting the drawing texture.
--
function NoTexture() end

--- draw.RoundedBox
-- @usage client_m
-- Draws a rounded rectangle.
--
-- @param  cornerRadius number  Radius of the rounded corners, works best with a multiple of 2.
-- @param  x number  The x coordinate of the top left of the rectangle.
-- @param  y number  The y coordinate of the top left of the rectangle.
-- @param  width number  The width of the rectangle.
-- @param  height number  The height of the rectangle.
-- @param  color table  The color to fill the rectangle with. Uses the Color structure.
function RoundedBox( cornerRadius,  x,  y,  width,  height,  color) end

--- draw.RoundedBoxEx
-- @usage client_m
-- Draws a rounded rectangle. This function also lets you specify which corners are drawn rounded.
--
-- @param  cornerRadius number  Radius of the rounded corners, works best with a power of 2 number.
-- @param  x number  The x coordinate of the top left of the rectangle.
-- @param  y number  The y coordinate of the top left of the rectangle.
-- @param  width number  The width of the rectangle.
-- @param  height number  The height of the rectangle.
-- @param  color table  The color to fill the rectangle with. Uses the Color structure.
-- @param  roundTopLeft=false boolean  Whether the top left corner should be rounded.
-- @param  roundTopRight=false boolean  Whether the top right corner should be rounded.
-- @param  roundBottomLeft=false boolean  Whether the bottom left corner should be rounded.
-- @param  roundBottomRight=false boolean  Whether the bottom right corner should be rounded.
function RoundedBoxEx( cornerRadius,  x,  y,  width,  height,  color,  roundTopLeft,  roundTopRight,  roundBottomLeft,  roundBottomRight) end

--- draw.SimpleText
-- @usage client_m
-- Draws text on the screen.
--
-- @param  text string  The text to be drawn.
-- @param  font="DermaDefault" string  The font. See surface.CreateFont to create your own, or see Default Fonts for a list of default fonts.
-- @param  x=0 number  The X Coordinate.
-- @param  y=0 number  The Y Coordinate.
-- @param  color=Color( 255, 255, 255, 255 ) table  The color of the text. Uses the Color structure.
-- @param  xAlign=TEXT_ALIGN_LEFT number  The alignment of the X coordinate using TEXT_ALIGN_ Enums.
-- @param  yAlign=TEXT_ALIGN_TOP number  The alignment of the Y coordinate using TEXT_ALIGN_ Enums.
-- @return number The width of the text. Same value as if you were calling surface.GetTextSize.
-- @return number The height of the text. Same value as if you were calling surface.GetTextSize.
function SimpleText( text,  font,  x,  y,  color,  xAlign,  yAlign) end

--- draw.SimpleTextOutlined
-- @usage client_m
-- Creates a simple line of text that is outlined.
--
-- @param  Text string  The text to draw.
-- @param  font="DermaDefault" string  The font name to draw with. See surface.CreateFont to create your own, or here for a list of default fonts.
-- @param  x=0 number  The X Coordinate.
-- @param  y=0 number  The Y Coordinate.
-- @param  color=Color( 255, 255, 255, 255 ) table  The color of the text. Uses the Color structure.
-- @param  xAlign=TEXT_ALIGN_LEFT number  The alignment of the X Coordinate using TEXT_ALIGN_ Enums.
-- @param  yAlign=TEXT_ALIGN_TOP number  The alignment of the Y Coordinate using TEXT_ALIGN_ Enums.
-- @param  outlinewidth number  Width of the outline.
-- @param  outlinecolor=Color( 255, 255, 255, 255 ) table  Color of the outline. Uses the Color structure.
-- @return number The width of the text. Same value as if you were calling surface.GetTextSize.
-- @return number The height of the text. Same value as if you were calling surface.GetTextSize.
function SimpleTextOutlined( Text,  font,  x,  y,  color,  xAlign,  yAlign,  outlinewidth,  outlinecolor) end

--- draw.Text
-- @usage client_m
-- Works like draw.SimpleText but uses a table structure instead.
--
-- @param  textdata table  The text properties. See the TextData structure
-- @return number Width of drawn text
-- @return number Height of drawn text
function Text( textdata) end

--- draw.TextShadow
-- @usage client_m
-- Works like draw.Text, but draws the text as a shadow.
--
-- @param  textdata table  The text properties. See TextData structure
-- @param  distance number  How far away the shadow appears.
-- @param  alpha=200 number  How visible the shadow is (0-255).
function TextShadow( textdata,  distance,  alpha) end

--- draw.TexturedQuad
-- @usage client_m
-- Draws a texture with a table structure.
--
-- @param  texturedata table  The texture properties. See TextureData structure
function TexturedQuad( texturedata) end

--- draw.WordBox
-- @usage client_m
-- Draws a rounded box with text in it.
--
-- @param  bordersize number  Size of border, should be multiple of 2. Ideally this will be 8 or 16.
-- @param  x number  The X Coordinate.
-- @param  y number  The Y Coordinate.
-- @param  text string  Text to draw.
-- @param  font string  Font to draw in. See surface.CreateFont to create your own, or here for a list of default fonts.
-- @param  boxcolor table  The box color. Uses the Color structure.
-- @param  textcolor table  The text color. Uses the Color structure.
-- @return number The width of the word box.
-- @return number The height of the word box.
function WordBox( bordersize,  x,  y,  text,  font,  boxcolor,  textcolor) end

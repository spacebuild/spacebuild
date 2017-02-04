---
-- @description Library killicon
 module("killicon")

--- killicon.Add
-- @usage client
-- Creates new kill icon using a texture.
--
-- @param  class string  Weapon or entity class
-- @param  texture string  Path to the texture
-- @param  color table  Color of the kill icon
function Add( class,  texture,  color) end

--- killicon.AddAlias
-- @usage client
-- Creates kill icon from existing one.
--
-- @param  new_class string  New class of the kill icon
-- @param  existing_class string  Already existing kill icon class
function AddAlias( new_class,  existing_class) end

--- killicon.AddFont
-- @usage client
-- Adds kill icon for given weapon/entity class using special font.
--
-- @param  class string  Weapon or entity class
-- @param  font string  Font to be used
-- @param  symbol string  The symbol to be used
-- @param  color table  Color of the killicon
function AddFont( class,  font,  symbol,  color) end

--- killicon.Draw
-- @usage client
-- Draws a kill icon.
--
-- @param  x number  X coordinate of the icon
-- @param  y number  Y coordinate of the icon
-- @param  name string  Classname of the kill icon
-- @param  alpha number  Alpha/transparency value ( 0 - 255 ) of the icon
function Draw( x,  y,  name,  alpha) end

--- killicon.Exists
-- @usage client
-- Checks if kill icon exists for given class.
--
-- @param  class string  The class to test
-- @return boolean Returns true if kill icon exists
function Exists( class) end

--- killicon.GetSize
-- @usage client
-- Returns the size of a kill icon.
--
-- @param  name string  Classname of the kill icon
-- @return number Width of the kill icon
-- @return number Height of the kill icon
function GetSize( name) end

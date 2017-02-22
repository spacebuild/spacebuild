--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

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

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
-- @description Library GWEN
 module("GWEN")

--- GWEN.CreateTextureBorder
-- @usage client_m
-- Used in derma skins to create a bordered rectangle drawing function from an image. The texture is taken from SKIN.GwenTexture
--
-- @param  x number  The X coordinate on the texture
-- @param  y number  The Y coordinate on the texture
-- @param  w number  Width of the area on texture
-- @param  h number  Height of the area on texture
-- @param  left number  Left width of border
-- @param  top number  Top width of border
-- @param  right number  Right width of border
-- @param  bottom number  Bottom width of border
-- @return function The drawing function. Arguments are: number x - X coordinate for the box number y - Y coordinate for the box number w - Width of the box number h - Height of the box table clr - Optional color, default is white. Uses the Color structure  
function CreateTextureBorder( x,  y,  w,  h,  left,  top,  right,  bottom) end

--- GWEN.CreateTextureCentered
-- @usage client_m
-- Used in derma skins to create a rectangle drawing function from an image. The rectangle will not be scaled, but instead it will be drawn in the center of the box. The texture is taken from SKIN.GwenTexture
--
-- @param  x number  The X coordinate on the texture
-- @param  y number  The Y coordinate on the texture
-- @param  w number  Width of the area on texture
-- @param  h number  Height of the area on texture
-- @return function The drawing function. Arguments are: number x - X coordinate for the box number y - Y coordinate for the box number w - Width of the box number h - Height of the box table clr - Optional color, default is white. Uses the Color structure  
function CreateTextureCentered( x,  y,  w,  h) end

--- GWEN.CreateTextureNormal
-- @usage client_m
-- Used in derma skins to create a rectangle drawing function from an image. The texture of the rectangle will be scaled. The texture is taken from SKIN.GwenTexture
--
-- @param  x number  The X coordinate on the texture
-- @param  y number  The Y coordinate on the texture
-- @param  w number  Width of the area on texture
-- @param  h number  Height of the area on texture
-- @return function The drawing function. Arguments are: number x - X coordinate for the box number y - Y coordinate for the box number w - Width of the box number h - Height of the box table clr - Optional color, default is white. Uses the Color structure  
function CreateTextureNormal( x,  y,  w,  h) end

--- GWEN.TextureColor
-- @usage client_m
-- When used in a material skin, it returns a color value from a point in the skin image.
--
-- @param  x number  X position of the pixel to get the color from.
-- @param  y number  Y position of the pixel to get the color from.
-- @return table The color of the point on the skin as a Color structure.
function TextureColor( x,  y) end

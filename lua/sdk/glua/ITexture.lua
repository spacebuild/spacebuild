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
-- @description Library ITexture
 module("ITexture")

--- ITexture:Download
-- @usage shared
-- Invokes the generator of the texture. Reloads file based textures from disk and clears render target textures.
--
function Download() end

--- ITexture:GetColor
-- @usage shared
-- Returns the color of the specified pixel, only works for textures created from PNG files.
--
-- @param  x number  The X coordinate.
-- @param  y number  The Y coordinate.
-- @return table The color of the pixel as a Color structure.
function GetColor( x,  y) end

--- ITexture:GetMappingHeight
-- @usage shared
-- Returns the true unmodified height of the texture.
--
-- @return number height
function GetMappingHeight() end

--- ITexture:GetMappingWidth
-- @usage shared
-- Returns the true unmodified width of the texture.
--
-- @return number width
function GetMappingWidth() end

--- ITexture:GetName
-- @usage shared
-- Returns the name of the texture, in most cases the path.
--
-- @return string name
function GetName() end

--- ITexture:Height
-- @usage shared
-- Returns the modified height of the texture, this value may be affected by mipmapping and other factors.
--
-- @return number height
function Height() end

--- ITexture:IsError
-- @usage shared
-- Returns whenever the texture is invalid or not.
--
-- @return boolean isError
function IsError() end

--- ITexture:Width
-- @usage shared
-- Returns the modified width of the texture, this value may be affected by mipmapping and other factors.
--
-- @return number width
function Width() end

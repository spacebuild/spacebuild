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
-- @description Library DImage
 module("DImage")

--- DImage:DoLoadMaterial
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function DoLoadMaterial() end

--- DImage:FixVertexLitMaterial
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function FixVertexLitMaterial() end

--- DImage:GetFailsafeMatName
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return string 
function GetFailsafeMatName() end

--- DImage:GetImage
-- @usage client
-- Returns the image loaded in the image panel.
--
-- @return string The path to the image that is loaded.
function GetImage() end

--- DImage:GetImageColor
-- @usage client
-- Returns the color override of the image panel.
--
-- @return table The color override of the image. Uses the Color structure.
function GetImageColor() end

--- DImage:GetKeepAspect
-- @usage client
-- Returns whether the DImage should keep the aspect ratio of its image when being resized.
--
-- @return boolean Whether the DImage should keep the aspect ratio of its image when being resized.
function GetKeepAspect() end

--- DImage:GetMaterial
-- @usage client
-- Returns the current Material of the DImage.
--
-- @return IMaterial 
function GetMaterial() end

--- DImage:GetMatName
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return string 
function GetMatName() end

--- DImage:LoadMaterial
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function LoadMaterial() end

--- DImage:PaintAt
-- @usage client
-- Paints a ghost copy of the DImage panel at the given position and dimensions. This function overrides Panel:PaintAt.
--
-- @param  posX number  The x coordinate to draw the panel from.
-- @param  posY number  The y coordinate to draw the panel from.
-- @param  width number  The width of the panel image to be drawn.
-- @param  height number  The height of the panel image to be drawn.
function PaintAt( posX,  posY,  width,  height) end

--- DImage:SetFailsafeMatName
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  backupMat string 
function SetFailsafeMatName( backupMat) end

--- DImage:SetImage
-- @usage client
-- Sets the image to load into the frame. If the first image can't be loaded and strBackup is set, that image will be loaded instead.
--
-- @param  strImage string  The path of the image to load. When no file extension is supplied the VMT file extension is used.
-- @param  strBackup string  The path of the backup image.
function SetImage( strImage,  strBackup) end

--- DImage:SetImageColor
-- @usage client
-- Sets the image's color override.
--
-- @param  col table  The color override of the image. Uses the Color structure.
function SetImageColor( col) end

--- DImage:SetKeepAspect
-- @usage client
-- Sets whether the DImage should keep the aspect ratio of its image when being resized.
--
-- @param  keep boolean  true to keep the aspect ratio, false not to
function SetKeepAspect( keep) end

--- DImage:SetMaterial
-- @usage client
-- Sets a Material directly as an image.
--
-- @param  mat IMaterial  The material to set
function SetMaterial( mat) end

--- DImage:SetMatName
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  mat string 
function SetMatName( mat) end

--- DImage:SetOnViewMaterial
-- @usage client
-- Similar to DImage:SetImage, but will only do the expensive part of actually loading the textures/material if the material is about to be rendered/viewed.
--
-- @param  mat string 
-- @param  backupMat string 
function SetOnViewMaterial( mat,  backupMat) end

--- DImage:Unloaded
-- @usage client
-- Returns true if the image is not yet loaded.
--
-- @return boolean 
function Unloaded() end

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
-- @description Library DImageButton
 module("DImageButton")

--- DImageButton:GetImage
-- @usage client
-- Returns the "image" of the DImageButton. Equivalent of DImage:GetImage.
--
-- @return string The path to the image that is loaded.
function GetImage() end

--- DImageButton:GetStretchToFit
-- @usage client
-- Returns whether the image inside the button should be stretched to fit it or not
--
-- @return boolean 
function GetStretchToFit() end

--- DImageButton:SetColor
-- @usage client
-- Sets the color of the image. Equivalent of DImage:SetImageColor
--
-- @param  color table  The Color to set
function SetColor( color) end

--- DImageButton:SetIcon
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
function SetIcon() end

--- DImageButton:SetImage
-- @usage client
-- Sets the "image" of the DImageButton. Equivalent of DImage:SetImage.
--
-- @param  strImage string  The path of the image to load. When no file extension is supplied the VMT file extension is used.
-- @param  strBackup string  The path of the backup image.
function SetImage( strImage,  strBackup) end

--- DImageButton:SetImageVisible
-- @usage client
-- Hides or shows the image of the image button. Internally this calls Panel:SetVisible on the internal DImage.
--
-- @param  visible boolean  Set true to make it visible ( default ), or false to hide the image
function SetImageVisible( visible) end

--- DImageButton:SetKeepAspect
-- @usage client
-- Sets whether the DImageButton should keep the aspect ratio of its image. Equivalent of DImage:SetKeepAspect.
--
-- @param  keep boolean  true to keep the aspect ratio, false not to
function SetKeepAspect( keep) end

--- DImageButton:SetMaterial
-- @usage client
-- Sets a Material directly as an image. Equivalent of DImage:SetMaterial.
--
-- @param  mat IMaterial  The material to set
function SetMaterial( mat) end

--- DImageButton:SetOnViewMaterial
-- @usage client
-- See DImage:SetOnViewMaterial
--
-- @param  mat string 
-- @param  backup string 
function SetOnViewMaterial( mat,  backup) end

--- DImageButton:SetStretchToFit
-- @usage client
-- Sets whether the image inside the DImageButton should be stretched to fill the entire size of the button, without preserving aspect ratio.
--
-- @param  stretch boolean  True to stretch, false to not to stretch
function SetStretchToFit( stretch) end

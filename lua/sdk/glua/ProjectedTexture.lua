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
-- @description Library ProjectedTexture
 module("ProjectedTexture")

--- ProjectedTexture:GetAngles
-- @usage client
-- Returns the angle of the ProjectedTexture, which were previously set by ProjectedTexture:SetAngles
--
-- @return Angle The angles of the ProjectedTexture.
function GetAngles() end

--- ProjectedTexture:GetBrightness
-- @usage client
-- Returns the brightness of the ProjectedTexture, which was previously set by ProjectedTexture:SetBrightness
--
-- @return number The brightness of the ProjectedTexture.
function GetBrightness() end

--- ProjectedTexture:GetColor
-- @usage client
-- Returns the color of the ProjectedTexture, which was previously set by ProjectedTexture:SetColor
--
-- @return table Color structure, the color of the ProjectedTexture.
function GetColor() end

--- ProjectedTexture:GetEnableShadows
-- @usage client
-- Returns whether shadows are enabled for this ProjectedTexture, which was previously set by ProjectedTexture:SetEnableShadows
--
-- @return boolean Whether shadows are enabled.
function GetEnableShadows() end

--- ProjectedTexture:GetFarZ
-- @usage client
-- Returns the projection distance of the ProjectedTexture, which was previously set by ProjectedTexture:SetFarZ
--
-- @return number The projection distance of the ProjectedTexture.
function GetFarZ() end

--- ProjectedTexture:GetHorizontalFOV
-- @usage client
-- Returns the horizontal FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetHorizontalFOV or ProjectedTexture:SetFOV
--
-- @return number The horizontal FOV of the ProjectedTexture.
function GetHorizontalFOV() end

--- ProjectedTexture:GetNearZ
-- @usage client
-- Returns the NearZ value of the ProjectedTexture, which was previously set by ProjectedTexture:SetNearZ
--
-- @return number NearZ of the ProjectedTexture.
function GetNearZ() end

--- ProjectedTexture:GetOrthographic
-- @usage client
-- Returns the current orthographic settings of the Projected Texture. To set these values, use ProjectedTexture:SetOrthographic.
--
-- @return boolean Whether or not this projected texture is orthographic. When false, nothing else is returned.
-- @return number left
-- @return number top
-- @return number right
-- @return number bottom
function GetOrthographic() end

--- ProjectedTexture:GetPos
-- @usage client
-- Returns the position of the ProjectedTexture, which was previously set by ProjectedTexture:SetPos
--
-- @return Vector The position of the ProjectedTexture.
function GetPos() end

--- ProjectedTexture:GetTexture
-- @usage client
-- Returns the texture of the ProjectedTexture, which was previously set by ProjectedTexture:SetTexture
--
-- @return ITexture The texture of the ProjectedTexture.
function GetTexture() end

--- ProjectedTexture:GetTextureFrame
-- @usage client
-- Returns the texture frame of the ProjectedTexture, which was previously set by ProjectedTexture:SetTextureFrame
--
-- @return number The texture frame.
function GetTextureFrame() end

--- ProjectedTexture:GetVerticalFOV
-- @usage client
-- Returns the vertical FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetVerticalFOV or ProjectedTexture:SetFOV
--
-- @return number The vertical FOV of the ProjectedTexture.
function GetVerticalFOV() end

--- ProjectedTexture:IsValid
-- @usage client
-- Returns true if the projected texture is valid (i.e. has not been removed), false otherwise.
--
-- @return boolean Whether the projected texture is valid.
function IsValid() end

--- ProjectedTexture:Remove
-- @usage client
-- Removes the projected texture. After calling this, ProjectedTexture:IsValid will return false, and any hooks with the projected texture as the identifier will be automatically deleted.
--
function Remove() end

--- ProjectedTexture:SetAngles
-- @usage client
-- Sets the angles (direction) of the projected texture.
--
-- @param  angle Angle 
function SetAngles( angle) end

--- ProjectedTexture:SetBrightness
-- @usage client
-- Sets the brightness of the projected texture.
--
-- @param  brightness number  The brightness to give the projected texture.
function SetBrightness( brightness) end

--- ProjectedTexture:SetColor
-- @usage client
-- Sets the color of the projected texture.
--
-- @param  color table  Must be a Color structure.  Unlike other projected textures, this color can only go up to 255.
function SetColor( color) end

--- ProjectedTexture:SetEnableShadows
-- @usage client
-- Enable or disable shadows cast from the projected texture.
--
-- @param UV boolean 
function SetEnableShadows(UV) end

--- ProjectedTexture:SetFarZ
-- @usage client
-- Sets the distance at which the projected texture ends.
--
-- @param  farZ number 
function SetFarZ( farZ) end

--- ProjectedTexture:SetFOV
-- @usage client
-- Sets the angle of projection.
--
-- @param  fov number  Must be higher than 0 and lower than 180
function SetFOV( fov) end

--- ProjectedTexture:SetHorizontalFOV
-- @usage client
-- Sets the horizontal angle of projection without affecting the vertical angle.
--
-- @param  hFOV number  The new horizontal Field Of View for the projected texture. Must be in range between 0 and 180.
function SetHorizontalFOV( hFOV) end

--- ProjectedTexture:SetNearZ
-- @usage client
-- Sets the distance at which the projected texture begins its projection.
--
-- @param  nearZ number 
function SetNearZ( nearZ) end

--- ProjectedTexture:SetOrthographic
-- @usage client
-- Changes the current projected texture between orthographic and perspective projection.
--
-- @param  orthographic boolean  When false, all other arguments are ignored and the texture is reset to perspective projection.
-- @param  left number  The amount of units left from the projected texture's origin to project.
-- @param  top number  The amount of units upwards from the projected texture's origin to project.
-- @param  right number  The amount of units right from the projected texture's origin to project.
-- @param  bottom number  The amount of units downwards from the projected texture's origin to project.
function SetOrthographic( orthographic,  left,  top,  right,  bottom) end

--- ProjectedTexture:SetPos
-- @usage client
-- Move the Projected Texture to the specified position.
--
-- @param  position Vector 
function SetPos( position) end

--- ProjectedTexture:SetTexture
-- @usage client
-- Sets the texture to be projected.
--
-- @param  texture string  The name of the texture. Can also be an ITexture.
function SetTexture( texture) end

--- ProjectedTexture:SetTextureFrame
-- @usage client
-- For animated textures, this will choose which frame in the animation will be projected.
--
-- @param  frame number  The frame index to use.
function SetTextureFrame( frame) end

--- ProjectedTexture:SetVerticalFOV
-- @usage client
-- Sets the vertical angle of projection without affecting the horizontal angle.
--
-- @param  vFOV number  The new vertical Field Of View for the projected texture. Must be in range between 0 and 180.
function SetVerticalFOV( vFOV) end

--- ProjectedTexture:Update
-- @usage client
-- Updates the Projected Light and applies all previously set parameters.
--
function Update() end

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
-- @description Library DSprite
 module("DSprite")

--- DSprite:GetColor
-- @usage client
-- Gets the color the sprite is using as a modifier.
--
-- @return table The Color being used.
function GetColor() end

--- DSprite:GetMaterial
-- @usage client
-- Gets the material the sprite is using.
--
-- @return IMaterial The material in use.
function GetMaterial() end

--- DSprite:GetRotation
-- @usage client
-- Gets the 2D rotation angle of the sprite, in the plane of the screen.
--
-- @return number The anti-clockwise rotation in degrees.
function GetRotation() end

--- DSprite:SetColor
-- @usage client
-- Sets the color modifier for the sprite.
--
-- @param  color table  The Color to use.
function SetColor( color) end

--- DSprite:SetMaterial
-- @usage client
-- Sets the source material for the sprite.
--
-- @param  material IMaterial  The material to use. This will ideally be an UnlitGeneric.
function SetMaterial( material) end

--- DSprite:SetRotation
-- @usage client
-- Sets the 2D rotation angle of the sprite, in the plane of the screen.
--
-- @param  ang number  The anti-clockwise rotation in degrees.
function SetRotation( ang) end

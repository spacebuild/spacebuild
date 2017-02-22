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
-- @description Library IMaterial
 module("IMaterial")

--- IMaterial:GetColor
-- @usage shared
-- Returns the color of the specified pixel, only works for materials created from PNG files.
--
-- @param  x number  The X coordinate.
-- @param  y number  The Y coordinate.
-- @return table The color of the pixel as a Color structure.
function GetColor( x,  y) end

--- IMaterial:GetFloat
-- @usage shared
-- Returns the specified material value as a float, or nil if the value is not set.
--
-- @param  materialFloat string  The name of the material value.
-- @return number float
function GetFloat( materialFloat) end

--- IMaterial:GetInt
-- @usage shared
-- Returns the specified material value as a int, rounds the value if its a float, or nil if the value is not set.
--
-- @param  materialInt string  The name of the material integer.
-- @return number int
function GetInt( materialInt) end

--- IMaterial:GetKeyValues
-- @usage shared
-- Gets all the key values defined for the material.
--
-- @return table The material's key values.
function GetKeyValues() end

--- IMaterial:GetMatrix
-- @usage shared
-- Returns the specified material matrix as a int, or nil if the value is not set or is not a matrix.
--
-- @param  materialMatrix string  The name of the material matrix.
-- @return VMatrix matrix
function GetMatrix( materialMatrix) end

--- IMaterial:GetName
-- @usage shared
-- Returns the name of the material, in most cases the path.
--
-- @return string Material name/path
function GetName() end

--- IMaterial:GetShader
-- @usage shared
-- Returns the name of the materials shader.
--
-- @return string shaderName
function GetShader() end

--- IMaterial:GetString
-- @usage shared
-- Returns the specified material string, or nil if the value is not set or if the value can not be converted to a string.
--
-- @param  materialString string  The name of the material string.
-- @return string strVal
function GetString( materialString) end

--- IMaterial:GetTexture
-- @usage shared
-- Returns an ITexture based on the passed shader parameter.
--
-- @param  param string  The shader parameter to retrieve. This should normally be $basetexture.
-- @return ITexture The value of the shader parameter. Returns nothing if the param doesn't exist.
function GetTexture( param) end

--- IMaterial:GetVector
-- @usage shared
-- Returns the specified material linear color vector, or nil if the value is not set.
--
-- @param  materialVector string  The name of the material vector.
-- @return Vector The linear color vector
function GetVector( materialVector) end

--- IMaterial:Height
-- @usage shared
-- Returns the height of the member texture set for $basetexture.
--
-- @return number height
function Height() end

--- IMaterial:IsError
-- @usage shared
-- Returns whenever the material was not loaded successfully.
--
-- @return boolean isError
function IsError() end

--- IMaterial:Recompute
-- @usage shared
-- Recomputes the material's snapshot. This needs to be called if you have changed variables on your material and it isn't changing.
--
function Recompute() end

--- IMaterial:SetFloat
-- @usage shared
-- Sets the specified material float to the specified float, does nothing on a type mismatch.
--
-- @param  materialFloat string  The name of the material float.
-- @param  float number  The new float value.
function SetFloat( materialFloat,  float) end

--- IMaterial:SetInt
-- @usage shared
-- Sets the specified material value to the specified int, does nothing on a type mismatch.
--
-- @param  materialInt string  The name of the material int.
-- @param  int number  The new int value.
function SetInt( materialInt,  int) end

--- IMaterial:SetMatrix
-- @usage shared
-- Sets the specified material value to the specified matrix, does nothing on a type mismatch.
--
-- @param  materialMatrix string  The name of the material int.
-- @param  matrix VMatrix  The new matrix.
function SetMatrix( materialMatrix,  matrix) end

--- IMaterial:SetShader
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This function does nothing
-- @param  shaderName string  Name of the shader
function SetShader( shaderName) end

--- IMaterial:SetString
-- @usage shared
-- Sets the specified material value to the specified string, does nothing on a type mismatch.
--
-- @param  materialString string  The name of the material string.
-- @param  string string  The new string.
function SetString( materialString,  string) end

--- IMaterial:SetTexture
-- @usage shared
-- Sets the specified material texture to the specified texture, does nothing on a type mismatch.
--
-- @param  materialTexture string  The name of the keyvalue on the material to store the texture on.
-- @param  texture ITexture  The new texture. This can also be a string, the name of the new texture.
function SetTexture( materialTexture,  texture) end

--- IMaterial:SetUndefined
-- @usage shared
-- Unsets the value for the specified material value.
--
-- @param  materialValueName string  The name of the material value to be unset.
function SetUndefined( materialValueName) end

--- IMaterial:SetVector
-- @usage shared
-- Sets the specified material vector to the specified vector, does nothing on a type mismatch.
--
-- @param  MaterialVector string  The name of the material vector.
-- @param  vec Vector  The new vector.
function SetVector( MaterialVector,  vec) end

--- IMaterial:Width
-- @usage shared
-- Returns the width of the member texture set for $basetexture.
--
-- @return number width
function Width() end

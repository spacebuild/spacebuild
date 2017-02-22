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
-- @description Library Vector
 module("Vector")

--- Vector:Add
-- @usage shared
-- Adds the values of the second vector to the orignal vector, this function can be used to avoid garbage collection.
--
-- @param  vector Vector  The other vector.
function Add( vector) end

--- Vector:Angle
-- @usage shared
-- Returns an angle representing the normal of the vector.
--
-- @return Angle The angle/direction of the vector.
function Angle() end

--- Vector:AngleEx
-- @usage shared
-- Returns the angle of the vector, but instead of assuming that up is Vector( 0, 0, 1 ) (Like Vector:Angle does) you can specify which direction is 'up' for the angle.
--
-- @param  up Vector  The up direction vector
-- @return Angle The angle
function AngleEx( up) end

--- Vector:Cross
-- @usage shared
-- Calculates the cross product of this vector and the passed one.
--
-- @param  otherVector Vector  Vector to calculate the cross product with.
-- @return Vector The cross product of the two vectors.
function Cross( otherVector) end

--- Vector:Distance
-- @usage shared
-- Returns the pythagorean distance between the vector and the other vector.
--
-- @param  otherVector Vector  The vector to get the distance to.
-- @return number Distance between the vectors.
function Distance( otherVector) end

--- Vector:DistToSqr
-- @usage shared
-- Returns the squared distance of 2 vectors, this is faster than Vector:Distance as calculating the square root is an expensive process.
--
-- @param  otherVec Vector  The vector to calculate the distance to.
-- @return number Squared distance to the vector
function DistToSqr( otherVec) end

--- Vector:Dot
-- @usage shared
-- Returns the dot product of this vector and the passed one.
--
-- @param  otherVector Vector  The vector to calculate the dot product with
-- @return number The dot product between the two vectors
function Dot( otherVector) end

--- Vector:DotProduct
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This is an alias of Vector:Dot. Use that instead.
-- @param  Vector Vector  The other vector.
-- @return number Dot Product
function DotProduct( Vector) end

--- Vector:GetNormal
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Use Vector:GetNormalized instead.
-- @return Vector Normalized version of the vector.
function GetNormal() end

--- Vector:GetNormalized
-- @usage shared
-- Returns a normalized version of the vector. Normalized means vector with same direction but with length of 1.
--
-- @return Vector Normalized version of the vector.
function GetNormalized() end

--- Vector:IsEqualTol
-- @usage shared
-- Returns if the vector is equal to another vector with the given tolerance.
--
-- @param  compare Vector  The vector to compare to.
-- @param  tolerance number  The tolerance range.
-- @return boolean Are the vectors equal or not.
function IsEqualTol( compare,  tolerance) end

--- Vector:IsZero
-- @usage shared
-- Checks whenever all fields of the vector are 0.
--
-- @return boolean Do all fields of the vector equal 0 or not
function IsZero() end

--- Vector:Length
-- @usage shared
-- Returns the Euclidean length of the vector: √ x² + y² + z² 
--
-- @return number Length of the vector.
function Length() end

--- Vector:Length2D
-- @usage shared
-- Returns the length of the vector in two dimensions, without the Z axis.
--
-- @return number Length of the vector in two dimensions, √ x² + y² 
function Length2D() end

--- Vector:Length2DSqr
-- @usage shared
-- Returns the squared length of the vectors x and y value, x² + y².
--
-- @return number Squared length of the vector in two dimensions
function Length2DSqr() end

--- Vector:LengthSqr
-- @usage shared
-- Returns the squared length of the vector, x² + y² + z².
--
-- @return number Squared length of the vector
function LengthSqr() end

--- Vector:Mul
-- @usage shared
-- Scales the vector by the given number, that means x, y and z are multiplied by that value.
--
-- @param  multiplier number  The value to scale the vector with.
function Mul( multiplier) end

--- Vector:Normalize
-- @usage shared
-- Normalizes the given vector. This changes the vector you call it on, if you want to return a normalized copy without affecting the original, use Vector:GetNormalized.
--
function Normalize() end

--- Vector:Rotate
-- @usage shared
-- Rotates a vector by the given angle.
--Doesn't return anything, but rather changes the original vector.
--
-- @param  rotation Angle  The angle to rotate the vector by.
function Rotate( rotation) end

--- Vector:Set
-- @usage shared
-- Copies the values from the second vector to the first vector.
--
-- @param  vector Vector  The vector to copy from.
function Set( vector) end

--- Vector:Sub
-- @usage shared
-- Substracts the values of the second vector from the orignal vector, this function can be used to avoid garbage collection.
--
-- @param  vector Vector  The other vector.
function Sub( vector) end

--- Vector:ToColor
-- @usage shared
-- Translates the vector normalized vector ( length is 1 ) into a Color structure.
--
-- @return table The created Color structure.
function ToColor() end

--- Vector:ToScreen
-- @usage client
-- Translates the vectors position into 2D user screen coordinates.
--
-- @return table The created ToScreenData structure.
function ToScreen() end

--- Vector:WithinAABox
-- @usage shared
-- Returns whenever the given vector is in a box created by the 2 other vectors.
--
-- @param  boxStart Vector  The first vector.
-- @param  boxEnd Vector  The second vector.
-- @return boolean Is the vector in the box or not
function WithinAABox( boxStart,  boxEnd) end

--- Vector:Zero
-- @usage shared
-- Sets x, y and z to 0.
--
function Zero() end

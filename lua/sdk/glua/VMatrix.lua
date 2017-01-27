---
-- @description Library VMatrix
 module("VMatrix")

--- VMatrix:GetAngles
-- @usage shared
-- Returns the absolute rotation of the matrix.
--
-- @return Angle Absolute rotation of the matrix
function GetAngles() end

--- VMatrix:GetField
-- @usage shared
-- Returns a specific field in the matrix.
--
-- @param  row number  Row of the field whose value is to be retrieved, from 1 to 4
-- @param  column number  Column of the field whose value is to be retrieved, from 1 to 4
-- @return number The value of the specified field
function GetField( row,  column) end

--- VMatrix:GetForward
-- @usage shared
-- Gets the forward direction of the matrix.
--
-- @return Vector The forward direction of the matrix.
function GetForward() end

--- VMatrix:GetInverse
-- @usage shared
-- Returns an inverted matrix without modifying the original matrix.
--
-- @return VMatrix The inverted matrix if possible, nil otherwise
function GetInverse() end

--- VMatrix:GetInverseTR
-- @usage shared
-- Returns an inverted matrix without modifying the original matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.
--
-- @return VMatrix The inverted matrix.
function GetInverseTR() end

--- VMatrix:GetRight
-- @usage shared
-- Gets the right direction of the matrix.
--
-- @return Vector The right direction of the matrix.
function GetRight() end

--- VMatrix:GetScale
-- @usage shared
-- Returns the absolute scale of the matrix.
--
-- @return Vector Absolute scale of the matrix
function GetScale() end

--- VMatrix:GetTranslation
-- @usage shared
-- Returns the absolute translation of the matrix.
--
-- @return Vector Absolute translation of the matrix
function GetTranslation() end

--- VMatrix:GetUp
-- @usage shared
-- Gets the up direction of the matrix.
--
-- @return Vector The up direction of the matrix.
function GetUp() end

--- VMatrix:Identity
-- @usage shared
-- Initializes the matrix as Identity matrix.
--
function Identity() end

--- VMatrix:Invert
-- @usage shared
-- Inverts the matrix.
--
-- @return boolean Whether the matrix was inverted or not
function Invert() end

--- VMatrix:InvertTR
-- @usage shared
-- Inverts the matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.
--
function InvertTR() end

--- VMatrix:IsIdentity
-- @usage shared
-- Returns whether the matrix is equal to Identity matrix or not.
--
-- @return boolean Is the matrix an Identity matrix or not
function IsIdentity() end

--- VMatrix:IsRotationMatrix
-- @usage shared
-- Returns whether the matrix is a rotation matrix or not.
--
-- @return boolean Is the matrix a rotation matrix or not
function IsRotationMatrix() end

--- VMatrix:Rotate
-- @usage shared
-- Rotates the matrix by the given angle.
--
-- @param  rotation Angle  Rotation.
function Rotate( rotation) end

--- VMatrix:Scale
-- @usage shared
-- Scales the matrix by the given vector.
--
-- @param  scale Vector  Vector to scale with matrix with.
function Scale( scale) end

--- VMatrix:ScaleTranslation
-- @usage shared
-- Scales the absolute translation with the given value.
--
-- @param  scale number  Value to scale the translation with.
function ScaleTranslation( scale) end

--- VMatrix:Set
-- @usage shared
-- Copies values from the given matrix object.
--
-- @param  src VMatrix  The matrix to copy values from.
function Set( src) end

--- VMatrix:SetAngles
-- @usage shared
-- Sets the absolute rotation of the matrix.
--
-- @param  angle Angle  New angles.
function SetAngles( angle) end

--- VMatrix:SetField
-- @usage shared
-- Sets a specific field in the matrix.
--
-- @param  row number  Row of the field to be set, from 1 to 4
-- @param  column number  Column of the field to be set, from 1 to 4
-- @param  value number  The value to set in that field
function SetField( row,  column,  value) end

--- VMatrix:SetForward
-- @usage shared
-- Sets the forward direction of the matrix.
--
-- @param  forward Vector  The forward direction of the matrix.
function SetForward( forward) end

--- VMatrix:SetRight
-- @usage shared
-- Sets the right direction of the matrix.
--
-- @param  forward Vector  The right direction of the matrix.
function SetRight( forward) end

--- VMatrix:SetScale
-- @usage shared
-- Modifies the scale of the matrix while preserving the rotation and translation.
--
-- @param  scale Vector  The scale to set.
function SetScale( scale) end

--- VMatrix:SetTranslation
-- @usage shared
-- Sets the absolute translation of the matrix.
--
-- @param  translation Vector  New translation.
function SetTranslation( translation) end

--- VMatrix:SetUp
-- @usage shared
-- Sets the up direction of the matrix.
--
-- @param  forward Vector  The up direction of the matrix.
function SetUp( forward) end

--- VMatrix:ToTable
-- @usage shared
-- Converts the matrix to a 4x4 table. See Matrix function.
--
-- @return table The 4x4 table.
function ToTable() end

--- VMatrix:Translate
-- @usage shared
-- Translates the matrix by the given vector aka. adds the vector to the translation.
--
-- @param  translation Vector  Vector to translate the matrix by.
function Translate( translation) end

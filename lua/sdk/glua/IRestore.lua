---
-- @description Library IRestore
 module("IRestore")

--- IRestore:EndBlock
-- @usage shared
-- Ends current data block started with IRestore:StartBlock and returns to the parent block.
--
function EndBlock() end

--- IRestore:ReadAngle
-- @usage shared
-- Reads next bytes from the restore object as an Angle.
--
-- @return Angle The angle that has been read
function ReadAngle() end

--- IRestore:ReadBool
-- @usage shared
-- Reads next bytes from the restore object as a boolean.
--
-- @return boolean The boolean that has been read
function ReadBool() end

--- IRestore:ReadEntity
-- @usage shared
-- Reads next bytes from the restore object as an Entity.
--
-- @return Entity The entity that has been read.
function ReadEntity() end

--- IRestore:ReadFloat
-- @usage shared
-- Reads next bytes from the restore object as a floating point number.
--
-- @return number The read floating point number.
function ReadFloat() end

--- IRestore:ReadInt
-- @usage shared
-- Reads next bytes from the restore object as an integer number.
--
-- @return number The read integer number.
function ReadInt() end

--- IRestore:ReadString
-- @usage shared
-- Reads next bytes from the restore object as a string.
--
-- @return string The read string. Maximum length is 1024.
function ReadString() end

--- IRestore:ReadVector
-- @usage shared
-- Reads next bytes from the restore object as a Vector.
--
-- @return Vector The read vector.
function ReadVector() end

--- IRestore:StartBlock
-- @usage shared
-- Loads next block of data to be read inside current block. Blocks must be ended with IRestore:EndBlock.
--
-- @return string The name of the next data block to be read.
function StartBlock() end

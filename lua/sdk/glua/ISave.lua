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
-- @description Library ISave
 module("ISave")

--- ISave:EndBlock
-- @usage shared
-- Ends current data block started with ISave:StartBlock and returns to the parent block.
--
function EndBlock() end

--- ISave:StartBlock
-- @usage shared
-- Starts a new block of data that you can write to inside current block. Blocks must be ended with ISave:EndBlock.
--
-- @param  name string  Name of the new block. Used for determining which block is which, returned by IRestore:StartBlock during game load.
function StartBlock( name) end

--- ISave:WriteAngle
-- @usage shared
-- Writes an Angle to the save object.
--
-- @param  ang Angle  The angle to write.
function WriteAngle( ang) end

--- ISave:WriteBool
-- @usage shared
-- Writes a boolean to the save object.
--
-- @param  bool boolean  The boolean to write.
function WriteBool( bool) end

--- ISave:WriteEntity
-- @usage shared
-- Writes an Entity to the save object.
--
-- @param  ent Entity  The entity to write.
function WriteEntity( ent) end

--- ISave:WriteFloat
-- @usage shared
-- Writes a floating point number to the save object.
--
-- @param  float number  The floating point number to write.
function WriteFloat( float) end

--- ISave:WriteInt
-- @usage shared
-- Writes an integer number to the save object.
--
-- @param  int number  The integer number to write.
function WriteInt( int) end

--- ISave:WriteString
-- @usage shared
-- Writes a string to the save object.
--
-- @param  str string  The string to write. Maximum length is 1024.
function WriteString( str) end

--- ISave:WriteVector
-- @usage shared
-- Writes a Vector to the save object.
--
-- @param  vec Vector  The vector to write.
function WriteVector( vec) end

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
-- @description Library bf_read
 module("bf_read")

--- bf_read:ReadAngle
-- @usage client
-- Reads an returns an angle object from the bitstream.
--
-- @return Angle The read angle
function ReadAngle() end

--- bf_read:ReadBool
-- @usage client
-- Reads 1 bit an returns a bool representing the bit.
--
-- @return boolean bit
function ReadBool() end

--- bf_read:ReadChar
-- @usage client
-- Reads a signed char and returns a number from -127 to 127 representing the ascii value of that char.
--
-- @return number asciiVal
function ReadChar() end

--- bf_read:ReadEntity
-- @usage client
-- Reads a short representing an entity index and returns the matching entity handle.
--
-- @return Entity ent
function ReadEntity() end

--- bf_read:ReadFloat
-- @usage client
-- Reads a 4 byte float from the bitstream and returns it.
--
-- @return number float
function ReadFloat() end

--- bf_read:ReadLong
-- @usage client
-- Reads a 4 byte long from the bitstream and returns it.
--
-- @return number int
function ReadLong() end

--- bf_read:ReadShort
-- @usage client
-- Reads a 2 byte short from the bitstream and returns it.
--
-- @return number short
function ReadShort() end

--- bf_read:ReadString
-- @usage client
-- Reads a null terminated string from the bitstream.
--
-- @return string str
function ReadString() end

--- bf_read:ReadVector
-- @usage client
-- Reads a special encoded vector from the bitstream and returns it, this function is not suitable to send normals.
--
-- @return Vector vec
function ReadVector() end

--- bf_read:ReadVectorNormal
-- @usage client
-- Reads a special encoded vector normal from the bitstream and returns it, this function is not suitable to send vectors that represent a position.
--
-- @return Vector normal
function ReadVectorNormal() end

--- bf_read:Reset
-- @usage client
-- Rewinds the bitstream so it can be read again.
--
function Reset() end

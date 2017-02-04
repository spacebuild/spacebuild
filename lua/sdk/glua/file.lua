---
-- @description Library File
 module("File")

--- File:Close
-- @usage shared
-- Dumps the file changes to disk and closes the file handle which makes the handle useless.
--
function Close() end

--- File:Flush
-- @usage shared
-- Dumps the file changes to disk and saves the file.
--
function Flush() end

--- File:Read
-- @usage shared
-- Reads the specified amount of chars and returns them as a binary string.
--
-- @param  length number  Reads the specified amount of chars.
-- @return string data
function Read( length) end

--- File:ReadBool
-- @usage shared
-- Reads one byte of the file and returns whether that byte was not 0.
--
-- @return boolean val
function ReadBool() end

--- File:ReadByte
-- @usage shared
-- Reads one unsigned 8-bit integer from the file.
--
-- @return number uint8
function ReadByte() end

--- File:ReadDouble
-- @usage shared
-- Reads 8 bytes from the file converts them to a double and returns them.
--
-- @return number value
function ReadDouble() end

--- File:ReadFloat
-- @usage shared
-- Reads 4 bytes from the file converts them to a float and returns them.
--
-- @return number value
function ReadFloat() end

--- File:ReadLine
-- @usage shared
-- Returns the contents of the file from the current position up until the end of the current line. This function will not return more than 8192 characters.
--
-- @return string The string of data from the read line.
function ReadLine() end

--- File:ReadLong
-- @usage shared
-- Reads a signed 32 bit integer from the file.
--
-- @return number int32
function ReadLong() end

--- File:ReadShort
-- @usage shared
-- Reads a signed 16-bit integer from the file.
--
-- @return number int16
function ReadShort() end

--- File:Seek
-- @usage shared
-- Sets the file pointer to the specified position.
--
-- @param  pos number  Pointer position.
function Seek( pos) end

--- File:Size
-- @usage shared
-- Returns the size of the file in bytes.
--
-- @return number size
function Size() end

--- File:Skip
-- @usage shared
-- Moves the file pointer by the specified amount of chars.
--
-- @param  amount number  The amount of chars to skip, can be negative to skip backwards.
-- @return number amount
function Skip( amount) end

--- File:Tell
-- @usage shared
-- Returns the current position of the file pointer.
--
-- @return number pos
function Tell() end

--- File:Write
-- @usage shared
-- Writes the given string into the file.
--
-- @param  data string  Binary data to write to the file.
function Write( data) end

--- File:WriteBool
-- @usage shared
-- Writes on byte, representing the a Boolean to the file.
--
-- @param  bool boolean  The bool to be written to the file.
function WriteBool( bool) end

--- File:WriteByte
-- @usage shared
-- Write an 8-bit unsigned integer to the file.
--
-- @param  uint8 number  The 8-bit unsigned integer to be written to the file.
function WriteByte( uint8) end

--- File:WriteDouble
-- @usage shared
-- Writes a 8byte floating point double to the file.
--
-- @param  double number  The double to be written to the file.
function WriteDouble( double) end

--- File:WriteFloat
-- @usage shared
-- Writes a 4byte float to the file.
--
-- @param  float number  The float to be written to the file.
function WriteFloat( float) end

--- File:WriteLong
-- @usage shared
-- Writes a 32-bit signed integer to the file.
--
-- @param  int32 number  The 32-bit signed integer to be written to the file.
function WriteLong( int32) end

--- File:WriteShort
-- @usage shared
-- Writes a 16-bit signed integer to the file.
--
-- @param  int16 number  The 16-bit signed integer to be written to the file.
function WriteShort( int16) end

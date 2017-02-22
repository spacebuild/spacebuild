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
-- @description Library utf8
 module("utf8")

--- utf8.char
-- @usage shared
-- Receives zero or more integers, converts each one to its corresponding UTF-8 byte sequence and returns a string with the concatenation of all these sequences.
--
-- @param  codepoints vararg  Unicode code points to be converted in to a UTF-8 string.
-- @return string UTF-8 string generated from given arguments.
function char( codepoints) end

--- utf8.charpattern
-- @usage shared
-- No description
function charpattern() end

--- utf8.codepoint
-- @usage shared
-- Returns the codepoints (as numbers) from all characters in the given string that start between byte position startPos and endPos. It raises an error if it meets any invalid byte sequence. This functions similarly to string.byte.
--
-- @param  string string  The string that you will get the code(s) from.
-- @param  startPos=1 number  The starting byte of the string to get the codepoint of.
-- @param  endPos=1 number  The ending byte of the string to get the codepoint of.
-- @return vararg The codepoint number(s).
function codepoint( string,  startPos,  endPos) end

--- utf8.codes
-- @usage shared
-- Returns an iterator (like string.gmatch) which returns both the position and codepoint of each utf8 character in the string. It raises an error if it meets any invalid byte sequence.
--
-- @param  string string  The string that you will get the codes from.
-- @return function The iterator (to be used in a for loop).
function codes( string) end

--- utf8.force
-- @usage shared
-- Forces a string to contain only valid UTF-8 data. Invalid sequences are replaced with U+FFFD (the Unicode replacement character).
--
-- @param  string string  The string that will become a valid UTF-8 string.
-- @return string The UTF-8 string.
function force( string) end

--- utf8.len
-- @usage shared
-- Returns the number of UTF-8 sequences in the given string between positions startPos and endPos (both inclusive). If it finds any invalid UTF-8 byte sequence, returns false as well as the position of the first invalid byte.
--
-- @param  string string  The string to calculate the length of.
-- @param  startPos=1 number  The starting position to get the length from.
-- @param  endPos=-1 number  The ending position to get the length from.
-- @return number The number of UTF-8 characters in the string. If there are invalid bytes, this will be false.
-- @return number The position of the first invalid byte. If there were no invalid bytes, this will be nil.
function len( string,  startPos,  endPos) end

--- utf8.offset
-- @usage shared
-- Returns the byte-index of the n'th UTF-8-character after the given startPos (nil if none). startPos defaults to 1 when n is positive and -1 when n is negative. If n is zero, this function instead returns the byte-index of the UTF-8-character startPos lies within.
--
-- @param  string string  The string that you will get the byte position from.
-- @param  n number  The position to get the beginning byte position from.
-- @param  startPos=1 when n>=0, -1 otherwise number  The offset for n.
-- @return number Starting byte-index of the given position.
function offset( string,  n,  startPos) end

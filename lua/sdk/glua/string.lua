---
-- @description Library string
 module("string")

--- string.byte
-- @usage shared_m
-- Returns the given string's characters in their numeric ASCII representation.
--
-- @param  string string  The string to get the chars from.
-- @param  startPos=1 number  The first character of the string to get the byte of.
-- @param  endPos=startPos number  The last character of the string to get the byte of.
-- @return vararg Numerical bytes
function byte( string,  startPos,  endPos) end

--- string.char
-- @usage shared_m
-- Takes the given numerical bytes and converts them to a string.
--
-- @param  bytes vararg  The bytes to create the string from.
-- @return string String built from given bytes
function char( bytes) end

--- string.Comma
-- @usage shared_m
-- Inserts commas for every third digit.
--
-- @param  InputNumber number  The input number to commafy
-- @return string Prettystring
function Comma( InputNumber) end

--- string.dump
-- @usage shared_m
-- Returns the binary bytecode of the given function.
--
-- @param  func function  The function to get the bytecode of
-- @param  stripDebugInfo=false boolean  True to strip the debug data, false to keep it
-- @return string Bytecode
function dump( func,  stripDebugInfo) end

--- string.EndsWith
-- @usage shared_m
-- Returns whether or not the second passed string matches the end of the first.
--
-- @param  str string  The string whose end is to be checked.
-- @param  endStr string  The string to be matched with the end of the first.
-- @return boolean true if the first string ends with the second, or the second is empty, otherwise false.
function EndsWith( str,  endStr) end

--- string.Explode
-- @usage shared_m
-- Splits a string up wherever it finds the given separator.
--
-- @param  separator string  The string will be separated wherever this sequence is found.
-- @param  str string  The string to split up.
-- @param  use_patterns boolean  Set this to true if your separator is a pattern.
-- @return table Exploded string as a numerical sequential table.
function Explode( separator,  str,  use_patterns) end

--- string.find
-- @usage shared_m
-- Attempts to find the specified substring in a string, uses Patterns by default.
--
-- @param  haystack string  The string to search in.
-- @param  needle string  The string to find, can contain patterns if enabled.
-- @param  startPos=1 number  The position to start the search from, can be negative start position will be relative to the end position.
-- @param  noPatterns=false boolean  Disable patterns.
-- @return number Starting position of the found text
-- @return number Ending position of found text
-- @return string Matched text for each group if patterns are enabled and used
function find( haystack,  needle,  startPos,  noPatterns) end

--- string.format
-- @usage shared_m
-- Formats the specified values into the string given.
--
-- @param  format string  The string to be formatted.  Follows this format: http://www.cplusplus.com/reference/cstdio/printf/
-- @param  formatParameters vararg  Values to be formatted into the string.
-- @return string formattedString
function format( format,  formatParameters) end

--- string.FormattedTime
-- @usage shared_m
-- Returns the time as a formatted string or as a table if no format is given.
--
-- @param  float number  The time in seconds to format.
-- @param  format=nil string  An optional formatting to use. If no format it specified, a table will be returned instead.
-- @return string Returns the time as a formatted string only if a format was specified. Returns a table only if no format was specified. The table will contain these fields: number ms - milliseconds number s - seconds number m - minutes number h - hours  
function FormattedTime( float,  format) end

--- string.FromColor
-- @usage shared_m
-- Creates a string from a Color variable.
--
-- @param  color table  The color to put in the string.
-- @return string Output
function FromColor( color) end

--- string.GetChar
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Use either string.sub(str, index, index) or str[index].
-- @param  str string  The string that you will be searching with the supplied index.
-- @param  index number  The index's value of the string to be returned.
-- @return string str
function GetChar( str,  index) end

--- string.GetExtensionFromFilename
-- @usage shared_m
-- Returns extension of the file.
--
-- @param  file string  String eg. file-path to get the file extensions from.
-- @return string fileExtension
function GetExtensionFromFilename( file) end

--- string.GetFileFromFilename
-- @usage shared_m
-- Returns file name and extension.
--
-- @param  pathString string  The string eg. file-path to get the file-name from.
-- @return string The file name
function GetFileFromFilename( pathString) end

--- string.GetPathFromFilename
-- @usage shared_m
-- Returns the path only from a file's path.
--
-- @param  Inputstring string  String to get path from.
-- @return string Path
function GetPathFromFilename( Inputstring) end

--- string.gfind
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This function is removed in Lua versions later than what GMod is currently using. Use string.gmatch instead.
-- @param  data string  The string to search in
-- @param  pattern string  The pattern to search for
-- @return function The iterator function that can be used in a for-in loop
function gfind( data,  pattern) end

--- string.gmatch
-- @usage shared_m
-- Using Patterns, returns an iterator which will return either one value if no capture groups are defined, or any capture group matches.
--
-- @param  data string  The string to search in
-- @param  pattern string  The pattern to search for
-- @return function The iterator function that can be used in a for-in loop
function gmatch( data,  pattern) end

--- string.gsub
-- @usage shared_m
-- This functions main purpose is to replace certain character sequences in a string using Patterns.
--
-- @param  string string  String which should be modified.
-- @param  pattern string  The pattern that defines what should be matched and eventually be replaced.
-- @param  replacement string  In case of a string the matches sequence will be replaced with it. In case of a table, the matched sequence will be used as key and the table will tested for the key, if a value exists it will be used as replacement.  In case of a function all matches will be passed as parameters to the function, the return value(s) of the function will then be used as replacement.
-- @param  maxReplaces number  Maximum number of replacements to be made.
-- @return string replaceResult
-- @return number replaceCount
function gsub( string,  pattern,  replacement,  maxReplaces) end

--- string.Implode
-- @usage shared_m
-- Joins the values of a table together to form a string.
--
-- @param  separator="" string  The separator to insert between each piece.
-- @param  pieces table  The table of pieces to concatenate. The keys for these must be numeric and sequential.
-- @return string Imploded pieces
function Implode( separator,  pieces) end

--- string.JavascriptSafe
-- @usage shared_m
-- Escapes special characters for JavaScript in a string, making the string safe for inclusion in to JavaScript strings.
--
-- @param  str string  The string that should be escaped.
-- @return string The escaped string.
function JavascriptSafe( str) end

--- string.Left
-- @usage shared_m
-- Returns everything left of supplied place of that string.
--
-- @param  str string  The string to extract from.
-- @param  num number  Amount of chars relative to the beginning (starting from 1).
-- @return string Returns a string containing a specified number of characters from the left side of a string.
function Left( str,  num) end

--- string.len
-- @usage shared_m
-- Counts the number of characters in the string (length). This is equivalent to using the length operator (#).
--
-- @param  str string  The string to find the length of.
-- @return number Length of the string
function len( str) end

--- string.lower
-- @usage shared_m
-- Changes any upper-case letters in a string to lower-case letters.
--
-- @param  str string  The string to convert.
-- @return string The original string, with all uppercase letters replaced with their lowercase variants.
function lower( str) end

--- string.match
-- @usage shared_m
-- Finds a Pattern in a string.
--
-- @param  string string  String which should be searched in for matches.
-- @param  pattern string  The pattern that defines what should be matched.
-- @param  startPosition number  The start index to start the matching from, can be negative to start the match from a position relative to the end.
-- @return string Matched text
function match( string,  pattern,  startPosition) end

--- string.NiceSize
-- @usage shared_m
-- Converts a digital filesize to human-readable text.
--
-- @param  bytes number  The filesize in bytes.
-- @return string The human-readable filesize, in Bytes/KB/MB/GB (whichever is appropriate).
function NiceSize( bytes) end

--- string.NiceTime
-- @usage shared_m
-- Converts supplied number into string.
--
-- @param  num number  The number to convert into string.
-- @return string string
function NiceTime( num) end

--- string.PatternSafe
-- @usage shared_m
-- Escapes all special characters within a string, making the string safe for inclusion in a Lua pattern.
--
-- @param  str string  The string to be sanitized
-- @return string The string that has been sanitized for inclusion in Lua patterns
function PatternSafe( str) end

--- string.rep
-- @usage shared_m
-- Repeats a string by the provided number, with an optional separator.
--
-- @param  str string  The string to convert.
-- @param  repetitions number  Timer to repeat, this values gets rounded internally.
-- @param  separator="" string  String that will separate the repeated piece. Notice that it doesn't add this string to the start or the end of the result, only between the repeated parts.
-- @return string Repeated string.
function rep( str,  repetitions,  separator) end

--- string.Replace
-- @usage shared_m
-- Replaces all occurrences of the supplied second string.
--
-- @param  str string  The string we are seeking to replace an occurrence(s).
-- @param  find string  What we are seeking to replace.
-- @param  replace string  What to replace find with.
-- @return string string
function Replace( str,  find,  replace) end

--- string.reverse
-- @usage shared_m
-- Reverses a string.
--
-- @param  str string  The string to be reversed.
-- @return string reversed string
function reverse( str) end

--- string.Right
-- @usage shared_m
-- Returns the last n-th characters of the string.
--
-- @param  str string  The string to extract from.
-- @param  num number  Amount of chars relative to the end (starting from 1).
-- @return string Returns a string containing a specified number of characters from the right side of a string.
function Right( str,  num) end

--- string.SetChar
-- @usage shared_m
-- Sets the character at the specific index of the string.
--
-- @param  InputString string  The input string
-- @param  Index number  The character index, 1 is the first from left.
-- @param  ReplacementChar string  String to replace with.
-- @return string ModifiedString
function SetChar( InputString,  Index,  ReplacementChar) end

--- string.Split
-- @usage shared_m
-- Splits the string into a table of strings, separated by the second argument.
--
-- @param  Inputstring string  String to split
-- @param  Separator string  Character(s) to split with.
-- @return table Splitted table
function Split( Inputstring,  Separator) end

--- string.StartWith
-- @usage shared_m
-- Returns whether or not the first string starts with the second.
--
-- @param  inputStr string  String to check.
-- @param  start string  String to check with.
-- @return boolean Whether the first string starts with the second.
function StartWith( inputStr,  start) end

--- string.StripExtension
-- @usage shared_m
-- Removes the extension of a path.
--
-- @param  Inputstring string  The path to change.
-- @return string Modifiedstring
function StripExtension( Inputstring) end

--- string.sub
-- @usage shared_m
-- Returns a sub-string, starting from the character at position StartPos of the string (inclusive), and optionally ending at the character at position EndPos of the string (also inclusive). If EndPos is not given, the rest of the string is returned.
--
-- @param  string string  The string you'll take a sub-string out of.
-- @param  StartPos number  The position of the first character that will be included in the sub-string.
-- @param  EndPos=nil number  The position of the last character to be included in the sub-string.
-- @return string The substring.
function sub( string,  StartPos,  EndPos) end

--- string.ToColor
-- @usage shared_m
-- Fetches a Color type from a string.
--
-- @param  Inputstring string  The string to convert from.
-- @return table The output Color structure
function ToColor( Inputstring) end

--- string.ToMinutesSeconds
-- @usage shared_m
-- Returns given time in "MM:SS" format.
--
-- @param  time number  Time in seconds
-- @return string Formatted time
function ToMinutesSeconds( time) end

--- string.ToMinutesSecondsMilliseconds
-- @usage shared_m
-- Returns given time in "MM:SS:MS" format.
--
-- @param  time number  Time in seconds
-- @return string Formatted time
function ToMinutesSecondsMilliseconds( time) end

--- string.ToTable
-- @usage shared_m
-- Splits the string into characters and creates a sequential table.
--
-- @param  string string  The string you'll turn into a table.
function ToTable( string) end

--- string.Trim
-- @usage shared_m
-- Removes leading and trailing matches of a string.
--
-- @param  Inputstring string  The string to trim.
-- @param  Char=" " string  String to match.
-- @return string Modified string
function Trim( Inputstring,  Char) end

--- string.TrimLeft
-- @usage shared_m
-- Removes leading spaces/characters from a string.
--
-- @param  str string  String to trim
-- @param  char=" " string  Custom character to remove
-- @return string Trimmed string
function TrimLeft( str,  char) end

--- string.TrimRight
-- @usage shared_m
-- Removes trailing spaces/passed character from a string.
--
-- @param  str string  String to remove from
-- @param  char=" " string  Custom character to remove, default is a space
-- @return string Trimmed string
function TrimRight( str,  char) end

--- string.upper
-- @usage shared_m
-- Changes any lower-case letters in a string to upper-case letters.
--
-- @param  str string  The string to convert.
-- @return string A string representing the value of a string converted to upper-case.
function upper( str) end

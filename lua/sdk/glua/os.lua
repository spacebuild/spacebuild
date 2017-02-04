---
-- @description Library os
 module("os")

--- os.clock
-- @usage shared_m
-- Returns the approximate cpu time the application ran.
--
-- @return number runtime
function clock() end

--- os.date
-- @usage shared_m
-- Returns the date/time as a formatted string or in a table.
--
-- @param  format string  The format string. If this is equal to '*t' then this function will return a table, otherwise it will return a string. If this starts with an '!', the returned data will use the UTC timezone rather than the local timezone. See http://www.mkssoftware.com/docs/man3/strftime.3.asp for available format flags.  Not all flags are available on all operating systems and the result of using an invalid flag is undefined. This currently crashes the game on Windows. Most or all flags are available on OS X and Linux but considerably fewer are available on Windows. See http://msdn.microsoft.com/en-us/library/fe06s4ak.aspx for a list of available flags on Windows.
-- @param  time number  Time to use for the format.
-- @return string Formatted date   NOTE  This can be a table if the first argument equals to '*t'! 
function date( format,  time) end

--- os.difftime
-- @usage shared_m
-- Subtracts the second of the first value and rounds the result.
--
-- @param  timeA number  The first value.
-- @param  timeB number  The value to subtract.
-- @return number diffTime
function difftime( timeA,  timeB) end

--- os.time
-- @usage shared_m
-- Returns the system time in seconds past the unix epoch. If a table is supplied, the function attempts to build a system time with the specified table members.
--
-- @param  dateData=nil table  Table to generate the time from. This table's data is interpreted as being in the local timezone. See DateData structure
-- @return number Seconds passed since Unix epoch
function time( dateData) end

---
-- @description Library cookie
 module("cookie")

--- cookie.Delete
-- @usage shared_m
-- Deletes a cookie on the client.
--
-- @param  name string  The name of the cookie that you want to delete.
function Delete( name) end

--- cookie.GetNumber
-- @usage shared_m
-- Gets the value of a cookie on the client as a number.
--
-- @param  name string  The name of the cookie that you want to get.
-- @param  default=nil any  Value to return if the cookie does not exist.
-- @return number The cookie value
function GetNumber( name,  default) end

--- cookie.GetString
-- @usage shared_m
-- Gets the value of a cookie on the client as a string.
--
-- @param  name string  The name of the cookie that you want to get.
-- @param  default=nil any  Value to return if the cookie does not exist.
-- @return string The cookie value
function GetString( name,  default) end

--- cookie.Set
-- @usage shared_m
-- Sets the value of a cookie, which is saved automatically by the sql library.
--
-- @param  key string  The name of the cookie that you want to set.
-- @param  value string  Value to store in the cookie.
function Set( key,  value) end

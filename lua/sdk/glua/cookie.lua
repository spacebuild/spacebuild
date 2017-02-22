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

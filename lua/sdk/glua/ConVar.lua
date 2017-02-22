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
-- @description Library ConVar
 module("ConVar")

--- ConVar:GetBool
-- @usage shared
-- Tries to convert the current string value of a ConVar to a boolean.
--
-- @return boolean The boolean value of the console variable. If the variable is numeric and not 0, the result will be true. Otherwise the result will be false.
function GetBool() end

--- ConVar:GetDefault
-- @usage shared
-- Returns the default value of the ConVar
--
-- @return string The default value of the console variable.
function GetDefault() end

--- ConVar:GetFloat
-- @usage shared
-- Attempts to convert the ConVar value to a float
--
-- @return number The float value of the console variable. If the value cannot be converted to a float, it will return 0.
function GetFloat() end

--- ConVar:GetHelpText
-- @usage shared
-- Returns the help text assigned to that convar.
--
-- @return string The help text
function GetHelpText() end

--- ConVar:GetInt
-- @usage shared
-- Attempts to convert the ConVar value to a integer.
--
-- @return number The integer value of the console variable. If it fails to convert to an integer, it will return 0.  All float/decimal values will be rounded down. ( With math.floor )
function GetInt() end

--- ConVar:GetName
-- @usage shared
-- Returns the name of the ConVar.
--
-- @return string The name of the console variable.
function GetName() end

--- ConVar:GetString
-- @usage shared
-- Returns the current ConVar value as a string.
--
-- @return string The current console variable value as a string.
function GetString() end

--- ConVar:SetBool
-- @usage shared
-- Sets a ConVar's value to 1 or 0 based on the input boolean. This can only be ran on ConVars created from within Lua.
--
-- @param  value boolean  Value to set the ConVar to.
function SetBool( value) end

--- ConVar:SetFloat
-- @usage shared
-- Sets a ConVar's value to to the input number. This can only be ran on ConVars created from within Lua.
--
-- @param  value number  Value to set the ConVar to.
function SetFloat( value) end

--- ConVar:SetInt
-- @usage shared
-- Sets a ConVar's value to the input number after converting it to an integer. This can only be ran on ConVars created from within Lua.
--
-- @param  value number  Value to set the ConVar to.
function SetInt( value) end

--- ConVar:SetString
-- @usage shared
-- Sets a ConVar's value to the input string. This can only be ran on ConVars created from within Lua.
--
-- @param  value string  Value to set the ConVar to.
function SetString( value) end

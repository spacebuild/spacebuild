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
-- @description Library system
 module("system")

--- system.AppTime
-- @usage shared_m
-- Returns the total uptime of the current application.
--
-- @return number Seconds of game uptime as an integer.
function AppTime() end

--- system.BatteryPower
-- @usage shared_m
-- Returns the current battery power.
--
-- @return number 0-100 if on battery power. If plugged in, the value will be 255 regardless of charging state.
function BatteryPower() end

--- system.FlashWindow
-- @usage client_m
-- Flashes the window. Currently works only on Windows.
--
function FlashWindow() end

--- system.GetCountry
-- @usage shared_m
-- Returns the country code of this computer, determined by the localisation settings of the OS.
--
-- @return string Two-letter country code, using ISO 3166-1 standard.
function GetCountry() end

--- system.HasFocus
-- @usage shared_m
-- Returns whether or not the game window has focus.
--
-- @return boolean Whether or not the game window has focus.
function HasFocus() end

--- system.IsLinux
-- @usage shared_m
-- Returns whether the current OS is Linux.
--
-- @return boolean Whether or not the game is running on Linux.
function IsLinux() end

--- system.IsOSX
-- @usage shared_m
-- Returns whether the current OS is OSX.
--
-- @return boolean Whether or not the game is running on OSX.
function IsOSX() end

--- system.IsWindowed
-- @usage client_m
-- Returns whether the game is being run in a window or in fullscreen (you can change this by opening the menu, clicking 'Options', then clicking the 'Video' tab, and changing the Display Mode using the dropdown menu):
--
-- @return boolean Is the game running in a window?
function IsWindowed() end

--- system.IsWindows
-- @usage shared_m
-- Returns whether the current OS is Windows.
--
-- @return boolean Whether the system the game runs on is Windows or not.
function IsWindows() end

--- system.SteamTime
-- @usage shared_m
-- Returns the synchronized steam time. This is the number of seconds since the Unix epoch.
--
-- @return number Current steam-synchronized Unix time.
function SteamTime() end

--- system.UpTime
-- @usage shared_m
-- Returns the total uptime of operating system.
--
-- @return number systemUpTime
function UpTime() end

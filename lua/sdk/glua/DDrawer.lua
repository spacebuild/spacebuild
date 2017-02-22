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
-- @description Library DDrawer
 module("DDrawer")

--- DDrawer:GetOpenSize
-- @usage client
-- Return the Open Size of DDrawer.
--
-- @return number Open size.
function GetOpenSize() end

--- DDrawer:GetOpenTime
-- @usage client
-- Return the Open Time of DDrawer.
--
-- @return number Time in seconds.
function GetOpenTime() end

--- DDrawer:SetOpenSize
-- @usage client
-- Set the height of DDrawer
--
-- @param  Value number  Height of DDrawer. Default is 100.
function SetOpenSize( Value) end

--- DDrawer:SetOpenTime
-- @usage client
-- Set the time (in seconds) for DDrawer to open.
--
-- @param  value number  Length in seconds. Default is 0.3
function SetOpenTime( value) end

--- DDrawer:Toggle
-- @usage client
-- Toggle the DDrawer.
--
function Toggle() end

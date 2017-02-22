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
-- @description Library DNotify
 module("DNotify")

--- DNotify:GetLife
-- @usage client
-- Returns the display time in seconds of the DNotify. This is set with
--DNotify:SetLife.
--
-- @return number The display time in seconds.
function GetLife() end

--- DNotify:SetLife
-- @usage client
-- Sets the display time in seconds for the DNotify.
--
-- @param  time number  The time in seconds.
function SetLife( time) end

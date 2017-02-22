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
-- @description Library DProgress
 module("DProgress")

--- DProgress:GetFraction
-- @usage client
-- Returns the progress bar's fraction. 0 is 0% and 1 is 100%.
--
-- @return number Current fraction of the progress bar.
function GetFraction() end

--- DProgress:SetFraction
-- @usage client
-- Sets the fraction of the progress bar. 0 is 0% and 1 is 100%.
--
-- @param  fraction number  Fraction of the progress bar. Range is 0 to 1 (0% to 100%).
function SetFraction( fraction) end

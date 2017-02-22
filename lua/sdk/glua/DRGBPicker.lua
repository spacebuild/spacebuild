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
-- @description Library DRGBPicker
 module("DRGBPicker")

--- DRGBPicker:GetRGB
-- @usage client
-- Returns the color currently set on the color picker.
--
-- @return table The color set on the color picker, see Color structure.
function GetRGB() end

--- DRGBPicker:OnChange
-- @usage client
-- Function which is called when the cursor is clicked and/or moved on the color picker. Meant to be overridden.
--
-- @param  col table  The color that is selected on the color picker (Color structure form).
function OnChange( col) end

--- DRGBPicker:SetRGB
-- @usage client
-- Sets the color stored in the color picker.
--
-- @param  color table  The color to set, see Color structure.
function SetRGB( color) end

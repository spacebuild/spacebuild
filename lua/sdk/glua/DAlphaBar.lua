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
-- @description Library DAlphaBar
 module("DAlphaBar")

--- DAlphaBar:GetBarColor
-- @usage client
-- Returns the base color of the alpha bar. This is the color for which the alpha channel is being modified.
--
-- @return table The current base color.
function GetBarColor() end

--- DAlphaBar:GetValue
-- @usage client
-- Returns the alpha value of the alpha bar.
--
-- @return number The current alpha value.
function GetValue() end

--- DAlphaBar:OnChange
-- @usage client
-- Called when user changes the desired alpha value with the control.
--
-- @param  alpha number  The new alpha value
function OnChange( alpha) end

--- DAlphaBar:SetBarColor
-- @usage client
-- Sets the base color of the alpha bar. This is the color for which the alpha channel is being modified.
--
-- @param  clr table  The new Color structure to set. See Color.
function SetBarColor( clr) end

--- DAlphaBar:SetValue
-- @usage client
-- Sets the alpha value or the alpha bar.
--
-- @param  alpha number  The new alpha value to set
function SetValue( alpha) end

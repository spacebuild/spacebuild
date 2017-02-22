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
-- @description Library DPanel
 module("DPanel")

--- DPanel:GetBackgroundColor
-- @usage client
-- Returns the panel's background color.
--
-- @return table Color of the panel's background.
function GetBackgroundColor() end

--- DPanel:GetDisabled
-- @usage client
-- Returns whether or not the panel is disabled.
--
-- @return boolean True if the panel is disabled (mouse input disabled and background alpha set to 75), false if its enabled (mouse input enabled and background alpha set to 255).
function GetDisabled() end

--- DPanel:GetDrawBackground
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use DPanel:GetPaintBackground instead.
-- @return boolean True if the panel background is drawn, false otherwise.
function GetDrawBackground() end

--- DPanel:GetPaintBackground
-- @usage client
-- Returns whether or not the panel background is being drawn.
--
-- @return boolean True if the panel background is drawn, false otherwise.
function GetPaintBackground() end

--- DPanel:SetBackgroundColor
-- @usage client
-- Sets the background color of the panel.
--
-- @param  color table  The background color.
function SetBackgroundColor( color) end

--- DPanel:SetDisabled
-- @usage client
-- Sets whether or not to disable the panel.
--
-- @param  disabled boolean  True to disable the panel (mouse input disabled and background alpha set to 75), false to enable it (mouse input enabled and background alpha set to 255).
function SetDisabled( disabled) end

--- DPanel:SetDrawBackground
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use DPanel:SetPaintBackground instead.
-- @param  draw boolean  True to show the panel's background, false to hide it.
function SetDrawBackground( draw) end

--- DPanel:SetPaintBackground
-- @usage client
-- Sets whether or not to paint/draw the panel background.
--
-- @param  paint boolean  True to show the panel's background, false to hide it.
function SetPaintBackground( paint) end

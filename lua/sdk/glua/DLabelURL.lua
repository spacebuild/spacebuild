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
-- @description Library DLabelURL
 module("DLabelURL")

--- DLabelURL:GetColor
-- @usage client
-- Gets the current text color of the DLabelURL. Same as DLabelURL:GetTextColor.
--
-- @return table The current text Color.
function GetColor() end

--- DLabelURL:GetTextColor
-- @usage client
-- Gets the current text color of the DLabelURL. Same as DLabelURL:GetColor.
--
-- @return table The current text Color.
function GetTextColor() end

--- DLabelURL:SetColor
-- @usage client
-- Alias of DLabelURL:SetTextColor.
--
-- @param  col table  The Color to use.
function SetColor( col) end

--- DLabelURL:SetTextColor
-- @usage client
-- Sets the text color of the DLabelURL. This should only be used immediately after it is created, and otherwise Panel:SetFGColor.
--
-- @param  col table  The Color to use.
function SetTextColor( col) end

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
-- @description Library DCheckBox
 module("DCheckBox")

--- DCheckBox:DoClick
-- @usage client
-- Called when the checkbox is clicked by a user. If you are overriding this, you must call DCheckBox:Toggle, else the checkbox will not respond to user clicks.
--
function DoClick() end

--- DCheckBox:GetChecked
-- @usage client
-- Gets the checked state of the checkbox.
--
-- @return boolean Whether the box is checked or not.
function GetChecked() end

--- DCheckBox:IsEditing
-- @usage client
-- Returns whether the state of the checkbox is being edited. This means whether the user is currently clicking (mouse-down) on the checkbox, and applies to both the left and right mouse buttons.
--
-- @return boolean Whether the checkbox is being clicked.
function IsEditing() end

--- DCheckBox:OnChange
-- @usage client
-- Called when the "checked" state is changed.
--
-- @param  bVal boolean  Whether the CheckBox is checked or not.
function OnChange( bVal) end

--- DCheckBox:SetChecked
-- @usage client
-- Sets the checked state of the checkbox. Does not call the checkbox's DCheckBox:OnChange and Panel:ConVarChanged methods, unlike DCheckBox:SetValue.
--
-- @param  checked boolean  Whether the box should be checked or not.
function SetChecked( checked) end

--- DCheckBox:SetValue
-- @usage client
-- Sets the checked state of the checkbox, and calls the checkbox's DCheckBox:OnChange and Panel:ConVarChanged methods.
--
-- @param  checked boolean  Whether the box should be checked or not.
function SetValue( checked) end

--- DCheckBox:Toggle
-- @usage client
-- Toggles the checked state of the checkbox, and calls the checkbox's DCheckBox:OnChange and Panel:ConVarChanged methods. This is called by DCheckBox:DoClick.
--
function Toggle() end

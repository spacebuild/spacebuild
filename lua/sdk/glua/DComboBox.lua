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
-- @description Library DComboBox
 module("DComboBox")

--- DComboBox:AddChoice
-- @usage client
-- Adds a choice to the combo box
--
-- @param  value string  The text show to the user.
-- @param  data=nil any  The data accompanying this string. If left empty, the value argument is used instead.
-- @param  select=false boolean  Should this be the default selected text show to the user or not.
function AddChoice( value,  data,  select) end

--- DComboBox:ChooseOption
-- @usage client
-- Selects a combo box option by its index and changes the text displayed at the top of the combo box.
--
-- @param  value string  The text to display at the top of the combo box.
-- @param  index number  The option index.
function ChooseOption( value,  index) end

--- DComboBox:ChooseOptionID
-- @usage client
-- Selects an option within a combo box based on its table index.
--
-- @param  index number  Selects the option with given index.
function ChooseOptionID( index) end

--- DComboBox:Clear
-- @usage client
-- Clears the combo box's text value, choices, and data values.
--
function Clear() end

--- DComboBox:CloseMenu
-- @usage client
-- Closes the combo box menu. Called when the combo box is clicked while open.
--
function CloseMenu() end

--- DComboBox:GetOptionData
-- @usage client
-- Returns an option's data based on the given index.
--
-- @param  index number  The option index.
-- @return any The option's data value.
function GetOptionData( index) end

--- DComboBox:GetOptionText
-- @usage client
-- Returns an option's text based on the given index.
--
-- @param  index number  The option index.
-- @return string The option's text value.
function GetOptionText( index) end

--- DComboBox:GetSelected
-- @usage client
-- Returns the currently selected option's text and data
--
-- @return string The option's text value.
-- @return any The option's stored data.
function GetSelected() end

--- DComboBox:GetSelectedID
-- @usage client
-- Returns the index (ID) of the currently selected option.
--
-- @return number The ID of the currently selected option.
function GetSelectedID() end

--- DComboBox:IsMenuOpen
-- @usage client
-- Returns whether or not the combo box's menu is opened.
--
-- @return boolean True if the menu is open, false otherwise.
function IsMenuOpen() end

--- DComboBox:OnSelect
-- @usage client
-- Internal function which is called when an option in the combo box is selected. This function does nothing by default and is meant to be overridden in order to make the combo box functional.
--
-- @param  index number  The table index of the option.
-- @param  value string  The name of the option.
-- @param  data any  The data assigned to the option.
function OnSelect( index,  value,  data) end

--- DComboBox:OpenMenu
-- @usage client
-- Opens the combo box drop down menu. Called when the combo box is clicked.
--
function OpenMenu() end

--- DComboBox:SetValue
-- @usage client
-- Sets the text shown in the combo box when the menu is not collapsed.
--
-- @param  value string  The text in the DComboBox.
function SetValue( value) end

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
-- @description Library DForm
 module("DForm")

--- DForm:AddItem
-- @usage client
-- Adds one or two items to the DForm.
--If this method is called with only one argument, it is added to the bottom of the form. If two arguments are passed, they are placed side-by-side at the bottom of the form.
--
-- @param  left Panel  Left-hand element to add to the DForm.
-- @param  right Panel  Right-hand element to add to the DForm.
function AddItem( left,  right) end

--- DForm:Button
-- @usage client
-- Adds a DButton onto the DForm
--
-- @param  text string  The text on the button
-- @param  concmd string  The concommand to run when the button is clicked
-- @param  concmdargs vararg  The arguments to pass on to the concommand when the button is clicked
-- @return Panel The created DButton
function Button( text,  concmd,  concmdargs) end

--- DForm:CheckBox
-- @usage client
-- Adds a DCheckBoxLabel onto the DForm
--
-- @param  label string  The label to be set next to the check box
-- @param  convar string  The console variable to change when this is changed
-- @return Panel The created DCheckBoxLabel
function CheckBox( label,  convar) end

--- DForm:Clear
-- @usage client
-- Clears all items from the DForm
--
function Clear() end

--- DForm:ComboBox
-- @usage client
-- Adds a DComboBox onto the DForm
--
-- @param  title string  Text to the left of the combo box
-- @param  convar string  Console variable to change when the user selects something from the dropdown.
-- @return Panel The created DComboBox
-- @return Panel The created DLabel
function ComboBox( title,  convar) end

--- DForm:ControlHelp
-- @usage client
-- Adds a DLabel onto the DForm. Unlike DForm:Help, this is indented and is colored blue, depending on the derma skin.
--
-- @param  help string  The help message to be displayed.
-- @return Panel The created DLabel
function ControlHelp( help) end

--- DForm:Help
-- @usage client
-- Adds a DLabel onto the DForm as a helper
--
-- @param  help string  The help message to be displayed
-- @return Panel The created DLabel
function Help( help) end

--- DForm:ListBox
-- @usage client
-- Adds a DListBox onto the DForm
--
-- @param  label string  The label to set on the DListBox
-- @return Panel The created DListBox
-- @return Panel The created DLabel
function ListBox( label) end

--- DForm:NumberWang
-- @usage client
-- Adds a DNumberWang onto the DForm
--
-- @param  label string  The label to be placed next to the DNumberWang
-- @param  convar string  The console variable to change when the slider is changed
-- @param  min number  The minimum value of the slider
-- @param  max number  The maximum value of the slider
-- @param  decimals=nil number  The number of decimals to allow in the slider (Optional)
-- @return Panel The created DNumberWang
-- @return Panel The created DLabel
function NumberWang( label,  convar,  min,  max,  decimals) end

--- DForm:NumSlider
-- @usage client
-- Adds a DNumSlider onto the DForm
--
-- @param  label string  The label of the DNumSlider
-- @param  convar string  The console variable to change when the slider is changed
-- @param  min number  The minimum value of the slider
-- @param  max number  The maximum value of the slider
-- @param  decimals=nil number  The number of decimals to allow on the slider. (Optional)
-- @return Panel The created DNumSlider
function NumSlider( label,  convar,  min,  max,  decimals) end

--- DForm:PanelSelect
-- @usage client
-- Creates a DPanelSelect and docks it to the top of the DForm.
--
-- @return Panel The created DPanelSelect.
function PanelSelect() end

--- DForm:SetName
-- @usage client
-- Sets the title (header) name of the DForm. This is Label until set.
--
-- @param  name string  The new header name.
function SetName( name) end

--- DForm:TextEntry
-- @usage client
-- Adds a DTextEntry to a DForm
--
-- @param  label string  The label to be next to the text entry
-- @param  convar string  The console variable to be changed when the text entry is changed
-- @return Panel The created DTextEntry
-- @return Panel The created DLabel
function TextEntry( label,  convar) end

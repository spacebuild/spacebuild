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
-- @description Library DProperty_Combo
 module("DProperty_Combo")

--- DProperty_Combo:AddChoice
-- @usage client
-- Add a choice to your combo control.
--
-- @param  Text string  Shown text.
-- @param  data any  Stored Data.
-- @param  select=false boolean  Select this element?
function AddChoice( Text,  data,  select) end

--- DProperty_Combo:DataChanged
-- @usage client
-- Called after the user selects a new value.
--
-- @param  data any  The new data that was selected.
function DataChanged( data) end

--- DProperty_Combo:SetSelected
-- @usage client
-- Set the selected option.
--
-- @param  Id number  Id of the choice to be selected.
function SetSelected( Id) end

--- DProperty_Combo:Setup
-- @usage client
-- Sets up a combo control.
--
-- @param  prop="Combo" string  The name of DProperty sub control to add.
-- @param  data={ text = "Select..." } table  Data to use to set up the combo box control. Structure:   string text - The default label for this combo box  table values - The values to add to the combo box
function Setup( prop,  data) end

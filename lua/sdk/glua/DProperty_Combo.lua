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

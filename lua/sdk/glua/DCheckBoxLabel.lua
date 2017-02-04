---
-- @description Library DCheckBoxLabel
 module("DCheckBoxLabel")

--- DCheckBoxLabel:GetChecked
-- @usage client
-- Gets the checked state of the checkbox. This calls the checkbox's DCheckBox:GetChecked function.
--
-- @return boolean Whether the box is checked or not.
function GetChecked() end

--- DCheckBoxLabel:OnChange
-- @usage client
-- Called when the "checked" state is changed.
--
-- @param  bVal boolean  Whether the checkbox is checked or unchecked.
function OnChange( bVal) end

--- DCheckBoxLabel:SetChecked
-- @usage client
-- Sets the checked state of the checkbox. Does not call DCheckBoxLabel:OnChange or Panel:ConVarChanged, unlike DCheckBoxLabel:SetValue.
--
-- @param  checked boolean  Whether the box should be checked or not.
function SetChecked( checked) end

--- DCheckBoxLabel:SetText
-- @usage client
-- Set the Text of the DCheckBoxLabel VGUI element.
--
-- @param  text string  The text.
function SetText( text) end

--- DCheckBoxLabel:SetTextColor
-- @usage client
-- Sets the text color for the DCheckBoxLabel.
--
-- @param  color table  The text color. Uses the Color structure.
function SetTextColor( color) end

--- DCheckBoxLabel:SetValue
-- @usage client
-- Sets the checked state of the checkbox, and calls DCheckBoxLabel:OnChange and the checkbox's Panel:ConVarChanged methods.
--
-- @param  checked boolean  Whether the box should be checked or not.
function SetValue( checked) end

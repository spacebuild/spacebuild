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

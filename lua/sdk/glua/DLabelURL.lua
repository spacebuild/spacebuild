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

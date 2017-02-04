---
-- @description Library DAlphaBar
 module("DAlphaBar")

--- DAlphaBar:GetBarColor
-- @usage client
-- Returns the base color of the alpha bar. This is the color for which the alpha channel is being modified.
--
-- @return table The current base color.
function GetBarColor() end

--- DAlphaBar:GetValue
-- @usage client
-- Returns the alpha value of the alpha bar.
--
-- @return number The current alpha value.
function GetValue() end

--- DAlphaBar:OnChange
-- @usage client
-- Called when user changes the desired alpha value with the control.
--
-- @param  alpha number  The new alpha value
function OnChange( alpha) end

--- DAlphaBar:SetBarColor
-- @usage client
-- Sets the base color of the alpha bar. This is the color for which the alpha channel is being modified.
--
-- @param  clr table  The new Color structure to set. See Color.
function SetBarColor( clr) end

--- DAlphaBar:SetValue
-- @usage client
-- Sets the alpha value or the alpha bar.
--
-- @param  alpha number  The new alpha value to set
function SetValue( alpha) end

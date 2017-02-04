---
-- @description Library DNumberWang
 module("DNumberWang")

--- DNumberWang:GetFraction
-- @usage client
-- Returns a fraction representing the current number selector value to number selector min/max range ratio. If argument val is supplied, that number will be computed instead.
--
-- @param  val number  The fraction numerator.
function GetFraction( val) end

--- DNumberWang:GetValue
-- @usage client
-- Returns the numeric value inside the number selector.
--
-- @return number The numeric value.
function GetValue() end

--- DNumberWang:HideWang
-- @usage client
-- Hides the number selector arrows.
--
function HideWang() end

--- DNumberWang:OnValueChanged
-- @usage client
-- Internal function which is called when the number selector value is changed. This function is empty by default so it needs to be overridden in order to provide functionality.
--
-- @param  val number  The new value of the number selector.
function OnValueChanged( val) end

--- DNumberWang:SetDecimals
-- @usage client
-- Sets the amount of decimal places allowed in the number selector.
--
-- @param  num number  The amount of decimal places.
function SetDecimals( num) end

--- DNumberWang:SetFraction
-- @usage client
-- Sets the value of the number selector based on the given fraction number.
--
-- @param  val number  The fraction of the number selector's range.
function SetFraction( val) end

--- DNumberWang:SetMax
-- @usage client
-- Sets the maximum numeric value allowed by the number selector.
--
-- @param  max number  The maximum value.
function SetMax( max) end

--- DNumberWang:SetMin
-- @usage client
-- Sets the minimum numeric value allowed by the number selector.
--
-- @param  min number  The minimum value.
function SetMin( min) end

--- DNumberWang:SetMinMax
-- @usage client
-- Sets the minimum and maximum value allowed by the number selector.
--
-- @param  min number  The minimum value.
-- @param  max number  The maximum value.
function SetMinMax( min,  max) end

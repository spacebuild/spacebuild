---
-- @description Library DNumSlider
 module("DNumSlider")

--- DNumSlider:OnValueChanged
-- @usage client
-- Called when the value of the slider is changed, through code or changing the slider.
--You should override this instead of DNumSlider:ValueChanged
--
-- @param  value number  The new value of the DNumSlider
function OnValueChanged( value) end

--- DNumSlider:SetMin
-- @usage client
-- Sets the minimum value for the slider
--
-- @param  min number  The value to set as minimum for the slider.
function SetMin( min) end

--- DNumSlider:ValueChanged
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  value number  The value the slider has been changed to.
function ValueChanged( value) end

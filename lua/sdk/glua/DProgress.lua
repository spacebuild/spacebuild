---
-- @description Library DProgress
 module("DProgress")

--- DProgress:GetFraction
-- @usage client
-- Returns the progress bar's fraction. 0 is 0% and 1 is 100%.
--
-- @return number Current fraction of the progress bar.
function GetFraction() end

--- DProgress:SetFraction
-- @usage client
-- Sets the fraction of the progress bar. 0 is 0% and 1 is 100%.
--
-- @param  fraction number  Fraction of the progress bar. Range is 0 to 1 (0% to 100%).
function SetFraction( fraction) end

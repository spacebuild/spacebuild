---
-- @description Library DNotify
 module("DNotify")

--- DNotify:GetLife
-- @usage client
-- Returns the display time in seconds of the DNotify. This is set with
--DNotify:SetLife.
--
-- @return number The display time in seconds.
function GetLife() end

--- DNotify:SetLife
-- @usage client
-- Sets the display time in seconds for the DNotify.
--
-- @param  time number  The time in seconds.
function SetLife( time) end

---
-- @description Library DDrawer
 module("DDrawer")

--- DDrawer:GetOpenSize
-- @usage client
-- Return the Open Size of DDrawer.
--
-- @return number Open size.
function GetOpenSize() end

--- DDrawer:GetOpenTime
-- @usage client
-- Return the Open Time of DDrawer.
--
-- @return number Time in seconds.
function GetOpenTime() end

--- DDrawer:SetOpenSize
-- @usage client
-- Set the height of DDrawer
--
-- @param  Value number  Height of DDrawer. Default is 100.
function SetOpenSize( Value) end

--- DDrawer:SetOpenTime
-- @usage client
-- Set the time (in seconds) for DDrawer to open.
--
-- @param  value number  Length in seconds. Default is 0.3
function SetOpenTime( value) end

--- DDrawer:Toggle
-- @usage client
-- Toggle the DDrawer.
--
function Toggle() end

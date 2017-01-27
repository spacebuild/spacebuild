---
-- @description Library DKillIcon
 module("DKillIcon")

--- DKillIcon:GetName
-- @usage client
-- Gets the killicon being shown.
--
-- @return string The name of the killicon currently being displayed.
function GetName() end

--- DKillIcon:SetName
-- @usage client
-- Sets the killicon to be displayed. You should call DKillIcon:SizeToContents following this.
--
-- @param  iconName string  The name of the killicon to be displayed.
function SetName( iconName) end

--- DKillIcon:SizeToContents
-- @usage client
-- Resizes the DKillIcon to fit the icon currently being shown. You should call this after DKillIcon:SetName.
--
function SizeToContents() end

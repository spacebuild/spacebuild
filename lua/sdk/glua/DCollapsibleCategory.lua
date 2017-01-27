---
-- @description Library DCollapsibleCategory
 module("DCollapsibleCategory")

--- DCollapsibleCategory:GetExpanded
-- @usage client
-- Returns whether the DCollapsibleCategory is expanded or not.
--
-- @return boolean If expanded it will return true.
function GetExpanded() end

--- DCollapsibleCategory:OnToggle
-- @usage client
-- Called by DCollapsibleCategory:Toggle.
--
function OnToggle() end

--- DCollapsibleCategory:SetAnimTime
-- @usage client
-- Sets the time in seconds it takes to expand the DCollapsibleCategory
--
-- @param  time number  The time in seconds it takes to expand
function SetAnimTime( time) end

--- DCollapsibleCategory:SetContents
-- @usage client
-- Sets the contents of the DCollapsibleCategory.
--
-- @param  pnl Panel  The panel, containing the contents for the DCollapsibleCategory, mostly an DScrollPanel
function SetContents( pnl) end

--- DCollapsibleCategory:SetExpanded
-- @usage client
-- Sets whether the DCollapsibleCategory is expanded or not upon opening the container
--
-- @param  expanded=true boolean  Whether it shall be expanded or not by default
function SetExpanded( expanded) end

--- DCollapsibleCategory:SetLabel
-- @usage client
-- Sets the name of the DCollapsibleCategory.
--
-- @param  label string  The label/name of the DCollapsibleCategory.
function SetLabel( label) end

--- DCollapsibleCategory:Toggle
-- @usage client
-- Toggles the expanded state of the DCollapsibleCategory.
--
function Toggle() end

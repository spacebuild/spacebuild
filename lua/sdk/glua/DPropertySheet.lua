---
-- @description Library DPropertySheet
 module("DPropertySheet")

--- DPropertySheet:AddSheet
-- @usage client
-- Adds a new tab.
--
-- @param  name string  Name of the tab
-- @param  pnl Panel  Panel to be used as contents of the tab. This normally should be a DPanel
-- @param  icon=nil string  Icon for the tab. This will ideally be a silkicon, but any material name can be used.
-- @param  noStretchX=false boolean  Should DPropertySheet try to fill itself with given panel horizontally.
-- @param  noStretchY=false boolean  Should DPropertySheet try to fill itself with given panel vertically.
-- @param  tooltip=nil string  Tooltip for the tab when user hovers over it with his cursor
-- @return table A table containing the created DTab on its "Tab" key.
function AddSheet( name,  pnl,  icon,  noStretchX,  noStretchY,  tooltip) end

--- DPropertySheet:SetFadeTime
-- @usage client
-- Sets the amount of time (in seconds) it takes to fade between tabs.
--
-- @param  time=0.1 number  The amount of time it takes (in seconds) to fade between tabs.
function SetFadeTime( time) end

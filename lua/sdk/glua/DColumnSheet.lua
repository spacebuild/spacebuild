---
-- @description Library DColumnSheet
 module("DColumnSheet")

--- DColumnSheet:AddSheet
-- @usage client
-- Adds a new column/tab.
--
-- @param  name string  Name of the column/tab
-- @param  pnl Panel  Panel to be used as contents of the tab. This normally would be a DPanel
-- @param  icon=nil string  Icon for the tab. This will ideally be a silkicon, but any material name can be used.
function AddSheet( name,  pnl,  icon) end

--- DColumnSheet:SetActiveButton
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  active Panel  The button to make active button
function SetActiveButton( active) end

--- DColumnSheet:UseButtonOnlyStyle
-- @usage client
-- Makes the tabs/buttons show only the image and no text.
--
function UseButtonOnlyStyle() end

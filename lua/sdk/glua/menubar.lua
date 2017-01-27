---
-- @description Library menubar
 module("menubar")

--- menubar.Init
-- @usage client
-- Creates the menu bar ( The bar at the top of the screen when holding C or Q in sandbox ) and docks it to the top of the screen. It will not appear.
--Calling this multiple times will NOT remove previous panel.
--
function Init() end

--- menubar.IsParent
-- @usage client
-- Checks if the supplied panel is parent to the menubar
--
-- @param  pnl Panel  The panel to check
-- @return boolean Is parent or not
function IsParent( pnl) end

--- menubar.ParentTo
-- @usage client
-- Parents the menubar to the panel and displays the menubar.
--
-- @param  pnl Panel  The panel to parent to
function ParentTo( pnl) end

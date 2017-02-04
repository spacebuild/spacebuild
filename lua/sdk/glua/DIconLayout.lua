---
-- @description Library DIconLayout
 module("DIconLayout")

--- DIconLayout:Layout
-- @usage client
-- Resets layout vars before calling Panel:InvalidateLayout. This is called when children are added or removed, and must be called when the spacing, border or layout direction is changed.
--
function Layout() end

--- DIconLayout:SetBorder
-- @usage client
-- Sets the internal border (padding) within the DIconLayout. This will not change its size, only the positioning of children. You must call DIconLayout:Layout in order for the changes to take effect.
--
-- @param  width number  The border (padding) inside the DIconLayout.
function SetBorder( width) end

--- DIconLayout:SetSpaceX
-- @usage client
-- Sets the horizontal (x) spacing between children within the DIconLayout. You must call DIconLayout:Layout in order for the changes to take effect.
--
-- @param  xSpacing number  The width of the gap between child objects.
function SetSpaceX( xSpacing) end

--- DIconLayout:SetSpaceY
-- @usage client
-- Sets the vertical (y) spacing between children within the DIconLayout. You must call DIconLayout:Layout in order for the changes to take effect.
--
-- @param  ySpacing number  The vertical gap between rows in the DIconLayout.
function SetSpaceY( ySpacing) end

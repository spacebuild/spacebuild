---
-- @description Library DScrollPanel
 module("DScrollPanel")

--- DScrollPanel:AddItem
-- @usage client
-- Parents the passed panel to the DScrollPanel's canvas.
--
-- @param  pnl Panel  The panel to add.
function AddItem( pnl) end

--- DScrollPanel:Clear
-- @usage client
-- Clears all childs from the DScrollPanel
--
function Clear() end

--- DScrollPanel:GetCanvas
-- @usage client
-- Returns the canvas ( The panel all child panels are parented to ) of the DScrollPanel.
--
-- @return Panel The canvas
function GetCanvas() end

--- DScrollPanel:GetPadding
-- @usage client
-- Gets the DScrollPanels padding
--
-- @return number DScrollPanels padding
function GetPadding() end

--- DScrollPanel:GetVBar
-- @usage client
-- Returns the vertical scroll bar of the panel.
--
-- @return Panel The DVScrollBar.
function GetVBar() end

--- DScrollPanel:InnerWidth
-- @usage client
-- Return the width of the DScrollPanel's canvas.
--
-- @return number The width of the DScrollPanel's canvas
function InnerWidth() end

--- DScrollPanel:Rebuild
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function Rebuild() end

--- DScrollPanel:ScrollToChild
-- @usage client
-- Scrolls to the given child
--
-- @param  panel Panel  The panel to scroll to, must be a child of the DScrollPanel.
function ScrollToChild( panel) end

--- DScrollPanel:SetCanvas
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  canvas Panel  The new canvas
function SetCanvas( canvas) end

--- DScrollPanel:SetPadding
-- @usage client
-- Sets the DScrollPanel's padding. This function appears to be unused.
--
-- @param  padding number  The padding of the DScrollPanel.
function SetPadding( padding) end

--- DScrollPanel:SizeToContents
-- @usage client
-- Sets the DScrollPanels size to the size of the contents
--
function SizeToContents() end

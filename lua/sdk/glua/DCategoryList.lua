---
-- @description Library DCategoryList
 module("DCategoryList")

--- DCategoryList:Add
-- @usage client
-- Adds a DCollapsibleCategory to the list.
--
-- @param  categoryName string  The name of the category to add.
function Add( categoryName) end

--- DCategoryList:AddItem
-- @usage client
-- Adds an element to the list.
--
-- @param  element Panel  VGUI element to add to the list.
function AddItem( element) end

--- DCategoryList:UnselectAll
-- @usage client
-- Calls Panel:UnselectAll on all child elements, if they have it.
--
function UnselectAll() end

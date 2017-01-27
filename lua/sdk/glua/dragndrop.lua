---
-- @description Library dragndrop
 module("dragndrop")

--- dragndrop.CallReceiverFunction
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  bDoDrop boolean  true if the mouse was released, false if we right clicked.
-- @param  command number  The command value. This should be the ID of the clicked dropdown menu ( if right clicked, or nil )
-- @param  mx number  The local to the panel mouse cursor X position when the click happened.
-- @param  my number  The local to the panel mouse cursor Y position when the click happened.
function CallReceiverFunction( bDoDrop,  command,  mx,  my) end

--- dragndrop.Clear
-- @usage client_m
-- Clears all the internal drag'n'drop variables.
--
function Clear() end

--- dragndrop.Drop
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function Drop() end

--- dragndrop.GetDroppable
-- @usage client_m
-- Returns a table of currently dragged panels.
--
-- @param  name=nil string  If set, the function will return only the panels with this Panel:Droppable name.
-- @return table A table of all panels that are being currently dragged, if any.
function GetDroppable( name) end

--- dragndrop.HandleDroppedInGame
-- @usage client_m
-- If returns true, calls dragndrop.StopDragging in dragndrop.Drop. Seems to be broken and does nothing. Is it for override?
--
function HandleDroppedInGame() end

--- dragndrop.HoverThink
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function HoverThink() end

--- dragndrop.IsDragging
-- @usage client_m
-- Returns whether the user is dragging something with the drag'n'drop system.
--
-- @return boolean True if the user is dragging something with the drag'n'drop system.
function IsDragging() end

--- dragndrop.StartDragging
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function StartDragging() end

--- dragndrop.StopDragging
-- @usage client_m
-- Stops the drag'n'drop and calls dragndrop.Clear.
--
function StopDragging() end

--- dragndrop.Think
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function Think() end

--- dragndrop.UpdateReceiver
-- @usage client_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function UpdateReceiver() end

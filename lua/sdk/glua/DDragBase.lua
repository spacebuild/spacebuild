---
-- @description Library DDragBase
 module("DDragBase")

--- DDragBase:MakeDroppable
-- @usage client
-- Makes the panel a receiver for any droppable panel with the same DnD name.
--
-- @param  name string  The unique name for the receiver slot. Only droppable panels with the same DnD name as this can be dropped on the panel.
-- @param  allowCopy boolean  Whether or not to allow droppable panels to be copied when the Ctrl key is held down.
function MakeDroppable( name,  allowCopy) end

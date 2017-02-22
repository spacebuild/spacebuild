--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

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

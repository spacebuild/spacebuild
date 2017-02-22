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
-- @description Library DTileLayout
 module("DTileLayout")

--- DTileLayout:ClearTiles
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function ClearTiles() end

--- DTileLayout:ConsumeTiles
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  x number  The x coordinate of the top-left corner of the panel.
-- @param  y number  The y coordinate of the top-left corner of the panel.
-- @param  w number  The panel's width.
-- @param  h number  The panel's height.
function ConsumeTiles( x,  y,  w,  h) end

--- DTileLayout:Copy
-- @usage client
-- Creates and returns an exact copy of the DTileLayout.
--
-- @return Panel The created copy.
function Copy() end

--- DTileLayout:CopyContents
-- @usage client
-- Creates copies of all the children from the given panel object and parents them to this one.
--
-- @param  source Panel  The source panel from which to copy all children.
function CopyContents( source) end

--- DTileLayout:FindFreeTile
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  x number  The x coordinate to start looking from.
-- @param  y number  The y coordinate to start looking from.
-- @param  w number  The needed width.
-- @param  h number  The needed height.
-- @return number The x coordinate of the found available space.
-- @return number The y coordinate of the found available space.
function FindFreeTile( x,  y,  w,  h) end

--- DTileLayout:FitsInTile
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  x number  The x coordinate of the first tile.
-- @param  y number  The y coordinate of the first tile.
-- @param  w number  The width needed.
-- @param  h number  The height needed.
-- @return boolean Whether or not this group is available for occupation.
function FitsInTile( x,  y,  w,  h) end

--- DTileLayout:GetBaseSize
-- @usage client
-- Returns the size of each single tile, set with DTileLayout:SetBaseSize.
--
-- @return number Base tile size.
function GetBaseSize() end

--- DTileLayout:GetMinHeight
-- @usage client
-- Returns the minimum height the DTileLayout can resize to.
--
-- @return number The minimum height the panel can shrink to.
function GetMinHeight() end

--- DTileLayout:GetTile
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  x number  The x coordinate of the tile.
-- @param  y number  The y coordinate of the tile.
-- @return any The occupied state of the tile, normally 1 or nil.
function GetTile( x,  y) end

--- DTileLayout:Layout
-- @usage client
-- Resets the last width/height info, and invalidates the panel's layout, causing it to recalculate all child positions. It is called whenever a child is added or removed, and can be called to refresh the panel.
--
function Layout() end

--- DTileLayout:LayoutTiles
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function LayoutTiles() end

--- DTileLayout:OnModified
-- @usage client
-- Called when anything is dropped on or rearranged within the DTileLayout. You should override this.
--
function OnModified() end

--- DTileLayout:SetBaseSize
-- @usage client
-- Sets the size of a single tile. If a child panel is larger than this size, it will occupy several tiles.
--
-- @param  size number  The size of each tile. It is recommended you use 2n (16, 32, 64...) numbers, and those above 4, as numbers lower than this will result in many tiles being processed and therefore slow operation.
function SetBaseSize( size) end

--- DTileLayout:SetMinHeight
-- @usage client
-- Determines the minimum height the DTileLayout will resize to. This is useful if child panels will be added/removed often.
--
-- @param  minH number  The minimum height the panel can shrink to.
function SetMinHeight( minH) end

--- DTileLayout:SetTile
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  x number  The x coordinate of the tile.
-- @param  y number  The y coordinate of the tile.
-- @param  state any  The new state of the tile, normally 1 or nil.
function SetTile( x,  y,  state) end

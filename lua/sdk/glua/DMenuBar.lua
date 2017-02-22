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
-- @description Library DMenuBar
 module("DMenuBar")

--- DMenuBar:AddMenu
-- @usage client
-- Creates a new DMenu object tied to a DButton with the given label on the menu bar.
--
-- @param  label string  The name (label) of the derma menu to create.
-- @return Panel The new DMenu which will be opened when the button is clicked.
function AddMenu( label) end

--- DMenuBar:AddOrGetMenu
-- @usage client
-- Retrieves a DMenu object from the menu bar. If one with the given label doesn't exist, a new one is created.
--
-- @param  label string  The name (label) of the derma menu to get or create.
-- @return Panel The DMenu with the given label.
function AddOrGetMenu( label) end

--- DMenuBar:GetBackgroundColor
-- @usage client
-- Returns the DMenuBar's background color
--
-- @return table The background's color. See Color structure
function GetBackgroundColor() end

--- DMenuBar:GetDisabled
-- @usage client
-- Returns whether or not the DMenuBar is disabled
--
-- @return boolean Is disabled
function GetDisabled() end

--- DMenuBar:GetDrawBackground
-- @usage client
-- Returns whether or not the background should be painted. Is the same as DMenuBar:GetPaintBackground
--
-- @return boolean Should the background be painted
function GetDrawBackground() end

--- DMenuBar:GetIsMenu
-- @usage client
-- Returns whether or not the panel is a menu. Used for closing menus when another panel is selected.
--
-- @return boolean Is a menu
function GetIsMenu() end

--- DMenuBar:GetOpenMenu
-- @usage client
-- If a menu is visible/opened, then the menu is returned.
--
-- @return Panel Returns the visible/open menu or nil.
function GetOpenMenu() end

--- DMenuBar:GetPaintBackground
-- @usage client
-- Returns whether or not the background should be painted. Is the same as DMenuBar:GetDrawBackground
--
-- @return boolean Should the background be painted
function GetPaintBackground() end

--- DMenuBar:SetBackgroundColor
-- @usage client
-- Sets the background color
--
-- @param  color table  See Color structure
function SetBackgroundColor( color) end

--- DMenuBar:SetDisabled
-- @usage client
-- Sets whether or not the panel is disabled
--
-- @param  disable boolean  Should be disabled or not
function SetDisabled( disable) end

--- DMenuBar:SetDrawBackground
-- @usage client
-- Sets whether or not the background should be painted. Is the same as DMenuBar:SetPaintBackground
--
-- @param  shouldPaint boolean  Should the background be painted
function SetDrawBackground( shouldPaint) end

--- DMenuBar:SetIsMenu
-- @usage client
-- Sets whether or not the panel is a menu. Used for closing menus when another panel is selected.
--
-- @param  isMenu boolean  Is this a menu
function SetIsMenu( isMenu) end

--- DMenuBar:SetPaintBackground
-- @usage client
-- Sets whether or not the background should be painted. Is the same as DMenuBar:SetDrawBackground
--
-- @param  shouldPaint boolean  Should the background be painted
function SetPaintBackground( shouldPaint) end

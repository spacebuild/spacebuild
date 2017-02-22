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
-- @description Library DMenu
 module("DMenu")

--- DMenu:AddOption
-- @usage client
-- Add an option to the DMenu
--
-- @param  name string  Name of the option.
-- @param  func=nil function  Function to execute when this option is clicked.
-- @return Panel Returns the created DMenuOption panel.
function AddOption( name,  func) end

--- DMenu:AddSpacer
-- @usage client
-- Adds a horizontal line spacer.
--
function AddSpacer() end

--- DMenu:AddSubMenu
-- @usage client
-- Add a sub menu to the DMenu
--
-- @param  Name string  Name of the sub menu.
-- @param  func=nil function  Function to execute when this sub menu is clicked.
-- @return Panel The sub menu
-- @return Label The option added to the parent DMenu
function AddSubMenu( Name,  func) end

--- DMenu:GetChild
-- @usage client
-- Gets a child by its index.
--
-- @param  childIndex number  The index of the child to get.    NOTE  Unlike Panel:GetChild, this index starts at 1. 
function GetChild( childIndex) end

--- DMenu:Open
-- @usage client
-- Opens the DMenu at the current mouse position
--
-- @param  x=gui.MouseX() number  Position (X coordinate) to open the menu at.
-- @param  y=gui.MouseY() number  Position (Y coordinate) to open the menu at.
-- @param  skipanimation any  This argument does nothing.
-- @param  ownerpanel Panel 
function Open( x,  y,  skipanimation,  ownerpanel) end

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

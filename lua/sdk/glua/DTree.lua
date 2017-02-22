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
-- @description Library DTree
 module("DTree")

--- DTree:GetIndentSize
-- @usage client
-- Get the indent size of the DTree. Currently does nothing.
--
-- @return number Indent size.
function GetIndentSize() end

--- DTree:GetSelectedItem
-- @usage client
-- Returns the currently selected node.
--
-- @return Panel Curently selected node.
function GetSelectedItem() end

--- DTree:GetShowIcons
-- @usage client
-- Returns whether or not the Silkicons next to each node of the DTree will be displayed.
--
-- @return boolean Whether or not the silkicons next to each node will be displayed.
function GetShowIcons() end

--- DTree:OnNodeSelected
-- @usage client
-- This function is called when a node within a tree is selected.
--
-- @param  node Panel  The node that was selected.
function OnNodeSelected( node) end

--- DTree:Root
-- @usage client
-- Returns the root DTree_Node, the node that is the parent to all other nodes of the DTree.
--
-- @return Panel Root node.
function Root() end

--- DTree:SetIndentSize
-- @usage client
-- Set the indent size of the DTree. Currently does nothing.
--
-- @param  size number  Indent size.
function SetIndentSize( size) end

--- DTree:SetSelectedItem
-- @usage client
-- Set the currently selected top-level node.
--
-- @param  node Panel  DTree_Node to select.
function SetSelectedItem( node) end

--- DTree:SetShowIcons
-- @usage client
-- Sets whether or not the Silkicons next to each node of the DTree will be displayed.
--
-- @param  show boolean  Whether or not to show icons.
function SetShowIcons( show) end

--- DTree:ShowIcons
-- @usage client
-- Returns whether or not the Silkicons next to each node of the DTree will be displayed.
--
-- @return boolean Whether or not the silkicons next to each node will be displayed.
function ShowIcons() end

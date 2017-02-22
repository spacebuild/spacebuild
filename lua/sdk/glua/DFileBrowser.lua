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
-- @description Library DFileBrowser
 module("DFileBrowser")

--- DFileBrowser:Clear
-- @usage client
-- Clears the file tree and list, and resets all values.
--
function Clear() end

--- DFileBrowser:GetBaseFolder
-- @usage client
-- Returns the root directory/folder of the file tree.
--
-- @return string The path to the root folder.
function GetBaseFolder() end

--- DFileBrowser:GetCurrentFolder
-- @usage client
-- Returns the current directory/folder being displayed.
--
-- @return string The directory the file list is currently displaying.
function GetCurrentFolder() end

--- DFileBrowser:GetFileTypes
-- @usage client
-- Returns the current file type filter on the file list.
--
-- @return string The current filter applied to the file list.
function GetFileTypes() end

--- DFileBrowser:GetFolderNode
-- @usage client
-- Returns the DTree Node that the file tree stems from.
--
-- @return Panel The DTree_Node used for the tree.
function GetFolderNode() end

--- DFileBrowser:GetModels
-- @usage client
-- Returns whether or not the model viewer mode is enabled. In this mode, files are displayed as SpawnIcons instead of a list.
--
-- @return boolean Whether or not files will be displayed using SpawnIcons.
function GetModels() end

--- DFileBrowser:GetName
-- @usage client
-- Returns the name being used for the file tree.
--
-- @return string The name used for the root of the file tree.
function GetName() end

--- DFileBrowser:GetOpen
-- @usage client
-- Returns whether or not the file tree is open.
--
-- @return boolean Whether or not the file tree is open.
function GetOpen() end

--- DFileBrowser:GetPath
-- @usage client
-- Returns the access path of the file tree. This is GAME unless changed with DFileBrowser:SetPath.
--
-- @return string The current access path i.e. "GAME", "LUA", "DATA" etc.
function GetPath() end

--- DFileBrowser:GetSearch
-- @usage client
-- Returns the current search filter on the file tree.
--
-- @return string The filter in use on the file tree.
function GetSearch() end

--- DFileBrowser:OnDoubleClick
-- @usage client
-- Called when a file is double-clicked.
--
-- @param  filePath string  The path to the file that was double-clicked.
-- @param  selectedPanel Panel  The panel that was double-clicked to select this file.This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled. See DFileBrowser:SetModels.
function OnDoubleClick( filePath,  selectedPanel) end

--- DFileBrowser:OnRightClick
-- @usage client
-- Called when a file is right-clicked.
--
-- @param  filePath string  The path to the file that was right-clicked.
-- @param  selectedPanel Panel  The panel that was right-clicked to select this file.This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled. See DFileBrowser:SetModels.
function OnRightClick( filePath,  selectedPanel) end

--- DFileBrowser:OnSelect
-- @usage client
-- Called when a file is selected.
--
-- @param  filePath string  The path to the file that was selected.
-- @param  selectedPanel Panel  The panel that was clicked to select this file.This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled. See DFileBrowser:SetModels.
function OnSelect( filePath,  selectedPanel) end

--- DFileBrowser:SetBaseFolder
-- @usage client
-- Sets the root directory/folder of the file tree.
--
-- @param  baseDir string  The path to the folder to use as the root.
function SetBaseFolder( baseDir) end

--- DFileBrowser:SetCurrentFolder
-- @usage client
-- Sets the directory/folder from which to display the file list.
--
-- @param  currentDir string  The directory to display files from.
function SetCurrentFolder( currentDir) end

--- DFileBrowser:SetFileTypes
-- @usage client
-- Sets the file type filter for the file list.
--
-- @param  fileTypes="*.*" string  A list of file types to display, separated by spaces e.g."*.lua *.txt *.mdl"
function SetFileTypes( fileTypes) end

--- DFileBrowser:SetModels
-- @usage client
-- Enables or disables the model viewer mode. In this mode, files are displayed as SpawnIcons instead of a list.
--
-- @param  showModels=false boolean  Whether or not to display files using SpawnIcons.
function SetModels( showModels) end

--- DFileBrowser:SetName
-- @usage client
-- Sets the name to use for the file tree.
--
-- @param baseFolder string  The name for the root of the file tree. Passing no value causes this to be the base folder name. See DFileBrowser:SetBaseFolder.
function SetName(baseFolder) end

--- DFileBrowser:SetOpen
-- @usage client
-- Opens or closes the file tree.
--
-- @param  open=false boolean  true to open the tree, false to close it.
-- @param  useAnim=false boolean  If true, the DTree's open/close animation is used.
function SetOpen( open,  useAnim) end

--- DFileBrowser:SetPath
-- @usage client
-- Sets the access path for the file tree. This is set to GAME by default.
--
-- @param  path string  The access path i.e. "GAME", "LUA", "DATA" etc.
function SetPath( path) end

--- DFileBrowser:SetSearch
-- @usage client
-- Sets the search filter for the file tree.
--
-- @param  filter="*" string  The filter to use on the file tree.
function SetSearch( filter) end

--- DFileBrowser:Setup
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return boolean Whether or not the variables needed to set up have been defined.
function Setup() end

--- DFileBrowser:SetupFiles
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return boolean Whether or not the files pane was set up successfully.
function SetupFiles() end

--- DFileBrowser:SetupTree
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return boolean Whether or not the tree was set up successfully.
function SetupTree() end

--- DFileBrowser:ShowFolder
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  currentDir string  The directory to populate the list from.
function ShowFolder( currentDir) end

--- DFileBrowser:SortFiles
-- @usage client
-- Sorts the file list.
--
-- @param  descending=false boolean  The sort order. true for descending (z-a), false for ascending (a-z).
function SortFiles( descending) end

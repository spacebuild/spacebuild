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
-- @description Library spawnmenu
 module("spawnmenu")

--- spawnmenu.ActivateTool
-- @usage client
-- Activates a tool, opens context menu and brings up the tool gun.
--
-- @param  tool string  Tool class/file name
function ActivateTool( tool) end

--- spawnmenu.ActivateToolPanel
-- @usage client
-- Activates tools context menu in specified tool tab.
--
-- @param  tab number  The tabID of the tab to open the context menu in
-- @param  cp Panel  The control panel to open
function ActivateToolPanel( tab,  cp) end

--- spawnmenu.ActiveControlPanel
-- @usage client
-- Returns currently opened control panel of a tool, post process effect or some other menu in spawnmenu.
--
-- @return Panel The currently opened control panel, if any.
function ActiveControlPanel() end

--- spawnmenu.AddContentType
-- @usage client
-- Registers a new content type that is saveable into spawnlists.
--Created/called by spawnmenu.CreateContentIcon.
--
-- @param  name string  An unique name of the content type.
-- @param  constructor function  A function that is called whenever we need create a new panel for this content type. It has two arguments: Panel container - The container/parent of the new panel table data - Data for the content type passed from spawnmenu.CreateContentIcon  
function AddContentType( name,  constructor) end

--- spawnmenu.AddCreationTab
-- @usage client
-- Inserts a new tab into the CreationMenus table, which will be used by the creation menu to generate its tabs (Spawnlists, Weapons, Entities, etc.)
--
-- @param  name string  What text will appear on the tab (I.E Spawnlists).
-- @param  func function  The function called to generate the content of the tab.
-- @param  material="icon16/exclamation.png" string  Path to the material that will be used as an icon on the tab.
-- @param  order=1000 number  The order in which this tab should be shown relative to the other tabs on the creation menu.
-- @param  tooltip=nil string  The tooltip to be shown for this tab.
function AddCreationTab( name,  func,  material,  order,  tooltip) end

--- spawnmenu.AddPropCategory
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
--
--You should never try to modify player's customized spawnlists.
-- @param  filename string  The filename of the list. This name has to be unique, but doesn't have to actually exist. If a player saves changes made to this list, it will be saved under this name.
-- @param  name string  The name of the category e.g. Comic Props.
-- @param  contents table  A table of entries for the spawn menu. It must be numerically indexed. Each member of the table is a sub-table containing a type member, and other members depending on the type.   string type - "header" - a simple header for organization  string text - The text that the header will display    string type - "model" - spawns a model where the player is looking  string model - The path to the model file  number skin - The skin for the model to use (optional)  string body - The bodygroups for the model (optional)  number wide - The width of the spawnicon (optional)  number tall - The height of the spawnicon (optional)    string type - "entity" - spawns an entity where the player is looking (appears in the Entities tab by default)  string spawnname - The filename of the entity, for example "sent_ball"  string nicename - The name of the entity to display  string material - The icon to display, this should be set to "entities/<sent_name>.png"  boolean admin - Whether the entity is only spawnable by admins (optional)    string type - "vehicle" - spawns a vehicle where the player is looking (appears in the Vehicles tab by default)  string spawnname - The filename of the vehicle  string nicename - The name of the vehicle to display  string material - The icon to display  boolean admin - Whether the vehicle is only spawnable by admins (optional)    string type - "npc" - spawns an NPC where the player is looking (appears in the NPCs tab by default)  string spawnname - The spawn name of the NPC  string nicename - The name to display  string material - The icon to display  table weapon - A table of potential weapons (each a string) to give to the NPC. When spawned, one of these will be chosen randomly each time.  boolean admin - Whether the NPC is only spawnable by admins (optional)    string type - "weapon" - When clicked, gives the player a weapon; when middle-clicked, spawns a weapon where the player is looking (appears in the Weapons tab by default)  string spawnname - The spawn name of the weapon  string nicename - The name to display  string material - The icon to display  boolean admin - Whether the weapon is only spawnable by admins (optional)
-- @param  icon string  The icon to use in the tree.
-- @param  id=1000 number  The unique ID number for the spawnlist category. Used to make sub categories. See "parentID" parameter below. If not set, it will be automatically set to ever increasing number, starting with 1000.
-- @param  parentID=0 number  The unique ID of the parent category. This will make the category a subcategory of that given. 0 makes this a base category (such as Builder).
-- @param  needsApp="" string  The needed game for this prop category, if one is needed. If the specified game is not mounted, the category isn't shown. This uses the shortcut name, e.g. cstrike, and not the Steam AppID.
function AddPropCategory( filename,  name,  contents,  icon,  id,  parentID,  needsApp) end

--- spawnmenu.AddToolCategory
-- @usage client
-- Used to create a new category in the list inside of a spawnmenu ToolTab.
--
-- @param  tab string  The ToolTab name, as created with spawnmenu.AddToolTab.  You can also use the default ToolTab names "Main" and "Utilities".
-- @param  RealName string  The identifier name
-- @param  PrintName string  The displayed name
function AddToolCategory( tab,  RealName,  PrintName) end

--- spawnmenu.AddToolMenuOption
-- @usage client
-- Adds an option to the right side of the spawnmenu
--
-- @param  tab string  The tab to add into
-- @param  category string  The category to add into
-- @param  class string  Name of item to add, must be unique
-- @param  name string  The nice name of item
-- @param  cmd string  Command to execute when the item is selected
-- @param  config string  Config name ( Unknown purpose )
-- @param  cpanel function  A function to build the C panel
-- @param N1 table
function AddToolMenuOption( tab,  category,  class,  name,  cmd,  config,  cpanel, N1) end

--- spawnmenu.AddToolTab
-- @usage client
-- Used to create a new Utility tab inside of the spawnmenu to place more content into. You must call from from SANDBOX:AddToolMenuTabs for it to add work correctly.
--
-- @param  tab string  The name of the tab in creation
-- @param  name string  The 'Unique' tab name (Tip: language.Add)
-- @param  icon string  (Optional) Directory to tab image
function AddToolTab( tab,  name,  icon) end

--- spawnmenu.ClearToolMenus
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function ClearToolMenus() end

--- spawnmenu.CreateContentIcon
-- @usage client
-- Creates a new content icon.
--
-- @param  type string  The type of the content icon.
-- @param  parent Panel  The parent to add the content icon to.
-- @param  data table  The data to send to the content icon in spawnmenu.AddContentType
-- @return Panel The created content icon, if it was returned by spawnmenu.AddContentType
function CreateContentIcon( type,  parent,  data) end

--- spawnmenu.DoSaveToTextFiles
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  spawnlists table  A table containing spawnlists.
function DoSaveToTextFiles( spawnlists) end

--- spawnmenu.GetContentType
-- @usage client
-- Returns the function to create an vgui element for a specified content type
--
-- @param  contentType string 
-- @return function The panel creation function
function GetContentType( contentType) end

--- spawnmenu.GetCreationTabs
-- @usage client
-- Gets the CreationMenus table, which was filled with creation menu tabs from spawnmenu.AddCreationTab.
--
-- @return table The CreationMenus table. See the CreationMenus structure.
function GetCreationTabs() end

--- spawnmenu.GetPropTable
-- @usage client
-- Returns a table of all prop categories and their props in the spawnmenu. Note that if the spawnmenu has not been populated, this will return an empty table.
--
-- @return table Table of all the prop categories and props in the following format:  { 	["settings/spawnlist/001-construction props.txt"] = { 		name = "Construction Props", 		icon = "icon16/page.png", 		id = 1, 		parentid = 0, 		needsapp = "", 		contents = { 			{ 				model = "models/Cranes/crane_frame.mdl", 				type = "model" 			} 			-- etc. 		}, 	} 	-- etc. } 
function GetPropTable() end

--- spawnmenu.GetToolMenu
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function GetToolMenu() end

--- spawnmenu.GetTools
-- @usage client
-- Gets a table of tools on the client.
--
-- @return table A table with groups of tools, along with information on each tool.
function GetTools() end

--- spawnmenu.PopulateFromEngineTextFiles
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function PopulateFromEngineTextFiles() end

--- spawnmenu.PopulateFromTextFiles
-- @usage client
-- Loads spawnlists from text files.
--
-- @param  callback function  The function to call. Arguments are ( strFilename, strName, tabContents, icon, id, parentid, needsapp )
function PopulateFromTextFiles( callback) end

--- spawnmenu.SaveToTextFiles
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  spawnlists table  A table containing spawnlists.
function SaveToTextFiles( spawnlists) end

--- spawnmenu.SetActiveControlPanel
-- @usage client
-- Sets currently active control panel to be returned by spawnmenu.ActiveControlPanel.
--
-- @param  pnl Panel  The panel to set.
function SetActiveControlPanel( pnl) end

--- spawnmenu.SwitchToolTab
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
-- @param  id number  The tab ID to open
function SwitchToolTab( id) end

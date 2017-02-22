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
-- @description Library SANDBOX
 module("SANDBOX")

--- SANDBOX:AddGamemodeToolMenuCategories
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function AddGamemodeToolMenuCategories() end

--- SANDBOX:AddGamemodeToolMenuTabs
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function AddGamemodeToolMenuTabs() end

--- SANDBOX:AddToolMenuCategories
-- @usage client
-- This hook is used to add new categories to spawnmenu tool tabs.
--
function AddToolMenuCategories() end

--- SANDBOX:AddToolMenuTabs
-- @usage client
-- This hook is used to add new tool tabs to spawnmenu.
--
function AddToolMenuTabs() end

--- SANDBOX:CanDrive
-- @usage shared
-- Called when a player attempts to drive a prop via Prop Drive
--
-- @param  ply Player  The player who attempted to use Prop Drive.
-- @param  ent Entity  The entity the player is attempting to drive
-- @return boolean Return true to allow driving, false to disallow
function CanDrive( ply,  ent) end

--- SANDBOX:CanProperty
-- @usage shared
-- Controls if a property can be used or not.
--
-- @param  ply Player  Player, that tried to use the property
-- @param  property string  Class of the property that is tried to use, for example - bonemanipulate
-- @param  ent Entity  The entity, on which property is tried to be used on
-- @return boolean Return false to disallow using that property
function CanProperty( ply,  property,  ent) end

--- SANDBOX:CanTool
-- @usage shared
-- Called when a player attempts to fire their tool gun. Return true to specifically allow the attempt, false to block it.
--
-- @param  ply Player  The player who attempted to use their toolgun.
-- @param  tr table  A trace from the players eye to where in the world their crosshair/cursor is pointing. See TraceResult structure
-- @param  tool string  The tool mode the player currently has selected.
-- @return boolean Can use toolgun or not.
function CanTool( ply,  tr,  tool) end

--- SANDBOX:ContentSidebarSelection
-- @usage client
-- Called when player selects an item on the spawnmenu sidebar at the left.
--
-- @param  parent Panel  The panel that holds spawnicons and the sidebar of spawnmenu
-- @param  node Panel  The item player selected
function ContentSidebarSelection( parent,  node) end

--- SANDBOX:ContextMenuCreated
-- @usage client
-- Called when the context menu is created.
--
-- @param  g_ContextMenu Panel  The created context menu panel
function ContextMenuCreated( g_ContextMenu) end

--- SANDBOX:PersistenceLoad
-- @usage server
-- Called when persistent props are loaded.
--
function PersistenceLoad() end

--- SANDBOX:PersistenceSave
-- @usage server
-- Called when persistent props are saved.
--
function PersistenceSave() end

--- SANDBOX:PlayerGiveSWEP
-- @usage server
-- Called when a player attempts to give themselves a weapon from the Q menu. ( Left mouse clicks on an icon )
--
-- @param  ply Player  The player who attempted to give themselves a weapon.
-- @param  weapon string  Class name of the weapon the player tried to give themselves.
-- @param  swep table  The swep table of this weapon, see SWEP structure
-- @return boolean Can the SWEP be given to the player
function PlayerGiveSWEP( ply,  weapon,  swep) end

--- SANDBOX:PlayerSpawnedEffect
-- @usage server
-- Called after the player spawned an effect.
--
-- @param  ply Player  The player that spawned the effect
-- @param  model string  The model of spawned effect
-- @param  ent Entity  The spawned effect itself
function PlayerSpawnedEffect( ply,  model,  ent) end

--- SANDBOX:PlayerSpawnedNPC
-- @usage server
-- Called after the player spawned an NPC.
--
-- @param  ply Player  The player that spawned the NPC
-- @param  ent Entity  The spawned NPC itself
function PlayerSpawnedNPC( ply,  ent) end

--- SANDBOX:PlayerSpawnedProp
-- @usage server
-- Called when a player has successfully spawned a prop from the Q menu.
--
-- @param  ply Player  The player who spawned a prop.
-- @param  model string  Path to the model of the prop the player is attempting to spawn.
-- @param  entity Entity  The entity that was spawned.
function PlayerSpawnedProp( ply,  model,  entity) end

--- SANDBOX:PlayerSpawnedRagdoll
-- @usage server
-- Called after the player spawned a ragdoll.
--
-- @param  ply Player  The player that spawned the ragdoll
-- @param  model string  The ragdoll model that player wants to spawn
-- @param  ent Entity  The spawned ragdoll itself
function PlayerSpawnedRagdoll( ply,  model,  ent) end

--- SANDBOX:PlayerSpawnedSENT
-- @usage server
-- Called after the player has spawned a scripted entity.
--
-- @param  ply Player  The player that spawned the SENT
-- @param  ent Entity  The spawned SENT
function PlayerSpawnedSENT( ply,  ent) end

--- SANDBOX:PlayerSpawnedSWEP
-- @usage server
-- Called after the player has spawned a scripted weapon.
--
-- @param  ply Player  The player that spawned the SWEP
-- @param  ent Entity  The SWEP itself
function PlayerSpawnedSWEP( ply,  ent) end

--- SANDBOX:PlayerSpawnedVehicle
-- @usage server
-- Called after the player spawned a vehicle.
--
-- @param  ply Player  The player that spawned the vehicle
-- @param  ent Entity  The vehicle itself
function PlayerSpawnedVehicle( ply,  ent) end

--- SANDBOX:PlayerSpawnEffect
-- @usage server
-- Called to ask if player allowed to spawn a particular effect or not.
--
-- @param  ply Player  The player that wants to spawn an effect
-- @param  model string  The effect model that player wants to spawn
-- @return boolean Return false to disallow spawning that effect
function PlayerSpawnEffect( ply,  model) end

--- SANDBOX:PlayerSpawnNPC
-- @usage server
-- Called to ask if player allowed to spawn a particular NPC or not.
--
-- @param  ply Player  The player that wants to spawn that NPC
-- @param  npc_type string  The npc type that player is trying to spawn
-- @param  weapon string  The weapon of that NPC
-- @return boolean Return false to disallow spawning that NPC
function PlayerSpawnNPC( ply,  npc_type,  weapon) end

--- SANDBOX:PlayerSpawnObject
-- @usage server
-- Called to ask whether player is allowed to spawn any objects.
--
-- @param  ply Player  The player in question
-- @param  model string  Modelname
-- @param  skin number  Skin number
-- @return boolean Return false to disallow him spawning anything
function PlayerSpawnObject( ply,  model,  skin) end

--- SANDBOX:PlayerSpawnProp
-- @usage server
-- Called when a player attempts to spawn a prop from the Q menu.
--
-- @param  ply Player  The player who attempted to spawn a prop.
-- @param  model string  Path to the model of the prop the player is attempting to spawn.
-- @return boolean Should the player be able to spawn the prop or not.
function PlayerSpawnProp( ply,  model) end

--- SANDBOX:PlayerSpawnRagdoll
-- @usage server
-- Called when a player attempts to spawn a ragdoll from the Q menu.
--
-- @param  ply Player  The player who attempted to spawn a ragdoll.
-- @param  model string  Path to the model of the ragdoll the player is attempting to spawn.
-- @return boolean Should the player be able to spawn the ragdoll or not.
function PlayerSpawnRagdoll( ply,  model) end

--- SANDBOX:PlayerSpawnSENT
-- @usage server
-- Called when a player attempts to spawn an Entity from the Q menu.
--
-- @param  ply Player  The player who attempted to spawn the entity.
-- @param  class string  Class name of the entity the player tried to spawn.
-- @return boolean can_spawn
function PlayerSpawnSENT( ply,  class) end

--- SANDBOX:PlayerSpawnSWEP
-- @usage server
-- Called when a player attempts to spawn a weapon from the Q menu. ( Mouse wheel clicks on an icon )
--
-- @param  ply Player  The player who attempted to spawn a weapon.
-- @param  weapon string  Class name of the weapon the player tried to spawn.
-- @param  swep table  Information about the weapon the player is trying to spawn, see SWEP structure
-- @return boolean Can the SWEP be spawned
function PlayerSpawnSWEP( ply,  weapon,  swep) end

--- SANDBOX:PlayerSpawnVehicle
-- @usage server
-- Called to ask if player allowed to spawn a particular vehicle or not.
--
-- @param  ply Player  The player that wants to spawn that vehicle
-- @param  model string  The vehicle model that player wants to spawn
-- @param  name string  Vehicle name
-- @param  table table  Table of that vehicle, containing info about it
-- @return boolean Return false to disallow spawning that vehicle
function PlayerSpawnVehicle( ply,  model,  name,  table) end

--- SANDBOX:PopulatePropMenu
-- @usage client
-- This hook makes the engine load the spawnlist text files.
--It calls spawnmenu.PopulateFromEngineTextFiles by default.
--
function PopulatePropMenu() end

--- SANDBOX:SpawnMenuEnabled
-- @usage client
-- If false is returned then the spawn menu is never created.
--This saves load times if your mod doesn't actually use the spawn menu for any reason.
--
-- @return boolean Whether to create spawnmenu or not
function SpawnMenuEnabled() end

--- SANDBOX:SpawnMenuOpen
-- @usage client
-- Called when spawnmenu is trying to be opened.
--
-- @return boolean Return false to dissallow opening the spawnmenu
function SpawnMenuOpen() end

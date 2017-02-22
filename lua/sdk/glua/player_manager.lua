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
-- @description Library player_manager
 module("player_manager")

--- player_manager.AddValidHands
-- @usage shared
-- Assigns view model hands to player model.
--
-- @param  name string  Player model name
-- @param  model string  Hands model
-- @param  skin number  Skin to apply to the hands
-- @param  bodygroups string  Bodygroups to apply to the hands
function AddValidHands( name,  model,  skin,  bodygroups) end

--- player_manager.AddValidModel
-- @usage shared
-- Associates a simplified name with a path to a valid player model.
--Only used internally.
--
-- @param  name string  Simplified name
-- @param  model string  Valid PlayerModel path
function AddValidModel( name,  model) end

--- player_manager.AllValidModels
-- @usage shared
-- Returns the entire list of valid player models.
--
function AllValidModels() end

--- player_manager.ClearPlayerClass
-- @usage shared
-- Clears a player's class association by setting their ClassID to 0
--
-- @param  ply Player  Player to clear class from
function ClearPlayerClass( ply) end

--- player_manager.GetPlayerClass
-- @usage shared
-- Gets a players class
--
-- @param  ply Player  Player to get class
-- @return string The players class
function GetPlayerClass( ply) end

--- player_manager.OnPlayerSpawn
-- @usage shared
-- Applies basic class variables when the player spawns.
--Called from GM:PlayerSpawn in the base gamemode.
--
-- @param  ply Player  Player to setup
function OnPlayerSpawn( ply) end

--- player_manager.RegisterClass
-- @usage shared
-- Register a class metatable to be assigned to players later
--
-- @param  name string  Class name
-- @param  table table  Class metatable
-- @param  base string  Base class name
function RegisterClass( name,  table,  base) end

--- player_manager.RunClass
-- @usage shared
-- Execute a named function within the player's set class
--
-- @param  ply Player  Player to execute function on.
-- @param  funcName string  Name of function.
-- @param  arguments vararg  Optional arguments. Can be of any type.
-- @return vararg The values returned by the called function.
function RunClass( ply,  funcName,  arguments) end

--- player_manager.SetPlayerClass
-- @usage shared
-- Sets a player's class
--
-- @param  ply Player  Player to set class
-- @param  classname string  Name of class to set
function SetPlayerClass( ply,  classname) end

--- player_manager.TranslatePlayerHands
-- @usage shared
-- Retrieves correct hands for given player model. By default returns citizen hands.
--
-- @param  name string  Player model name
-- @return table A table with following contents:  string model - Model of hands  number skin - Skin of hands  string body - Bodygroups of hands
function TranslatePlayerHands( name) end

--- player_manager.TranslatePlayerModel
-- @usage shared
-- Returns the valid model path for a simplified name.
--
-- @param  shortName string  The short name of the model.
-- @return string The valid model path for the short name.
function TranslatePlayerModel( shortName) end

--- player_manager.TranslateToPlayerModelName
-- @usage shared
-- Returns the simplified name for a valid model path of a player model.
--
-- @param  model string  The model path to a player model
-- @return string The simplified name for that model
function TranslateToPlayerModelName( model) end

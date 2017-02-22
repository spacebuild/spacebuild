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
-- @description Library gmsave
 module("gmsave")

--- gmsave.LoadMap
-- @usage server
-- Loads a saved map.
--
-- @param  mapData string  The JSON encoded string containing all the map data.
-- @param  ply Player  The player to load positions for
function LoadMap( mapData,  ply) end

--- gmsave.PlayerLoad
-- @usage server
-- Sets player position and angles from supplied table
--
-- @param  ply Player  The player to "load" values for
-- @param  data table  A table containing Origin and Angle keys for position and angles to set.
function PlayerLoad( ply,  data) end

--- gmsave.PlayerSave
-- @usage server
-- Returns a table containing player position and angles. Used by gmsave.SaveMap.
--
-- @param  ply Player  The player to "save"
-- @return table A table containing player position ( Origin ) and angles ( Angle )
function PlayerSave( ply) end

--- gmsave.SaveMap
-- @usage server
-- Saves the map
--
-- @param  ply Player  The player, whose position should be saved for loading the save
-- @return string The encoded to JSON string containing save data
function SaveMap( ply) end

--- gmsave.ShouldSaveEntity
-- @usage server
-- Returns if we should save this entity in a duplication or a map save or not.
--
-- @param  ent Entity  The entity
-- @param  t table  A table containing classname key with entities classname.
-- @return boolean Should save entity or not
function ShouldSaveEntity( ent,  t) end

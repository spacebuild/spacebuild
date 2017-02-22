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
-- @description Library navmesh
 module("navmesh")

--- navmesh.AddWalkableSeed
-- @usage server
-- Add this position and normal to the list of walkable positions, used before map generation with navmesh.BeginGeneration
--
-- @param  pos Vector  The terrain position.
-- @param  dir Vector  The normal of this terrain position.
function AddWalkableSeed( pos,  dir) end

--- navmesh.BeginGeneration
-- @usage server
-- Starts the generation of a new navmesh.
--
function BeginGeneration() end

--- navmesh.ClearWalkableSeeds
-- @usage server
-- Clears all the walkable positions, used before calling navmesh.BeginGeneration.
--
function ClearWalkableSeeds() end

--- navmesh.Find
-- @usage server
-- Returns a bunch of areas within distance, used to find hiding spots by NextBots for example.
--
-- @param  pos Vector  The position to search around
-- @param  radius number  Radius to search within
-- @param  stepdown number  Maximum stepdown( fall distance ) allowed
-- @param  stepup number  Maximum stepup( jump height ) allowed
-- @return table A table of CNavAreas
function Find( pos,  radius,  stepdown,  stepup) end

--- navmesh.GetAllNavAreas
-- @usage server
-- Returns an integer indexed table of all CNavAreas on the current map. If the map doesn't have a navmesh generated then this will return an empty table.
--
-- @return table A table of all the CNavAreas on the current map.
function GetAllNavAreas() end

--- navmesh.GetEditCursorPosition
-- @usage server
-- Returns the position of the edit cursor when nav_edit is set to 1.
--
-- @return Vector The position of the edit cursor.
function GetEditCursorPosition() end

--- navmesh.GetMarkedArea
-- @usage server
-- Returns the currently marked CNavArea, for use with editing console commands.
--
-- @return CNavArea The currently marked CNavArea.
function GetMarkedArea() end

--- navmesh.GetMarkedLadder
-- @usage server
-- Returns the currently marked CNavLadder, for use with editing console commands.
--
-- @return CNavLadder The currently marked CNavLadder.
function GetMarkedLadder() end

--- navmesh.GetNavArea
-- @usage server
-- Returns the Nav Area contained in this position that also satisfies the elevation limit.
--
-- @param  pos Vector  The position to search for.
-- @param  beneathLimit number  The elevation limit at which the Nav Area will be searched.
-- @return CNavArea The nav area.
function GetNavArea( pos,  beneathLimit) end

--- navmesh.GetNavAreaByID
-- @usage server
-- Returns a CNavArea by the given ID.
--
-- @param  id number  ID of the CNavArea to get. Starts with 1.
-- @return CNavArea The CNavArea with given ID.
function GetNavAreaByID( id) end

--- navmesh.GetNavAreaCount
-- @usage server
-- Returns the highest ID of all nav areas on the map. While this can be used to get all nav areas, this number may not actually be the actual number of nav areas on the map.
--
-- @return number The highest ID of all nav areas on the map.
function GetNavAreaCount() end

--- navmesh.GetNavLadderByID
-- @usage server
-- Returns a CNavLadder by the given ID.
--
-- @param  id number  ID of the CNavLadder to get. Starts with 1.
-- @return CNavLadder The CNavLadder with given ID.
function GetNavLadderByID( id) end

--- navmesh.GetNearestNavArea
-- @usage server
-- Returns the closest CNavArea to given position at the same height, or beneath it.
--
-- @param  pos Vector  The position to look from
-- @param  anyZ=false boolean  This argument is ignored and has no effect
-- @param  maxDist=10000 number  This is the maximum distance from the given position that the function will look for a CNavArea
-- @param  checkLOS=false boolean  If this is set to true then the function will internally do a util.TraceLine from the starting position to each potential CNavArea with a MASK_NPCSOLID_BRUSHONLY MASK_ Enums. If the trace fails then the CNavArea is ignored.  If this is set to false then the function will find the closest CNavArea through anything, including the world.
-- @param  checkGround=true boolean  If checkGround is true then this function will internally call navmesh.GetNavArea to check if there is a CNavArea directly below the position, and return it if so, before checking anywhere else.
-- @param  team=TEAM_ANY=-2 number  This will internally call CNavArea:IsBlocked to check if the target CNavArea is not to be navigated by the given team. Currently this appears to do nothing.
-- @return CNavArea The closest CNavArea found with the given parameters.
function GetNearestNavArea( pos,  anyZ,  maxDist,  checkLOS,  checkGround,  team) end

--- navmesh.GetPlayerSpawnName
-- @usage server
-- Returns the classname of the player spawn entity.
--
-- @return string The classname of the spawn point entity. By default returns "info_player_start"
function GetPlayerSpawnName() end

--- navmesh.IsGenerating
-- @usage server
-- Whether we're currently generating a new navmesh with navmesh.BeginGeneration.
--
-- @return boolean Whether we're generating a nav mesh or not.
function IsGenerating() end

--- navmesh.IsLoaded
-- @usage server
-- Returns true if a navmesh has been loaded when loading the map.
--
-- @return boolean Whether a navmesh has been loaded when loading the map.
function IsLoaded() end

--- navmesh.Load
-- @usage server
-- Loads a new navmesh from the .nav file for current map discarding any changes made to the navmesh previously.
--
function Load() end

--- navmesh.Reset
-- @usage server
-- Deletes every CNavArea and CNavLadder on the map without saving the changes.
--
function Reset() end

--- navmesh.Save
-- @usage server
-- Saves any changes made to navmesh to the .nav file.
--
function Save() end

--- navmesh.SetMarkedArea
-- @usage server
-- Sets the CNavArea as marked, so it can be used with editing console commands.
--
-- @param  area CNavArea  The CNavArea to set as the marked area.
function SetMarkedArea( area) end

--- navmesh.SetMarkedLadder
-- @usage server
-- Sets the CNavLadder as marked, so it can be used with editing console commands.
--
-- @param  area CNavLadder  The CNavLadder to set as the marked ladder.
function SetMarkedLadder( area) end

--- navmesh.SetPlayerSpawnName
-- @usage server
-- Sets the classname of the default spawn point entity, used before generating a new navmesh with navmesh.BeginGeneration.
--
-- @param  spawnPointClass string  The classname of what the player uses to spawn, automatically adds it to the walkable positions during map generation.
function SetPlayerSpawnName( spawnPointClass) end

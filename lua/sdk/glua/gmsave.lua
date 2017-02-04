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

---
-- @description Library presets
 module("presets")

--- presets.Add
-- @usage client
-- Adds preset to a preset group.
--
-- @param  groupname string  The preset group name, usually it's tool class name.
-- @param  name string  Preset name, must be unique.
-- @param  values table  A table of preset console commands.
function Add( groupname,  name,  values) end

--- presets.GetTable
-- @usage client
-- Returns a table with preset names and values from a single preset group.
--
-- @param  groupname string  Preset group name.
-- @return table All presets in specified group.
function GetTable( groupname) end

--- presets.Remove
-- @usage client
-- Removes a preset entry from a preset group.
--
-- @param  groupname string  Preset group to remove from
-- @param  name string  Name of preset to remove
function Remove( groupname,  name) end

--- presets.Rename
-- @usage client
-- Renames preset.
--
-- @param  groupname string  Preset group name
-- @param  oldname string  Old preset name
-- @param  newname string  New preset name
function Rename( groupname,  oldname,  newname) end

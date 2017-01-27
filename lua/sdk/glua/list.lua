---
-- @description Library list
 module("list")

--- list.Add
-- @usage shared_m
-- Adds an item to a named list
--
-- @param  identifier string  The list identifier
-- @param  item any  The item to add to the list
function Add( identifier,  item) end

--- list.Contains
-- @usage shared_m
-- Returns true if the list contains the value. (as a value - not a key)
--
-- @param  list string  List to search through
-- @param  value any  The value to test
-- @return boolean Returns true if the list contains the value, false otherwise
function Contains( list,  value) end

--- list.Get
-- @usage shared_m
-- Returns a copy of the list stored at identifier
--
-- @param  identifier string  The list identifier
-- @return table listCopy
function Get( identifier) end

--- list.GetForEdit
-- @usage shared_m
-- Returns the actual table of the list stored at identifier. Modifying this will affect the stored list
--
-- @param  identifier string  The list identifier
-- @return table The actual list
function GetForEdit( identifier) end

--- list.Set
-- @usage shared_m
-- Sets a specific position in the named list to a value.
--
-- @param  identifier string  The list identifier
-- @param  key any  The key in the list to set
-- @param  item any  The item to set to the list as key
function Set( identifier,  key,  item) end

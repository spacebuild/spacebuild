---
-- @description Library baseclass
 module("baseclass")

--- baseclass.Get
-- @usage shared_m
-- Gets the base class of an an object.
--
-- @param  name string  The child class.
-- @return table The base class's meta table.
function Get( name) end

--- baseclass.Set
-- @usage shared_m
-- Add a new base class that can be derived by others. This is done automatically for:
--
-- @param  name string  The name of this base class. Must be completely unique.
-- @param  tab table  The base class.
function Set( name,  tab) end

---
-- @description Library gamemode
 module("gamemode")

--- gamemode.Call
-- @usage shared
-- Called by the engine to call a hook within the loaded gamemode.
--
-- @param  name string  The name of the hook to call.
-- @param  args vararg  The arguments
-- @return any The result of the hook function.
function Call( name,  args) end

--- gamemode.Get
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  name string  The name of the gamemode you want to get
-- @return table The gamemode's table
function Get( name) end

--- gamemode.Register
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  gm table  Your GM table
-- @param  name string  Name of your gamemode, lowercase, no spaces.
-- @param  derived string  The gamemode name that your gamemode is derived from
function Register( gm,  name,  derived) end

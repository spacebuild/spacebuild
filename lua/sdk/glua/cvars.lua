---
-- @description Library cvars
 module("cvars")

--- cvars.AddChangeCallback
-- @usage shared_m
-- Adds a callback to be called when the named convar changes.
--
-- @param  name string  The name of the convar to add the change callback to.
-- @param  callback function  The function to be called when the convar changes. The arguments passed are:   string convar - The name of the convar.  string oldValue - The old value of the convar.  string newValue - The new value of the convar.
-- @param  indentifier=nil string  If set, you will be able to remove the callback using cvars.RemoveChangeCallback.
function AddChangeCallback( name,  callback,  indentifier) end

--- cvars.Bool
-- @usage shared_m
-- Retrieves console variable as a boolean.
--
-- @param  cvar string  Name of console variable
-- @param  default=false boolean  The value to return if the console variable does not exist
-- @return boolean Retrieved value
function Bool( cvar,  default) end

--- cvars.GetConVarCallbacks
-- @usage shared_m
-- Returns a table of the given ConVars callbacks.
--
-- @param  name string  The name of the ConVar.
-- @param  createIfNotFound=false boolean  Whether or not to create the internal callback table for given ConVar if there isn't one yet.  This argument is internal and should not be used.
-- @return table A table of the convar's callbacks, or nil if the convar doesn't exist.
function GetConVarCallbacks( name,  createIfNotFound) end

--- cvars.Number
-- @usage shared_m
-- Retrieves console variable as a number.
--
-- @param  cvar string  Name of console variable
-- @param  default=nil any  The value to return if the console variable does not exist
-- @return number Retrieved value
function Number( cvar,  default) end

--- cvars.OnConVarChanged
-- @usage shared_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
--
--You are probably looking for cvars.AddChangeCallback.
-- @param  name string  Convar name
-- @param  oldVal string  The old value of the convar
-- @param  newVal string  The new value of the convar
function OnConVarChanged( name,  oldVal,  newVal) end

--- cvars.RemoveChangeCallback
-- @usage shared_m
-- Removes a callback for a convar using the the callback's identifier. The identifier should be the third argument specified for cvars.AddChangeCallback.
--
-- @param  name string  The name of the convar to remove the callback from.
-- @param  indentifier string  The callback's identifier.
function RemoveChangeCallback( name,  indentifier) end

--- cvars.String
-- @usage shared_m
-- Retrieves console variable as a string.
--
-- @param  cvar string  Name of console variable
-- @param  default=nil any  The value to return if the console variable does not exist
-- @return string Retrieved value
function String( cvar,  default) end

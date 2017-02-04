---
-- @description Library numpad
 module("numpad")

--- numpad.Activate
-- @usage server
-- Activates numpad key owned by the player
--
-- @param  ply Player  The player whose numpad should be simulated
-- @param  key number  The key to press, see KEY_ Enums
-- @param  isButton boolean  Should this keypress pretend to be a from a gmod_button? (causes numpad.FromButton to return true)
function Activate( ply,  key,  isButton) end

--- numpad.Deactivate
-- @usage server
-- Deactivates numpad key owned by the player
--
-- @param  ply Player  The player whose numpad should be simulated
-- @param  key number  The key to press, corresponding to KEY_ Enums
-- @param  isButton boolean  Should this keypress pretend to be a from a gmod_button? (causes numpad.FromButton to return true)
function Deactivate( ply,  key,  isButton) end

--- numpad.FromButton
-- @usage server
-- Returns true during a function added with  numpad.Register when the third argument to numpad.Activate is true.
--
-- @return boolean wasButton
function FromButton() end

--- numpad.OnDown
-- @usage server
-- Calls a function registered with numpad.Register when a player presses specified key.
--
-- @param  ply Player  The player whose numpad should be watched
-- @param  key number  The key, corresponding to KEY_ Enums
-- @param  name string  The name of the function to run, corresponding with the one used in numpad.Register
-- @param  ... vararg  Arguments to pass to the function passed to numpad.Register.
-- @return number The impulse ID
function OnDown( ply,  key,  name,  ...) end

--- numpad.OnUp
-- @usage server
-- Calls a function registered with numpad.Register when a player releases specified key.
--
-- @param  ply Player  The player whose numpad should be watched
-- @param  key number  The key, corresponding to KEY_ Enums
-- @param  name string  The name of the function to run, corresponding with the one used in numpad.Register
-- @param  ... vararg  Arguments to pass to the function passed to numpad.Register.
-- @return number The impulse ID
function OnUp( ply,  key,  name,  ...) end

--- numpad.Register
-- @usage server
-- Registers a numpad library action for use with numpad.OnDown and numpad.OnUp
--
-- @param  id string  The unique id of your action.
-- @param  func function  The function to be executed. Arguments are: Player ply - The player who pressed the button vararg ... - The 4th and all subsequent arguments passed from numpad.OnDown and/or numpad.OnUp   Returning false in this function will remove the listener which triggered this function (example: return false if one of your varargs is an entity which is no longer valid)
function Register( id,  func) end

--- numpad.Remove
-- @usage server
-- Removes a function added by either numpad.OnUp or numpad.OnDown
--
-- @param  ID number  The impulse ID returned by numpad.OnUp or numpad.OnDown
function Remove( ID) end

--- numpad.Toggle
-- @usage server
-- Either runs numpad.Activate or numpad.Deactivate depending on the key's current state
--
-- @param  ply Player  The player whose numpad should be simulated
-- @param  key number  The key to press, corresponding to KEY_ Enums
function Toggle( ply,  key) end

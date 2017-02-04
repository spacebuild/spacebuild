---
-- @description Library concommand
 module("concommand")

--- concommand.Add
-- @usage shared_m
-- Creates a console command that runs a function in lua with optional autocompletion function and help text.
--
-- @param  name string  The command name to be used in console.  This cannot be a name of existing console command or console variable. It will silently fail if it is.
-- @param  callback function  The function to run when the concommand is executed. Arguments passed are:   Player ply - The player the ran the concommand. NULL entity if command was entered with the dedicated server console.  string cmd - The concommand string (if one callback is used for several concommands).  table args - A table of all string arguments.  string argStr - The arguments as a string.
-- @param  autoComplete=nil function  The function to call which should return a table of options for autocompletion. (Autocompletion Tutorial) This only properly works on the client since it is not networked. Arguments passed are:   string cmd - The concommand this autocompletion is for.  string args - The arguments typed so far.
-- @param  helpText=nil string  The text to display should a user run 'help cmdName'.
-- @param  flags=0 number  Concommand modifier flags. See FCVAR_ Enums.
function Add( name,  callback,  autoComplete,  helpText,  flags) end

--- concommand.AutoComplete
-- @usage shared_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  command string  Name of command
-- @param  arguments string  Arguments given to the command
-- @return table Possibilities for auto-completion. This is the return value of the auto-complete callback.
function AutoComplete( command,  arguments) end

--- concommand.GetTable
-- @usage shared_m
-- Returns the tables of all console command callbacks, and autocomplete functions, that were added to the game with concommand.Add.
--
-- @return table Table of command callback functions.
-- @return table Table of command autocomplete functions.
function GetTable() end

--- concommand.Remove
-- @usage shared_m
-- Removes a console command.
--
-- @param  name string  The name of the command to be removed.
function Remove( name) end

--- concommand.Run
-- @usage shared_m
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
--
--You might be looking for RunConsoleCommand or Player:ConCommand.
-- @param  ply Player  Player to run concommand on
-- @param  cmd string  Command name
-- @param  args any  Command arguments.  Can be table or string
-- @param  argumentString string  string of all arguments sent to the command
-- @return boolean true if the console command with the given name exists, and false if it doesn't.
function Run( ply,  cmd,  args,  argumentString) end

---
-- @description Library undo
 module("undo")

--- undo.AddEntity
-- @usage server
-- Adds an entity to the current undo block
--
-- @param  ent Entity  The entity to add
function AddEntity( ent) end

--- undo.AddFunction
-- @usage server
-- Adds a function to call when the current undo block is undone
--
-- @param  func function  The function to call
-- @param  arg2, ... any  Arguments to pass to the function (after the undo info table)
function AddFunction( func,  arg2, ...) end

--- undo.Create
-- @usage server
-- Begins a new undo entry
--
-- @param  name string  Name of the undo message to show to players
function Create( name) end

--- undo.Do_Undo
-- @usage server
-- Processes an undo block (in table form). This is used internally by the undo manager when a player presses Z.
--
-- @param  tab table  The undo block to process as an Undo structure
-- @return number Number of removed entities
function Do_Undo( tab) end

--- undo.Finish
-- @usage shared
-- Completes an undo entry, and registers it with the player's client
--
function Finish() end

--- undo.GetTable
-- @usage shared
-- Serverside, returns a table containing all undo blocks of all players. Clientside, returns a table of the local player's undo blocks.
--
-- @return table The undo table.
function GetTable() end

--- undo.MakeUIDirty
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function MakeUIDirty() end

--- undo.ReplaceEntity
-- @usage server
-- Replaces any instance of the "from" reference with the "to" reference, in any existing undo block. Returns true if something was replaced
--
-- @param  from Entity  The old entity
-- @param  to Entity  The new entity to replace the old one
-- @return boolean somethingReplaced
function ReplaceEntity( from,  to) end

--- undo.SetCustomUndoText
-- @usage server
-- Sets a custom undo text for the current undo block
--
-- @param  customText string  The text to display when the undo block is undone
function SetCustomUndoText( customText) end

--- undo.SetPlayer
-- @usage server
-- Sets the player which the current undo block belongs to
--
-- @param  ply Player  The player responsible for undoing the block
function SetPlayer( ply) end

--- undo.SetupUI
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function SetupUI() end

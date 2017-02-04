---
-- @description Library drive
 module("drive")

--- drive.CalcView
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ply Player  The player
-- @param  view table  The view, see ViewData structure
-- @return boolean true if succeeded
function CalcView( ply,  view) end

--- drive.CreateMove
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  cmd CUserCmd  The user command
-- @return boolean true if succeeded
function CreateMove( cmd) end

--- drive.DestroyMethod
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ply Player  The player to affect
function DestroyMethod( ply) end

--- drive.End
-- @usage shared
-- Player has stopped driving the entity.
--
-- @param  ply Player  The player
-- @param  ent Entity  The entity
function End( ply,  ent) end

--- drive.FinishMove
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ply Player  The player
-- @param  mv CMoveData  The move data
-- @return boolean true if succeeded
function FinishMove( ply,  mv) end

--- drive.GetMethod
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ply Player  The player
-- @return table A method object.
function GetMethod( ply) end

--- drive.Move
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ply Player  The player
-- @param  mv CMoveData  The move data
-- @return boolean true if succeeded
function Move( ply,  mv) end

--- drive.PlayerStartDriving
-- @usage shared
-- Starts driving for the player.
--
-- @param  ply Player  The player to affect
-- @param  ent Entity  The entity to drive
-- @param  mode string  The driving mode
function PlayerStartDriving( ply,  ent,  mode) end

--- drive.PlayerStopDriving
-- @usage shared
-- Stops the player from driving anything. ( For example a prop in sandbox )
--
-- @param  ply Player  The player to affect
function PlayerStopDriving( ply) end

--- drive.Register
-- @usage shared
-- Registers a new entity drive.
--
-- @param  name string  The name of the drive.
-- @param  data table  The data required to create the drive. This includes the functions used by the drive.
-- @param  base string  The base of the drive.
function Register( name,  data,  base) end

--- drive.Start
-- @usage shared
-- Called when the player first starts driving this entity
--
-- @param  ply Player  The player
-- @param  ent Entity  The entity
function Start( ply,  ent) end

--- drive.StartMove
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ply Player  The player
-- @param  mv CMoveData  The move data
-- @param  cmd CUserCmd  The user command
-- @return boolean true if succeeded
function StartMove( ply,  mv,  cmd) end

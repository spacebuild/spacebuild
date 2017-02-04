---
-- @description Library game
 module("game")

--- game.AddAmmoType
-- @usage shared
-- Adds a new ammo type to the game.
--
-- @param  ammoData table  The attributes of the ammo. See the AmmoData structure.
function AddAmmoType( ammoData) end

--- game.AddDecal
-- @usage shared
-- Registers a new decal.
--
-- @param  decalName string  The name of the decal.
-- @param  materialName string  The material to be used for the decal. May also be a list of material names, in which case a random material from that list will be chosen every time the decal is placed.
function AddDecal( decalName,  materialName) end

--- game.AddParticles
-- @usage shared
-- Loads a particle file.
--
-- @param  particleFileName string  The path of the file to add. Must be (file).pcf.
function AddParticles( particleFileName) end

--- game.BuildAmmoTypes
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @return table All ammo types registered via game.AddAmmoType, sorted by its name value.
function BuildAmmoTypes() end

--- game.CleanUpMap
-- @usage shared
-- If called serverside it will remove ALL entities which were not created by the map(not players or weapons held by players).
--
-- @param  dontSendToClients=false boolean  If set to true, don't run this functions on all clients.
-- @param  ExtraFilters={} table  Entity classes not to reset during cleanup.
function CleanUpMap( dontSendToClients,  ExtraFilters) end

--- game.ConsoleCommand
-- @usage server
-- Runs a console command.
--Make sure to add a newline ("\n") at the end of the command.
--
-- @param  stringCommand string  String containing the command and arguments to be ran.
function ConsoleCommand( stringCommand) end

--- game.GetAmmoID
-- @usage shared
-- Returns the ammo type ID for given ammo type name.
--
-- @param  name string  Name of the ammo type to look up ID of
-- @return number The ammo type ID of given ammo type name, or -1 if not found
function GetAmmoID( name) end

--- game.GetAmmoMax
-- @usage shared
-- Returns the real maximum amount of ammo of given ammo ID.
--
-- @param  id number  Ammo type ID
-- @return number The maximum amount of reserve ammo a player can hold of this ammo type.
function GetAmmoMax( id) end

--- game.GetAmmoName
-- @usage shared
-- Returns the ammo name for given ammo type ID.
--
-- @param  id number  Ammo ID to retrieve the name of. Starts from 1.
-- @return string The name of given ammo type ID or nil if ammo type ID is invalid.
function GetAmmoName( id) end

--- game.GetIPAddress
-- @usage shared
-- Returns the public IP address and port of the current server. This will return the IP/port that you are connecting through when ran clientside.
--
-- @return string The IP address and port in the format "x.x.x.x:x"
function GetIPAddress() end

--- game.GetMap
-- @usage shared_m
-- Returns the name of the current map, without a file extension.
--On the menu state, returns "menu".
--
-- @return string The name of the current map, without a file extension.
function GetMap() end

--- game.GetMapNext
-- @usage server
-- Returns the next map that would be loaded according to the file that is set by the mapcyclefile convar.
--
-- @return string nextMap
function GetMapNext() end

--- game.GetMapVersion
-- @usage shared
-- Returns the VBSP version of the current map.
--
-- @return number mapVersion
function GetMapVersion() end

--- game.GetSkillLevel
-- @usage shared
-- Returns the difficulty level of the game.
--
-- @return number The difficulty level, Easy( 1 ), Normal( 2 ), Hard( 3 ).
function GetSkillLevel() end

--- game.GetTimeScale
-- @usage shared
-- Returns the timescale of the game
--
-- @return number timeScale
function GetTimeScale() end

--- game.GetWorld
-- @usage shared
-- Returns the worldspawn entity.
--
-- @return Entity The world
function GetWorld() end

--- game.IsDedicated
-- @usage shared
-- Returns true if the server is a dedicated server, false if it is a Listen server or a singleplayer game.
--
-- @return boolean Is the server dedicated or not.
function IsDedicated() end

--- game.KickID
-- @usage server
-- Kicks a player from the server. This can be ran before the player has spawned.
--
-- @param  id string  UserID or SteamID of the player to kick.
-- @param  reason="No reason given" string  Reason to display to the player. This can span across multiple lines.
function KickID( id,  reason) end

--- game.LoadNextMap
-- @usage server
-- Loads the next map according to the nextlevel convar, or from the current mapcycle file set by the respective convar.
--
function LoadNextMap() end

--- game.MapLoadType
-- @usage server
-- Returns the map load type of the current map.
--
-- @return string The load type. Possible values are: "newgame", "loadgame", "transition", "background".
function MapLoadType() end

--- game.MaxPlayers
-- @usage shared
-- Returns the maximum number of players for this server.
--
-- @return number maxPlayers
function MaxPlayers() end

--- game.MountGMA
-- @usage shared
-- Mounts a GMA addon from the disk. Any error models currently loaded that the mounted addon provides will be reloaded.
--
-- @param  path string  Location of the GMA file to mount, relative to the garrysmod directory
-- @return boolean success
-- @return table If successful, a table of files that have been mounted
function MountGMA( path) end

--- game.RemoveRagdolls
-- @usage shared
-- Removes all the clientside ragdolls.
--
function RemoveRagdolls() end

--- game.SetSkillLevel
-- @usage server
-- Sets the difficulty level of the game, can be retrieved with game.GetSkillLevel.
--
-- @param  level number  The difficulty level, Easy( 1 ), Normal( 2 ), Hard( 3 ).
function SetSkillLevel( level) end

--- game.SetTimeScale
-- @usage server
-- Sets the time scale of the game.
--
-- @param  timeScale number  The new timescale, minimum value is 0.001 and maximum is 5.
function SetTimeScale( timeScale) end

--- game.SinglePlayer
-- @usage shared
-- Returns whenever the current session is a single player game.
--
-- @return boolean isSinglePlayer
function SinglePlayer() end

--- game.StartSpot
-- @usage shared
-- Returns position the player should start from, this is not the same thing as spawn points, it is used to properly transit the player between maps.
--
-- @return Vector startSpot
function StartSpot() end

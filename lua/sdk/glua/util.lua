---
-- @description Library util
 module("util")

--- util.AddNetworkString
-- @usage server
-- Adds the specified string to a string table, which will cache it and network it to all clients automatically.
--Whenever you want to create a net message with net.Start, you must add the name of that message as a networked string via this function.
--
-- @param  str string  Adds the specified string to the string table.
-- @return number The id of the string that was added to the string table. Same as calling util.NetworkStringToID.
function AddNetworkString( str) end

--- util.AimVector
-- @usage shared_m
-- Function used to calculate aim vector from 2D screen position. It is used in SuperDOF calculate Distance.
--
-- @param  ViewAngles Angle  View angles
-- @param  ViewFOV number  View Field of View
-- @param  x number  Mouse X position
-- @param  y number  Mouse Y position
-- @param  scrWidth number  Screen width
-- @param  scrHeight number  Screen height
-- @return Vector Calculated aim vector
function AimVector( ViewAngles,  ViewFOV,  x,  y,  scrWidth,  scrHeight) end

--- util.Base64Encode
-- @usage shared_m
-- Encodes the specified string to base64.
--
-- @param  str string  String to encode.
-- @return string Base 64 encoded string, or nil for a zero length string.
function Base64Encode( str) end

--- util.BlastDamage
-- @usage server
-- Applies explosion damage to all entities in the specified radius.
--
-- @param  inflictor Entity  The entity that caused the damage.
-- @param  attacker Entity  The entity that attacked.
-- @param  damageOrigin Vector  The center of the explosion
-- @param  damageRadius number  The radius in which entities will be damaged.
-- @param  damage number  The amount of damage to be applied.
function BlastDamage( inflictor,  attacker,  damageOrigin,  damageRadius,  damage) end

--- util.BlastDamageInfo
-- @usage server
-- Applies spherical damage based on damage info to all entities in the specified radius.
--
-- @param  dmg CTakeDamageInfo  The information about the damage
-- @param  damageOrigin Vector  Center of the spherical damage
-- @param  damageRadius number  The radius in which entities will be damaged.
function BlastDamageInfo( dmg,  damageOrigin,  damageRadius) end

--- util.Compress
-- @usage shared_m
-- Compresses the given string using the LZMA algorithm.
--
-- @param  str string  String to compress.
-- @return string The compressed string, or nil if the input string was zero length ("").
function Compress( str) end

--- util.CRC
-- @usage shared
-- Generates the CRC checksum of the specified string.
--
-- @param  stringToHash string  The string to calculate the checksum of.
-- @return string The unsigned 32 bit checksum.
function CRC( stringToHash) end

--- util.DateStamp
-- @usage shared_m
-- Returns the current date formatted like '2012-10-31 18-00-00'
--
-- @return string date
function DateStamp() end

--- util.Decal
-- @usage shared
-- Performs a trace and paints a decal to the surface hit.
--
-- @param  decalName string  The name of the decal to paint.
-- @param  traceStart Vector  The start of the trace.
-- @param  traceEnd Vector  The end of the trace.
-- @param  dontSendToPredictedPlayer=false boolean  Don't network this decal to the player currently set for use by SuppressHostEvents.  Set this to true if you are using this function in a predicted context such as a weapon.
function Decal( decalName,  traceStart,  traceEnd,  dontSendToPredictedPlayer) end

--- util.DecalEx
-- @usage client
-- Performs a trace and paints a decal to the surface hit.
--
-- @param  material IMaterial  The name of the decal to paint.
-- @param  ent Entity  The start of the trace.
-- @param  position Vector  The position of the decal.
-- @param  normal Vector  The normal of the decal.
-- @param  color table  The color of the decal. Uses the Color structure.
-- @param  w number  The width of the decal.
-- @param  h number  The height of the decal.
function DecalEx( material,  ent,  position,  normal,  color,  w,  h) end

--- util.DecalMaterial
-- @usage shared
-- Gets the full material path by the decal name.
--
-- @param  decalName string  Name of the decal.
-- @return string materialPath
function DecalMaterial( decalName) end

--- util.Decompress
-- @usage shared_m
-- Decompresses the given string using LZMA algorithm. Used to decompress strings previously compressed with util.Compress.
--
-- @param  compressedString string  The compressed string to decompress.
-- @return string The original, decompressed string.
function Decompress( compressedString) end

--- util.DistanceToLine
-- @usage shared
-- Gets the distance between a line and a point in 3d space.
--
-- @param  lineStart Vector  Start of the line.
-- @param  lineEnd Vector  End of the line.
-- @param  pointPos Vector  The position of the point.
-- @return number distance
function DistanceToLine( lineStart,  lineEnd,  pointPos) end

--- util.Effect
-- @usage shared
-- Creates a effect with the specified data.
--
-- @param  effectName string  The name of the effect to create.
-- @param  effectData CEffectData  The effect data describing the effect.
-- @param  allowOverride=true boolean  If this is an engine-defined effect, this controls whether or not we can be overridden by Lua defined scripted effects with the same name.
-- @param  ignorePredictionOrRecipientFilter=nil any  Can either be a boolean to ignore the prediction filter or a CRecipientFilter.  Set this to true if you wish to call this function in multiplayer from server.
function Effect( effectName,  effectData,  allowOverride,  ignorePredictionOrRecipientFilter) end

--- util.GetModelInfo
-- @usage shared
-- Returns a table containing the info about the model. It seems to be not working serverside, but still exists serverside.
--
-- @param  mdl string  Model path
-- @return table The model info
function GetModelInfo( mdl) end

--- util.GetPData
-- @usage shared_m
-- Gets PData of an offline player using their SteamID
--
-- @param  steamID string  SteamID of the player
-- @param  name string  Variable name to get the value of
-- @param  default string  The default value, in case there's nothing stored
-- @return string The stored value
function GetPData( steamID,  name,  default) end

--- util.GetPixelVisibleHandle
-- @usage client
-- Creates a new PixVis handle. See util.PixelVisible.
--
-- @return pixelvis handle t PixVis
function GetPixelVisibleHandle() end

--- util.GetPlayerTrace
-- @usage shared_m
-- Utility function to quickly generate a trace table that starts at the players view position, and ends 16384 units along a specified direction.
--
-- @param  ply Player  The player the trace should be based on
-- @param  dir=ply:GetAimVector() Vector  The direction of the trace
-- @return table The trace data. See Trace structure
function GetPlayerTrace( ply,  dir) end

--- util.GetSunInfo
-- @usage client
-- Gets information about the sun position and obstruction or nil if there is no sun.
--
-- @return table The sun info. See SunInfo structure
function GetSunInfo() end

--- util.GetSurfaceIndex
-- @usage shared
-- Returns the matching surface index for the surface name.
--
-- @param  surfaceName string  The name of the surface.
-- @return number surfaceIndex
function GetSurfaceIndex( surfaceName) end

--- util.GetSurfacePropName
-- @usage shared
-- Returns a name of surfaceproperties ID.
--
-- @param  id number  Surface properties ID. You can get it from TraceResult structure.
-- @return string The name
function GetSurfacePropName( id) end

--- util.GetUserGroups
-- @usage server
-- Returns a table of all SteamIDs that have a usergroup.
--
-- @return table The table of users. The table consists of SteamID-Table pairs, where the table has 2 fields: string name - Players name  string group - The players user group
function GetUserGroups() end

--- util.IntersectRayWithOBB
-- @usage shared
-- Performs a ray box intersection and returns position, normal and the fraction.
--
-- @param  rayStart Vector  Any position on the ray.
-- @param  rayDirection Vector  The direction of the ray. Note that this is not a true ray: the trace is only as long as the length.
-- @param  boxOrigin Vector  The center of the box.
-- @param  boxAngles Angle  The angles of the box.
-- @param  boxMins Vector  The min position of the box.
-- @param  boxMaxs Vector  The max position of the box.
-- @return Vector Hit position
-- @return Vector Normal/direction vector
-- @return number Fraction of trace used
function IntersectRayWithOBB( rayStart,  rayDirection,  boxOrigin,  boxAngles,  boxMins,  boxMaxs) end

--- util.IntersectRayWithPlane
-- @usage shared
-- Performs a ray plane intersection and returns the hit position or nil.
--
-- @param  rayOrigin Vector  Any position of the ray.
-- @param  rayDirection Vector  The direction of the ray.
-- @param  planePosition Vector  Any position on the plane.
-- @param  planeNormal Vector  The normal vector of the plane.
-- @return Vector The position of intersection.
function IntersectRayWithPlane( rayOrigin,  rayDirection,  planePosition,  planeNormal) end

--- util.IsInWorld
-- @usage server
-- Checks if a certain position in within the world bounds.
--
-- @param  position Vector  Position to check.
-- @return boolean Whether the vector is in world.
function IsInWorld( position) end

--- util.IsModelLoaded
-- @usage shared
-- Checks if the model is loaded in the game.
--
-- @param  modelName string  Name/Path of the model to check.
-- @return boolean Returns true if the model is loaded in the game; otherwise false.
function IsModelLoaded( modelName) end

--- util.IsSkyboxVisibleFromPoint
-- @usage client
-- Returns whenever the skybox is visibile from the point specified.
--
-- @param  position Vector  The position to check the skybox visibility from.
-- @return boolean skyboxVisible
function IsSkyboxVisibleFromPoint( position) end

--- util.IsValidModel
-- @usage shared
-- Checks if the specified model is valid.
--
-- @param  modelName string  Name/Path of the model to check.
-- @return boolean Whether the model is valid or not.
function IsValidModel( modelName) end

--- util.IsValidPhysicsObject
-- @usage shared_m
-- Checks if given numbered physics object of given entity is valid or not. Most useful for ragdolls.
--
-- @param  ent Entity  The entity
-- @param  physobj number  Number of the physics object to test
-- @return boolean true is valid, false otherwise
function IsValidPhysicsObject( ent,  physobj) end

--- util.IsValidProp
-- @usage shared
-- Checks if the specified prop is valid.
--
-- @param  modelName string  Name/Path of the model to check.
-- @return boolean Returns true if the specified prop is valid; otherwise false.
function IsValidProp( modelName) end

--- util.IsValidRagdoll
-- @usage shared
-- Checks if the specified model name points to a valid ragdoll.
--
-- @param  ragdollName string  Name/Path of the ragdoll model to check.
-- @return boolean Returns true if the specified model name points to a valid ragdoll; otherwise false.
function IsValidRagdoll( ragdollName) end

--- util.JSONToTable
-- @usage shared_m
-- Converts a JSON string to a Lua table.
--
-- @param  json string  The JSON string to convert.
-- @return table The table containing converted information. Returns nothing on failure.
function JSONToTable( json) end

--- util.KeyValuesToTable
-- @usage shared_m
-- Converts a KeyValue string to a Lua table.
--
-- @param  KeyValuestring string  The KeyValue string to convert.
-- @param  usesEscapeSequences=false boolean 
-- @param  preserveKeyCase=false boolean  Whether we should preserve key case or not.
-- @return table The converted table
function KeyValuesToTable( KeyValuestring,  usesEscapeSequences,  preserveKeyCase) end

--- util.KeyValuesToTablePreserveOrder
-- @usage shared_m
-- Similar to util.KeyValuesToTable but it also preserves order of keys.
--
-- @param  keyvals string  The key value string
-- @param  usesEscapeSequences=false boolean 
-- @param  preserveKeyCase=false boolean  Whether we should preserve key case or not.
-- @return table The output table
function KeyValuesToTablePreserveOrder( keyvals,  usesEscapeSequences,  preserveKeyCase) end

--- util.LocalToWorld
-- @usage shared_m
-- Returns a vector in world coordinates based on an entity and local coordinates
--
-- @param  ent Entity  The entity lpos is local to
-- @param  lpos Vector  Coordinates local to the ent
-- @param  bonenum number  The bonenumber of the ent lpos is local to
-- @return Vector wpos
function LocalToWorld( ent,  lpos,  bonenum) end

--- util.NetworkIDToString
-- @usage shared
-- Returns the networked string associated with the given ID from the string table.
--
-- @param  stringTableID number  ID to get the associated string from.
-- @return string The networked string, or nil if it wasn't found.
function NetworkIDToString( stringTableID) end

--- util.NetworkStringToID
-- @usage shared
-- Returns the networked ID associated with the given string from the string table.
--
-- @param  networkString string  String to get the associated networked ID from.
-- @return number The networked ID of the string, or 0 if it hasn't been networked with util.AddNetworkString.
function NetworkStringToID( networkString) end

--- util.NiceFloat
-- @usage shared_m
-- Formats a float by stripping off extra 0's and .'s
--
-- @param  float number  The float to format
-- @return string Formatted float
function NiceFloat( float) end

--- util.ParticleTracer
-- @usage shared
-- Creates a tracer effect with the given parameters.
--
-- @param  name string  The name of the tracer effect.
-- @param  startPos Vector  The start position of the tracer.
-- @param  endPos Vector  The end position of the tracer.
-- @param  doWhiz boolean  Play the hit miss(whiz) sound.
function ParticleTracer( name,  startPos,  endPos,  doWhiz) end

--- util.ParticleTracerEx
-- @usage shared
-- Creates a tracer effect with the given parameters.
--
-- @param  name string  The name of the tracer effect.
-- @param  startPos Vector  The start position of the tracer.
-- @param  endPos Vector  The end position of the tracer.
-- @param  doWhiz boolean  Play the hit miss(whiz) sound.
-- @param  entityIndex number  Entity index of the emitting entity.
-- @param  attachmentIndex number  Attachment index to be used as origin.
function ParticleTracerEx( name,  startPos,  endPos,  doWhiz,  entityIndex,  attachmentIndex) end

--- util.PixelVisible
-- @usage client
-- Returns the visibility of a sphere in the world.
--
-- @param  position Vector  The center of the visibility test.
-- @param  radius number  The radius of the sphere to check for visibility.
-- @param  PixVis pixelvis handle t  The PixVis handle. Created with util.GetPixelVisibleHandle. Don't use the same handle twice per tick or it will give unpredictable results.
-- @return number Visibility. Ranges from 0-1: 0 when none of the area is visible, 1 when all of it is visible.
function PixelVisible( position,  radius,  PixVis) end

--- util.PointContents
-- @usage shared
-- Returns the contents of the position specified.
--
-- @param  position Vector  Position to get the contents sample from.
-- @return number Contents bitflag, see CONTENTS_ Enums
function PointContents( position) end

--- util.PrecacheModel
-- @usage shared
-- Precaches a model for later use. Model is cached after being loaded once.
--
-- @param  modelName string  The model to precache.
function PrecacheModel( modelName) end

--- util.PrecacheSound
-- @usage shared
-- Precaches a sound for later use. Sound is cached after being loaded once.
--
-- @param  soundName string  The sound to precache.
function PrecacheSound( soundName) end

--- util.QuickTrace
-- @usage shared_m
-- Performs a trace with the given origin, direction and filter.
--
-- @param  origin Vector  The origin of the trace.
-- @param  direction Vector  The end point of the trace, relative to the start.  This is the direction of the trace times the distance of the trace.
-- @param  filter=nil Entity  Entity which should be ignored by the trace. Can also be a table of entities.
-- @return table Trace result. See TraceResult structure
function QuickTrace( origin,  direction,  filter) end

--- util.RelativePathToFull
-- @usage shared
-- Returns the absolute system path the file relative to /garrysmod/.
--
-- @param  file string  The file to get the absolute path of.
-- @return string absolutePath
function RelativePathToFull( file) end

--- util.RemovePData
-- @usage shared_m
-- Removes PData of offline player using his SteamID
--
-- @param  steamID string  SteamID of the player
-- @param  name string  Variable name to remove
function RemovePData( steamID,  name) end

--- util.ScreenShake
-- @usage shared
-- Makes the screen shake
--
-- @param  pos Vector  The origin of the effect
-- @param  amplitude number  The strength of the effect
-- @param  frequency number  The frequency of the effect in hz
-- @param  duration number  The duration of the effect in seconds
-- @param  radius number  The range from the origin within which views will be affected, in Hammer Units
function ScreenShake( pos,  amplitude,  frequency,  duration,  radius) end

--- util.SetPData
-- @usage shared_m
-- Sets PData for offline player using his SteamID
--
-- @param  steamID string  SteamID of the player
-- @param  name string  Variable name to store the value in
-- @param  value any  The value to store
function SetPData( steamID,  name,  value) end

--- util.SharedRandom
-- @usage shared
-- Generates a random float value that should be the same on client and server.
--
-- @param  uniqueName string  The seed for the random value
-- @param  min number  The minimum value of the random range
-- @param  max number  The maximum value of the random range
-- @param  additionalSeed=0 number  The additional seed
-- @return number The random float value
function SharedRandom( uniqueName,  min,  max,  additionalSeed) end

--- util.SpriteTrail
-- @usage server
-- Adds a trail to the specified entity.
--
-- @param  ent Entity  Entity to attach trail to
-- @param  attachmentID number  Attachment ID of the entitiys model to attach trail to. If you are not sure, set this to 0
-- @param  color table  Color of the trail, use Color
-- @param  additive boolean  Should the trail be additive or not
-- @param  startWidth number  Start width of the trail
-- @param  endWidth number  End width of the trail
-- @param  lifetime number  How long it takes to transition from startWidth to endWidth
-- @param  textureRes number  The resolution of trails texture. A good value can be calculated using this formula: 1 / ( startWidth + endWidth ) * 0.5
-- @param  texture string  Path to the texture to use as a trail. Note that you should also include the ".vmt" or the game WILL crash!
-- @return Entity Entity of created trail (env_spritetrail)
function SpriteTrail( ent,  attachmentID,  color,  additive,  startWidth,  endWidth,  lifetime,  textureRes,  texture) end

--- util.Stack
-- @usage shared_m
-- Returns a new Stack object
--
-- @return Stack A brand new stack object
function Stack() end

--- util.SteamIDFrom64
-- @usage shared
-- Given a 64bit SteamID will return a STEAM_0: style Steam ID
--
-- @param  id string  The 64 bit Steam ID
-- @return string STEAM_0 style Steam ID
function SteamIDFrom64( id) end

--- util.SteamIDTo64
-- @usage shared
-- Given a STEAM_0 style Steam ID will return a 64bit Steam ID
--
-- @param  id string  The STEAM_0 style id
-- @return string 64bit Steam ID
function SteamIDTo64( id) end

--- util.StringToType
-- @usage shared_m
-- Converts a string to the specified type.
--
-- @param  str string  The string to convert
-- @param  typename string  The type to attempt to convert the string to. This can be vector, angle, float, int, bool, or string (case insensitive).
-- @return any The result of the conversion, or nil if a bad type is specified.
function StringToType( str,  typename) end

--- util.TableToJSON
-- @usage shared_m
-- Converts a table to a JSON string.
--
-- @param  table table  Table to convert.
-- @param  prettyPrint=false boolean  Format and indent the JSON.
-- @return string JSON
function TableToJSON( table,  prettyPrint) end

--- util.TableToKeyValues
-- @usage shared_m
-- Converts the given table into a key value string.
--
-- @param  table table  The table to convert.
-- @return string KeyValueString
function TableToKeyValues( table) end

--- util.Timer
-- @usage shared_m
-- Creates a timer object.
--
-- @param  startdelay=0 number 
-- @return table A timer object. It has next methods: Reset() - Resets the timer to nothing Start( time ) - Starts the timer, call with end time Started() - Returns true if the timer has been started Elapsed() - Returns true if the time has elapsed
function Timer( startdelay) end

--- util.TimerCycle
-- @usage shared_m
-- Returns the time since this function has been last called
--
-- @return number Time since this function has been last called in ms
function TimerCycle() end

--- util.tobool
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use tobool instead.
-- @param  input any  A string or a number to convert.
-- @return boolean False if the input is equal to the string or boolean "false", if the input is equal to the string or number "0", or if the input is nil. Returns true otherwise.
function tobool( input) end

--- util.TraceEntity
-- @usage shared
-- Runs a trace using the ent's collisionmodel between two points.
--
-- @param  tracedata table  Trace data. See Trace structure
-- @param  ent Entity  The entity to use
-- @return table Trace result. See TraceResult structure
function TraceEntity( tracedata,  ent) end

--- util.TraceEntityHull
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This function is broken and returns the same values all the time
-- @param  ent1 Entity  The first entity to trace from
-- @param  ent2 Entity  The second entity to trace to
-- @return table Trace result. See TraceResult structure
function TraceEntityHull( ent1,  ent2) end

--- util.TraceHull
-- @usage shared
-- Performs a hull trace with the given trace data. This function is shared but will not give the desired results on the client; you should only use this serverside as the function utilizes certain physics mechanisms that do not exist on the client.
--
-- @param  TraceData table  The trace data to use. See HullTrace structure
-- @return table Trace result. See TraceResult structure
function TraceHull( TraceData) end

--- util.TraceLine
-- @usage shared
-- Performs a trace with the given trace data.
--
-- @param  TraceData table  The trace data to use. See Trace structure
-- @return table Trace result. See TraceResult structure
function TraceLine( TraceData) end

--- util.TypeToString
-- @usage shared_m
-- Converts a type to a (nice, but still parsable) string
--
-- @param  input any  What to convert
-- @return string Converted string
function TypeToString( input) end

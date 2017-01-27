---
-- @description Library construct
 module("construct")

--- construct.Magnet
-- @usage server
-- Creates a magnet.
--
-- @param  ply Player  Player that will have the numpad control over the magnet
-- @param  pos Vector  The position of the magnet
-- @param  ang Angle  The angles of the magnet
-- @param  model string  The model of the maget
-- @param  material string  Material of the magnet ( texture )
-- @param  key number  The key to toggle the magnet, see KEY_ Enums
-- @param  maxObjects number  Maximum amount of objects the magnet can hold
-- @param  strength number  Strength of the magnet
-- @param  nopull=0 number  If > 0, disallows the magnet to pull objects towards it
-- @param  allowrot=0 number  If > 0, allows rotation of the objects attached
-- @param  startOn=0 number  If > 0, enabled from spawn
-- @param  toggle number  If != 0, pressing the key toggles the magnet, otherwise you'll have to hold the key to keep it enabled
-- @param  vel=Vector( 0, 0, 0 ) Vector  Velocity to set on spawn
-- @param  aVel=Angle( 0, 0, 0 ) Angle  Angular velocity to set on spawn
-- @param  frozen=false boolean  Freeze the magnet on start
-- @return Entity The magnet
function Magnet( ply,  pos,  ang,  model,  material,  key,  maxObjects,  strength,  nopull,  allowrot,  startOn,  toggle,  vel,  aVel,  frozen) end

--- construct.SetPhysProp
-- @usage server
-- Sets props physical properties.
--
-- @param  ply Player  The player. This variable is not used and can be left out.
-- @param  ent Entity  The entity to apply properties to
-- @param  physObjID number  You can use this or the argument below. This will be used in case you don't provide argument below.
-- @param  physObj PhysObj  The physics object to apply the properties to
-- @param  data table  The table containing properties to apply. See PhysProperties structure
function SetPhysProp( ply,  ent,  physObjID,  physObj,  data) end

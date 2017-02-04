---
-- @description Library ENT_ANIM
 module("ENT_ANIM")

--- ENT_ANIM:Blocked
-- @usage server
-- Called when the entity is blocked.
--
-- @param  other Entity  The entity that is blocking this entity.
function Blocked( other) end

--- ENT_ANIM:Draw
-- @usage client
-- Called if and when the entity should be drawn opaquely, based on the Entity:GetRenderGroup of the entity.
--
-- @param  flags number  The bit flags from STUDIO_ Enums
function Draw( flags) end

--- ENT_ANIM:DrawTranslucent
-- @usage client
-- Called when the entity should be drawn translucently.
--
function DrawTranslucent() end

--- ENT_ANIM:EndTouch
-- @usage server
-- Called when the entity stops touching another entity.
--
-- @param  entity Entity  The entity which was touched.
function EndTouch( entity) end

--- ENT_ANIM:ImpactTrace
-- @usage client
-- Called when a bullet trace hits this entity and allows you to override the default behavior by returning true.
--
-- @param  traceResult table  The trace that hit this entity as a TraceResult structure.
-- @param  damageType number  The damage bits associated with the trace, see DMG_ Enums
-- @param  customImpactName=nil string  The effect name to override the impact effect with.  Possible arguments are ImpactJeep, AirboatGunImpact, HelicopterImpact, ImpactGunship.
-- @return boolean Return true to override the default impact effects.
function ImpactTrace( traceResult,  damageType,  customImpactName) end

--- ENT_ANIM:OnTakeDamage
-- @usage server
-- Called when the entity is taking damage.
--
-- @param  damage CTakeDamageInfo  The damage to be applied to the entity.
function OnTakeDamage( damage) end

--- ENT_ANIM:PhysicsCollide
-- @usage server
-- Called when the entity collides with anything.
--
-- @param  colData table  Information regarding the collision. See CollisionData structure.
-- @param  collider PhysObj  The physics object that collided.
function PhysicsCollide( colData,  collider) end

--- ENT_ANIM:PhysicsSimulate
-- @usage shared
-- Called from the Entity's motion controller to simulate physics.
--
-- @param  phys PhysObj  The physics object of the entity.
-- @param  deltaTime number  Time since the last call.
-- @return Vector Angular force
-- @return Vector Linear force
-- @return number One of the SIM_ Enums.
function PhysicsSimulate( phys,  deltaTime) end

--- ENT_ANIM:PhysicsUpdate
-- @usage shared
-- Called whenever the physics of the entity are updated.
--
-- @param  phys PhysObj  The physics object of the entity.
function PhysicsUpdate( phys) end

--- ENT_ANIM:StartTouch
-- @usage server
-- Called when the entity starts touching another entity.
--
-- @param  entity Entity  The entity which is being touched.
function StartTouch( entity) end

--- ENT_ANIM:TestCollision
-- @usage shared
-- Allows you to override trace result when a trace hits the entitys Bounding Box.
--
-- @param  startpos Vector  Start position of the trace
-- @param  delta Vector  Offset from startpos to the endpos of the trace
-- @param  isbox boolean  Is the trace a hull trace?
-- @param  extents Vector  Size of the hull trace?
-- @return table A table containing new HitPos, Fraction and Normal. Returning nothing allows the trace to ignore the entity completely.
function TestCollision( startpos,  delta,  isbox,  extents) end

--- ENT_ANIM:Touch
-- @usage server
-- Called when another entity touches the entity.
--
-- @param  entity Entity  The entity that touched it.
function Touch( entity) end

--- ENT_ANIM:UpdateTransmitState
-- @usage server
-- Called whenever the transmit state should be updated.
--
-- @return number Transmit state to set, see TRANSMIT_ Enums.
function UpdateTransmitState() end

--- ENT_ANIM:Use
-- @usage server
-- Called when another entity uses this entity, example would be a player pressing "+use" this entity.
--
-- @param  activator Entity  The initial cause for the input getting triggered.
-- @param  caller Entity  The entity that directly triggered the input.
-- @param  useType number  Use type, see USE_ Enums.
-- @param  value number  Any passed value.
function Use( activator,  caller,  useType,  value) end

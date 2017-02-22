--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

---
-- @description Library CLuaEmitter
 module("CLuaEmitter")

--- CLuaEmitter:Add
-- @usage client
-- Creates a new CLuaParticle with the given material and position.
--
-- @param  material string  The particles material. Can also be an IMaterial.
-- @param  position Vector  The position to spawn the particle on.
-- @return CLuaParticle The created particle, if any.
function Add( material,  position) end

--- CLuaEmitter:Draw
-- @usage client
-- Manually renders all particles the emitter has created.
--
function Draw() end

--- CLuaEmitter:Finish
-- @usage client
-- Removes the emitter and all its particles.
--
function Finish() end

--- CLuaEmitter:GetNumActiveParticles
-- @usage client
-- Returns the amount of active particles of this emitter.
--
-- @return number The amount of active particles of this emitter
function GetNumActiveParticles() end

--- CLuaEmitter:GetPos
-- @usage client
-- Returns the position of this emitter. This is set when creating the emitter with ParticleEmitter.
--
-- @return Vector Position of this particle emitter.
function GetPos() end

--- CLuaEmitter:Is3D
-- @usage client
-- Returns whether this emitter is 3D or not. This is set when creating the emitter with ParticleEmitter.
--
-- @return boolean Whether this emitter is 3D or not.
function Is3D() end

--- CLuaEmitter:SetBBox
-- @usage client
-- Sets the bounding box for this emitter.
--
-- @param  mins Vector  The minimum position of the box
-- @param  maxs Vector  The maximum position of the box
function SetBBox( mins,  maxs) end

--- CLuaEmitter:SetNearClip
-- @usage client
-- This function sets the the distance between the render camera and the emitter at which the particles should start fading and at which distance fade ends ( alpha becomes 0 ).
--
-- @param  distanceMin number  Min distance where the alpha becomes 0.
-- @param  distanceMax number  Max distance where the alpha starts fading.
function SetNearClip( distanceMin,  distanceMax) end

--- CLuaEmitter:SetNoDraw
-- @usage client
-- Prevents all particles of the emitter from automatically drawing.
--
-- @param  noDraw boolean  Whether we should draw the particles ( false ) or not ( true )
function SetNoDraw( noDraw) end

--- CLuaEmitter:SetParticleCullRadius
-- @usage client
-- The function name has not much in common with its actual function, it applies a radius to every particles that affects the building of the bounding box, as it, usually is constructed by the particle that has the lowest x, y and z and the highest x, y and z, this function just adds/subtracts the radius and inflates the bounding box.
--
-- @param  radius number  Particle radius.
function SetParticleCullRadius( radius) end

--- CLuaEmitter:SetPos
-- @usage client
-- Sets the position of the particle emitter.
--
-- @param  position Vector  New position.
function SetPos( position) end

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
-- @description Library CLuaParticle
 module("CLuaParticle")

--- CLuaParticle:GetAirResistance
-- @usage client
-- Returns the air resistance of the particle.
--
-- @return number The air resistance of the particle
function GetAirResistance() end

--- CLuaParticle:GetAngles
-- @usage client
-- Returns the current orientation of the particle.
--
-- @return Angle The angles of the particle
function GetAngles() end

--- CLuaParticle:GetAngleVelocity
-- @usage client
-- Returns the angular velocity of the particle
--
-- @return Angle The angular velocity of the particle
function GetAngleVelocity() end

--- CLuaParticle:GetBounce
-- @usage client
-- Returns the 'bounciness' of the particle.
--
-- @return number The 'bounciness' of the particle 2 means it will gain 100% of its previous velocity, 1 means it will not lose velocity, 0.5 means it will lose half of its velocity with each bounce.  
function GetBounce() end

--- CLuaParticle:GetColor
-- @usage client
-- Returns the color of the particle.
--
-- @return number Red part of the color
-- @return number Green part of the color
-- @return number Blue part of the color
function GetColor() end

--- CLuaParticle:GetDieTime
-- @usage client
-- Returns the amount of time in seconds after which the particle will be destroyed.
--
-- @return number The amount of time in seconds after which the particle will be destroyed
function GetDieTime() end

--- CLuaParticle:GetEndAlpha
-- @usage client
-- Returns the alpha value that the particle will reach on its death.
--
-- @return number The alpha value the particle will fade to
function GetEndAlpha() end

--- CLuaParticle:GetEndLength
-- @usage client
-- Returns the length that the particle will reach on its death.
--
-- @return number The length the particle will reach
function GetEndLength() end

--- CLuaParticle:GetEndSize
-- @usage client
-- Returns the size that the particle will reach on its death.
--
-- @return number The size the particle will reach
function GetEndSize() end

--- CLuaParticle:GetGravity
-- @usage client
-- Returns the gravity of the particle.
--
-- @return Vector The gravity of the particle.
function GetGravity() end

--- CLuaParticle:GetLifeTime
-- @usage client
-- Returns the 'life time' of the particle, how long the particle existed since its creation.
--
-- @return number How long the particle existed, in seconds.
function GetLifeTime() end

--- CLuaParticle:GetPos
-- @usage client
-- Returns the absolute position of the particle.
--
-- @return Vector The absolute position of the particle.
function GetPos() end

--- CLuaParticle:GetRoll
-- @usage client
-- Returns the current rotation of the particle in radians, this should only be used for 2D particles.
--
-- @return number The current rotation of the particle in radians
function GetRoll() end

--- CLuaParticle:GetRollDelta
-- @usage client
-- Returns the current rotation speed of the particle in radians, this should only be used for 2D particles.
--
-- @return number The current rotation speed of the particle in radians
function GetRollDelta() end

--- CLuaParticle:GetStartAlpha
-- @usage client
-- Returns the alpha value which the particle has when it's created.
--
-- @return number The alpha value which the particle has when it's created.
function GetStartAlpha() end

--- CLuaParticle:GetStartLength
-- @usage client
-- Returns the length which the particle has when it's created.
--
-- @return number The length which the particle has when it's created.
function GetStartLength() end

--- CLuaParticle:GetStartSize
-- @usage client
-- Returns the size which the particle has when it's created.
--
-- @return number The size which the particle has when it's created.
function GetStartSize() end

--- CLuaParticle:GetVelocity
-- @usage client
-- Returns the current velocity of the particle.
--
-- @return Vector The current velocity of the particle.
function GetVelocity() end

--- CLuaParticle:SetAirResistance
-- @usage client
-- Sets the air resistance of the the particle.
--
-- @param  airResistance number  New air resistance.
function SetAirResistance( airResistance) end

--- CLuaParticle:SetAngles
-- @usage client
-- Sets the angles of the particle.
--
-- @param  ang Angle  New angle.
function SetAngles( ang) end

--- CLuaParticle:SetAngleVelocity
-- @usage client
-- Sets the angular velocity of the the particle.
--
-- @param  angVel Angle  New angular velocity.
function SetAngleVelocity( angVel) end

--- CLuaParticle:SetBounce
-- @usage client
-- Sets the 'bounciness' of the the particle.
--
-- @param  bounce number  New 'bounciness' of the particle 2 means it will gain 100% of its previous velocity, 1 means it will not lose velocity, 0.5 means it will lose half of its velocity with each bounce.  
function SetBounce( bounce) end

--- CLuaParticle:SetCollide
-- @usage client
-- Sets the whether the particle should collide with the world or not.
--
-- @param  shouldCollide boolean  Whether the particle should collide with the world or not
function SetCollide( shouldCollide) end

--- CLuaParticle:SetCollideCallback
-- @usage client
-- Sets the function that gets called whenever the particle collides with the world.
--
-- @param  collideFunc function  Collide callback, the arguments are:  CLuaParticle particle - The particle itselfVector hitPos - Position of the collisionVector hitNormal - Direction of the collision, perpendicular to the hit surface
function SetCollideCallback( collideFunc) end

--- CLuaParticle:SetColor
-- @usage client
-- Sets the color of the particle.
--
-- @param  r number  The red component.
-- @param  g number  The green component.
-- @param  b number  The blue component.
function SetColor( r,  g,  b) end

--- CLuaParticle:SetDieTime
-- @usage client
-- Sets the time where the particle will be removed.
--
-- @param  dieTime number  The new die time.
function SetDieTime( dieTime) end

--- CLuaParticle:SetEndAlpha
-- @usage client
-- Sets the alpha value of the particle that it will reach when it dies.
--
-- @param  endAlpha number  The new alpha value of the particle that it will reach when it dies.
function SetEndAlpha( endAlpha) end

--- CLuaParticle:SetEndLength
-- @usage client
-- Sets the length of the particle that it will reach when it dies.
--
-- @param  endLength number  The new length of the particle that it will reach when it dies.
function SetEndLength( endLength) end

--- CLuaParticle:SetEndSize
-- @usage client
-- Sets the size of the particle that it will reach when it dies.
--
-- @param  endSize number  The new size of the particle that it will reach when it dies.
function SetEndSize( endSize) end

--- CLuaParticle:SetGravity
-- @usage client
-- Sets the directional gravity aka. acceleration of the particle.
--
-- @param  gravity Vector  The directional gravity.
function SetGravity( gravity) end

--- CLuaParticle:SetLifeTime
-- @usage client
-- Sets the 'life time' of the particle, how long the particle existed since its creation.
--
-- @param  lifeTime number  The new life time of the particle.
function SetLifeTime( lifeTime) end

--- CLuaParticle:SetLighting
-- @usage client
-- Sets whether the particle should be lighted.
--
-- @param  useLighting boolean  Whether the particle should be lighted.
function SetLighting( useLighting) end

--- CLuaParticle:SetNextThink
-- @usage client
-- Sets when the particles think function should be called next, this uses the synchronized server time returned by CurTime.
--
-- @param  nextThink number  Next think time.
function SetNextThink( nextThink) end

--- CLuaParticle:SetPos
-- @usage client
-- Sets the absolute position of the particle.
--
-- @param  pos Vector  The new particle position.
function SetPos( pos) end

--- CLuaParticle:SetRoll
-- @usage client
-- Sets the roll of the particle in radians. This should only be used for 2D particles.
--
-- @param  roll number  The new rotation of the particle in radians.
function SetRoll( roll) end

--- CLuaParticle:SetRollDelta
-- @usage client
-- Sets the rotation speed of the particle in radians. This should only be used for 2D particles.
--
-- @param  rollDelta number  The new rotation speed of the particle in radians.
function SetRollDelta( rollDelta) end

--- CLuaParticle:SetStartAlpha
-- @usage client
-- Sets the initial alpha value of the particle.
--
-- @param  startAlpha number  Initial alpha.
function SetStartAlpha( startAlpha) end

--- CLuaParticle:SetStartLength
-- @usage client
-- Sets the initial length value of the particle.
--
-- @param  startLength number  Initial length.
function SetStartLength( startLength) end

--- CLuaParticle:SetStartSize
-- @usage client
-- Sets the initial size value of the particle.
--
-- @param  startSize number  Initial size.
function SetStartSize( startSize) end

--- CLuaParticle:SetThinkFunction
-- @usage client
-- Sets the think function of the particle.
--
-- @param  thinkFunc function  Think function. It has only one argument:  CLuaParticle particle - The particle the think hook is set on
function SetThinkFunction( thinkFunc) end

--- CLuaParticle:SetVelocity
-- @usage client
-- Sets the velocity of the particle.
--
-- @param  vel Vector  The new velocity of the particle.
function SetVelocity( vel) end

--- CLuaParticle:SetVelocityScale
-- @usage client
-- Scales the velocity based on the particle speed.
--
-- @param  doScale=false boolean  Use velocity scaling.
function SetVelocityScale( doScale) end

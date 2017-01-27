---
-- @description Library CNewParticleEffect
 module("CNewParticleEffect")

--- CNewParticleEffect:AddControlPoint
-- @usage client
-- Adds a control point to the particle system.
--
-- @param  cpID number  The control point ID, 0 to 63.
-- @param  ent Entity  The entity to attach the control point to.
-- @param  partAttachment number  See PATTACH_ Enums.
-- @param  entAttachment=0 number  The attachment ID on the entity to attach the particle system to
-- @param  offset=Vector( 0, 0, 0 ) Vector  The offset from the Entity:GetPos of the entity we are attaching this CP to.
function AddControlPoint( cpID,  ent,  partAttachment,  entAttachment,  offset) end

--- CNewParticleEffect:GetAutoUpdateBBox
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return boolean 
function GetAutoUpdateBBox() end

--- CNewParticleEffect:GetEffectName
-- @usage client
-- Returns the name of the particle effect this system is set to emit.
--
-- @return string The name of the particle effect.
function GetEffectName() end

--- CNewParticleEffect:GetHighestControlPoint
-- @usage client
-- Returns the highest control point number for given particle system.
--
-- @return boolean The highest control point number for given particle system, 0 to 63.
function GetHighestControlPoint() end

--- CNewParticleEffect:GetOwner
-- @usage client
-- Returns the owner of the particle system, the entity the particle system is attached to.
--
-- @return Entity The owner of the particle system.
function GetOwner() end

--- CNewParticleEffect:IsFinished
-- @usage client
-- Returns whether the particle system has finished emitting particles or not.
--
-- @return boolean Whether the particle system has finished emitting particles or not.
function IsFinished() end

--- CNewParticleEffect:IsValid
-- @usage client
-- Returns whether the particle system is valid or not.
--
-- @return boolean Whether the particle system is valid or not.
function IsValid() end

--- CNewParticleEffect:IsViewModelEffect
-- @usage client
-- Returns whether the particle system is intended to be used on a view model?
--
-- @return boolean 
function IsViewModelEffect() end

--- CNewParticleEffect:Render
-- @usage client
-- Forces the particle system to render using current rendering context.
--
function Render() end

--- CNewParticleEffect:Restart
-- @usage client
-- Forces the particle system to restart emitting particles.
--
function Restart() end

--- CNewParticleEffect:SetControlPoint
-- @usage client
-- Sets a value for given control point.
--
-- @param  cpID number  The control point ID, 0 to 63.
-- @param  value Vector  The value to set for given control point.
function SetControlPoint( cpID,  value) end

--- CNewParticleEffect:SetControlPointEntity
-- @usage client
-- Essentially makes child control point follow the parent entity.
--
-- @param  child number  The child control point ID, 0 to 63.
-- @param  parent Entity  The parent entity to follow.
function SetControlPointEntity( child,  parent) end

--- CNewParticleEffect:SetControlPointForwardVector
-- @usage client
-- Sets the forward direction for given control point.
--
-- @param  cpID number  The control point ID, 0 to 63.
-- @param  forward Vector  The forward direction for given control point
function SetControlPointForwardVector( cpID,  forward) end

--- CNewParticleEffect:SetControlPointOrientation
-- @usage client
-- Sets the orientation for given control point.
--
-- @param  cpID number  The control point ID, 0 to 63.
-- @param  forward Vector  The forward direction for given control point
-- @param  right Vector  The right direction for given control point
-- @param  up Vector  The up direction for given control point
function SetControlPointOrientation( cpID,  forward,  right,  up) end

--- CNewParticleEffect:SetControlPointParent
-- @usage client
-- Essentially makes child control point follow the parent control point.
--
-- @param  child number  The child control point ID, 0 to 63.
-- @param  parent number  The parent control point ID, 0 to 63.
function SetControlPointParent( child,  parent) end

--- CNewParticleEffect:SetControlPointRightVector
-- @usage client
-- Sets the right direction for given control point.
--
-- @param  cpID number  The control point ID, 0 to 63.
-- @param  right Vector  The right direction for given control point.
function SetControlPointRightVector( cpID,  right) end

--- CNewParticleEffect:SetControlPointUpVector
-- @usage client
-- Sets the upward direction for given control point.
--
-- @param  cpID number  The control point ID, 0 to 63.
-- @param  upward Vector  The upward direction for given control point
function SetControlPointUpVector( cpID,  upward) end

--- CNewParticleEffect:SetIsViewModelEffect
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  isViewModel boolean 
function SetIsViewModelEffect( isViewModel) end

--- CNewParticleEffect:SetShouldDraw
-- @usage client
-- Forces the particle system to stop automatically rendering.
--
-- @param  should boolean  Whether to automatically draw the particle effect or not.
function SetShouldDraw( should) end

--- CNewParticleEffect:SetSortOrigin
-- @usage client
-- Sets the sort origin for given particle system. This is used as a helper to determine which particles are in front of which.
--
-- @param  origin Vector  The new sort origin.
function SetSortOrigin( origin) end

--- CNewParticleEffect:StartEmission
-- @usage client
-- Starts the particle emission.
--
-- @param  infiniteOnly=false boolean 
function StartEmission( infiniteOnly) end

--- CNewParticleEffect:StopEmission
-- @usage client
-- Stops the particle emission.
--
-- @param  infiniteOnly=false boolean 
-- @param  removeAllParticles=false boolean 
-- @param  wakeOnStop=false boolean 
function StopEmission( infiniteOnly,  removeAllParticles,  wakeOnStop) end

--- CNewParticleEffect:StopEmissionAndDestroyImmediately
-- @usage client
-- Stops particle emission and destroys all particles instantly.
--
function StopEmissionAndDestroyImmediately() end

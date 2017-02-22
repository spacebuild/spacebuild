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
-- @description Library PhysObj
 module("PhysObj")

--- PhysObj:AddAngleVelocity
-- @usage shared
-- Adds the specified velocity to the current.
--
-- @param  angularVelocity Vector  Additional velocity.
function AddAngleVelocity( angularVelocity) end

--- PhysObj:AddGameFlag
-- @usage shared
-- Adds one or more bit flags.
--
-- @param  flags number  Bitflag, see FVPHYSICS_ Enums.
function AddGameFlag( flags) end

--- PhysObj:AddVelocity
-- @usage shared
-- Adds the specified velocity to the current.
--
-- @param  velocity Vector  Additional velocity.
function AddVelocity( velocity) end

--- PhysObj:AlignAngles
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  from Angle 
-- @param  to Angle 
-- @return Angle 
function AlignAngles( from,  to) end

--- PhysObj:ApplyForceCenter
-- @usage shared
-- Applies the specified force to the physics object. (in Newtons)
--
-- @param  force Vector  The force to be applied.
function ApplyForceCenter( force) end

--- PhysObj:ApplyForceOffset
-- @usage shared
-- Applies the specified force on the physics object at the specified position
--
-- @param  force Vector  The force to be applied.
-- @param  position Vector  The position in world coordinates where the force is applied to the physics object.
function ApplyForceOffset( force,  position) end

--- PhysObj:CalculateForceOffset
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  force Vector  The initial force?
-- @param  pos Vector  The world position
-- @return Vector The calculated force?
-- @return Vector The calculated torque?
function CalculateForceOffset( force,  pos) end

--- PhysObj:CalculateVelocityOffset
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  force Vector  The initial force?
-- @param  pos Vector  The world position
-- @return Vector The calculated force?
-- @return Vector The calculated torque?
function CalculateVelocityOffset( force,  pos) end

--- PhysObj:ClearGameFlag
-- @usage shared
-- Removes one of more specified flags.
--
-- @param  flags number  Bitflag, see FVPHYSICS_ Enums.
function ClearGameFlag( flags) end

--- PhysObj:ComputeShadowControl
-- @usage shared
-- Allows you to move a PhysObj to a point and angle in 3D space.
--
-- @param  shadowparams table  The parameters for the shadow. See example code to see how its used.
function ComputeShadowControl( shadowparams) end

--- PhysObj:EnableCollisions
-- @usage shared
-- Sets whenever the physics object should not collide with anything.
--
-- @param  enable boolean  True to enable, false to disable.
function EnableCollisions( enable) end

--- PhysObj:EnableDrag
-- @usage shared
-- Sets whenever the physics object should be affected by drag.
--
-- @param  enable boolean  True to enable, false to disable.
function EnableDrag( enable) end

--- PhysObj:EnableGravity
-- @usage shared
-- Sets whenever the physobject should be affected by gravity
--
-- @param  enable boolean  True to enable, false to disable.
function EnableGravity( enable) end

--- PhysObj:EnableMotion
-- @usage shared
-- Sets whenever the physobject should be able to move or not.
--By calling PhysObj:EnableMotion(false), the physobject will no longer be able to move. However, when the physobject is clicked by physics gun, the object will be able to move again.
--
-- @param  enable boolean  True to enable, false to disable.
function EnableMotion( enable) end

--- PhysObj:GetAABB
-- @usage shared
-- Returns the mins and max of the physics object.
--
-- @return Vector Mins
-- @return Vector Maxs
function GetAABB() end

--- PhysObj:GetAngles
-- @usage shared
-- Returns the angles of the physics object.
--
-- @return Angle The angles of the physics object.
function GetAngles() end

--- PhysObj:GetAngleVelocity
-- @usage shared
-- Gets the angular velocity of the object in degrees per second.
--
-- @return Vector The angular velocity
function GetAngleVelocity() end

--- PhysObj:GetDamping
-- @usage shared
-- Returns the linear and angular damping of the physics object.
--
-- @return number The linear damping
-- @return number The angular damping
function GetDamping() end

--- PhysObj:GetEnergy
-- @usage shared
-- Returns the kinetic energy of the physobject.
--
-- @return number The kinetic energy
function GetEnergy() end

--- PhysObj:GetEntity
-- @usage shared
-- Returns the parent entity of the physics object.
--
-- @return Entity parent
function GetEntity() end

--- PhysObj:GetInertia
-- @usage shared
-- Returns the directional inertia of the physics object.
--
-- @return Vector directionalInertia
function GetInertia() end

--- PhysObj:GetInvInertia
-- @usage shared
-- Returns the inverted inertia.
--
-- @return number invMass
function GetInvInertia() end

--- PhysObj:GetInvMass
-- @usage shared
-- Returns 1 divided by the entities mass.
--
-- @return number invMass
function GetInvMass() end

--- PhysObj:GetMass
-- @usage shared
-- Returns the mass of the physics object.
--
-- @return number The mass
function GetMass() end

--- PhysObj:GetMassCenter
-- @usage shared
-- Returns the center of mass of the physics object as a local vector.
--
-- @return Vector The center of mass of the physics object.
function GetMassCenter() end

--- PhysObj:GetMaterial
-- @usage shared
-- Returns the physical material of the physobject.
--
-- @return string material
function GetMaterial() end

--- PhysObj:GetMesh
-- @usage shared
-- Returns a table of MeshVertex structures where each 3 vertices represent a triangle.
--
-- @return table vertexes
function GetMesh() end

--- PhysObj:GetMeshConvexes
-- @usage shared
-- Returns a structured table, the physics mesh of the physics object.
--
-- @return table 
function GetMeshConvexes() end

--- PhysObj:GetName
-- @usage shared
-- Returns the name of the physics object.
--
-- @return string The name of the physics object.
function GetName() end

--- PhysObj:GetPos
-- @usage shared
-- Returns the position of the physobject.
--
-- @return Vector position
function GetPos() end

--- PhysObj:GetRotDamping
-- @usage shared
-- Returns the rotation damping of the physics object.
--
-- @return number rotationDamping
function GetRotDamping() end

--- PhysObj:GetSpeedDamping
-- @usage shared
-- Returns the speed damping of the physics object.
--
-- @return number speedDamping
function GetSpeedDamping() end

--- PhysObj:GetStress
-- @usage server
-- Returns the stress of the entity.
--
-- @return number exertedStress
function GetStress() end

--- PhysObj:GetSurfaceArea
-- @usage shared
-- Returns the surface area of the physics object in source-units².
--
-- @return number surfaceArea
function GetSurfaceArea() end

--- PhysObj:GetVelocity
-- @usage shared
-- Returns the absolute directional velocity of the physobject.
--
-- @return Vector velocity
function GetVelocity() end

--- PhysObj:GetVolume
-- @usage shared
-- Returns the volume in source units³.
--
-- @return number volume
function GetVolume() end

--- PhysObj:HasGameFlag
-- @usage shared
-- Returns whenever the specified flag(s) is/are set.
--
-- @param  flags number  Bitflag, see FVPHYSICS_ Enums.
-- @return boolean If flag was set or not
function HasGameFlag( flags) end

--- PhysObj:IsAsleep
-- @usage shared
-- Returns whenever the physics object is sleeping eg. not active.
--
-- @return boolean Is the physics object dormant or not
function IsAsleep() end

--- PhysObj:IsCollisionEnabled
-- @usage shared
-- Returns whenever the entity is able to collide or not.
--
-- @return boolean isCollisionEnabled
function IsCollisionEnabled() end

--- PhysObj:IsDragEnabled
-- @usage shared
-- Returns whenever the entity is affected by drag.
--
-- @return boolean dragEnabled
function IsDragEnabled() end

--- PhysObj:IsGravityEnabled
-- @usage shared
-- Returns whenever the entity is affected by gravity.
--
-- @return boolean gravitated
function IsGravityEnabled() end

--- PhysObj:IsMotionEnabled
-- @usage shared
-- Returns if the physics object can move itself (by velocity, acceleration)
--
-- @return boolean motionEnabled
function IsMotionEnabled() end

--- PhysObj:IsMoveable
-- @usage shared
-- Returns whenever the entity is able to move.
--
-- @return boolean movable
function IsMoveable() end

--- PhysObj:IsPenetrating
-- @usage shared
-- Returns whenever the physics object is penetrating another physics object.
--
-- @return boolean isPenetrating
function IsPenetrating() end

--- PhysObj:IsValid
-- @usage shared
-- Returns if the physics object is valid/not NULL.
--
-- @return boolean isValid
function IsValid() end

--- PhysObj:LocalToWorld
-- @usage shared
-- Mapping a vector in local frame of the physics object to world frame.
--
-- @param  LocalVec Vector  A vector in the physics object's local frame
-- @return Vector The corresponding vector in world frame
function LocalToWorld( LocalVec) end

--- PhysObj:LocalToWorldVector
-- @usage shared
-- Rotate a vector from the local frame of the physics object to world frame.
--
-- @param  LocalVec Vector  A vector in the physics object's local frame
-- @return Vector The corresponding vector in world frame
function LocalToWorldVector( LocalVec) end

--- PhysObj:OutputDebugInfo
-- @usage shared
-- Prints debug info about the state of the physics object to the console.
--
function OutputDebugInfo() end

--- PhysObj:RecheckCollisionFilter
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function RecheckCollisionFilter() end

--- PhysObj:RotateAroundAxis
-- @usage shared
-- A convinience function for Angle:RotateAroundAxis.
--
-- @param  dir Vector  Direction, around which we will rotate
-- @param  ang number  Amount of rotation, in degrees
-- @return Angle The resulting angle
function RotateAroundAxis( dir,  ang) end

--- PhysObj:SetAngleDragCoefficient
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  coef number  The bigger this value is, the slower the angles will change.
function SetAngleDragCoefficient( coef) end

--- PhysObj:SetAngles
-- @usage shared
-- Sets the angles of the physobject.
--
-- @param  angles Angle  The new angles of the physobject.
function SetAngles( angles) end

--- PhysObj:SetBuoyancyRatio
-- @usage shared
-- Sets the buoyancy ratio.
--
-- @param  buoyancy number  Buoyancy from 0 to 1.
-- @return boolean flagSet
function SetBuoyancyRatio( buoyancy) end

--- PhysObj:SetDamping
-- @usage shared
-- Sets the linear and angular damping of the physics object.
--
-- @param  linearDamping number  Linear damping.
-- @param  angularDamping number  Angular damping.
function SetDamping( linearDamping,  angularDamping) end

--- PhysObj:SetDragCoefficient
-- @usage shared
-- Modifies how much drag affects the object.
--
-- @param  drag number  The drag coefficient  It can be positive or negative.
function SetDragCoefficient( drag) end

--- PhysObj:SetInertia
-- @usage shared
-- Sets the directional inertia.
--
-- @param  directionalInertia Vector  The directional inertia of the object.  A value of Vector(0,0,0) makes the physobject go invalid.
function SetInertia( directionalInertia) end

--- PhysObj:SetMass
-- @usage shared
-- Sets the mass of the physobject.
--
-- @param  mass number  The the mass of the physobject.
function SetMass( mass) end

--- PhysObj:SetMaterial
-- @usage shared
-- Sets the material of the physobject.
--
-- @param  materialName string  The name of the phys material to use. From this list: Valve Developer
function SetMaterial( materialName) end

--- PhysObj:SetPos
-- @usage shared
-- Sets the position of the physobject.
--
-- @param  position Vector  The new position of the physobject.
-- @param  teleport=false boolean 
function SetPos( position,  teleport) end

--- PhysObj:SetVelocity
-- @usage shared
-- Sets the velocity of the physics object for the next iteration.
--
-- @param  velocity Vector  The new velocity of the phyiscs object.
function SetVelocity( velocity) end

--- PhysObj:SetVelocityInstantaneous
-- @usage shared
-- Sets the velocity of the physics object.
--
-- @param  velocity Vector  The new velocity of the physics object.
function SetVelocityInstantaneous( velocity) end

--- PhysObj:Sleep
-- @usage shared
-- Make the physics object sleep.
--
function Sleep() end

--- PhysObj:UpdateShadow
-- @usage shared
-- Unlike PhysObj:SetPos and PhysObj:SetAngles, this allows the movement of a physobj while leaving physics interactions intact.
--This is used internally by the motion controller of the Gravity Gun , the +use pickup and the Physics Gun, and entities such as the crane.
--
-- @param  targetPosition Vector  The position we should move to.
-- @param  targetAngles Angle  The angle we should rotate towards.
-- @param  frameTime number  The frame time to use for this movement, can be generally filled with FrameTime or ENTITY:PhysicsSimulate with the deltaTime.  Can be set to 0 when you need to update the physics object just once.
function UpdateShadow( targetPosition,  targetAngles,  frameTime) end

--- PhysObj:Wake
-- @usage shared
-- Wakes the physics object. See also PhysObj:Sleep
--
function Wake() end

--- PhysObj:WorldToLocal
-- @usage shared
-- Converts a vector to a relative to the physics object coordinate system.
--
-- @param  vec Vector  The vector in world space coordinates.
-- @return Vector The vector local to PhysObj:GetPos.
function WorldToLocal( vec) end

--- PhysObj:WorldToLocalVector
-- @usage shared
-- Rotate a vector from the world frame to the local frame of the physics object.
--
-- @param  WorldVec Vector  A vector in the world frame
-- @return Vector The corresponding vector relative to the PhysObj
function WorldToLocalVector( WorldVec) end

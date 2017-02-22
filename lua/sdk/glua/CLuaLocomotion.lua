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
-- @description Library CLuaLocomotion
 module("CLuaLocomotion")

--- CLuaLocomotion:Approach
-- @usage server
-- Sets the location we want to get to
--
-- @param  goal Vector  The vector we want to get to
-- @param  goalweight number  If unsure then set this to 1
function Approach( goal,  goalweight) end

--- CLuaLocomotion:ClearStuck
-- @usage server
-- Removes the stuck status from the bot
--
function ClearStuck() end

--- CLuaLocomotion:FaceTowards
-- @usage server
-- Sets the direction we want to face
--
-- @param  goal Vector  The vector we want to face
function FaceTowards( goal) end

--- CLuaLocomotion:GetAcceleration
-- @usage server
-- Returns the acceleration speed
--
-- @return number Current acceleration speed
function GetAcceleration() end

--- CLuaLocomotion:GetCurrentAcceleration
-- @usage server
-- Returns the current acceleration as a vector
--
-- @return Vector Current acceleration
function GetCurrentAcceleration() end

--- CLuaLocomotion:GetDeathDropHeight
-- @usage server
-- Gets the height the bot is scared to fall from
--
-- @return number Current death drop height
function GetDeathDropHeight() end

--- CLuaLocomotion:GetDeceleration
-- @usage server
-- Gets the deceleration speed
--
-- @return number Current deceleration speed
function GetDeceleration() end

--- CLuaLocomotion:GetGroundMotionVector
-- @usage server
-- Return unit vector in XY plane describing our direction of motion - even if we are currently not moving
--
-- @return Vector A vector representing the X and Y movement
function GetGroundMotionVector() end

--- CLuaLocomotion:GetJumpHeight
-- @usage server
-- Gets the height of the bot's jump
--
-- @return number Current jump height
function GetJumpHeight() end

--- CLuaLocomotion:GetMaxJumpHeight
-- @usage server
-- Returns maximum jump height of this CLuaLocomotion.
--
-- @return number The maximum jump height.
function GetMaxJumpHeight() end

--- CLuaLocomotion:GetMaxYawRate
-- @usage server
-- Returns the max rate at which the NextBot can visually rotate.
--
-- @return number Maximum yaw rate
function GetMaxYawRate() end

--- CLuaLocomotion:GetStepHeight
-- @usage server
-- Gets the max height the bot can step up
--
-- @return number Current step height
function GetStepHeight() end

--- CLuaLocomotion:GetVelocity
-- @usage server
-- Returns the current movement velocity as a vector
--
-- @return Vector Current velocity
function GetVelocity() end

--- CLuaLocomotion:IsAreaTraversable
-- @usage server
-- Returns whether this CLuaLocomotion can reach and/or traverse/move in given CNavArea.
--
-- @param  area CNavArea  The area to test
-- @return boolean Whether this CLuaLocomotion can traverse given CNavArea.
function IsAreaTraversable( area) end

--- CLuaLocomotion:IsAttemptingToMove
-- @usage server
-- Returns true if we're trying to move.
--
-- @return boolean Whether we're trying to move or not.
function IsAttemptingToMove() end

--- CLuaLocomotion:IsClimbingOrJumping
-- @usage server
-- Returns true of the locomotion engine is jumping or climbing
--
-- @return boolean Whether we're climbing or jumping or not
function IsClimbingOrJumping() end

--- CLuaLocomotion:IsOnGround
-- @usage server
-- Returns whether the locomotion/nextbot is on ground or not.
--
-- @return boolean Whether the locomotion/nextbot is on ground or not.
function IsOnGround() end

--- CLuaLocomotion:IsStuck
-- @usage server
-- Returns true if we're stuck
--
-- @return boolean Whether we're stuck or not
function IsStuck() end

--- CLuaLocomotion:IsUsingLadder
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return boolean 
function IsUsingLadder() end

--- CLuaLocomotion:Jump
-- @usage server
-- Makes the bot jump
--
function Jump() end

--- CLuaLocomotion:JumpAcrossGap
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  landingGoal Vector 
-- @param  landingForward Vector 
function JumpAcrossGap( landingGoal,  landingForward) end

--- CLuaLocomotion:SetAcceleration
-- @usage server
-- Sets the acceleration speed
--
-- @param  speed number  Speed acceleration (default is 400)
function SetAcceleration( speed) end

--- CLuaLocomotion:SetDeathDropHeight
-- @usage server
-- Sets the height the bot is scared to fall from.
--
-- @param  height number  Height (default is 200)
function SetDeathDropHeight( height) end

--- CLuaLocomotion:SetDeceleration
-- @usage server
-- Sets the deceleration speed.
--
-- @param  deceleration number  New deceleration speed (default is 400)
function SetDeceleration( deceleration) end

--- CLuaLocomotion:SetDesiredSpeed
-- @usage server
-- Sets movement speed.
--
-- @param  speed number  The new desired speed
function SetDesiredSpeed( speed) end

--- CLuaLocomotion:SetJumpHeight
-- @usage server
-- Sets the height of the bot's jump
--
-- @param  height number  Height (default is 58)
function SetJumpHeight( height) end

--- CLuaLocomotion:SetMaxYawRate
-- @usage server
-- Sets the max rate at which the NextBot can visually rotate. This will not affect moving or pathing.
--
-- @param  yawRate number  Desired new maximum yaw rate
function SetMaxYawRate( yawRate) end

--- CLuaLocomotion:SetStepHeight
-- @usage server
-- Sets the max height the bot can step up
--
-- @param  height number  Height (default is 18)
function SetStepHeight( height) end

--- CLuaLocomotion:SetVelocity
-- @usage server
-- Sets the current movement velocity
--
-- @param  velocity Vector 
function SetVelocity( velocity) end

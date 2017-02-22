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
-- @description Library motionsensor
 module("motionsensor")

--- motionsensor.BuildSkeleton
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  translator table 
-- @param  player Player 
-- @param  rotation Angle 
-- @return Vector Pos
-- @return Angle ang
-- @return sensor sensor
function BuildSkeleton( translator,  player,  rotation) end

--- motionsensor.ChooseBuilderFromEntity
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  ent Entity  Entity to choose builder for
-- @return string Chosen builder
function ChooseBuilderFromEntity( ent) end

--- motionsensor.GetColourMaterial
-- @usage client_m
-- Returns the depth map material.
--
-- @return IMaterial The material
function GetColourMaterial() end

--- motionsensor.GetSkeleton
-- @usage client
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function GetSkeleton() end

--- motionsensor.IsActive
-- @usage client
-- Return whether a kinect is connected - and active (ie - Start has been called).
--
-- @return boolean Connected and active or not
function IsActive() end

--- motionsensor.IsAvailable
-- @usage client_m
-- Returns true if we have detected that there's a kinect connected to the PC
--
-- @return boolean Connected or not
function IsAvailable() end

--- motionsensor.ProcessAngle
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  translator table 
-- @param  sensor table 
-- @param  pos Vector 
-- @param  ang Angle 
-- @param  special_vectors table 
-- @param  boneid number 
-- @param  v table 
-- @return boolean Return nil on failure
function ProcessAngle( translator,  sensor,  pos,  ang,  special_vectors,  boneid,  v) end

--- motionsensor.ProcessAnglesTable
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  translator table 
-- @param  sensor table 
-- @param  pos Vector 
-- @param  rotation Angle 
-- @return Angle Ang. If !translator.AnglesTable then return - {}
function ProcessAnglesTable( translator,  sensor,  pos,  rotation) end

--- motionsensor.ProcessPositionTable
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  translator table 
-- @param  sensor table 
-- @return Vector Pos. if !translator.PositionTable then return - {}
function ProcessPositionTable( translator,  sensor) end

--- motionsensor.Start
-- @usage client_m
-- This starts access to the kinect sensor. Note that this usually freezes the game for a couple of seconds.
--
function Start() end

--- motionsensor.Stop
-- @usage client
-- Stops the motion capture.
--
function Stop() end

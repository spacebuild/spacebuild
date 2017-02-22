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
-- @description Library Vehicle
 module("Vehicle")

--- Vehicle:BoostTimeLeft
-- @usage server
-- Returns the remaining boosting time left.
--
-- @return number The remaining boosting time left
function BoostTimeLeft() end

--- Vehicle:CheckExitPoint
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  yaw number 
-- @param  distance number 
-- @param  endPoint Vector 
-- @return boolean 
function CheckExitPoint( yaw,  distance,  endPoint) end

--- Vehicle:EnableEngine
-- @usage server
-- Sets whether the engine is enabled or disabled, i.e. can be started or not.
--
-- @param  enable boolean  Enable or disable the engine
function EnableEngine( enable) end

--- Vehicle:GetAmmo
-- @usage client
-- Returns information about the ammo of the vehicle
--
-- @return number Ammo type of the vehicle ammo
-- @return number Clip size
-- @return number Count
function GetAmmo() end

--- Vehicle:GetCameraDistance
-- @usage shared
-- Returns third person camera distance.
--
-- @return number Camera distance
function GetCameraDistance() end

--- Vehicle:GetDriver
-- @usage server
-- Gets the driver of the vehicle, returns NULL if no driver is present.
--
-- @return Entity The driver of the vehicle
function GetDriver() end

--- Vehicle:GetHLSpeed
-- @usage server
-- Returns the current speed of the vehicle in Half-Life Hammer Units (in/s). Same as Entity:GetVelocity + Vector:Length.
--
-- @return number The speed of the vehicle
function GetHLSpeed() end

--- Vehicle:GetMaxSpeed
-- @usage server
-- Returns the max speed of the vehicle in MPH.
--
-- @return number The max speed of the vehicle in MPH
function GetMaxSpeed() end

--- Vehicle:GetOperatingParams
-- @usage server
-- Returns some info about the vehicle.
--
-- @return table The operating params. See OperatingParams structure.
function GetOperatingParams() end

--- Vehicle:GetPassenger
-- @usage server
-- Gets the passenger of the vehicle, returns NULL if no drivers is present.
--
-- @param  passenger number  The index of the passenger
-- @return Entity The passenger
function GetPassenger( passenger) end

--- Vehicle:GetPassengerSeatPoint
-- @usage server
-- Returns the seat position and angle of a given passenger seat.
--
-- @param  role number  The passenger role. ( 1 is the driver )
-- @return Vector The seat position
-- @return Angle The seat angle
function GetPassengerSeatPoint( role) end

--- Vehicle:GetRPM
-- @usage server
-- Returns the current RPM of the vehicle. This value is fake and doesn't actually affect the vehicle movement.
--
-- @return number The RPM.
function GetRPM() end

--- Vehicle:GetSpeed
-- @usage server
-- Returns the current speed of the vehicle in MPH.
--
-- @return number The speed of the vehicle in MPH
function GetSpeed() end

--- Vehicle:GetSteering
-- @usage server
-- Returns the current steering of the vehicle.
--
-- @return number The current steering of the vehicle.
function GetSteering() end

--- Vehicle:GetSteeringDegrees
-- @usage server
-- Returns the maximum steering degree of the vehicle
--
-- @return number The maximum steering degree of the vehicle
function GetSteeringDegrees() end

--- Vehicle:GetThirdPersonMode
-- @usage shared
-- Returns if vehicle has thirdperson mode enabled or not.
--
-- @return boolean Returns true if third person mode enabled, false otherwise
function GetThirdPersonMode() end

--- Vehicle:GetThrottle
-- @usage server
-- Returns the current throttle of the vehicle.
--
-- @return number The current throttle of the vehicle
function GetThrottle() end

--- Vehicle:GetVehicleClass
-- @usage shared
-- Returns the vehicle class name. This is only useful for Sandbox spawned vehicles or any vehicle that properly sets the vehicle class with Vehicle:SetVehicleClass.
--
-- @return string The class name of the vehicle.
function GetVehicleClass() end

--- Vehicle:GetVehicleParams
-- @usage server
-- Returns the vehicle parameters of given vehicle.
--
-- @return table The vehicle parameters. See VehicleParams structure
function GetVehicleParams() end

--- Vehicle:GetVehicleViewPosition
-- @usage server
-- Returns the view position and forward angle of a given passenger seat.
--
-- @param  role number  The passenger role. ( 1 is the driver )
-- @return Vector The view position
-- @return Angle The view angles
-- @return number The field of view
function GetVehicleViewPosition( role) end

--- Vehicle:GetWheel
-- @usage server
-- Returns the PhysObj of given wheel.
--
-- @param  wheel number  The wheel to retrieve
-- @return PhysObj The wheel
function GetWheel( wheel) end

--- Vehicle:GetWheelBaseHeight
-- @usage server
-- Returns the base wheel height.
--
-- @param  wheel number  The wheel to get the base wheel height of.
-- @return number The base wheel height.
function GetWheelBaseHeight( wheel) end

--- Vehicle:GetWheelContactPoint
-- @usage server
-- Returns the wheel contact point.
--
-- @param  wheel number  The wheel to check
-- @return Vector The contact position
-- @return number The Surface Properties ID of hit surface.
-- @return boolean Whether the wheel is on ground or not
function GetWheelContactPoint( wheel) end

--- Vehicle:GetWheelCount
-- @usage server
-- Returns the wheel count of the vehicle
--
-- @return boolean The amount of wheels
function GetWheelCount() end

--- Vehicle:GetWheelTotalHeight
-- @usage server
-- Returns the total wheel height.
--
-- @param  wheel number  The wheel to get the base wheel height of.
-- @return number The total wheel height.
function GetWheelTotalHeight( wheel) end

--- Vehicle:HasBoost
-- @usage server
-- Returns whether this vehicle has boost at all.
--
-- @return boolean Whether this vehicle has boost at all.
function HasBoost() end

--- Vehicle:HasBrakePedal
-- @usage server
-- Returns whether this vehicle has a brake pedal. See Vehicle:SetHasBrakePedal.
--
-- @return boolean Whether this vehicle has a brake pedal or not.
function HasBrakePedal() end

--- Vehicle:IsBoosting
-- @usage server
-- Returns whether this vehicle is currently boosting or not.
--
-- @return boolean Whether this vehicle is currently boosting or not.
function IsBoosting() end

--- Vehicle:IsEngineEnabled
-- @usage server
-- Returns whether the engine is enabled or not, i.e. whether it can be started.
--
-- @return boolean Whether the engine is enabled
function IsEngineEnabled() end

--- Vehicle:IsEngineStarted
-- @usage server
-- Returns whether the engine is started or not.
--
-- @return boolean Whether the engine is started or not.
function IsEngineStarted() end

--- Vehicle:IsValidVehicle
-- @usage shared
-- Returns true if the vehicle object is a valid or not. This will return false when Vehicle functions are not usable on the vehicle.
--
-- @return boolean Is the vehicle a valid vehicle or not
function IsValidVehicle() end

--- Vehicle:IsVehicleBodyInWater
-- @usage server
-- Returns whether this vehicle's engine is underwater or not. ( Internally the attachment point "engine" or "vehicle_engine" is checked )
--
-- @return boolean Whether this vehicle's engine is underwater or not.
function IsVehicleBodyInWater() end

--- Vehicle:ReleaseHandbrake
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function ReleaseHandbrake() end

--- Vehicle:SetBoost
-- @usage server
-- Sets the boost. It is possible that this function does not work while the vehicle has a valid driver in it.
--
-- @param  boost number  The new boost value
function SetBoost( boost) end

--- Vehicle:SetCameraDistance
-- @usage shared
-- Sets the third person camera distance of the vehicle.
--
-- @param  distance number  Camera distance to set to
function SetCameraDistance( distance) end

--- Vehicle:SetHandbrake
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  handbrake boolean 
function SetHandbrake( handbrake) end

--- Vehicle:SetHasBrakePedal
-- @usage server
-- Sets whether this vehicle has a brake pedal.
--
-- @param  brakePedal boolean  Whether this vehicle has a brake pedal
function SetHasBrakePedal( brakePedal) end

--- Vehicle:SetMaxReverseThrottle
-- @usage server
-- Sets maximum reverse throttle
--
-- @param  maxRevThrottle number  The new maximum throttle. This number must be negative.
function SetMaxReverseThrottle( maxRevThrottle) end

--- Vehicle:SetMaxThrottle
-- @usage server
-- Sets maximum forward throttle
--
-- @param  maxThrottle number  The new maximum throttle.
function SetMaxThrottle( maxThrottle) end

--- Vehicle:SetSpringLength
-- @usage server
-- Sets spring length of given wheel
--
-- @param  wheel number  The wheel to change spring length of
-- @param  length number  The new spring length
function SetSpringLength( wheel,  length) end

--- Vehicle:SetSteering
-- @usage server
-- Sets the steering of the vehicle.
--
-- @param  steering number  The new steering value.
function SetSteering( steering) end

--- Vehicle:SetSteeringDegrees
-- @usage server
-- Sets the maximum steering degrees of the vehicle
--
-- @param  steeringDegrees number  The new maximum steering degree
function SetSteeringDegrees( steeringDegrees) end

--- Vehicle:SetThirdPersonMode
-- @usage shared
-- Sets the third person mode state.
--
-- @param  enable boolean  Enable or disable the third person mode for this vehicle
function SetThirdPersonMode( enable) end

--- Vehicle:SetThrottle
-- @usage server
-- Sets the throttle of the vehicle. It is possible that this function does not work with a valid driver in it.
--
-- @param  throttle number  The new throttle.
function SetThrottle( throttle) end

--- Vehicle:SetVehicleClass
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  class string  The vehicle class name to set
function SetVehicleClass( class) end

--- Vehicle:SetVehicleEntryAnim
-- @usage server
-- Sets whether the entry or exit camera animation should be played or not.
--
-- @param  bOn boolean  Whether the entry or exit camera animation should be played or not.
function SetVehicleEntryAnim( bOn) end

--- Vehicle:SetVehicleParams
-- @usage server
-- Sets the vehicle parameters for given vehicle.
--
-- @param  params table  The new new vehicle parameters. See VehicleParams structure
function SetVehicleParams( params) end

--- Vehicle:SetWheelFriction
-- @usage server
-- Validation required.
--This page contains eventual incorrect information and requires validation.
-- @param  wheel number  The wheel to change the friction of
-- @param  friction number  The new friction to set
function SetWheelFriction( wheel,  friction) end

--- Vehicle:StartEngine
-- @usage server
-- Starts or stops the engine.
--
-- @param  start boolean  True to start, false to stop
function StartEngine( start) end

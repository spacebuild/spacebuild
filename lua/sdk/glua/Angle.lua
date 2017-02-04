---
-- @description Library Angle
 module("Angle")

--- Angle:Forward
-- @usage shared
-- Returns a normal vector facing in the direction that the angle points.
--
-- @return Vector The forward direction of the angle
function Forward() end

--- Angle:IsZero
-- @usage shared
-- Returns whether the pitch, yaw and roll are 0 or not.
--
-- @return boolean Whether the pitch, yaw and roll are 0 or not.
function IsZero() end

--- Angle:Normalize
-- @usage shared
-- Normalizes the angles by applying a module with 360 to pitch, yaw and roll.
--
function Normalize() end

--- Angle:Right
-- @usage shared
-- Returns a normal vector facing in the direction that points right relative to the angle's direction.
--
-- @return Vector The right direction of the angle
function Right() end

--- Angle:RotateAroundAxis
-- @usage shared
-- Rotates the angle around the specified axis by the specified degrees.
--
-- @param  axis Vector  The axis to rotate around.
-- @param  rotation number  The degrees to rotate around the specified axis.
function RotateAroundAxis( axis,  rotation) end

--- Angle:Set
-- @usage shared
-- Copies pitch, yaw and roll from the second angle to the first.
--
-- @param  originalAngle Angle  The angle to copy the values from.
function Set( originalAngle) end

--- Angle:SnapTo
-- @usage shared
-- Snaps the angle to nearest interval of degrees.
--
-- @param  axis string  The component/axis to snap. Can be either "p"/"pitch", "y"/"yaw" or "r"/"roll".
-- @param  target number  The target angle snap interval
-- @return Angle The snapped angle.
function SnapTo( axis,  target) end

--- Angle:Up
-- @usage shared
-- Returns a normal vector facing in the direction that points up relative to the angle's direction.
--
-- @return Vector The up direction of the angle.
function Up() end

--- Angle:Zero
-- @usage shared
-- Sets pitch, yaw and roll to 0.
--This function is faster than doing it manually.
--
function Zero() end

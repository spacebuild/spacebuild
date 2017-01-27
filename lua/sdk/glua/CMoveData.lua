---
-- @description Library CMoveData
 module("CMoveData")

--- CMoveData:AddKey
-- @usage shared
-- Adds keys to the move data, as if player pressed them.
--
-- @param  keys number  Keys to add, see IN_ Enums
function AddKey( keys) end

--- CMoveData:GetAbsMoveAngles
-- @usage shared
-- Gets the aim angle. Seems to be same as CMoveData:GetAngles.
--
-- @return Angle Aiming angle
function GetAbsMoveAngles() end

--- CMoveData:GetAngles
-- @usage shared
-- Gets the aim angle. On client is the same as Entity:GetAngles.
--
-- @return Angle Aiming angle
function GetAngles() end

--- CMoveData:GetButtons
-- @usage shared
-- Gets which buttons are down
--
-- @return number An integer representing which buttons are down, see IN_ Enums
function GetButtons() end

--- CMoveData:GetConstraintRadius
-- @usage shared
-- Returns the radius that constrains the players movement.
--
-- @return number The constraint radius
function GetConstraintRadius() end

--- CMoveData:GetForwardSpeed
-- @usage shared
-- Returns the players forward speed.
--
-- @return number speed
function GetForwardSpeed() end

--- CMoveData:GetImpulseCommand
-- @usage shared
-- Gets the number passed to "impulse" console command
--
-- @return number The impulse
function GetImpulseCommand() end

--- CMoveData:GetMaxClientSpeed
-- @usage shared
-- Returns the maximum client speed of the player
--
-- @return number The maximum client speed
function GetMaxClientSpeed() end

--- CMoveData:GetMaxSpeed
-- @usage shared
-- Returns the maximum speed of the player.
--
-- @return number The maximum speed
function GetMaxSpeed() end

--- CMoveData:GetMoveAngles
-- @usage shared
-- Returns the angle the player is moving at. For more info, see CMoveData:SetMoveAngles.
--
-- @return Angle The move direction
function GetMoveAngles() end

--- CMoveData:GetOldAngles
-- @usage shared
-- Gets the aim angle. Only works clientside, server returns same as CMoveData:GetAngles.
--
-- @return Angle The aim angle
function GetOldAngles() end

--- CMoveData:GetOldButtons
-- @usage shared
-- Get which buttons were down last frame
--
-- @return number An integer representing which buttons were down, see IN_ Enums
function GetOldButtons() end

--- CMoveData:GetOrigin
-- @usage shared
-- Gets the player's position.
--
-- @return Vector The player's position.
function GetOrigin() end

--- CMoveData:GetSideSpeed
-- @usage shared
-- Returns the strafe speed of the player.
--
-- @return number speed
function GetSideSpeed() end

--- CMoveData:GetUpSpeed
-- @usage shared
-- Returns the vertical speed of the player. ( Z axis of CMoveData:GetVelocity )
--
-- @return number Vertical speed
function GetUpSpeed() end

--- CMoveData:GetVelocity
-- @usage shared
-- Gets the players velocity.
--
-- @return Vector The players velocity
function GetVelocity() end

--- CMoveData:KeyDown
-- @usage shared
-- Returns whether the key is down or not
--
-- @param  key number  The key to test, see IN_ Enums
-- @return boolean Is the key down or not
function KeyDown( key) end

--- CMoveData:KeyPressed
-- @usage shared
-- Returns whether the key was pressed. If you want to check if the key is held down, try CMoveData:KeyDown
--
-- @param  key number  The key to test, see IN_ Enums
-- @return boolean Was the key pressed or not.
function KeyPressed( key) end

--- CMoveData:KeyReleased
-- @usage shared
-- Returns whether the key was released
--
-- @param  key number  A key to test, see IN_ Enums
-- @return boolean Was the key released or not.
function KeyReleased( key) end

--- CMoveData:KeyWasDown
-- @usage shared
-- Returns whether the key was down or not.
--Unlike CMoveData:KeyDown, it will return false if CMoveData:KeyPressed is true and it will return true if CMoveData:KeyReleased is true.
--
-- @param  key number  The key to test, seee IN_ Enums
-- @return boolean Was the key down or not
function KeyWasDown( key) end

--- CMoveData:SetAbsMoveAngles
-- @usage shared
-- Sets absolute move angles.( ? ) Doesn't seem to do anything.
--
-- @param  ang Angle  New absolute move angles
function SetAbsMoveAngles( ang) end

--- CMoveData:SetAngles
-- @usage shared
-- Sets angles ( ? ). Doesn't seem to be doing anything.
--
-- @param  ang Angle  The angles
function SetAngles( ang) end

--- CMoveData:SetButtons
-- @usage shared
-- Sets the pressed buttons on the move data
--
-- @param  buttons number  A number representing which buttons are down, see IN_ Enums
function SetButtons( buttons) end

--- CMoveData:SetConstraintRadius
-- @usage shared
-- Sets the radius that constrains the players movement.
--It is unknown what this function does as changing its values doesn't affect player movement.
--
-- @param  radius number  The new constraint radius
function SetConstraintRadius( radius) end

--- CMoveData:SetForwardSpeed
-- @usage shared
-- Sets players forward speed.
--
-- @param  speed number  New forward speed
function SetForwardSpeed( speed) end

--- CMoveData:SetImpulseCommand
-- @usage shared
-- Sets the impulse command. Seems to be broken.
--
-- @param  impulse number  The impulse to set
function SetImpulseCommand( impulse) end

--- CMoveData:SetMaxClientSpeed
-- @usage shared
-- Sets the maximum player speed. Player won't be able to run or sprint faster then this value.
--This also automatically sets CMoveData:SetMaxSpeed when used in the GM:SetupMove hook. You must set it manually in the GM:Move hook.
--This must be called on both client and server to avoid prediction errors.
--This will not reduce speed in air.
--
-- @param  maxSpeed number  The new maximum speed
function SetMaxClientSpeed( maxSpeed) end

--- CMoveData:SetMaxSpeed
-- @usage shared
-- Sets the maximum speed of the player. This must match with CMoveData:SetMaxClientSpeed both, on server and client.
--Doesn't seem to be doing anything on it's own, use CMoveData:SetMaxClientSpeed instead.
--
-- @param  maxSpeed number  The new maximum speed
function SetMaxSpeed( maxSpeed) end

--- CMoveData:SetMoveAngles
-- @usage shared
-- Sets the serverside move angles. Means movement keys will act as if player was facing that direction.
--
-- @param  dir Angle  The aim direction.
function SetMoveAngles( dir) end

--- CMoveData:SetOldAngles
-- @usage shared
-- Sets old aim angles. ( ? ) Doesn't seem to be doing anything.
--
-- @param  aimAng Angle  The old angles
function SetOldAngles( aimAng) end

--- CMoveData:SetOldButtons
-- @usage shared
-- Sets the 'old' pressed buttons on the move data. These buttons are used to work out which buttons have been released, which have just been pressed and which are being held down.
--
-- @param  buttons number  A number representing which buttons were down, see IN_ Enums
function SetOldButtons( buttons) end

--- CMoveData:SetOrigin
-- @usage shared
-- Sets the players position.
--
-- @param  pos Vector  The position
function SetOrigin( pos) end

--- CMoveData:SetSideSpeed
-- @usage shared
-- Sets players strafe speed.
--
-- @param  speed number  Strafe speed
function SetSideSpeed( speed) end

--- CMoveData:SetUpSpeed
-- @usage shared
-- Sets vertical speed of the player. ( Z axis of CMoveData:SetVelocity )
--
-- @param  speed number  Vertical speed to set
function SetUpSpeed( speed) end

--- CMoveData:SetVelocity
-- @usage shared
-- Sets the player's velocity
--
-- @param  velocity Vector  The velocity to set
function SetVelocity( velocity) end

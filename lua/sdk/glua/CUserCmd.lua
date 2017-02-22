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
-- @description Library CUserCmd
 module("CUserCmd")

--- CUserCmd:ClearButtons
-- @usage shared
-- Removes all keys from the command. Doesn't prevent movement, see CUserCmd:ClearMovement for this.
--
function ClearButtons() end

--- CUserCmd:ClearMovement
-- @usage shared
-- Clears the movement from the command.
--
function ClearMovement() end

--- CUserCmd:CommandNumber
-- @usage shared
-- Returns an increasing number representing the index of the user cmd. The value returned is occasionally 0 inside GM:CreateMove, so it's advised to check for a non-zero value if you wish to get the correct number.
--
-- @return number The command number
function CommandNumber() end

--- CUserCmd:GetButtons
-- @usage shared
-- Returns a bitflag indicating which buttons are pressed.
--
-- @return number Pressed buttons, see IN_ Enums
function GetButtons() end

--- CUserCmd:GetForwardMove
-- @usage shared
-- The speed the client wishes to move forward with, negative if the clients wants to move backwards.
--
-- @return number The desired speed
function GetForwardMove() end

--- CUserCmd:GetImpulse
-- @usage shared
-- Gets the current impulse from the client, usually 0.
--
-- @return number The impulse
function GetImpulse() end

--- CUserCmd:GetMouseWheel
-- @usage shared
-- Returns the scroll delta as whole number.
--
-- @return number Scroll delta
function GetMouseWheel() end

--- CUserCmd:GetMouseX
-- @usage shared
-- Returns the delta of the angular horizontal mouse movement of the player.
--
-- @return number xDelta
function GetMouseX() end

--- CUserCmd:GetMouseY
-- @usage shared
-- Returns the delta of the angular vertical mouse movement of the player.
--
-- @return number yDelta
function GetMouseY() end

--- CUserCmd:GetSideMove
-- @usage shared
-- The speed the client wishes to move sideways with, positive if it wants to move right, negative if it wants to move left.
--
-- @return number requestSpeed
function GetSideMove() end

--- CUserCmd:GetUpMove
-- @usage shared
-- The speed the client wishes to move up with, negative if the clients wants to move down.
--
-- @return number requestSpeed
function GetUpMove() end

--- CUserCmd:GetViewAngles
-- @usage shared
-- Gets the direction the player is looking in.
--
-- @return Angle requestDir
function GetViewAngles() end

--- CUserCmd:IsForced
-- @usage shared
-- When players are not sending usercommands to the server (often due to lag), their last usercommand will be executed multiple times as a backup. This function returns true if that is happening.
--
-- @return boolean isForced
function IsForced() end

--- CUserCmd:KeyDown
-- @usage shared
-- Returns true if the specified button(s) is pressed.
--
-- @param  key number  Bitflag representing which button to check, see IN_ Enums.
-- @return boolean Is key down or not
function KeyDown( key) end

--- CUserCmd:RemoveKey
-- @usage shared
-- Removed a key bit from the current key bitflag.
--
-- @param  button number  Bitflag to be removed from the key bitflag, see IN_ Enums.
function RemoveKey( button) end

--- CUserCmd:SelectWeapon
-- @usage shared
-- Forces the associated player to select a weapon.
--This is used internally in the default HL2 weapon selection HUD.
--
-- @param  weapon Weapon  The weapon entity to select.
function SelectWeapon( weapon) end

--- CUserCmd:SetButtons
-- @usage shared
-- Sets the buttons bitflag
--
-- @param  buttons number  Bitflag representing which buttons are "down", see IN_ Enums.
function SetButtons( buttons) end

--- CUserCmd:SetForwardMove
-- @usage shared
-- Sets speed the client wishes to move forward with, negative if the clients wants to move backwards.
--
-- @param  speed number  The new speed to request.
function SetForwardMove( speed) end

--- CUserCmd:SetImpulse
-- @usage shared
-- Sets the impulse to be send together with the command.
--
-- @param  speed number  The impulse to send.
function SetImpulse( speed) end

--- CUserCmd:SetMouseWheel
-- @usage shared
-- Sets the scroll delta.
--
-- @param  speed number  The scroll delta.
function SetMouseWheel( speed) end

--- CUserCmd:SetMouseX
-- @usage shared
-- Sets the delta of the angular horizontal mouse movement of the player.
--
-- @param  speed number  Angular horizontal move delta.
function SetMouseX( speed) end

--- CUserCmd:SetMouseY
-- @usage shared
-- Sets the delta of the angular vertical mouse movement of the player.
--
-- @param  speed number  Angular vertical move delta.
function SetMouseY( speed) end

--- CUserCmd:SetSideMove
-- @usage shared
-- Sets speed the client wishes to move sidewards with, positive to move right, negative to move left.
--
-- @param  speed number  The new speed to request.
function SetSideMove( speed) end

--- CUserCmd:SetUpMove
-- @usage shared
-- Sets speed the client wishes to move upwards with, negative to move down.
--
-- @param  speed number  The new speed to request.
function SetUpMove( speed) end

--- CUserCmd:SetViewAngles
-- @usage shared
-- Sets the direction the client wants to move in.
--
-- @param  viewAngle Angle  New view angles.
function SetViewAngles( viewAngle) end

--- CUserCmd:TickCount
-- @usage shared
-- Returns tick count since joining the server. This will always return 0 for bots.
--
-- @return number The amount of ticks passed since joining the server.
function TickCount() end

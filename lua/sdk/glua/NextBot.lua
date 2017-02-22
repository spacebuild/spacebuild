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
-- @description Library NextBot
 module("NextBot")

--- NextBot:BecomeRagdoll
-- @usage server
-- Become a ragdoll and remove the entity.
--
-- @param  info CTakeDamageInfo  Damage info passed from an onkilled event
function BecomeRagdoll( info) end

--- NextBot:BodyMoveXY
-- @usage server
-- Should only be called in BodyUpdate. This sets the move_x and move_y pose parameters of the bot to fit how they're currently moving, sets the animation speed to suit the ground speed and calls FrameAdvance.
--
function BodyMoveXY() end

--- NextBot:FindSpot
-- @usage server
-- Like NextBot:FindSpots but only returns a vector.
--
-- @param  type string  Either "random", "near", "far"
-- @param  options table  This table should contain the search info.  string type - The type (Only'hiding' for now)Vector pos - the position to search.number radius - the radius to search.number stepup - the highest step to step up.number stepdown - the highest we can step down without being hurt.
-- @return Vector If it finds a spot it will return a vector. If not it will return nil.
function FindSpot( type,  options) end

--- NextBot:FindSpots
-- @usage server
-- Returns a table of hiding spots.
--
-- @param  specs table  This table should contain the search info.  string type - The type (either 'hiding')Vector pos - the position to search.number radius - the radius to search.number stepup - the highest step to step up.number stepdown - the highest we can step down without being hurt.
-- @return table An unsorted table of tables containing: Vector vector - The position of the hiding spotnumber distance - the distance to that position
function FindSpots( specs) end

--- NextBot:GetActivity
-- @usage server
-- Returns the currently running activity
--
-- @return number The current activity
function GetActivity() end

--- NextBot:GetRangeSquaredTo
-- @usage server
-- Returns the distance to an entity or position. It is supposed to return a squared distance, however.
--
-- @param  to Vector  Position to measure distance to. Can be an entity.
-- @return number Distance
function GetRangeSquaredTo( to) end

--- NextBot:GetRangeTo
-- @usage server
-- Returns the distance to an entity or position
--
-- @param  to Vector  Either an entity or a Vector position
-- @return number distance
function GetRangeTo( to) end

--- NextBot:GetSolidMask
-- @usage server
-- Returns the solid mask for given NextBot.
--
-- @return number The solid mask, see CONTENTS_ Enums and MASK_ Enums
function GetSolidMask() end

--- NextBot:HandleStuck
-- @usage server
-- Called from Lua when the NPC is stuck. This should only be called from the behaviour coroutine - so if you want to override this function and do something special that yields - then go for it.
--
function HandleStuck() end

--- NextBot:MoveToPos
-- @usage server
-- To be called in the behaviour coroutine only! Will yield until the bot has reached the goal or is stuck
--
-- @param  pos Vector  The position we want to get to
-- @param  options table  A table containing a bunch of tweakable options. number lookahead - Minimum look ahead distance. number tolerance - How close we must be to the goal before it can be considered complete. boolean draw - Draw the path. Only visible on listen servers and single player. number maxage - Maximum age of the path before it times out.  number repath - Rebuilds the path after this number of seconds.
-- @return string Either "failed", "stuck", "timeout" or "ok" - depending on how the NPC got on
function MoveToPos( pos,  options) end

--- NextBot:PlaySequenceAndWait
-- @usage server
-- To be called in the behaviour coroutine only! Plays an animation sequence and waits for it to end before returning.
--
-- @param  name string  The sequence name
-- @param  speed=1 number  Playback Rate of that sequence
function PlaySequenceAndWait( name,  speed) end

--- NextBot:SetSolidMask
-- @usage server
-- Sets the solid mask for given NextBot.
--
-- @param  mask number  The new mask, see CONTENTS_ Enums and MASK_ Enums
function SetSolidMask( mask) end

--- NextBot:StartActivity
-- @usage server
-- Start doing an activity (animation)
--
-- @param  activity number  One of the ACT_ Enums
function StartActivity( activity) end

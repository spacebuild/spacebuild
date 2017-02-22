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
-- @description Library ENT_NEXTBOT
 module("ENT_NEXTBOT")

--- ENT_NEXTBOT:BehaveStart
-- @usage server
-- Called to initialize the behaviour.
--
function BehaveStart() end

--- ENT_NEXTBOT:BehaveUpdate
-- @usage server
-- Called to update the bot's behaviour.
--
-- @param  interval number  How long since the last update
function BehaveUpdate( interval) end

--- ENT_NEXTBOT:BodyUpdate
-- @usage server
-- Called to update the bot's animation.
--
function BodyUpdate() end

--- ENT_NEXTBOT:OnContact
-- @usage server
-- Called when the nextbot touches another entity.
--
-- @param  ent Entity  The entity the nextbot came in contact with.
function OnContact( ent) end

--- ENT_NEXTBOT:OnIgnite
-- @usage server
-- Called when the bot is ignited.
--
function OnIgnite() end

--- ENT_NEXTBOT:OnInjured
-- @usage server
-- Called when the bot gets hurt.
--
-- @param  info CTakeDamageInfo  The damage info
function OnInjured( info) end

--- ENT_NEXTBOT:OnKilled
-- @usage server
-- Called when the bot gets killed.
--
-- @param  info CTakeDamageInfo  The damage info
function OnKilled( info) end

--- ENT_NEXTBOT:OnLandOnGround
-- @usage server
-- Called when the bot's feet return to the ground.
--
-- @param  ent Entity  The entity the nextbot has landed on.
function OnLandOnGround( ent) end

--- ENT_NEXTBOT:OnLeaveGround
-- @usage server
-- Called when the bot's feet leave the ground - for whatever reason.
--
-- @param  ent Entity  The entity the bot "jumped" from.
function OnLeaveGround( ent) end

--- ENT_NEXTBOT:OnNavAreaChanged
-- @usage server
-- Called when the nextbot enters a new navigation area.
--
-- @param  old CNavArea  The navigation area the bot just left
-- @param  new CNavArea  The navigation area the bot just entered
function OnNavAreaChanged( old,  new) end

--- ENT_NEXTBOT:OnOtherKilled
-- @usage server
-- Called when someone else or something else has been killed.
--
-- @param  victim Entity  The victim that was killed
-- @param  info CTakeDamageInfo  The damage info
function OnOtherKilled( victim,  info) end

--- ENT_NEXTBOT:OnStuck
-- @usage server
-- Called when the bot thinks it is stuck.
--
function OnStuck() end

--- ENT_NEXTBOT:OnUnStuck
-- @usage server
-- Called when the bot thinks it is un-stuck.
--
function OnUnStuck() end

--- ENT_NEXTBOT:Think
-- @usage server
-- Called every tick.
--
function Think() end

--- ENT_NEXTBOT:Use
-- @usage server
-- Called when a player 'uses' the entity.
--
-- @param  activator Entity  The initial cause for the use.
-- @param  caller Entity  The entity that directly triggered the use.
-- @param  type number  The type of use, see USE_ Enums
-- @param  value number  Any passed value
function Use( activator,  caller,  type,  value) end

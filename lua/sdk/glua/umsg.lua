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
-- @description Library umsg
 module("umsg")

--- umsg.Angle
-- @usage server
-- Writes an angle to the usermessage.
--
-- @param  angle Angle  The angle to be sent.
function Angle( angle) end

--- umsg.Bool
-- @usage server
-- Writes a bool to the usermessage.
--
-- @param  bool boolean  The bool to be sent.
function Bool( bool) end

--- umsg.Char
-- @usage server
-- Writes a signed char to the usermessage.
--
-- @param  char number  The char to be sent.
function Char( char) end

--- umsg.End
-- @usage server
-- Dispatches the usermessage to the client(s).
--
function End() end

--- umsg.Entity
-- @usage server
-- Writes an entity object to the usermessage.
--
-- @param  entity Entity  The entity to be sent.
function Entity( entity) end

--- umsg.Float
-- @usage server
-- Writes a float to the usermessage.
--
-- @param  float number  The float to be sent.
function Float( float) end

--- umsg.Long
-- @usage server
-- Writes a signed int (32 bit) to the usermessage.
--
-- @param  int number  The int to be sent.
function Long( int) end

--- umsg.PoolString
-- @usage server
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Inferior version of util.AddNetworkString
-- @param  string string  The string to be pooled.
function PoolString( string) end

--- umsg.Short
-- @usage server
-- Writes a signed short (16 bit) to the usermessage.
--
-- @param  short number  The short to be sent.
function Short( short) end

--- umsg.Start
-- @usage server
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using net library instead
-- @param  name string  The name of the message to be sent.
-- @param  filter Player  If passed a player object, it will only be sent to the player, if passed a CRecipientFilter of players, it will be sent to all specified players, if passed nil (or another invalid value), the message will be sent to all players.
function Start( name,  filter) end

--- umsg.String
-- @usage server
-- Writes a null terminated string to the usermessage.
--
-- @param  string string  The string to be sent.
function String( string) end

--- umsg.Vector
-- @usage server
-- Writes a Vector to the usermessage.
--
-- @param  vector Vector  The vector to be sent.
function Vector( vector) end

--- umsg.VectorNormal
-- @usage server
-- Writes a vector normal to the usermessage.
--
-- @param  normal Vector  The vector normal to be sent.
function VectorNormal( normal) end

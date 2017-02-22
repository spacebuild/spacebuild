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
-- @description Library usermessage
 module("usermessage")

--- usermessage.GetTable
-- @usage shared
-- Returns a table of every usermessage hook
--
-- @return table hooks
function GetTable() end

--- usermessage.Hook
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using net library instead
-- @param  name string  The message name to hook to.
-- @param  callback function  The function to be called if the specified message was received. Parameters (Optional):   bf_read msg  vararg preArgs
-- @param  preArgs=nil vararg  Arguments that are passed to the callback function when the hook is called. *ring ring*
function Hook( name,  callback,  preArgs) end

--- usermessage.IncomingMessage
-- @usage shared
-- Called by the engine when a usermessage arrives, this method calls the hook function specified by usermessage.Hook if any.
--
-- @param  name string  The message name.
-- @param  msg bf_read  The message.
function IncomingMessage( name,  msg) end

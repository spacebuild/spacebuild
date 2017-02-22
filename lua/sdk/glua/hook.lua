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
-- @description Library hook
 module("hook")

--- hook.Add
-- @usage shared_m
-- Add a hook to be called upon the given event occurring.
--
-- @param  eventName string  The event to hook on to, see GM Hooks and Sandbox Hooks
-- @param  identifier any  The unique identifier, usually a string. This can be used elsewhere in the code to replace or remove the hook. The identifier should be unique so that you do not accidentally override some other mods hook, unless that's what you are trying to do. The identifier can be either a string, or a table/object with an IsValid function defined such as an Entity or Panel. numbers and booleans, for example, are not allowed.  If the identifier is a table/object, it will be inserted in front of the other arguments in the callback and the hook will be called as long as it's valid. However, as soon as IsValid( identifier ) returns false, the hook will be removed.
-- @param  func function  The function to be called, arguments given to it depend on the hook.    WARNING  Returning any value besides nil from the hook's function will stop other hooks of the same event down the loop from being executed. Only return a value when absolutely necessary and when you know what you are doing.It WILL break other addons. 
function Add( eventName,  identifier,  func) end

--- hook.Call
-- @usage shared_m
-- Calls hooks associated with the given event
--Calls all hooks until one returns something other than nil and then returns that data.
--
-- @param  eventName string  The event to call hooks for
-- @param  gamemodeTable table  If the gamemode is specified, the gamemode hook within will be called, otherwise not
-- @param  args vararg  The arguments to be passed to the hooks
-- @return vararg Return data from called hooks. Limited to 6 return values
function Call( eventName,  gamemodeTable,  args) end

--- hook.GetTable
-- @usage shared_m
-- Returns a table containing subtables which contain all hooks.
--
-- @return table hooks
function GetTable() end

--- hook.Remove
-- @usage shared_m
-- Removes the hook with the supplied identifier from the given event.
--
-- @param  eventName string  The event name.
-- @param  identifier any  The unique identifier of the hook to remove, usually a string.
function Remove( eventName,  identifier) end

--- hook.Run
-- @usage shared_m
-- Calls hooks associated with the given event
--Calls all hooks until one returns something other than nil and then returns that data.
--This works by calling hook.Call
--
-- @param  eventName string  The event to call hooks for
-- @param  args vararg  The arguments to be passed to the hooks
-- @return any Returned data from called hooks
function Run( eventName,  args) end

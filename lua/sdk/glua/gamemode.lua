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
-- @description Library gamemode
 module("gamemode")

--- gamemode.Call
-- @usage shared
-- Called by the engine to call a hook within the loaded gamemode.
--
-- @param  name string  The name of the hook to call.
-- @param  args vararg  The arguments
-- @return any The result of the hook function.
function Call( name,  args) end

--- gamemode.Get
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  name string  The name of the gamemode you want to get
-- @return table The gamemode's table
function Get( name) end

--- gamemode.Register
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  gm table  Your GM table
-- @param  name string  Name of your gamemode, lowercase, no spaces.
-- @param  derived string  The gamemode name that your gamemode is derived from
function Register( gm,  name,  derived) end

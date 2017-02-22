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
-- @description Library effects
 module("effects")

--- effects.Create
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
--
--You are looking for util.Effect.
-- @param  name string  Effect name.
-- @return table Effect table.
function Create( name) end

--- effects.Register
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  effect_table table  Effect table.
-- @param  name string  Effect name.
function Register( effect_table,  name) end

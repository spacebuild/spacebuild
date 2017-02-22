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
-- @description Library baseclass
 module("baseclass")

--- baseclass.Get
-- @usage shared_m
-- Gets the base class of an an object.
--
-- @param  name string  The child class.
-- @return table The base class's meta table.
function Get( name) end

--- baseclass.Set
-- @usage shared_m
-- Add a new base class that can be derived by others. This is done automatically for:
--
-- @param  name string  The name of this base class. Must be completely unique.
-- @param  tab table  The base class.
function Set( name,  tab) end

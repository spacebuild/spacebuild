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
-- @description Library weapons
 module("weapons")

--- weapons.Get
-- @usage shared
-- Get copy of weapon table by name. If all you need to do is access a variable from the weapon table, use weapons.GetStored instead.
--
-- @param  classname string  Class name of weapon to retrieve
-- @return table The retrieved table or nil
function Get( classname) end

--- weapons.GetList
-- @usage shared
-- Get a list of all the registered SWEPs. This does not include weapons added to spawnmenu manually.
--
-- @return table List of all the registered SWEPs
function GetList() end

--- weapons.GetStored
-- @usage shared
-- Gets the REAL weapon table, not a copy.
--
-- @param  weapon_class string  Weapon class to retrieve weapon table of
-- @return table The weapon table
function GetStored( weapon_class) end

--- weapons.IsBasedOn
-- @usage shared
-- Checks if name is based on base
--
-- @param  name string  Entity's class name to be checked
-- @param  base string  Base class name to be checked
-- @return boolean Returns true if class name is based on base, else false.
function IsBasedOn( name,  base) end

--- weapons.OnLoaded
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function OnLoaded() end

--- weapons.Register
-- @usage shared
-- Used to register your SWEP with the engine.
--
-- @param  swep_table table  The SWEP table
-- @param  classname string  Classname to assign to that swep
function Register( swep_table,  classname) end

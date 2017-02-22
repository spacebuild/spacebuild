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
-- @description Library scripted_ents
 module("scripted_ents")

--- scripted_ents.Alias
-- @usage shared
-- Defines an alias string that can be used to refer to another classname
--
-- @param  alias string  A new string which can be used to refer to another classname
-- @param  classname string  The classname the alias should refer to
function Alias( alias,  classname) end

--- scripted_ents.Get
-- @usage shared
-- Returns a copy of the ENT table for a class, including functions defined by the base class
--
-- @param  classname string  The classname of the ENT table to return, can be an alias
-- @return table entTable
function Get( classname) end

--- scripted_ents.GetList
-- @usage shared
-- Returns a copy of the list of all ENT tables registered
--
-- @return table entTables
function GetList() end

--- scripted_ents.GetMember
-- @usage shared
-- Retrieves a member of entity's table.
--
-- @param  class string  Entity's class name
-- @param  name string  Name of member to retrieve
-- @return any The member or nil if failed
function GetMember( class,  name) end

--- scripted_ents.GetSpawnable
-- @usage shared
-- Returns a list of all ENT tables which contain either ENT.Spawnable or ENT.AdminSpawnable
--
-- @return table spawnableClasses
function GetSpawnable() end

--- scripted_ents.GetStored
-- @usage shared
-- Returns the actual ENT table for a class. Modifying functions/variables in this table will change newly spawned entities
--
-- @param  classname string  The classname of the ENT table to return
-- @return table entTable
function GetStored( classname) end

--- scripted_ents.GetType
-- @usage shared
-- Returns the 'type' of a class, this will one of the following: 'anim', 'ai', 'brush', 'point'.
--
-- @param  classname string  The classname to check
-- @return string type
function GetType( classname) end

--- scripted_ents.IsBasedOn
-- @usage shared
-- Checks if name is based on base
--
-- @param  name string  Entity's class name to be checked
-- @param  base string  Base class name to be checked
-- @return boolean Returns true if class name is based on base, else false.
function IsBasedOn( name,  base) end

--- scripted_ents.OnLoaded
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function OnLoaded() end

--- scripted_ents.Register
-- @usage shared
-- Registers an ENT table with a classname. Reregistering an existing classname will automatically update the functions of all existing entities of that class.
--
-- @param  ENT table  The ENT table to register
-- @param  classname string  The classname to register
function Register( ENT,  classname) end

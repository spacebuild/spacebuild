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
-- @description Library saverestore
 module("saverestore")

--- saverestore.AddRestoreHook
-- @usage shared
-- Adds a restore/load hook for the Half-Life 2 save system.
--
-- @param  identifier string  The unique identifier for this hook.
-- @param  callback function  The function to be called when an engine save is being loaded. It has one argument: IRestore save - The restore object to be used to read data from save file that is being loaded  You can also use those functions to read data: saverestore.ReadVar saverestore.ReadTable saverestore.LoadEntity  
function AddRestoreHook( identifier,  callback) end

--- saverestore.AddSaveHook
-- @usage shared
-- Adds a save hook for the Half-Life 2 save system. You can this to carry data through level transitions in Half-Life 2.
--
-- @param  identifier string  The unique identifier for this hook.
-- @param  callback function  The function to be called when an engine save is being saved. It has one argument: ISave save - The save object to be used to write data to the save file that is being saved  You can also use those functions to save data: saverestore.WriteVar saverestore.WriteTable saverestore.SaveEntity  
function AddSaveHook( identifier,  callback) end

--- saverestore.LoadEntity
-- @usage shared
-- Loads Entity:GetTable from the save game file that is being loaded and merges it with the given entitys Entity:GetTable.
--
-- @param  ent Entity  The entity which will receive the loaded values from the save.
-- @param  save IRestore  The restore object to read the Entity:GetTable from.
function LoadEntity( ent,  save) end

--- saverestore.LoadGlobal
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  save IRestore  The restore object to read data from the save file with.
function LoadGlobal( save) end

--- saverestore.PreRestore
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function PreRestore() end

--- saverestore.PreSave
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function PreSave() end

--- saverestore.ReadTable
-- @usage shared
-- Reads a table from the save game file that is being loaded.
--
-- @param  save IRestore  The restore object to read the table from.
-- @return table The table that has been read, if any
function ReadTable( save) end

--- saverestore.ReadVar
-- @usage shared
-- Loads a variable from the save game file that is being loaded.
--
-- @param  save IRestore  The restore object to read variables from.
-- @return any The variable that was read, if any.
function ReadVar( save) end

--- saverestore.SaveEntity
-- @usage shared
-- Saves entitys Entity:GetTable to the save game file that is being saved.
--
-- @param  ent Entity  The entity to save Entity:GetTable of.
-- @param  save ISave  The save object to save Entity:GetTable to.
function SaveEntity( ent,  save) end

--- saverestore.SaveGlobal
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  save ISave  The save object to write data into the save file.
function SaveGlobal( save) end

--- saverestore.WritableKeysInTable
-- @usage shared
-- Returns how many writable keys are in the given table.
--
-- @param  table table  The table to test.
-- @return number The number of keys that can be written with saverestore.WriteTable.
function WritableKeysInTable( table) end

--- saverestore.WriteTable
-- @usage shared
-- Write a table to a save game file that is being saved.
--
-- @param  table table  The table to write
-- @param  save ISave  The save object to write the table to.
function WriteTable( table,  save) end

--- saverestore.WriteVar
-- @usage shared
-- Writes a variable to the save game file that is being saved.
--
-- @param  value any  The value to save.It can be one of the following types: number, boolean, string, Entity, Angle, Vector or table.
-- @param  save ISave  The save object to write the variable to.
function WriteVar( value,  save) end

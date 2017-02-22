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
-- @description Library Schedule
 module("Schedule")

--- Schedule:AddTask
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  taskname string  Task name, see ai_task.h
-- @param  taskdata number  Task data as a float
function AddTask( taskname,  taskdata) end

--- Schedule:AddTaskEx
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  start string 
-- @param  run string 
-- @param  data number 
function AddTaskEx( start,  run,  data) end

--- Schedule:EngTask
-- @usage server
-- Adds an engine task to the schedule.
--
-- @param  taskname string  Task name.
-- @param  taskdata number  Task data.
function EngTask( taskname,  taskdata) end

--- Schedule:GetTask
-- @usage server
-- Returns the task at the given index.
--
-- @param  num number  Task index.
function GetTask( num) end

--- Schedule:Init
-- @usage server
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  debugName string  The name passed from ai_schedule.New.
function Init( debugName) end

--- Schedule:NumTasks
-- @usage server
-- Returns the number of tasks in the schedule.
--
-- @return number The number of tasks in this schedule.
function NumTasks() end

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
-- @description Library Task
 module("Task")

--- Task:Init
-- @usage server
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function Init() end

--- Task:InitEngine
-- @usage server
-- Initialises the AI task as an engine task.
--
-- @param  taskname string  The name of the task.
-- @param  taskdata number 
function InitEngine( taskname,  taskdata) end

--- Task:InitFunctionName
-- @usage server
-- Initialises the AI task as NPC method-based.
--
-- @param  startname string  The name of the NPC method to call on task start.
-- @param  runname string  The name of the NPC method to call on task run.
-- @param  taskdata number 
function InitFunctionName( startname,  runname,  taskdata) end

--- Task:IsEngineType
-- @usage server
-- Determines if the task is an engine task (TYPE_ENGINE, 1).
--
function IsEngineType() end

--- Task:IsFNameType
-- @usage server
-- Determines if the task is an NPC method-based task (TYPE_FNAME, 2).
--
function IsFNameType() end

--- Task:Run
-- @usage server
-- Runs the AI task.
--
-- @param  target NPC  The NPC to run the task on.
function Run( target) end

--- Task:Run_FName
-- @usage server
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  target NPC  The NPC to run the task on.
function Run_FName( target) end

--- Task:Start
-- @usage server
-- Starts the AI task.
--
-- @param  target NPC  The NPC to start the task on.
function Start( target) end

--- Task:Start_FName
-- @usage server
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  target NPC  The NPC to start the task on.
function Start_FName( target) end

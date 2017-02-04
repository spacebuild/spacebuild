---
-- @description Library ENT_AI
 module("ENT_AI")

--- ENT_AI:DoingEngineSchedule
-- @usage server
-- Called whenever an engine schedule is being ran.
--
function DoingEngineSchedule() end

--- ENT_AI:DoSchedule
-- @usage server
-- Runs a Lua schedule. Runs tasks inside the schedule.
--
-- @param  sched table  The schedule to run.
function DoSchedule( sched) end

--- ENT_AI:EndTouch
-- @usage server
-- Called when the entity stops touching another entity.
--
-- @param  entity Entity  The entity which was touched.
function EndTouch( entity) end

--- ENT_AI:EngineScheduleFinish
-- @usage server
-- Called whenever an engine schedule is finished.
--
function EngineScheduleFinish() end

--- ENT_AI:ExpressionFinished
-- @usage server
-- Validation required.
--This page contains eventual incorrect information and requires validation.
-- @param  strExp string  The path of the expression.
function ExpressionFinished( strExp) end

--- ENT_AI:GetAttackSpread
-- @usage server
-- Validation required.
--This page contains eventual incorrect information and requires validation.
-- @param  wep Entity  The weapon being used by the NPC.
-- @param  target Entity  The target the NPC is attacking
-- @return number The number of degrees of inaccuracy in the NPC's attack.
function GetAttackSpread( wep,  target) end

--- ENT_AI:GetRelationship
-- @usage server
-- Called when scripted NPC needs to check how he "feels" against another entity.
--
-- @param  ent Entity  The entity in question
-- @return number How our scripter NPC "feels" towards the entity in question. See D_ Enums.
function GetRelationship( ent) end

--- ENT_AI:NextTask
-- @usage server
-- Start the next task in specific schedule.
--
-- @param  sched table  The schedule to start next task in.
function NextTask( sched) end

--- ENT_AI:OnCondition
-- @usage server
-- Called each time the NPC updates its condition.
--
-- @param  conditionID number  The ID of condition. See NPC:ConditionName.
function OnCondition( conditionID) end

--- ENT_AI:OnTakeDamage
-- @usage server
-- Called when the entity is taking damage.
--
-- @param  damage CTakeDamageInfo  The damage to be applied to the entity.
function OnTakeDamage( damage) end

--- ENT_AI:OnTaskComplete
-- @usage server
-- Called from the engine when TaskComplete is called.
--This allows us to move onto the next task - even when TaskComplete was called from an engine side task.
--
function OnTaskComplete() end

--- ENT_AI:RunAI
-- @usage server
-- Called from the engine every 0.1 seconds.
--
function RunAI() end

--- ENT_AI:RunEngineTask
-- @usage server
-- Called when an engine task is ran on the entity.
--
-- @param  taskID number  The task ID, see ai_task.h
-- @param  taskData number  The task data.
function RunEngineTask( taskID,  taskData) end

--- ENT_AI:RunTask
-- @usage server
-- Called every think on running task.
--The actual task function should tell us when the task is finished.
--
-- @param  task table  The task to run
function RunTask( task) end

--- ENT_AI:ScheduleFinished
-- @usage server
-- Called whenever a schedule is finished.
--
function ScheduleFinished() end

--- ENT_AI:SelectSchedule
-- @usage server
-- Set the schedule we should be playing right now.
--
-- @param  iNPCState number 
function SelectSchedule( iNPCState) end

--- ENT_AI:SetTask
-- @usage server
-- Sets the current task.
--
-- @param  task table  The task to set.
function SetTask( task) end

--- ENT_AI:StartEngineSchedule
-- @usage server
-- Starts an engine schedule.
--
-- @param  scheduleID number  Schedule ID to start. See SCHED_ Enums
function StartEngineSchedule( scheduleID) end

--- ENT_AI:StartEngineTask
-- @usage server
-- Called when an engine task has been started on the entity.
--
-- @param  taskID number  Task ID to start, see ai_task.h
-- @param  TaskData number  Task data
function StartEngineTask( taskID,  TaskData) end

--- ENT_AI:StartSchedule
-- @usage server
-- Starts a schedule previously created by ai_schedule.New.
--
-- @param  sched Schedule  Schedule to start.
function StartSchedule( sched) end

--- ENT_AI:StartTask
-- @usage server
-- Called once on starting task.
--
-- @param  task Task  The task to start, created by ai_task.New.
function StartTask( task) end

--- ENT_AI:StartTouch
-- @usage server
-- Called when the entity starts touching another entity.
--
-- @param  entity Entity  The entity which is being touched.
function StartTouch( entity) end

--- ENT_AI:TaskFinished
-- @usage server
-- Returns true if the current running Task is finished.
--
-- @return boolean Is the current running Task is finished or not.
function TaskFinished() end

--- ENT_AI:TaskTime
-- @usage server
-- Returns how many seconds we've been doing this current task
--
-- @return number How many seconds we've been doing this current task
function TaskTime() end

--- ENT_AI:Touch
-- @usage server
-- Called when another entity touches the entity.
--
-- @param  entity Entity  The entity that touched it.
function Touch( entity) end

--- ENT_AI:UpdateTransmitState
-- @usage server
-- Called whenever the transmit state should be updated.
--
-- @return number Transmit state to set, see TRANSMIT_ Enums.
function UpdateTransmitState() end

--- ENT_AI:Use
-- @usage server
-- Called when another entity uses this entity, example would be a player pressing "+use" this entity.
--
-- @param  activator Entity  The initial cause for the input getting triggered.
-- @param  caller Entity  The entity that directly triggered the input.
-- @param  useType number  Use type, see USE_ Enums.
-- @param  value number  Any passed value.
function Use( activator,  caller,  useType,  value) end

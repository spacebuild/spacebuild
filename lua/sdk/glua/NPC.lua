---
-- @description Library NPC
 module("NPC")

--- NPC:AddEntityRelationship
-- @usage server
-- Makes the NPC like, hate, feel neutral towards, or fear the entity in question. If you want to setup relationship towards a certain entity class, use NPC:AddRelationship.
--
-- @param  target Entity  The entity for the relationship to be applied to.
-- @param  disposition number  A D_ Enums representing the relationship type.
-- @param  priority number  How strong the relationship is.
function AddEntityRelationship( target,  disposition,  priority) end

--- NPC:AddRelationship
-- @usage server
-- Changes how an NPC feels towards another NPC. If you want to setup relationship towards a certain entity, use NPC:AddEntityRelationship.
--
-- @param  relationstring string  A string representing how the relationship should be set up.  Should be formatted as "npc_class D_ Enums numberPriority".
function AddRelationship( relationstring) end

--- NPC:AlertSound
-- @usage server
-- Force an NPC to play his Alert sound.
--
function AlertSound() end

--- NPC:CapabilitiesAdd
-- @usage server
-- Adds a capability to the NPC.
--
-- @param  capabilities number  Capabilities to add, see CAP_ Enums
function CapabilitiesAdd( capabilities) end

--- NPC:CapabilitiesClear
-- @usage server
-- Removes all of Capabilities the NPC has.
--
function CapabilitiesClear() end

--- NPC:CapabilitiesGet
-- @usage server
-- Returns the NPC's capabilities along the ones defined on its weapon.
--
-- @return number The capabilities as a bitflag. See CAP_ Enums
function CapabilitiesGet() end

--- NPC:CapabilitiesRemove
-- @usage server
-- Remove a certain capability.
--
-- @param  capabilities number  Capabilities to remove, see CAP_ Enums
function CapabilitiesRemove( capabilities) end

--- NPC:Classify
-- @usage server
-- Returns the NPC class. Do not confuse with Entity:GetClass!
--
-- @return number See CLASS_ Enums
function Classify() end

--- NPC:ClearCondition
-- @usage server
-- Clears out the specified COND_ Enums on this NPC.
--
-- @param  condition number  The COND_ Enums to clear out.
function ClearCondition( condition) end

--- NPC:ClearEnemyMemory
-- @usage server
-- Clears the Enemy from the NPC's memory, effectively forgetting it until met again with either the NPC vision or with NPC:UpdateEnemyMemory.
--
function ClearEnemyMemory() end

--- NPC:ClearExpression
-- @usage server
-- Clears the NPC's current expression which can be set with NPC:SetExpression.
--
function ClearExpression() end

--- NPC:ClearGoal
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function ClearGoal() end

--- NPC:ClearSchedule
-- @usage server
-- Stops the current schedule that the NPC is doing.
--
function ClearSchedule() end

--- NPC:ConditionName
-- @usage server
-- Translates condition ID to a string.
--
-- @param  cond number  The NPCs condition ID
-- @return string A human understandable string equivalent of that condition.
function ConditionName( cond) end

--- NPC:Disposition
-- @usage server
-- Returns the way the NPC "feels" about the entity.
--
-- @param  ent Entity  The entity to get the disposition from.
-- @return number The NPCs disposition, see D_ Enums.
function Disposition( ent) end

--- NPC:ExitScriptedSequence
-- @usage server
-- Makes an NPC exit a scripted sequence, if one is playing.
--
function ExitScriptedSequence() end

--- NPC:FearSound
-- @usage server
-- Force an NPC to play his Fear sound.
--
function FearSound() end

--- NPC:FoundEnemySound
-- @usage server
-- Force an NPC to play its FoundEnemy sound.
--
function FoundEnemySound() end

--- NPC:GetActiveWeapon
-- @usage shared
-- Returns the weapon the NPC is currently carrying, or NULL.
--
-- @return Entity The NPCs current weapon
function GetActiveWeapon() end

--- NPC:GetActivity
-- @usage server
-- Returns the NPC's current activity.
--
-- @return number Current activity, see ACT_ Enums.
function GetActivity() end

--- NPC:GetAimVector
-- @usage server
-- Returns the aim vector of the NPC. NPC alternative of Player:GetAimVector.
--
-- @return Vector The aim direction of the NPC.
function GetAimVector() end

--- NPC:GetArrivalActivity
-- @usage server
-- Returns the activity to be played when the NPC arrives at its goal
--
-- @return number 
function GetArrivalActivity() end

--- NPC:GetArrivalSequence
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return number 
function GetArrivalSequence() end

--- NPC:GetBlockingEntity
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return Entity 
function GetBlockingEntity() end

--- NPC:GetCurrentWeaponProficiency
-- @usage server
-- Returns how proficient (skilled) an NPC is with its current weapon.
--
-- @return number NPC's proficiency for current weapon. See WEAPON_PROFICIENCY_ Enums.
function GetCurrentWeaponProficiency() end

--- NPC:GetEnemy
-- @usage server
-- Returns the entity that this NPC is trying to fight
--
-- @return NPC Enemy NPC
function GetEnemy() end

--- NPC:GetExpression
-- @usage server
-- Returns the expression file the NPC is currently playing.
--
-- @return string The file path of the expression.
function GetExpression() end

--- NPC:GetHullType
-- @usage server
-- Returns NPCs hull type set by NPC:SetHullType.
--
-- @return number Hull type, see HULL_ Enums
function GetHullType() end

--- NPC:GetMovementActivity
-- @usage server
-- Returns the NPC's current movement activity.
--
-- @return number Current NPC movement activity, see ACT_ Enums.
function GetMovementActivity() end

--- NPC:GetMovementSequence
-- @usage server
-- Returns the index of the sequence the NPC uses to move.
--
-- @return number The movement sequence index
function GetMovementSequence() end

--- NPC:GetNPCState
-- @usage server
-- Returns the NPC's state.
--
-- @return number The NPC's current state, see NPC_STATE_ Enums.
function GetNPCState() end

--- NPC:GetPathDistanceToGoal
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return number 
function GetPathDistanceToGoal() end

--- NPC:GetPathTimeToGoal
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return number 
function GetPathTimeToGoal() end

--- NPC:GetShootPos
-- @usage server
-- Returns the shooting position of the NPC.
--
-- @return Vector The NPC's shooting position.
function GetShootPos() end

--- NPC:GetTarget
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return Entity 
function GetTarget() end

--- NPC:Give
-- @usage server
-- Used to give a weapon to an already spawned NPC.
--
-- @param  weapon string  Class name of the weapon to equip to the NPC.
-- @return Weapon The weapon entity given to the NPC.
function Give( weapon) end

--- NPC:HasCondition
-- @usage server
-- Returns whether or not the NPC has the given condition.
--
-- @param  condition number  The condition index, see COND_ Enums.
-- @return boolean True if the NPC has the given condition, false otherwise.
function HasCondition( condition) end

--- NPC:IdleSound
-- @usage server
-- Force an NPC to play his Idle sound.
--
function IdleSound() end

--- NPC:IsCurrentSchedule
-- @usage server
-- Returns whether or not the NPC is performing the given schedule.
--
-- @param  schedule number  The schedule number, see SCHED_ Enums.
-- @return boolean True if the NPC is performing the given schedule, false otherwise.
function IsCurrentSchedule( schedule) end

--- NPC:IsMoving
-- @usage server
-- Returns whether the NPC is moving or not.
--
-- @return boolean Whether the NPC is moving or not.
function IsMoving() end

--- NPC:IsRunningBehavior
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return boolean 
function IsRunningBehavior() end

--- NPC:IsUnreachable
-- @usage server
-- Returns whether the entity given can be reached by this NPC.
--
-- @param  testEntity Entity  The entity to test.
-- @return boolean If the entity is reachable or not.
function IsUnreachable( testEntity) end

--- NPC:LostEnemySound
-- @usage server
-- Force an NPC to play his LostEnemy sound.
--
function LostEnemySound() end

--- NPC:MaintainActivity
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function MaintainActivity() end

--- NPC:MarkEnemyAsEluded
-- @usage server
-- Causes the NPC to temporarily forget the current enemy and switch on to a better one.
--
function MarkEnemyAsEluded() end

--- NPC:MoveOrder
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function MoveOrder() end

--- NPC:NavSetGoal
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  position Vector  The position to set as the goal
function NavSetGoal( position) end

--- NPC:NavSetGoalTarget
-- @usage server
-- Set the goal target for an NPC.
--
-- @param  target Entity  The targeted entity to set the goal to.
-- @param  offset Vector  The offset to apply to the targeted entity's position.
function NavSetGoalTarget( target,  offset) end

--- NPC:NavSetRandomGoal
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function NavSetRandomGoal() end

--- NPC:NavSetWanderGoal
-- @usage server
-- Sets a goal in x, y offsets for the npc to wander to
--
-- @param  xoffset number  X offset
-- @param  yoffset number  Y offset
function NavSetWanderGoal( xoffset,  yoffset) end

--- NPC:PlaySentence
-- @usage server
-- Forces the NPC to play a sentence from scripts/sentences.txt
--
-- @param  sentence string  The sentence string to speak.
-- @param  delay number  Delay in seconds until the sentence starts playing.
-- @param  volume number  The volume of the sentence, from 0 to 1.
-- @return number Returns the sentence index, -1 if the sentence couldn't be played.
function PlaySentence( sentence,  delay,  volume) end

--- NPC:RemoveMemory
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function RemoveMemory() end

--- NPC:RunEngineTask
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  taskID number  The task ID, see ai_task.h
-- @param  taskData number  The task data.
function RunEngineTask( taskID,  taskData) end

--- NPC:SentenceStop
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function SentenceStop() end

--- NPC:SetArrivalActivity
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  act number 
function SetArrivalActivity( act) end

--- NPC:SetArrivalDirection
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function SetArrivalDirection() end

--- NPC:SetArrivalDistance
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function SetArrivalDistance() end

--- NPC:SetArrivalSequence
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function SetArrivalSequence() end

--- NPC:SetArrivalSpeed
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function SetArrivalSpeed() end

--- NPC:SetCondition
-- @usage server
-- Sets an NPC condition.
--
-- @param  condition number  The condition index, see COND_ Enums.
function SetCondition( condition) end

--- NPC:SetCurrentWeaponProficiency
-- @usage server
-- Sets the weapon proficiency of an NPC (how skilled an NPC is with its current weapon).
--
-- @param  proficiency number  The proficiency for the NPC's current weapon. See WEAPON_PROFICIENCY_ Enums.
function SetCurrentWeaponProficiency( proficiency) end

--- NPC:SetEnemy
-- @usage server
-- Sets the target for an NPC.
--
-- @param  enemy Entity  The enemy that the NPC should target
function SetEnemy( enemy) end

--- NPC:SetExpression
-- @usage server
-- Sets the NPC's .vcd expression. Similar to Entity:PlayScene except the scene is looped until it's interrupted by default NPC behavior or NPC:ClearExpression.
--
-- @param  expression string  The expression filepath.
function SetExpression( expression) end

--- NPC:SetHullSizeNormal
-- @usage server
-- Updates the NPC's hull and physics hull in order to match its model scale. Entity:SetModelScale seems to take care of this regardless.
--
function SetHullSizeNormal() end

--- NPC:SetHullType
-- @usage server
-- Sets the hull type for the NPC.
--
-- @param  hullType number  Hull type. See HULL_ Enums
function SetHullType( hullType) end

--- NPC:SetLastPosition
-- @usage server
-- Sets the last registered or memorized position for an npc. When using scheduling, the NPC will focus on navigating to the last position via nodes.
--
-- @param  Position Vector  Where the NPC's last position will be set.
function SetLastPosition( Position) end

--- NPC:SetMaxRouteRebuildTime
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function SetMaxRouteRebuildTime() end

--- NPC:SetMovementActivity
-- @usage server
-- Sets the activity the NPC uses when it moves.
--
-- @param  activity number  The movement activity, see ACT_ Enums.
function SetMovementActivity( activity) end

--- NPC:SetMovementSequence
-- @usage server
-- Sets the sequence the NPC navigation path uses for speed calculation. Doesn't seem to have any visible effect on NPC movement.
--
-- @param  sequenceId number  The movement sequence index
function SetMovementSequence( sequenceId) end

--- NPC:SetNPCState
-- @usage server
-- Sets the state the NPC is in to help it decide on a ideal schedule.
--
-- @param  state number  New NPC state, see NPC_STATE_ Enums
function SetNPCState( state) end

--- NPC:SetSchedule
-- @usage server
-- Sets the NPC's current schedule.
--
-- @param  schedule number  The NPC schedule, see SCHED_ Enums.
function SetSchedule( schedule) end

--- NPC:SetTarget
-- @usage server
-- Sets the NPC's target to a player.(Used in some engine schedules)
--
-- @param  player Player  The target of the NPC.
function SetTarget( player) end

--- NPC:StartEngineTask
-- @usage server
-- Forces the NPC to start an engine task, this has different results for every NPC.
--
-- @param  task number  The id of the task to start, see ai_task.h
-- @param  taskData number  The task data as a float, not all tasks make use of it.
function StartEngineTask( task,  taskData) end

--- NPC:StopMoving
-- @usage server
-- Resets the NPC's movement animation and velocity. Does not actually stop the NPC from moving.
--
function StopMoving() end

--- NPC:TargetOrder
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function TargetOrder() end

--- NPC:TaskComplete
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function TaskComplete() end

--- NPC:TaskFail
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  task string  A string most likely defined as a Source Task, for more information on Tasks go to https://developer.valvesoftware.com/wiki/Task
function TaskFail( task) end

--- NPC:UpdateEnemyMemory
-- @usage server
-- Force the NPC to update information on the supplied enemy, as if it had line of sight to it.
--
-- @param  enemy Entity  The enemy to update.
-- @param  pos Vector  The last known position of the enemy.
function UpdateEnemyMemory( enemy,  pos) end

--- NPC:UseActBusyBehavior
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UseActBusyBehavior() end

--- NPC:UseAssaultBehavior
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UseAssaultBehavior() end

--- NPC:UseFollowBehavior
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UseFollowBehavior() end

--- NPC:UseFuncTankBehavior
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UseFuncTankBehavior() end

--- NPC:UseLeadBehavior
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UseLeadBehavior() end

--- NPC:UseNoBehavior
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UseNoBehavior() end

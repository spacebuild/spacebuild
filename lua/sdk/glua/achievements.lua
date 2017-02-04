---
-- @description Library achievements
 module("achievements")

--- achievements.BalloonPopped
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function BalloonPopped() end

--- achievements.Count
-- @usage client_m
-- Returns the amount of achievements in Garry's Mod.
--
-- @return number The amount of achievements available.
function Count() end

--- achievements.EatBall
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function EatBall() end

--- achievements.GetCount
-- @usage client_m
-- Retrieves progress of given achievement
--
-- @param  achievementID number  The ID of achievement to retrieve progress of. Note: IDs start from 0, not 1.
function GetCount( achievementID) end

--- achievements.GetDesc
-- @usage client_m
-- Retrieves description of given achievement
--
-- @param  achievementID number  The ID of achievement to retrieve description of. Note: IDs start from 0, not 1.
-- @return string Description of an achievement
function GetDesc( achievementID) end

--- achievements.GetGoal
-- @usage client_m
-- Retrieves progress goal of given achievement
--
-- @param  achievementID number  The ID of achievement to retrieve goal of. Note: IDs start from 0, not 1.
-- @return number Progress goal of an achievement
function GetGoal( achievementID) end

--- achievements.GetName
-- @usage client_m
-- Retrieves name of given achievement
--
-- @param  achievementID number  The ID of achievement to retrieve name of. Note: IDs start from 0, not 1.
-- @return string Name of an achievement
function GetName( achievementID) end

--- achievements.IncBaddies
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function IncBaddies() end

--- achievements.IncBystander
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function IncBystander() end

--- achievements.IncGoodies
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function IncGoodies() end

--- achievements.IsAchieved
-- @usage client_m
-- Used in GMod 12 in the achievements menu to show the user if they have unlocked certain achievements.
--
-- @param  AchievementID number  Internal Achievement ID number
-- @return boolean Returns true if the given achievementID is achieved.
function IsAchieved( AchievementID) end

--- achievements.Remover
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function Remover() end

--- achievements.SpawnedNPC
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function SpawnedNPC() end

--- achievements.SpawnedProp
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function SpawnedProp() end

--- achievements.SpawnedRagdoll
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function SpawnedRagdoll() end

--- achievements.SpawnMenuOpen
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function SpawnMenuOpen() end

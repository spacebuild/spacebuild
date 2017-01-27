---
-- @description Library PathFollower
 module("PathFollower")

--- PathFollower:Chase
-- @usage server
-- If you created your path with type "Chase" this functions should be used in place of PathFollower:Update to cause the bot to chase the specified entity.
--
-- @param  bot NextBot  The bot to update along the path
-- @param  ent Entity  The entity we want to chase
function Chase( bot,  ent) end

--- PathFollower:Compute
-- @usage server
-- Compute shortest path from bot to 'goal' via A* algorithm.
--
-- @param  from NextBot  The nextbot we're generating for
-- @param  to Vector  To point
-- @param  generator=nil function  A funtion that allows you to alter the path generation. See example below for the default function.
-- @return boolean   If returns true, path was found to the goal position.  If returns false, path may either be invalid (use IsValid() to check), or valid but doesn't reach all the way to the goal.
function Compute( from,  to,  generator) end

--- PathFollower:Draw
-- @usage server
-- Draws the path. This is meant for debugging - and uses debug overlay.
--
function Draw() end

--- PathFollower:FirstSegment
-- @usage server
-- Returns the first segment of the path.
--
-- @return table A table with PathSegment structure.
function FirstSegment() end

--- PathFollower:GetAge
-- @usage server
-- Returns the age since the path was built
--
-- @return number Path age
function GetAge() end

--- PathFollower:GetAllSegments
-- @usage server
-- Returns all of the segments of the given path.
--
-- @return table A table of tables with PathSegment structure.
function GetAllSegments() end

--- PathFollower:GetClosestPosition
-- @usage server
-- The closest position along the path to a position
--
-- @param  position Vector  The point we're querying for
-- @return Vector The closest position on the path
function GetClosestPosition( position) end

--- PathFollower:GetCurrentGoal
-- @usage server
-- Returns the current goal data. Can return nil if the current goal is invalid, for example immediately after PathFollower:Update.
--
-- @return table A table with PathSegment structure.
function GetCurrentGoal() end

--- PathFollower:GetCursorData
-- @usage server
-- Returns the cursor data
--
-- @return table A table with 3 keys: number curvature  Vector forward  Vector pos   
function GetCursorData() end

--- PathFollower:GetCursorPosition
-- @usage server
-- Returns the current progress along the path
--
-- @return number The current progress
function GetCursorPosition() end

--- PathFollower:GetEnd
-- @usage server
-- Returns the path end position
--
-- @return Vector The end position
function GetEnd() end

--- PathFollower:GetHindrance
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return Entity 
function GetHindrance() end

--- PathFollower:GetLength
-- @usage server
-- Returns the total length of the path
--
-- @return number The length of the path
function GetLength() end

--- PathFollower:GetPositionOnPath
-- @usage server
-- Returns the vector position of distance along path
--
-- @param  distance number  The distance along the path to query
-- @return Vector The position
function GetPositionOnPath( distance) end

--- PathFollower:GetStart
-- @usage server
-- Returns the path start position
--
-- @return Vector The start position
function GetStart() end

--- PathFollower:Invalidate
-- @usage server
-- Invalidates the current path
--
function Invalidate() end

--- PathFollower:IsValid
-- @usage server
-- Returns true if the path is valid
--
function IsValid() end

--- PathFollower:LastSegment
-- @usage server
-- Returns the last segment of the path.
--
-- @return table A table with PathSegment structure.
function LastSegment() end

--- PathFollower:MoveCursor
-- @usage server
-- Moves the cursor by give distance.
--
-- @param  distance number  The distance to move the cursor (in relative world units)
function MoveCursor( distance) end

--- PathFollower:MoveCursorTo
-- @usage server
-- Sets the cursor position to given distance.
--
-- @param  distance number  The distance to move the cursor (in world units)
function MoveCursorTo( distance) end

--- PathFollower:MoveCursorToClosestPosition
-- @usage server
-- Moves the cursor of the path to the closest position compared to given vector.
--
-- @param  pos Vector 
-- @param  type=0 number  Seek type 0 = SEEK_ENTIRE_PATH - Search the entire path length 1 = SEEK_AHEAD - Search from current cursor position forward toward end of path 2 = SEEK_BEHIND - Search from current cursor position backward toward path start  
-- @param  alongLimit=0 number 
function MoveCursorToClosestPosition( pos,  type,  alongLimit) end

--- PathFollower:MoveCursorToEnd
-- @usage server
-- Moves the cursor to the end of the path
--
function MoveCursorToEnd() end

--- PathFollower:MoveCursorToStart
-- @usage server
-- Moves the cursor to the end of the path
--
function MoveCursorToStart() end

--- PathFollower:ResetAge
-- @usage server
-- Resets the age which is retrieved by PathFollower:GetAge to 0.
--
function ResetAge() end

--- PathFollower:SetGoalTolerance
-- @usage server
-- How close we can get to the goal to call it done
--
-- @param  distance number  The distance we're setting it to
function SetGoalTolerance( distance) end

--- PathFollower:SetMinLookAheadDistance
-- @usage server
-- Sets minimum range movement goal must be along path
--
-- @param  mindist number  The minimum look ahead distance
function SetMinLookAheadDistance( mindist) end

--- PathFollower:Update
-- @usage server
-- Move the bot along the path.
--
-- @param  bot NextBot  The bot to update along the path
function Update( bot) end

---
-- @description Library CRecipientFilter
 module("CRecipientFilter")

--- CRecipientFilter:AddAllPlayers
-- @usage server
-- Adds all players to the recipient filter.
--
function AddAllPlayers() end

--- CRecipientFilter:AddPAS
-- @usage server
-- Adds all players that are in the same PAS as this position.
--
-- @param  pos Vector  PAS position that players may be able to see.
function AddPAS( pos) end

--- CRecipientFilter:AddPlayer
-- @usage server
-- Adds a player to the recipient filter
--
-- @param  Player Player  Player to add to the recipient filter.
function AddPlayer( Player) end

--- CRecipientFilter:AddPVS
-- @usage server
-- Adds all players that are in the same PVS as this position.
--
-- @param  Position Vector  PVS position.
function AddPVS( Position) end

--- CRecipientFilter:AddRecipientsByTeam
-- @usage server
-- Adds all players that are on the given team to the filter.
--
-- @param  teamid number  Team index to add players from.
function AddRecipientsByTeam( teamid) end

--- CRecipientFilter:GetCount
-- @usage server
-- Returns the number of valid players in the recipient filter.
--
-- @return number Number of valid players in the recipient filter.
function GetCount() end

--- CRecipientFilter:GetPlayers
-- @usage server
-- Returns a table of all valid players currently in the recipient filter.
--
-- @return table A table of all valid players currently in the recipient filter.
function GetPlayers() end

--- CRecipientFilter:RemoveAllPlayers
-- @usage server
-- Removes all players from the recipient filter.
--
function RemoveAllPlayers() end

--- CRecipientFilter:RemovePAS
-- @usage server
-- Removes all players from the filter that are in Potentially Audible Set for given position.
--
-- @param  position Vector  The position to test
function RemovePAS( position) end

--- CRecipientFilter:RemovePlayer
-- @usage server
-- Removes the player from the recipient filter.
--
-- @param  Player Player  The player that should be in the recipient filter if you call this function.
function RemovePlayer( Player) end

--- CRecipientFilter:RemovePVS
-- @usage server
-- Removes all players that can see this PVS from the recipient filter.
--
-- @param  pos Vector  Position that players may be able to see.
function RemovePVS( pos) end

--- CRecipientFilter:RemoveRecipientsByTeam
-- @usage server
-- Removes all players that are on the given team from the filter.
--
-- @param  teamid number  Team index to remove players from.
function RemoveRecipientsByTeam( teamid) end

--- CRecipientFilter:RemoveRecipientsNotOnTeam
-- @usage server
-- Removes all players that are not on the given team from the filter.
--
-- @param  teamid number  Team index.
function RemoveRecipientsNotOnTeam( teamid) end

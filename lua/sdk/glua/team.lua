---
-- @description Library team
 module("team")

--- team.AddScore
-- @usage shared
-- Increases the score of the given team
--
-- @param  index number  Index of the team
-- @param  increment number  Amount to increase the team's score by
function AddScore( index,  increment) end

--- team.BestAutoJoinTeam
-- @usage shared
-- Returns the team index of the team with the least players. Falls back to TEAM_UNASSIGNED
--
-- @return number Team index
function BestAutoJoinTeam() end

--- team.GetAllTeams
-- @usage shared
-- Returns a table consisting of information on every defined team
--
-- @return table Team info
function GetAllTeams() end

--- team.GetClass
-- @usage shared
-- Returns the selectable classes for the given team. This can be added to with team/SetClass
--
-- @param  index number  Index of the team
-- @return table Selectable classes
function GetClass( index) end

--- team.GetColor
-- @usage shared
-- Returns the team's color.
--
-- @param  teamIndex number  The team index.
-- @return table The team's color as a Color structure.
function GetColor( teamIndex) end

--- team.GetName
-- @usage shared
-- Returns the name of the team.
--
-- @param  teamIndex number  The team index.
-- @return string The team name. If the team is not defined, returns an empty string.
function GetName( teamIndex) end

--- team.GetPlayers
-- @usage shared
-- Returns a table with all player of the specified team.
--
-- @param  teamIndex number  The team index.
-- @return table players
function GetPlayers( teamIndex) end

--- team.GetScore
-- @usage shared
-- Returns the score of the team.
--
-- @param  teamIndex number  The team index.
-- @return number score
function GetScore( teamIndex) end

--- team.GetSpawnPoint
-- @usage shared
-- Returns a table of valid spawnpoint classes the team can use. These are set with team.SetSpawnPoint.
--
-- @param  index number  Index of the team
-- @return table Valid spawnpoint classes
function GetSpawnPoint( index) end

--- team.GetSpawnPoints
-- @usage shared
-- Returns a table of valid spawnpoint entities the team can use. These are set with team.SetSpawnPoint.
--
-- @param  index number  Index of the team
-- @return table Valid spawnpoint entities
function GetSpawnPoints( index) end

--- team.Joinable
-- @usage shared
-- Returns if a team is joinable or not. This is set in team.SetUp.
--
-- @param  index number  The index of the team.
-- @return boolean True if the team is joinable. False otherwise.
function Joinable( index) end

--- team.NumPlayers
-- @usage shared
-- Returns the amount of players in a team.
--
-- @param  teamIndex number  The team index.
-- @return number playerCount
function NumPlayers( teamIndex) end

--- team.SetClass
-- @usage shared
-- Sets valid classes for use by a team. Classes can be created using player_manager.RegisterClass
--
-- @param  index number  Index of the team
-- @param  classes any  A class ID or table of class IDs
function SetClass( index,  classes) end

--- team.SetColor
-- @usage shared
-- Sets the team's color.
--
-- @param  teamIndex number  The team index.
-- @param  color table  The team's new color as a Color structure.
function SetColor( teamIndex,  color) end

--- team.SetScore
-- @usage shared
-- Sets the score of the given team
--
-- @param  index number  Index of the team
-- @param  score number  The team's new score
function SetScore( index,  score) end

--- team.SetSpawnPoint
-- @usage shared
-- Sets valid spawnpoint classes for use by a team.
--
-- @param  index number  Index of the team
-- @param  classes any  A spawnpoint classname or table of spawnpoint classnames
function SetSpawnPoint( index,  classes) end

--- team.SetUp
-- @usage shared
-- Creates a new team.
--
-- @param  teamIndex number  The team index.
-- @param  teamName string  The team name.
-- @param  teamColor table  The team color. Uses the Color structure.
-- @param  isJoinable=true boolean  Whether the team is joinable or not.
function SetUp( teamIndex,  teamName,  teamColor,  isJoinable) end

--- team.TotalDeaths
-- @usage shared
-- Returns the sum of deaths of all players of the team.
--
-- @param  teamIndex number  The team index.
-- @return number deathCount
function TotalDeaths( teamIndex) end

--- team.TotalFrags
-- @usage shared
-- Get's the total frags in a team.
--
-- @param  EntityOrNumber Entity  Entity or number.
-- @return number index
function TotalFrags( EntityOrNumber) end

--- team.Valid
-- @usage shared
-- Returns true if the given team index is valid
--
-- @param  index number  Index of the team
-- @return boolean Is valid
function Valid( index) end

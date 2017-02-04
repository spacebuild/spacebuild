---
-- @description Library serverlist
 module("serverlist")

--- serverlist.PlayerList
-- @usage menu
-- Queries a server for its player list.
--
-- @param  ip string  The IP address of the server, including the port.
-- @param  callback function  The function to be called if and when the request finishes. Function has one argument, a table containing tables with player info. Each table with player info has next fields: number time - The amount of time the player is playing on the server, in seconds string name - The player name number score - The players score  
function PlayerList( ip,  callback) end

--- serverlist.Query
-- @usage menu
-- Queries the master server for server list.
--
-- @param  data table  The information about what kind of servers we want. See ServerQueryData structure.
function Query( data) end

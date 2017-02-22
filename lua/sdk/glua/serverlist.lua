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

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
-- @description Library search
 module("search")

--- search.AddProvider
-- @usage client
-- Adds a search result provider. For examples, see gamemodes/sandbox/gamemode/cl_search_models.lua
--
-- @param  provider function  Provider function. It has one argument: string searchQuery You must return a list of tables structured like this:   string text - Text to "Copy to clipboard"  function func - Function to use/spawn the item  Panel icon - A panel to add to spawnmenu  table words - A table of words?
-- @param  id=nil string  If provided, ensures that only one provider exists with the given ID at a time.
function AddProvider( provider,  id) end

--- search.GetResults
-- @usage client
-- Retrieves search results.
--
-- @param  query string  Search query
-- @return table A table of results ( Maximum 1024 items )
function GetResults( query) end

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
-- @description Library ENT_FILTER
 module("ENT_FILTER")

--- ENT_FILTER:PassesDamageFilter
-- @usage server
-- Called by Entity:PassesDamageFilter and engine entities to determine whether an entity passes this filter's damage filter.
--
-- @param  dmg CTakeDamageInfo  Damage to test.
-- @return boolean Whether the entity passes the damage filter ( true ) or not. ( false )
function PassesDamageFilter( dmg) end

--- ENT_FILTER:PassesFilter
-- @usage server
-- Called by Entity:PassesFilter and engine entities to determine whether an entity passes this filter's filter.
--
-- @param  trigger Entity  The 'caller' entity, the one that wants to know if the entity passes the filter
-- @param  ent Entity  The entity in question that is being tested
-- @return boolean Whether the entity passes the filter ( true ) or not ( false )
function PassesFilter( trigger,  ent) end

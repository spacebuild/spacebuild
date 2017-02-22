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
-- @description Library ENT_BRUSH
 module("ENT_BRUSH")

--- ENT_BRUSH:EndTouch
-- @usage server
-- Called when the entity stops touching another entity.
--
-- @param  entity Entity  The entity which was touched.
function EndTouch( entity) end

--- ENT_BRUSH:PassesTriggerFilters
-- @usage server
-- Polls whenever the entity should trigger the brush.
--
-- @param  ent Entity  The entity that is about to trigger.
-- @return boolean Should trigger or not.
function PassesTriggerFilters( ent) end

--- ENT_BRUSH:StartTouch
-- @usage server
-- Called when the entity starts touching another entity.
--
-- @param  entity Entity  The entity which is being touched.
function StartTouch( entity) end

--- ENT_BRUSH:Touch
-- @usage server
-- Called when another entity touches the entity.
--
-- @param  entity Entity  The entity that touched it.
function Touch( entity) end

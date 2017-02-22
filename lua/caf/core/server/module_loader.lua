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

require("ArrayList")
require("HashMap")

local meta = FindMetaTable("Entity")

function meta:WaterLevel2()
    local waterlevel = self:WaterLevel()
    if (self:GetPhysicsObject():IsValid() and self:GetPhysicsObject():IsMoveable()) then
        --Msg("Normal WaterLEvel\n")
        return waterlevel --this doesn't look like it works when ent is welded to world, or not moveable
    else
        --Msg("Special WaterLEvel\n") --Broken in Gmod SVN!!!
        if (waterlevel ~= 0) then
            return waterlevel
        end
        local trace = {}
        trace.start = self:GetPos()
        trace.endpos = self:GetPos()
        trace.filter = { self }
        trace.mask = 16432 -- MASK_WATER
        local tr = util.TraceLine(trace)
        if (tr.Hit) then
            return 3
        end
    end
    return 0
end











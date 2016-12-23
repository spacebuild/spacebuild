-- Copyright 2016 SB Dev Team (http://github.com/spacebuild)
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.

--
-- Created by IntelliJ IDEA.
-- User: stijn
-- Date: 18/06/2016
-- Time: 21:14
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD
local log = SB.log
local core = SB.core

local net_pools = { "SBRU", "SBRPU", "SBMU", "SBEU" }
for _, v in pairs(net_pools) do
    log.debug("Pooling ", v, " for net library")
    util.AddNetworkString(v)
end

local function EntityRemoved(ent)
    for _, part in pairs(core) do
        if part.entityRemoved then
            part.entityRemoved(ent)
        end
    end
end
hook.Add("EntityRemoved", "spacebuild.common.EntityRemoved", EntityRemoved)

local time
local function Think( )
    time = CurTime()
    for _, ply in pairs(player.GetAll()) do

        for _, part in pairs(core) do
            if part.player and part.player.think then
                part.player.think(ply, time)
            end
        end

    end
end
hook.Add("Think", "spacebuild.common.Think", Think)

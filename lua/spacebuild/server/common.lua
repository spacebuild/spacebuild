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

local SB = SPACEBUILD
local log = SB.log
local core = SB.core

local net_pools = { "sbru", "sbrpu", "sbmu", "sbeu", "sbee", "sbre" }
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

local function LSSpawnFunc( ply )
    log.debug("Player spawn - common")
    ply.firstsync = nil
end
hook.Add( "PlayerInitialSpawn", "spacebuild.core.initialspawn", LSSpawnFunc )

-- Player ready to receive messages?
net.Receive( "sbre", function(length, ply)
    ply.cansync = true
end)

local time
local function Think( )
    time = CurTime()
    -- Update players
    for _, ply in pairs(player.GetAll()) do
        if ply.cansync or game.SinglePlayer() then
            core.rd.player.think(ply, time)
            core.sb.player.think(ply, time)
            core.ls.player.think(ply, time)
        end
    end
    -- Perform updates for everything else
    core.sb.think(time)
end
hook.Add("Think", "spacebuild.common.Think", Think)

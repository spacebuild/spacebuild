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
local class= SB.class
local log = SB.log
local time_to_next_ls_sync = SB.constants.TIME_TO_NEXT_LS_SYNC
local time_to_next_ls_env = SB.constants.TIME_TO_NEXT_LS_ENV


local function LSSpawnFunc( ply )
    log.debug("Adding playersuit")
    ply.suit = class.new("ls/Playersuit", ply)
end
hook.Add( "PlayerInitialSpawn", "spacebuild.mod.ls.initialspawn", LSSpawnFunc )

local function LSResetSpawnFunc( ply )
    log.debug("Resetting playersuit")
    ply.suit:reset()
end
hook.Add( "PlayerSpawn", "spacebuild.mod.ls.spawn", LSResetSpawnFunc )

SB.core.ls = {
    player = {
        think = function(ply, time)
            --LS
            if not ply.lastlsEnvupdate or ply.lastlsEnvupdate + time_to_next_ls_env < time then
                if ply.suit then
                    ply.suit:processEnvironment()
                    ply.lastlsEnvupdate = time
                end
            end
            if not ply.lastlsupdate or ply.lastlsupdate + time_to_next_ls_sync < time then
                if ply.suit then
                    ply.suit:send(ply.lastlsupdate or 0)
                    ply.lastlsupdate = time
                end
            end
        end
    }

}
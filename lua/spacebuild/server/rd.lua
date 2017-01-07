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
local time_to_next_rd_sync = SB.constants.TIME_TO_NEXT_RD_SYNC
local internal = SB.internal
local log = SB.log

require("sbnet")
local net = sbnet

local to_sync
net.Receive("sbru", function(bitsreceived, ply)
    local syncid = net.readShort()
    to_sync = internal.device_table[syncid] --- TODO got a sync issue occasionally :/
    to_sync:send(0, ply) -- Send fully to client on request :)
end)

local dupeFactories = {}

function SB:registerDupeFunctions(className, buildDupeFunction, applyDupeFunction, restoreFunction)
    dupeFactories[className] = {
        build = buildDupeFunction,
        apply = applyDupeFunction,
        restore = restoreFunction
    }
end

function SB:buildDupeInfo(ent)
    local className = ent.rdobject and ent.rdobject:getClass()
    if className and dupeFactories[className] then
        duplicator.StoreEntityModifier( ent, "rdinfo", {class = className, data = dupeFactories[className].build(ent, ent.rdobject) })
    end
end

function SB:onRestore(ent)
    local oldrdobject = ent.rdobject
    ent.rdobject = nil
    dupeFactories[oldrdobject:getClass()].restore(ent, oldrdobject)
end

function SB:applyDupeInfo(ent, createdEntities)
    local data = ent.EntityMods and ent.EntityMods.rdinfo
    if data then
        dupeFactories[data.class].apply(ent, createdEntities, data.data)
    end
end

local function LSSpawnFunc( ply )
    log.debug("Player spawn - rd")
    ply.lastrdupdate = nil
    ply.amountofupdates = 0
end
hook.Add( "PlayerInitialSpawn", "spacebuild.mod.rd.initialspawn", LSSpawnFunc )

SB.core.rd = {
    player = {
        think = function(ply, time)
            if not ply or not ply:Alive() then return end
            -- RD
            if not ply.lastrdupdate or ply.lastrdupdate + time_to_next_rd_sync < time then
                ply.amountofupdates = ply.amountofupdates + 1
                local lastUpdate = ply.lastrdupdate or 0
                if ply.amountofupdates == 2 then
                    lastUpdate = 0 -- Resend all data again for a full sync, so we are sure everything is send
                end
                for k, v in pairs(internal.device_table) do
                    v:send(lastUpdate, ply)
                end
                ply.lastrdupdate = time
            end
        end
    },
    entityRemoved = function(ent)
        if ent.rdobject then
            ent.rdobject:unlink()
            log.debug("Removing RD object pre-hook")
        end
    end

}
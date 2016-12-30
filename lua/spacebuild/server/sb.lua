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
local class = SB.class
local internal = SB.internal
local time_to_next_sb_sync = SB.constants.TIME_TO_NEXT_SB_SYNC
local config = SB.config
require("sbnet")
local net = sbnet

local function AllowAdminNoclip(ply)
    if (ply:IsAdmin() or ply:IsSuperAdmin()) and config.adminspacenoclip.get() then return true end
    if ply:IsSuperAdmin() and config.superadminspacenoclip.get() then return true end
    return false
end

--- Players can't get damaged in a jeep, so kick them out
-- TODO filter for jeep entity!!
-- @param ply
--
local function JeepFix(ply)
    if ply:InVehicle() then --Kick them out of the vehicle first
    ply:ExitVehicle()
    end
end

local function isNoclippingWhenNotAllowed(ply)
    return SB.onSBMap() and ply.environment and ply.environment == SB.getSpace() and config.noclip.get() and not AllowAdminNoclip(ply) and config.planetnocliponly.get() and ply:GetMoveType() == MOVETYPE_NOCLIP
end

--- Prevent players from noclipping in space if isn't not allowed
-- @param ply
--
local function NoClipCheck(ply)
    if isNoclippingWhenNotAllowed(ply) then -- Now set their movetype to walk if in noclip and only admins allowed noclip.
        ply:SetMoveType(MOVETYPE_WALK)
    end
end

local function PlayerNoClip( ply, on )
    if isNoclippingWhenNotAllowed(ply) then return false end
    -- Don't return, let the gamemode or other hooks take care of it
end
hook.Add("PlayerNoClip", "SB_PlayerNoClip_Check", PlayerNoClip)

local sun

local function spawnEnvironmentEnt(name, pos, angles)
    local ent = ents.Create(name)
    ent:SetAngles(angles)
    ent:SetPos(pos)
    ent:Spawn()
    return ent
end

local function spawnSun(pos, angle, data)
    local ent = spawnEnvironmentEnt("sun", pos, angle)
    local environment = class.new("sb/SunEnvironment", ent:EntIndex(), data, SB:getResourceRegistry())
    ent.envobject = environment
    SB:addEnvironment(environment)
    return environment
end

local function initSun()
    if not sun then
        --TODO create an ent and spawn the sun! but what location and what angle?
        --spawnSun(Vector(0, 0, 0), Angle(0, 0, -1), {}) --Crashes gmod
    end
end
hook.Add("Initialize", "spacebuild.init.server.sun", initSun)

local function addSun(data)
    log.debug("Spawn Sun")
    local environment = spawnSun(data.ent:GetPos(), data.ent:GetAngles(), data)
    if not sun then
        sun = environment
    end
end

local function addLegacyEnvironment(data)
    log.table(data, log.DEBUG, "adding legacy evironment")
    if data[1] == "planet" or data[1] == "planet2" or data[1] == "star" or data[1] == "star2" then
        local ent = spawnEnvironmentEnt("LegacyPlanet", data.ent:GetPos(), data.ent:GetAngles())
        local environment = class.new("sb/LegacyPlanet", ent:EntIndex(), data, SB:getResourceRegistry())
        ent.envobject = environment
        SB:addEnvironment(environment)
        ent:InitEnvironment()
    elseif data[1] == "cube" then
        local ent = spawnEnvironmentEnt("LegacyPlanet", data.ent:GetPos(), data.ent:GetAngles())
        local environment = class.new("sb/LegacyCube", ent:EntIndex(), data, SB:getResourceRegistry())
        ent.envobject = environment
        SB:addEnvironment(environment)
        ent:InitEnvironment()
    elseif data[1] == "planet_color" then
        local colorinfo = class.new("sb/LegacyColorInfo", data)
        SB:addEnvironmentColor(colorinfo)
    elseif data[1] == "planet_bloom" then
        local bloominfo = class.new("sb/LegacyBloomInfo", data)
        SB:addEnvironmentBloom(bloominfo)
    end
end

function SB:getSun()
    return sun
end

local environment_data = {}
local environment_classes = { env_sun = addSun, logic_case = addLegacyEnvironment }

local function getKey(key)
    if key == "Case01" then
        return 1
    elseif key == "Case02" then
        return 2
    elseif key == "Case03" then
        return 3
    elseif key == "Case04" then
        return 4
    elseif key == "Case05" then
        return 5
    elseif key == "Case06" then
        return 6
    elseif key == "Case07" then
        return 7
    elseif key == "Case08" then
        return 8
    elseif key == "Case09" then
        return 9
    elseif key == "Case10" then
        return 10
    elseif key == "Case11" then
        return 11
    elseif key == "Case12" then
        return 12
    elseif key == "Case13" then
        return 13
    elseif key == "Case14" then
        return 14
    elseif key == "Case15" then
        return 15
    elseif key == "Case16" then
        return 16
    else
        return key
    end
end

local function SpawnEnvironments()
    for k, v in pairs(environment_data) do
        environment_classes[v["classname"]](v)
    end
end

local function InitPostEntity()
    if not GAMEMODE.SPACEBUILD and GAMEMODE.Name ~= "Sandbox" then
        log.info("Not starting Spacebuild because the gamemode does not suppor it")
        return
    end
    log.debug("Start spacebuild environment load")
    local entities
    local data
    local values
    for k, _ in pairs(environment_classes) do
        entities = ents.FindByClass(k)
        for _, ent in ipairs(entities) do
            data = { ent = ent }
            values = ent:GetKeyValues()
            for key, value in pairs(values) do
                data[getKey(key)] = value
            end
            table.insert(environment_data, data)
        end
    end
    SpawnEnvironments()
end
hook.Add("InitPostEntity", "spacebuild.init.server.environments", InitPostEntity)

local ignoredClasses = {}
ignoredClasses["func_door"] = true
ignoredClasses["prop_combine_ball"] = true

-- TODO check if this block is still needed!

local protectedEnvironmentEntities = {}
protectedEnvironmentEntities["LegacyPlanet"] = true
protectedEnvironmentEntities["base_environment_entity"] = true

--Don't remove environment on cleanup
local originalCleanUpMap = game.CleanUpMap
function game.CleanUpMap(dontSendToClients, ExtraFilters)
    local MapEntities = {}
    for className, _ in pairs(protectedEnvironmentEntities) do
       table.insert(MapEntities, className)
    end

    if ExtraFilters then
        table.Add(ExtraFilters, MapEntities)
    else
        ExtraFilters = MapEntities
    end
    originalCleanUpMap(dontSendToClients, ExtraFilters)
end

local function PhysgunPickup(ply , ent)
    local entClass = ent:GetClass()
    return not protectedEnvironmentEntities[entClass];
end
hook.Add("PhysgunPickup", "SB_PhysgunPickup_Check", PhysgunPickup)

function SB:addProtectedEnvironmentEntityClass(className)
    protectedEnvironmentEntities[className] = true
end

-- end block

function SB:isValidSBEntity(ent)
    return IsValid(ent)
            and not ent:IsWorld()
            and IsValid(ent:GetPhysicsObject()) -- only valid physics
            and not ent.NoGrav -- ignore entities that mentioned they want to be ignored
            and not ignoredClasses[ent:GetClass()] -- ignore certain types of entities
end

function SB:registerIgnoredEntityClass(class)
    ignoredClasses[class] = true
end

local spawned_entities = {}

local function OnEntitySpawn(ent)
    if not SB:getSpace() then
        timer.Simple(0.1, function() OnEntitySpawn(ent) end)
    elseif not table.HasValue(spawned_entities, ent) then
        table.insert(spawned_entities, ent)
        timer.Simple(0.1, function()

            if SB:onSBMap() and not ent.environment and SB:isValidSBEntity(ent) then
                ent.environment = SB:getSpace()
                ent.environment:updateEnvironmentOnEntity(ent)
            end
        end)
    end
end
hook.Add("OnEntityCreated", "SB_OnEntitySpawn", OnEntitySpawn)

local function onEnterEnvironment(environmentThatNotifies, ent, environment, oldenvironment)
    net.Start("sbee")
    net.writeShort(ent:EntIndex())
    net.writeShort(environment:getID())
    if oldenvironment then
        net.writeShort(oldenvironment:getID())
    else
        net.writeShort(-1)
    end
    net.Broadcast()
end
hook.Add("OnEnterEnvironment", "SB_OnEnterEnvironment", onEnterEnvironment)

function internal.getSpawnedEntities()
    return spawned_entities
end

SB.core.sb = {

    player = {
        think = function(ply, time)
            -- SB
            if ply.lastsbupdate and ply.lastsbupdate + time_to_next_sb_sync < time then
                for _, v in pairs(internal.mod_tables) do
                    for _, w in pairs(v) do
                        w:send(ply.lastsbupdate or 0, ply)
                    end
                end
                for _, v in pairs(internal.environments) do
                    v:send(ply.lastsbupdate or 0, ply)
                end
                ply.lastsbupdate = time
            elseif not ply.lastsbupdate then
                ply.lastsbupdate = (-time_to_next_sb_sync)
            end
            -- Noclip from planets check?
            if ply.environment and ply.environment == SB:getSpace() and ply:Alive() then --Generic check to see if we can get space and they're alive.
                JeepFix(ply)
                NoClipCheck(ply)
            end
        end
    },
    entityRemoved = function(ent)
        if ent.envobject then
            log.debug("Removing SB Environment object pre-hook")
        end
    end

}
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
local internal = SB.internal
local class = SB.class

internal.environments = {}
internal.mod_tables = {}
internal.mod_tables.color = {}
internal.mod_tables.bloom = {}

local space
local isSBMap

local function init()
    space = class.new("sb/SpaceEnvironment", SB:getResourceRegistry())
end
hook.Add("Initialize", "spacebuild.init.shared", init)

SB.onSBMap = function()
    -- We only check
    if isSBMap == nil then
        local count =  table.Count(internal.environments)
        local isOnlyEnvironmentAStar = false
        if count == 1 then
            for _, v in pairs(internal.environments) do
                isOnlyEnvironmentAStar = v:isStar()
            end
        end
        isSBMap =  count > 0 and not isOnlyEnvironmentAStar
    end
    return isSBMap
end
SB.getSpace = function() return space end

function SB:addEnvironment(environment)
    if not environment or not environment.isA or not environment:isA("BaseEnvironment") then error("not a valid environment class!") end
    internal.environments[environment:getID()] = environment
    hook.Call("onEnvironmentAdded", GAMEMODE, environment)
end

function SB:removeEnvironment(environment)
    if not environment or not environment.isA or not environment:isA("BaseEnvironment") then error("not a valid environment class!") end
    internal.environments[environment:getID()] = nil
    hook.Call("onEnvironmentRemoved", GAMEMODE, environment)
end

function SB:removeEnvironmentFromEntity(ent)
    internal.environments[ent:EntIndex()] = nil
end

function SB:getEnvironments()
    local environments = {}
    for _, v in pairs(internal.environments) do
       table.insert(environments, v)
    end
    return environments
end

function SB:getPlanets()
    local planets = {}
    for _, v in pairs(internal.environments) do
        if v:isPlanet() then
            table.insert(planets, v)
        end
    end
    return planets
end

function SB:getStars()
    local stars = {}
    for _, v in pairs(internal.environments) do
        if v:isStar() then
            table.insert(stars, v)
        end
    end
    return stars
end

function SB:getOtherEnvironments()
    local environments = {}
    for _, v in pairs(internal.environments) do
        if not v:isPlanet() and not v:isStar() then
            table.insert(environments, v)
        end
    end
    return environments
end

function SB:getEnvironment(id)
    if id == -1 then
        return self:getSpace()
    end
    return internal.environments[id]
end

function SB:addEnvironmentColor(env_color)
    if not env_color or not env_color.isA or not env_color:isA("LegacyColorInfo") then error("not a valid color effect class!") end
    internal.mod_tables.color[env_color:getID()] = env_color
end

function SB:getEnvironmentColor(id)
    return internal.mod_tables.color[id]
end

function SB:addEnvironmentBloom(env_bloom)
    if not env_bloom or not env_bloom.isA or not env_bloom:isA("LegacyBloomInfo") then error("not a valid bloom effect class!") end
    internal.mod_tables.bloom[env_bloom:getID()] = env_bloom
end

function SB:getEnvironmentBloom(id)
    return internal.mod_tables.bloom[id]
end
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

local function init()
    space = class.new("sb/SpaceEnvironment", SB:getResourceRegistry())
end
hook.Add("Initialize", "spacebuild.init.shared", init)

SB.onSBMap = function() return table.Count(internal.environments) > 0 end
SB.getSpace = function() return space end

function SB:addEnvironment(environment)
    internal.environments[environment:getID()] = environment
    hook.Call("onEnvironmentAdded", GAMEMODE, environment)
end

function SB:removeEnvironment(environment)
    internal.environments[environment:getID()] = nil
    hook.Call("onEnvironmentRemoved", GAMEMODE, environment)
end

function SB:removeEnvironmentFromEntity(ent)
    internal.environments[ent:EntIndex()] = nil
end


function SB:getEnvironment(id)
    if id == -1 then
        return self:getSpace()
    end
    return internal.environments[id]
end

function SB:addEnvironmentColor(env_color)
    internal.mod_tables.color[env_color:getID()] = env_color
end

function SB:getEnvironmentColor(id)
    return internal.mod_tables.color[id]
end

function SB:addEnvironmentBloom(env_bloom)
    internal.mod_tables.bloom[env_bloom:getID()] = env_bloom
end

function SB:getEnvironmentBloom(id)
    return internal.mod_tables.bloom[id]
end
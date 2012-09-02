local E = ENGINE
local sb = sb;
local gse = sb.util.getSpawnedEntities --Shortcut to function
local sb_core

-- Engine internals (these are up to the engine designer)

local environments = {}
local planets = {}
local stars = {}
local custom = {}






-- Engine external (These have to be implemented)
E.NAME = "legacy"

function E:start(environment_data, sbcore)
    sb_core = sbcore
    for k, v in pairs(environment_data) do
    end
end

function E:stop()
end

function E:getPlanets()
    return planets
end

function E:getStars()
    return stars
end

function E:getCustomEnvironments()
    return custom
end

function E:getAllEnvironments()
    local output = {}
    for k, v in pairs(environments) do
        table.insert(output, v)
    end
    for k, v in pairs(custom) do
        table.insert(output, v)
    end
    return output
end


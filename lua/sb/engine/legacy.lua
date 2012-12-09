--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ]]


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


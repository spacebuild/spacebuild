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


-- Lua Specific
local tostring = tostring
local error = error
local setmetatable = setmetatable
local unpack = unpack
-- Gmod specific
local file = file
-- SB Specific
local sb = sb
local class = sb.core.class
local classes = {}
local classes_folder = {"sb/classes/" }

local function getClassFolder(name)
    for k, v in pairs(classes_folder) do
        if #file.Find(v .. name .. ".lua", "LUA") == 1 then
            return v
        end
    end
    return false
end

function class.create(name, ...)
    name = tostring(name);
    if not classes[name] then
        if not class.exists(name) then
            error("Class " .. name .. " not found");
        end
        CLASS = {}
        CLASS.__index = CLASS
        local c = CLASS
        include(getClassFolder(name) .. name .. ".lua");
        CLASS = nil
        function c:getClass()
            return name;
        end

        classes[name] = function(...)
            local tmp = {}
            setmetatable(tmp, c)
            tmp:init(unpack({ ... }))
            return tmp
        end
    end
    return classes[name](unpack({ ... }))
end



function class.exists(name)
    name = tostring(name);
    return classes[name] ~= nil or getClassFolder(name) ~= false--FUCK YOU GARRY
end

function class.registerClassPath(path)
    table.insert(classes_folder, path)
    PrintTable(classes_folder)
end


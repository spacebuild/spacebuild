---
-- User: Stijn
-- Date: 9/09/11
-- Time: 19:51
-- License: http://creativecommons.org/licenses/by-sa/3.0/
---

-- Lua Specific
local tostring = tostring
local error = error
local setmetatable = setmetatable
local unpack = unpack
-- Gmod specific
local class = class
local file = file
-- SB Specific
local class = sb.class
local classes = {}

function class.create(name, ...)
    name = tostring(name);
    if not classes[name] then
        if not class.exists(name) then
            error("Class " .. name .. " not found");
        end
        CLASS = {}
        CLASS.__index = CLASS
        local c = CLASS
        include("sb/classes/" .. name .. ".lua");
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
    return classes[name] ~= nil or #file.Find("sb/classes/" .. name .. ".lua", "LUA") == 1 -- Changed LUA_PATH to new format, blame Garry
end


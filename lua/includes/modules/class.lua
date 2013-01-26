
local tostring = tostring
local error = error
local setmetatable = setmetatable
local pairs = pairs
local table = table

-- GMOD
local include = include
local file = file
local MsgN = MsgN

local PrintTable = PrintTable

local function initClass(class)
   CLASS = class
end

local function destroyClass()
   CLASS = nil
end


module("class")

local classes_folder = {"sb/classes/"}
local loadedclasses = {}

-- GMOD
local function getClassFolder(name)
   for k, v in pairs(classes_folder) do
       if #file.Find(v .. name .. ".lua", "LUA") == 1 then
          return v
       end
   end
   return false
end

-- GMOD
local function openClass(name)
    include(getClassFolder(name) .. name .. ".lua");
end


function exists(name)
    return loadedclasses[name] or getClassFolder(name) ~= false
end

function new(name, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
    name = tostring(name);
    if not loadedclasses[name] then
        if not exists(name) then
            error("Class " .. name .. " not found");
        end
        local class = {}
        class.__index = class
        initClass(class)
        openClass(name);
        destroyClass()
        function class:getClass()
            return name;
        end
        loadedclasses[name] = function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
            local tmp = {}
            setmetatable(tmp, class)
            tmp:init(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
            return tmp
        end
    end
    return loadedclasses[name](a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
end

function registerClassPath(path)
   table.insert(classes_folder, path)
end


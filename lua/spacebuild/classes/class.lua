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

local GM = SPACEBUILD
local class = GM.class or {}
GM.class = class
local log = GM.log

local preload = true
local tostring = tostring
local error = error
local setmetatable = setmetatable
local pairs = pairs
local table = table

-- GMOD
local include = include
local file = file

local classes_folder = { "classes" }
local loadedclasses = {}

-- GMOD
local function getClassFolder(name)
	if preload then return "" end
	for _, v in pairs(classes_folder) do
		log.info("Looking for:"..v .. name .. ".lua")
		if #file.Find(v .. name .. ".lua", "LUA") == 1 then
			return v
		end
	end
	return false
end

-- GMOD
local function openClass(name)
	include(getClassFolder(name) .. name .. ".lua")
end


function class.exists(name)
	return loadedclasses[name] or getClassFolder(name) ~= false
end

function class.new(name, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
	name = tostring(name):lower()
	if not loadedclasses[name] then
		if not class.exists(name) then
			error("Class " .. name .. " not found")
		end
		local class = {
			classLoader = class
		}
		class.__index = class
		CLASS = class
		openClass(name)
		CLASS = nil
		function class:getClass()
			return name
		end

		loadedclasses[name] = function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
			local tmp = {}
			setmetatable(tmp, class)
			tmp:init(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
			return tmp
		end
	end
	if not preload then
		return loadedclasses[name](a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
	end
end

function class.registerClassPath(path)
	table.insert(classes_folder, path)
end

-- PreLoad
class.new("rd/ResourceRegistry")
class.new("rd/Beam")
class.new("rd/Resource")
class.new("rd/ResourceContainer")
class.new("rd/ResourceEntity")
class.new("rd/ResourceGenerator")
class.new("rd/ResourceStorage")
class.new("rd/ResourceInfo")
class.new("rd/ResourceNetwork")
class.new("ls/PlayerSuit")
class.new("sb/BaseEnvironment")
class.new("sb/SunEnvironment")
class.new("sb/LegacyBloomInfo")
class.new("sb/LegacyColorInfo")
class.new("sb/LegacyPlanet")
class.new("sb/SpaceEnvironment")

preload = false

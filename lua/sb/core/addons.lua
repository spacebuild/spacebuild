-- DEPRECATED

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
local addon = sb.addons

local list = {

    register = function(self,name,value)
        if not self[name] then
            rawset(self, name, value)
        end
    end,

    get = function(self,name)
        return self[name] or false
    end,

    getaddons = function(self)
        local tmp = {}
        for k,v in pairs(self) do
            if k ~= "register" and k ~= "get" and k ~= "getaddons" then
                tmp[k] = v
            end
        end
        return tmp
    end

}


local util =  sb.util
local addons = util.createReadOnlyTable(list)

addon.addons = addons

local function create(scope, name, config)
    name = tostring(name);
    ADDON = {}
    ADDON.__index = ADDON
    local c = ADDON
    include("sb/addons/" ..scope .. name..".lua");
    ADDON = nil
    function c:getClass()
        return name;
    end

    local tmp = {}
    setmetatable(tmp, c)
    tmp:construct(config)
    addons:register(tmp:getName(), tmp)
end

local basePath = "sb/addons/"
local function loadAddons(scope, send)
    local files = sb.wrappers:Find("file",basePath .. scope .."*", "LUA")
    for k, v in pairs(files) do
        if send then
            AddCSLuaFile(basePath..scope..v)
        else
            v = string.sub(v, 0, -5)
            create(scope, v, {})
        end
    end
end


if SERVER then
    loadAddons(util.SCOPES.SERVER)
    loadAddons(util.SCOPES.CLIENT, true)
    loadAddons(util.SCOPES.SHARED, true)
    loadAddons(util.SCOPES.SHARED)
else
    loadAddons(util.SCOPES.CLIENT)
    loadAddons(util.SCOPES.SHARED)
end

print("The following addons have been loaded")
PrintTable(addons:getaddons())
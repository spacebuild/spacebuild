--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 1/11/12
-- Time: 23:53
-- To change this template use File | Settings | File Templates.
--

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
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
local addons = {}

addon.SCOPES = {
    SERVER = 1,
    CLIENT = 2,
    SHARED = 3
}

local function getScopeDir(scope)
    local scopedir = "";
    if scope == addon.SCOPES.SERVER then
       scopedir = "server/"
    elseif scope == addon.SCOPES.CLIENT then
       scopedir = "client/"
    end
    return scopedir
end

local function create(scope, name, config)
    local scopedir = getScopeDir(scope);
    name = tostring(name);
    if not addons[name] then
        ADDON = {}
        ADDON.__index = ADDON
        local c = ADDON
        include("sb/addons/" ..scopedir .. name..".lua");
        ADDON = nil
        function c:getClass()
            return name;
        end

        local createAddon = function(config)
            local tmp = {}
            setmetatable(tmp, c)
            tmp:construct(config)
            return tmp
        end
        addons[name] = createAddon(config)
    end
    return addons[name]
end

local basePath = "sb/addons/"
local function loadAddons(scope, send)
    local scopedir = getScopeDir(scope)
    local files = sb.wrappers:Find("file",basePath .. scopedir .."*", "LUA")
    for k, v in pairs(files) do
        if send then
            AddCSLuaFile(basePath..scopedir..v)
        else
            v = string.sub(v, 0, -5)
            print("Loading addon", scopedir, v)
            create(scope, v, {})
        end
    end
end


local scope = addon.SCOPES.SHARED
if SERVER then
    loadAddons(addon.SCOPES.SERVER)
    loadAddons(addon.SCOPES.CLIENT, true)
    loadAddons(addon.SCOPES.SHARED, true)
    loadAddons(addon.SCOPES.SHARED)
else
    loadAddons(addon.SCOPES.CLIENT)
    loadAddons(addon.SCOPES.SHARED)
end
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
-- User: Stijn
-- Date: 20/05/2016
-- Time: 19:56
-- To change this template use File | Settings | File Templates.
--

if SERVER then
    -- We do modules manually to not the ones from other modules!
    AddCSLuaFile("includes/modules/log.lua")
    AddCSLuaFile("includes/modules/luaunit.lua")
    AddCSLuaFile("includes/modules/sbnet.lua")
    -- end modules

    include("spacebuild/shared/send.lua")
    include("spacebuild/classes/send.lua")
    include("spacebuild/client/send.lua")
    include("spacebuild/documentation/send.lua")
    include("spacebuild/tests/shared/send.lua")

    --Deprecated
    include("caf/send.lua")
end

AddCSLuaFile() -- send this file to the client, but only after all the others have been send!

local version = {
    major = 4,
    minor = 0, -- never more then 99 minors
    patch = 0, -- never more then 99 patches
    tag = "alpha1",
    date = 20161226,
    requiredGmodVersion = 161216,
    fullVersion = function(self)
        return self.major .. "." .. self.minor .. ".".. self.patch.."-"..self.tag
    end,
    longVersion = function(self)
        return self.major + (self.minor/100) + (self.patch/10000)
    end
}
if VERSION < version.requiredGmodVersion then
    error("SB Loader: Your gmod is out of date: found version "..VERSION.."required "..version.requiredGmodVersion)
end

require("log")
local log = log

if version.tag == "release" then
    log.setLevel(log.INFO)
end

concommand.Add("spacebuild", function() log.info("Spacebuild version "..version:fullVersion()) end)

SPACEBUILD = {}
local SB = SPACEBUILD
SB.log = log
SB.version = version
SB.core = {}
SB.plugins = {}
SB.constants = {}
SB.config = {}
SB.internal = {}

log.info("Starting up spacebuild " .. version:fullVersion());

-- Prevent outside access to the SB table, to prevent any modifications to it!!
local function createReadOnlyTable(t)
    return setmetatable({}, {
        __index = t,
        __newindex = function(t, k, v)
            error("Attempt to update a read-only table")
            --print(tostring(debug.traceback()))
        end,
        __metatable = false
    })
end
SB.internal.readOnlyTable = createReadOnlyTable

include("spacebuild/classes/include.lua")
include("spacebuild/shared/include.lua")

if SERVER then
    include("spacebuild/server/include.lua")
end

if CLIENT then
    include("spacebuild/documentation/menu.lua")
    include("spacebuild/client/include.lua")
end

if SERVER then
    concommand.Add("run_sb_server_tests", function()
        require("luaunit")
        local lu = luaunit
        include("spacebuild/tests/shared/include.lua")
        include("spacebuild/tests/server/include.lua")
        MsgN("Tests completed: "..lu.LuaUnit.run('-v'))
    end)
end

if CLIENT then
    concommand.Add("run_sb_client_tests", function()
        require("luaunit")
        local lu = luaunit
        include("spacebuild/tests/shared/include.lua")
        include("spacebuild/tests/client/include.lua")
        MsgN("Tests completed: "..lu.LuaUnit.run('-v'))
    end)
end

-- Load legacy auto loader files
if SERVER then
    include("caf/autostart/server/sv_caf_autostart.lua")
end

if CLIENT then
    include("caf/autostart/client/cl_caf_autostart.lua")
end
include("caf/autostart/resources_api.lua")
-- End load legacy auto loader files

-- Prevent outside access to internal tables
SB.log = createReadOnlyTable(SB.log)
SB.version = createReadOnlyTable(SB.version)
SB.core = nil
SB.plugins = nil
SB.constants = createReadOnlyTable(SB.constants)
SB.config = nil
SB.internal = nil

SB = createReadOnlyTable(SB)
SPACEBUILD = SB


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


require("sbhelper")
local sbhelper = sbhelper

-- Gmod Specific
local include = include

-- SB specific
local VERSION = 4.00
local VERSION_AS_STRING = "4.0.0b1"

sb = {} --Define the global SB table
local sb = sb -- Make it local for a little bit of better performance
sb.core = {}
sb.core.const = {}
sb.core.config = sbhelper.loadConfig("core")
sb.core.data = {}
sb.core.debug = {}
sb.core.gui = {}
sb.core.lang = {}
sb.core.log = {}
sb.core.util = {}
sb.core.test = {}
sb.core.wrappers = {}
sb.core.extensions = {}

function sb.getVersion()
    return VERSION;
end

function sb.getVersionAsString()
    return VERSION_AS_STRING;
end

include("sb/core/wrappers.lua");
include("sb/core/const.lua");
include("sb/core/config.lua");
include("sb/core/debug.lua");
include("sb/core/util.lua")
include("sb/core/spacebuild.lua")

---- Extension System ----
include("sb/core/extensions.lua")
--------------------------






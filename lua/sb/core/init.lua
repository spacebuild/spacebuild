--[[
		Addon: SB core
		Filename: core/init.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Shared init file

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]

require("sbhelper")
local sbhelper = sbhelper

-- Gmod Specific
local include = include

-- SB specific
local VERSION = 0.1

sb = {} --Define the global SB table
local sb = sb -- Make it local for a little bit of better performance
sb.core = {}
sb.core.config = sbhelper.loadConfig("core")
sb.core.class = {}
sb.core.data = {}
sb.core.debug = {}
sb.core.gui = {}
sb.core.lang = {}
sb.core.log = {}
sb.core.util = {}
sb.core.test = {}
sb.core.wrappers = {}
sb.core.extensions = {}
sb.core.net = {}

function sb.getVersion()
    return VERSION;
end

include("sb/core/wrappers.lua");

include("sb/core/config.lua");
include("sb/core/class.lua");
include("sb/core/debug.lua");
include("sb/core/util.lua")
include("sb/core/spacebuild.lua")

---- Extension System ----
include("sb/core/extensions.lua")
--------------------------






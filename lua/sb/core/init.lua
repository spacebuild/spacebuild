--[[
		Addon: SB core
		Filename: core/init.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Shared init file

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]

-- Gmod Specific
local include = include

-- SB specific
local VERSION = 0.1

sb = {} --Define the global SB table
local sb = sb -- Make it local for a little bit of better performance
sb.addons = {}
sb.config = {}
sb.class = {}
sb.data = {}
sb.debug = {}
sb.gui = {}
sb.lang = {}
sb.log = {}
sb.util = {}
sb.test = {}
---- experimental ----

sb.wrappers = {}

----------------------

include("sb/core/config.lua");
include("sb/core/class.lua");
include("sb/core/debug.lua");

function sb.getVersion()
    return VERSION;
end





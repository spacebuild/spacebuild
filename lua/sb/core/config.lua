--[[
		Addon: SB core
		Filename: core/config.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Shared config file

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]

local config = sb.core.config

if not config.version then
    config.version = 0.1
    config.testMode = true
    config.engine = "legacy"
    config.usedrag = true
    config.infiniteresources = false
    config.allownoclip = false
    config.allownocliponplanets = true
    config.allowadminnoclip = true
    config.engine = DEFAULT_ENGINE
    config.temperaturescale = "K" --K, C, F
else
    -- Updates
    -- add/update references
    -- store updated config
end









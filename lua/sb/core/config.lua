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

local sb = sb
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









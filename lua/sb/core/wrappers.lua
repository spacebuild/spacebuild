--[[
		Addon: SB core
		Filename: core/wrappers.lua
		Author(s): Radon
		Website: http://www.snakesvx.net
		
		Description:
			Function wrappers for certain GM13 elements, to ease coding.

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]

local file, sb = file, sb

function sb.wrappers:Find(typeof,...)

	local typeof = typeof
	local files, dirs = {}

	files, dirs = file.Find(...)

	if typeof == "file" then
		return files
	else
		return dirs
	end

end
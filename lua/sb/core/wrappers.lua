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

--- "Find" function, this will replace the stock file.Find implemented by Garry.
-- Use this as a replacement to the standard file.find. This enables the use of file.Find in one liners.
-- @author Radon
-- @param typeof What to return, files, or directories. Defaults to directories if not passed "file".
-- @param ... Other parameters, array of passed params which will be used in file.Find, see official Garrys Mod documentation.
--
function sb.core.wrappers:Find(typeof,...)

	local typeof = typeof
	local files, dirs = {}

	files, dirs = file.Find(...)

	if typeof == "file" then
		return files
	else
		return dirs
	end

end
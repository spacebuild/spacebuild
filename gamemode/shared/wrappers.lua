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


local file, GM = file, GM

--- "Find" function, this will replace the stock file.Find implemented by Garry.
-- Use this as a replacement to the standard file.find. This enables the use of file.Find in one liners.
-- @author Radon
-- @param typeof What to return, files, or directories. Defaults to directories if not passed "file".
-- @param ... Other parameters, array of passed params which will be used in file.Find, see official Garrys Mod documentation.
--
function GM.wrappers:Find(typeof, ...)

	local typeof = typeof
	local files, dirs = {}, {}

	files, dirs = file.Find(...)

	if typeof == "file" then
		return files
	else
		return dirs
	end
end
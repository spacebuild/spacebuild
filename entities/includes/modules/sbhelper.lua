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

local tostring = tostring
local file = file
require("Json")
local Json = Json

module("sbhelper")

local base_folder = "configs/"
local empty_config = {}
local temp
local extension = ".txt"

function loadConfig(filename, basefolder)
	basefolder = basefolder or base_folder
	basefolder = tostring(basefolder)
	filename = tostring(filename)
	filename = basefolder .. filename .. extension
	if file.Exists(filename, "DATA") then
		temp = file.Read(filename)
		if temp then
			return Json.Decode(temp)
		end
	end
	return empty_config
end

function saveConfig(filename, data, basefolder)
	basefolder = basefolder or base_folder
	basefolder = tostring(basefolder)
	filename = tostring(filename)
	filename = basefolder .. filename .. extension
	temp = Json.Encode(data)
	file.Write(filename, temp)
end



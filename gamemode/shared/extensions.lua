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

local GM = GM
local include = include

local debug = debug
local string = string
local rawset = rawset
local print = MsgN
local pairs = pairs


local basePath = "sb/extensions/"
local exts = GM.wrappers:Find("dir", basePath.."*", "LUA") -- table for storing exts in.

--- Registering Extensions. Responsible for assigning values and keys on the extensions table.
-- Such as sb.core.extensions.key = value
-- @param name The name of the extension, or the name used to store it on the extensions table
-- @param value The value you wish to store at that key on the table. Usually another table, for extensions.
function GM.extensions:register(name, value)
	if not self[name] then

		value.basePath = self:getBasePath(debug.getinfo(2).source)

		rawset(self, name, value) -- Set the key and value using rawset as writing metamethod has been disabled.
	else
		print("That key already exists in the table") -- To stop duplicate entries, or overrides.
	end
end

--- Getting your basePath from an extension without registering.
-- So you can get your basePath for use in shared includes.
function GM.extensions:getBasePath(source)

	local execPath = source or debug.getinfo(2).source
	local _, _, folder = string.find(execPath, basePath.."(.-)/") -- Find what the folder is, will be third return from string.find

	local basePath = "sb/extensions/" .. folder .. "/"

	return basePath
end


--- Getter function, retreive values from the sb.core.extensions table.
-- Simply a getter, however normal sb.core.extensions["key"] or sb.core.extensions.key should work.
-- @param name The name of the key to retreive the value of.
function GM.extensions:get(name)
	return self[name] or false
end





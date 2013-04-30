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

local AddCSLuaFile = AddCSLuaFile

--Send modules first
AddCSLuaFile("includes/modules/Json.lua")
AddCSLuaFile("includes/modules/luaunit.lua")
AddCSLuaFile("includes/modules/quaternion.lua")
AddCSLuaFile("includes/modules/sbnet.lua")
AddCSLuaFile("includes/modules/log.lua")

--Send core files
AddCSLuaFile("const.lua")
AddCSLuaFile("wrappers.lua")
AddCSLuaFile("extensions.lua")
AddCSLuaFile("spacebuild.lua")
AddCSLuaFile("util.lua")









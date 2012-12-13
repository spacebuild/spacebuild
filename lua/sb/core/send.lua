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
AddCSLuaFile("includes/modules/sbhelper.lua")
AddCSLuaFile("includes/modules/luaunit.lua")

--Send core files
AddCSLuaFile("sb/core/const.lua")
AddCSLuaFile("sb/core/config.lua")
AddCSLuaFile("sb/core/init.lua")
AddCSLuaFile("sb/core/class.lua")
AddCSLuaFile("sb/core/debug.lua")
AddCSLuaFile("sb/core/wrappers.lua")
AddCSLuaFile("sb/core/extensions.lua")
AddCSLuaFile("sb/core/spacebuild.lua")
AddCSLuaFile("sb/core/util.lua")

--Send classes
AddCSLuaFile("sb/classes/Resource.lua");
AddCSLuaFile("sb/classes/ResourceContainer.lua");
AddCSLuaFile("sb/classes/ResourceEntity.lua");
AddCSLuaFile("sb/classes/ResourceInfo.lua");
AddCSLuaFile("sb/classes/ResourceNetwork.lua");

--Send tests
AddCSLuaFile("sb/tests/class.lua")








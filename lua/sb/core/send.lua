--[[
		Addon: SB core
		Filename: core/send.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Shared send file

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]

local AddCSLuaFile = AddCSLuaFile

--Send modules first
AddCSLuaFile("includes/modules/Json.lua")
AddCSLuaFile("includes/modules/sbhelper.lua")
AddCSLuaFile("includes/modules/luaunit.lua")
AddCSLuaFile("includes/modules/readOnlyList.lua")

--Send core files
AddCSLuaFile("sb/core/config.lua")
AddCSLuaFile("sb/core/init.lua")
AddCSLuaFile("sb/core/class.lua")
AddCSLuaFile("sb/core/debug.lua")
AddCSLuaFile("sb/core/wrappers.lua")
AddCSLuaFile("sb/core/extensions.lua")
AddCSLuaFile("sb/core/addons.lua")

--Send classes
AddCSLuaFile("sb/classes/Resource.lua");
AddCSLuaFile("sb/classes/ResourceContainer.lua");
AddCSLuaFile("sb/classes/ResourceEntity.lua");
AddCSLuaFile("sb/classes/ResourceInfo.lua");
AddCSLuaFile("sb/classes/ResourceNetwork.lua");

--Send tests
AddCSLuaFile("sb/tests/class.lua")








--[[
		Addon: SB core
		Filename: core/extensions.lua
		Author(s): Radon
		Website: http://www.snakesvx.net
		
		Description:
			Handles loading and inclusion of extensions under sb/extensions/

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]


local sb = sb;
local include = include
local AddCSLuaFile = AddCSLuaFile
local tostring = tostring
local Json = require("Json");

local basePath = "sb/extensions/"
MsgN("Extensions lua loaded...")
local dirList = sb.wrappers:Find("dir",basePath.."*", "LUA")

for k,v in ipairs(dirList) do 

	local files = sb.wrappers:Find("file",basePath..v.."/autorun/*", "LUA")

	if #files > 0 then
		
		MsgN("==========================")
		MsgN("Found Extension Folder: "..v)

		sb.extensions[v] = {}
		sb.extensions[v].basePath = tostring(basePath..v.."/")

		for i,j in ipairs(files) do
			
			MsgN("==========================")
			MsgN("=== Autorunning: ".. j)

			AddCSLuaFile(basePath..v.."/autorun/"..j)
			include(basePath..v.."/autorun/"..j)

		end
	end
end

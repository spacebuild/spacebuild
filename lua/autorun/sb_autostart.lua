--[[
		Addon: SB core
		Filename: caf_autostart.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Sends the file to the client and initializes SB on both the client and the server

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]
local gmod_version_required = 150;
if ( VERSION < gmod_version_required ) then
	error("SB CORE: Your gmod is out of date: found version ", VERSION, "required ", gmod_version_required)
end

if SERVER then
	AddCSLuaFile("autorun/sb_autostart.lua")
	include("sb/core/server/init.lua")
else
	include("sb/core/client/init.lua")
end

local sb = sb


---- Experimental ----
function sb.wrappers:Find(type,name,path,sort)

	if name ~= nil and path ~= nil then
		if sort then
			files,dirs = file.Find(name,path,sort)
		else
			files,dirs = file.Find(name,path)
		end

		if type == "file" then
			return files
		elseif type == "dir" then
			return dirs
		end

	else
		return nil
	end	
end
----------------------

if not sb then
	error("SB CORE: failed loading SB core")
end

if sb.config and sb.config.testMode then
	require("luaunit")
	local fls = file.Find("sb/tests/*.lua", "LUA") -- Changed LUA_PATH to new format, blame garry
	for k, v in ipairs(fls) do
		print("Running test:", v)
		include("sb/tests/" .. v)
	end
	luaunit.run() -- will execute all tests
end

if sb.config and sb.wrappers then -- Below finds extensions, and their config files.

	local basePath = "sb/extensions/"
	local dirList = sb.wrappers:Find("dir",basePath.."*", "LUA")

	for i, j in ipairs(dirList) do

		local configs = sb.wrappers:Find("file",basePath..j.."/config.lua", "LUA")

		MsgN(type(configs))

		if #configs > 0 then

			MsgN("==========================")
			MsgN("Found Extension Folder: "..j)
			MsgN("    Found Config File: "..basePath..j.."/config.lua")
			MsgN("==========================")

		end
	end
end

properties.Add( "rdmenu",
{
	MenuLabel       =       "Open RD Menu",
    Order           =       300,
    Filter          =       function( self, ent )
								return true; -- CODE HERE TO CHECK IF IT IS AN RD ENTITY
                            end,                                
	Action          =       function( self, ent )
								-- CODE HERE TO OPEN THE RD MENU
                            end
                                        
 
});







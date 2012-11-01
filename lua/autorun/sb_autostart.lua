--[[
		Addon: SB core
		Filename: sb_autostart.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Sends the file to the client and initializes SB on both the client and the server

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]
local gmod_version_required = 145;
if ( VERSION < gmod_version_required ) then
	error("SB CORE: Your gmod is out of date: found version ", VERSION, "required ", gmod_version_required)
end

if SERVER then
	AddCSLuaFile("autorun/sb_autostart.lua")
    include("sb/core/server/send.lua")
	include("sb/core/server/init.lua")
else
	include("sb/core/client/init.lua")
end

local sb = sb

----------------------

if not sb then
	error("SB CORE: failed loading SB core")
end

if sb.config and sb.config.testMode then
	require("luaunit")
	local fls = sb.wrappers:Find("file","sb/tests/*.lua", "LUA")
	for k, v in ipairs(fls) do
		print("Running test:", v)
		include("sb/tests/" .. v)
	end
	luaunit.run() -- will execute all tests
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







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

if sb.core.config and sb.core.config.testMode then
	require("luaunit")
	local fls = sb.core.wrappers:Find("file","sb/tests/*.lua", "LUA")
	for k, v in ipairs(fls) do
		print("Running test:", v)
		include("sb/tests/" .. v)
	end
	luaunit.run() -- will execute all tests

    local function spawn( ply )
        sb.registerDevice(ply, sb.RDTYPES.STORAGE)
        Msg( "Player has been registered as a "..ply.rdobject.getClass().." device for testing :p.\n" )
    end

    sb.registerResourceInfo(1, "testresource", "Test Resource")
    sb.registerResourceInfo(2, "testresource2", "Test Resource 2")

    if SERVER then
        hook.Add( "PlayerInitialSpawn", "some_unique_name", function(ply)
            spawn(ply)
            ply.rdobject:addResource("testresource", 100000, 0)
            ply.rdobject:addResource("testresource2", 100000, 0)
            local test
            test = function()
                ply.rdobject:consumeResource("testresource", 100)
                ply.rdobject:supplyResource("testresource", 1000)

                ply.rdobject:supplyResource("testresource2", 1000)
                ply.rdobject:consumeResource("testresource2", 500)
                timer.Simple(1, test );
            end
            timer.Simple(1, test );
        end )
        Msg("SERVER")
    end
    if CLIENT then
        hook.Add( "Initialize", "some_unique_name", function() spawn(LocalPlayer()) end )
        Msg("CLIENT")
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







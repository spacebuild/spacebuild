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

require("sbnet")
local net = sbnet

local sb = sb
local core = sb.core;
local to_sync;

require("class")
local class = class

local player_suit = class.new("PlayerSuit")

net.Receive("SBRU", function(bitsreceived)
    local syncid = net.readShort()
    to_sync = core.device_table[syncid]
    if not to_sync then
        core.missing_devices[syncid] = true
    end
    to_sync:receive()
end)

net.Receive("SBRPU", function(bitsreceived)
    local suit = sb.getPlayerSuit()
    local env = suit:getEnvironment()
    suit:receive()
    if suit:getEnvironment() ~= env then
        sb.callOnLeaveEnvironmentHook(env, nil)
        sb.callOnEnterEnvironmentHook(suit:getEnvironment(), nil)
    end
end)

net.Receive("SBEU", function(bitsreceived)
    local class_name = net.ReadString()
    local id = net.readShort()
    local environment_object = sb.getEnvironment(id);
    if not environment_object then
        environment_object = class.new(class_name)
        environment_object:setID(id)
        sb.addEnvironment(environment_object)
    end
    environment_object:receive()
end)

net.Receive("SBMU", function(bitsreceived)
    local type = net.readTiny()
    local class_name = net.ReadString()
    local id = net.ReadString()
    local mod_object
    if type == 1 then
        mod_object = sb.getEnvironmentColor(mod_object)
    elseif type == 2 then
        mod_object = sb.getEnvironmentBloom(mod_object)
    else
        error("invalid mod sync type")
    end
    if not mod_object then
       mod_object = class.new(class_name)
       mod_object:setID(id)
       if type == 1 then
           sb.addEnvironmentColor(mod_object)
       elseif type == 2 then
           sb.addEnvironmentBloom(mod_object)
       else
           error("invalid mod sync type")
       end
    end
    mod_object:receive()
end)

function sb.getPlayerSuit()
   return player_suit
end

local function RenderEffects()
    if not LocalPlayer():Alive() then return end
    if not sb.getPlayerSuit() or not sb.getPlayerSuit():getEnvironment() then return end
    local bloom = sb.getPlayerSuit():getEnvironment():getEnvironmentBloom()
    local color = sb.getPlayerSuit():getEnvironment():getEnvironmentColor()

    if color then color:render() end
    if bloom then bloom:render() end
end
hook.Add("RenderScreenspaceEffects","SBRenderEnvironmentEffects", RenderEffects)

local function InitGame()
    chat.AddText( Color( 255,255,255 ), "Welcome to ", Color( 100,255,100 ), "Spacebuild " .. sb.getVersionAsString() )
    chat.AddText( Color( 255,255,255 ), "Visit ", Color( 100,255,100 ), "http://www.snakesvx.net/", Color( 255,255,255 ), " to dicuss spacebuild or introduce yourself." )
    chat.AddText( Color( 255,255,255 ), "Visit ", Color( 100,255,100 ), "https://github.com/SnakeSVx/spacebuild", Color( 255,255,255 ), " for the latest version or to report bugs." )
end
hook.Add("Initialize","SBClientInit", InitGame)


sb.addOnEnterEnvironmentHook("SB_EnterMessage", function(environment)
    if environment:hasName() then
        chat.AddText( Color( 255,255,255 ), "Entering ", Color( 100,255,100 ), environment:getName() )
    end
end)

--[[sb.addOnLeaveEnvironmentHook("SB_LeaveMessage", function(environment)
    if environment:hasName() then
        chat.AddText( Color( 255,255,255 ), "Leaving ", Color( 100,255,100 ), environment:getName() )
    end
end)]]

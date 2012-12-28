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

local sb = sb
local core = sb.core;
local to_sync;
local player_suit = core.class.create("PlayerSuit")

net.Receive("SBRU", function(bitsreceived)
    local syncid = core.net.readShort()
    to_sync = core.device_table[syncid]
    to_sync:receive()
end)

net.Receive("SBRPU", function(bitsreceived)
    player_suit:receive()
end)

net.Receive("SBMU", function(bitsreceived)
    local type = core.net.readTiny()
    local class = net.ReadString()
    local id = net.ReadString()
    local mod_object = nil;
    if type == 1 then
        mod_object = sb.getEnvironmentColor(mod_object)
    elseif type == 2 then
        mod_object = sb.getEnvironmentBloom(mod_object)
    else
        error("invalid mod sync type")
    end
    if not mod_object then
       mod_object = core.class.create(class)
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
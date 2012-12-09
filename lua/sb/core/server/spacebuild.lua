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

local timer = timer
local core = sb.core;

local time = 0;
local function sendData()
    time = CurTime();
    for _, ply in pairs(player.GetAll()) do
        if not ply.lastrdupdate or ply.lastrdupdate + 1 < time then
            for k, v in pairs(core.resource_tables) do
                v:send(ply.lastrdupdate or 0, ply)
                PrintTable(v);
            end
            ply.lastrdupdate = time
        end
    end
end
hook.Add( "Think", "some_unique_name", sendData )
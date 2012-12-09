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
local corenet = net
local net = sb.core.net;

function net.readBool()
    return corenet.ReadBit() == 1
end

function net.readShort()
    return corenet.ReadInt(net.TYPES_INT.SHORT.length);
end

function net.readLong()
    return corenet.ReadInt(net.TYPES_INT.LONG.length);
end

function net.readTiny()
    return corenet.ReadInt(net.TYPES_INT.TINY.length)
end

function net.readAmount()
    return corenet.ReadInt(net.TYPES_INT.INT.length)
end
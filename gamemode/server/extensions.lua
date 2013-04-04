-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

require("sbnet")
local net = sbnet
local pairs = pairs
local type = type
local GM = GM

local function netChangeExtensionStatus(len, ply)
	if ply:IsAdmin() then
		local synckey = net.readShort()
		local status = net.readBool()
		for k, v in pairs(GM.extensions) do
			if (type(v) == "table") then
			    if v:getSyncKey() == synckey then
					if status ~= v:isActive() then
					   v:setActive(status)
					   net.Start( "EXTSTATUS" )
						   net.writeShort( synckey )
						   net.writeBool( status )
					   net.Broadcast()
					end
					break
				end
			end
		end
	end
end
net.Receive("EXTSTATUS", netChangeExtensionStatus)


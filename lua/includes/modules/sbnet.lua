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

--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 26/01/13
-- Time: 18:43
-- To change this template use File | Settings | File Templates.
--

local net = net
local math = math

module("sbnet")

-- Proxy
Broadcast = net.Broadcast
BytesWritten = net.BytesWritten
Incoming = net.Incoming
ReadAngle = net.ReadAngle
ReadBit = net.ReadBit
ReadData = net.ReadData
ReadDouble = net.ReadDouble
ReadEntity = net.ReadEntity
ReadFloat = net.ReadFloat
ReadHeader = net.ReadHeader
ReadInt = net.ReadInt
ReadNormal = net.ReadNormal
ReadString = net.ReadString
ReadTable = net.ReadTable
ReadType = net.ReadType
ReadUInt = net.ReadUInt
ReadVector = net.ReadVector
Receive = net.Receive
Send = net.Send
SendOmit = net.SendOmit
SendPAS = net.SendPAS
SendPVS = net.SendPVS
SendToServer = net.SendToServer
Start = net.Start
WriteAngle = net.WriteAngle
WriteBit = net.WriteBit
WriteData = net.WriteData
WriteDouble = net.WriteDouble
WriteEntity = net.WriteEntity
WriteFloat = net.WriteFloat
WriteInt = net.WriteInt
WriteNormal = net.WriteNormal
WriteString = net.WriteString
WriteTable = net.WriteTable
WriteType = net.WriteType
WriteUInt = net.WriteUInt
WriteVector = net.WriteVector

-- Custom

local TYPES_INT = {
	-- Default types
	TINY = {
		length = 1 * 8,
		min = -128,
		max = 127,
		umax = 255
	},
	SHORT = {
		length = 2 * 8,
		min = -32768,
		max = 32767,
		umax = 65535
	},
	INT = {
		length = 4 * 8,
		min = -2147483648,
		max = 2147483647,
		umax = 4294967295
	}
}

-- Write
function writeBool(bool)
	net.WriteBit(bool)
end

function writeShort(short)
	net.WriteInt(short, TYPES_INT.SHORT.length)
end

function writeLong(long)
	net.WriteInt(long, TYPES_INT.INT.length)
end

function writeTiny(tiny)
	net.WriteInt(tiny, TYPES_INT.TINY.length)
end

function writeAmount(amount)
	local mul = 0
	if amount > TYPES_INT.INT.max then
		writeBool(true)
		mul = math.floor(amount / TYPES_INT.INT.max)
		writeTiny(mul)
		amount = amount - (mul * TYPES_INT.INT.max) --Prevent syncing more then is allowed!!
	else
		writeBool(false)
	end
	net.WriteUInt(amount, TYPES_INT.INT.length)
end

-- Read
function readBool()
	return net.ReadBit() == 1
end

function readShort()
	return net.ReadInt(TYPES_INT.SHORT.length)
end

function readLong()
	return net.ReadInt(TYPES_INT.INT.length)
end

function readTiny()
	return net.ReadInt(TYPES_INT.TINY.length)
end

function readAmount()
	local base = 0
	if readBool() then
		base = readTiny() * TYPES_INT.INT.max
	end
	return base + net.ReadUInt(TYPES_INT.INT.length)
end
--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

local net = net
local math = math

module("sbnet")

-- Proxy
Broadcast = net.Broadcast
BytesWritten = net.BytesWritten
Incoming = net.Incoming
ReadAngle = net.ReadAngle
ReadBit = net.ReadBit
ReadBool = net.ReadBool
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
ReadBool = net.ReadBool
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
WriteUInt = net.WriteUInt
WriteNormal = net.WriteNormal
WriteString = net.WriteString
WriteTable = net.WriteTable
WriteType = net.WriteType
WriteUInt = net.WriteUInt
WriteVector = net.WriteVector
WriteBool = net.WriteBool

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

function writeShort(short)
	WriteInt(short, TYPES_INT.SHORT.length)
end

function writeLong(long)
	WriteInt(long, TYPES_INT.INT.length)
end

function writeTiny(tiny)
	WriteInt(tiny, TYPES_INT.TINY.length)
end

function writeAmount(amount)
	local mul = 0
	if amount > TYPES_INT.INT.max then
		WriteBool(true)
		mul = math.floor(amount / TYPES_INT.INT.max)
		writeTiny(mul)
		amount = amount - (mul * TYPES_INT.INT.max) --Prevent syncing more then is allowed!!
	else
		WriteBool(false)
	end
	WriteUInt(amount, TYPES_INT.INT.length)
end

-- Read

function readShort()
	return ReadInt(TYPES_INT.SHORT.length)
end

function readLong()
	return ReadInt(TYPES_INT.INT.length)
end

function readTiny()
	return ReadInt(TYPES_INT.TINY.length)
end

function readAmount()
	local base = 0
	if ReadBool() then
		base = readTiny() * TYPES_INT.INT.max
	end
	return base + net.ReadUInt(TYPES_INT.INT.length)
end
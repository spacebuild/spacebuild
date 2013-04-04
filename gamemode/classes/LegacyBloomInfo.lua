--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 28/12/12
-- Time: 19:37
-- To change this template use File | Settings | File Templates.
--

--Lua specific
local error = error
local tostring = tostring
local type = type

-- Gmod specific
local CurTime = CurTime
require("sbnet")
local net = sbnet
-- Class specific
local C = CLASS

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return className == "LegacyBloomInfo"
end

function C:init(data)
	if data then
		self.data = data
		if string.len(data[2]) > 0 then
			local case2 = Vector(data[2])
			self.Col_r = case2.x
			self.Col_g = case2.y
			self.Col_b = case2.z
		end
		if string.len(data[3]) > 0 then
			local case3 = string.Explode(" ", data[3])
			self.SizeX = tonumber(case3[1])
			self.SizeY = tonumber(case3[2])
		end
		self.passes = tonumber(data[4])
		self.darken = tonumber(data[5])
		self.multiply = tonumber(data[6])
		self.color = tonumber(data[7])
		self.id = data[16]
	end
	self.modified = CurTime()
end

function C:getID()
	return self.id
end

function C:setID(id)
	self.id = id
end

function C:render()
	if (not render.SupportsPixelShaders_2_0()) then return end -- Don't try if bloom is not supported
	DrawBloom(self.darken, self.multiply, self.SizeX, self.SizeY, self.passes, self.color, self.Col_r, self.Col_g, self.Col_b)
end

--- Sync function to send data to the client from the server
-- @param modified timestamp the client received information about this environment last
-- @param ply the client to send this information to; if nil send to all clients
--
function C:send(modified, ply)
	if self.modified > modified then
		net.Start("SBMU")
		net.writeTiny(2)
		net.WriteString(self:getClass())
		net.WriteString(self.id)
		self:_sendContent(modified)
		if ply then
			net.Send(ply)
		else
			net.Broadcast()
		end
	end
end

--- Sync function to send data from the client to the server, contains the specific data transfer
-- @param modified timestamp the client received information about this environment last
--
function C:_sendContent(modified)
	net.WriteFloat(self.Col_r or 0)
	net.WriteFloat(self.Col_g or 0)
	net.WriteFloat(self.Col_b or 0)
	net.WriteFloat(self.SizeX or 0)
	net.WriteFloat(self.SizeY or 0)
	net.WriteFloat(self.passes or 0)
	net.WriteFloat(self.darken or 0)
	net.WriteFloat(self.multiply or 0)
	net.WriteFloat(self.color or 0)
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	self.Col_r = net.ReadFloat()
	self.Col_g = net.ReadFloat()
	self.Col_b = net.ReadFloat()
	self.SizeX = net.ReadFloat()
	self.SizeY = net.ReadFloat()
	self.passes = net.ReadFloat()
	self.darken = net.ReadFloat()
	self.multiply = net.ReadFloat()
	self.color = net.ReadFloat()
end
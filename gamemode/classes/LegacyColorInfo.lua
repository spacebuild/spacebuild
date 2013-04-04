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
	return className == "LegacyColorInfo"
end

function C:init(data)
	if data then
		self.data = data
		if string.len(data[2]) > 0 then
			self.addColor = {}
			local case2 = Vector(data[2])
			self.addColor.r = case2.x
			self.addColor.g = case2.y
			self.addColor.b = case2.z
		end
		if string.len(data[3]) > 0 then
			self.mulColor = {}
			local case3 = Vector(data[3])
			self.mulColor.r = case3.x
			self.mulColor.g = case3.y
			self.mulColor.b = case3.z
		end
		self.brightness = tonumber(data[4])
		self.contrast = tonumber(data[5])
		self.color = tonumber(data[6])
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

local cmod = {}
function C:render()
	if (not render.SupportsPixelShaders_2_0()) then return end -- Don't try if not supported
	cmod["$pp_colour_addr"] = self.addColor.r
	cmod["$pp_colour_addg"] = self.addColor.g
	cmod["$pp_colour_addb"] = self.addColor.b
	cmod["$pp_colour_brightness"] = self.brightness
	cmod["$pp_colour_contrast"] = self.contrast
	cmod["$pp_colour_colour"] = self.color
	cmod["$pp_colour_mulr"] = self.mulColor.r
	cmod["$pp_colour_mulg"] = self.mulColor.g
	cmod["$pp_colour_mulb"] = self.mulColor.b
	DrawColorModify(cmod)
end

--- Sync function to send data to the client from the server
-- @param modified timestamp the client received information about this environment last
-- @param ply the client to send this information to; if nil send to all clients
--
function C:send(modified, ply)
	if self.modified > modified then
		net.Start("SBMU")
		net.writeTiny(1)
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
	if self.addColor then
		net.writeBool(true)
		net.WriteFloat(self.addColor.r)
		net.WriteFloat(self.addColor.g)
		net.WriteFloat(self.addColor.b)
	else
		net.writeBool(false)
	end
	if self.mulColor then
		net.writeBool(true)
		net.WriteFloat(self.mulColor.r or -1)
		net.WriteFloat(self.mulColor.g or -1)
		net.WriteFloat(self.mulColor.b or -1)
	else
		net.writeBool(false)
	end
	net.WriteFloat(self.brightness)
	net.WriteFloat(self.contrast)
	net.WriteFloat(self.color)
end

--- Sync function to receive data from the server to this client
--
function C:receive()
	self.addColor = self.addColor or {}
	self.mulColor = self.mulColor or {}
	if net.readBool() then
		self.addColor.r = net.ReadFloat()
		self.addColor.g = net.ReadFloat()
		self.addColor.b = net.ReadFloat()
	else
		self.addColor.r = 0
		self.addColor.g = 0
		self.addColor.b = 0
	end
	if net.readBool() then
		self.mulColor.r = net.ReadFloat()
		self.mulColor.g = net.ReadFloat()
		self.mulColor.b = net.ReadFloat()
	else
		self.mulColor.r = 0
		self.mulColor.g = 0
		self.mulColor.b = 0
	end
	self.brightness = net.ReadFloat()
	self.contrast = net.ReadFloat()
	self.color = net.ReadFloat()
end
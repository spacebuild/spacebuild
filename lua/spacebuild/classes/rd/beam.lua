--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 28/12/2016
-- Time: 19:34
-- To change this template use File | Settings | File Templates.
--



local SB = SPACEBUILD
local log = SB.log
local C = CLASS

local CurTime = CurTime
require("sbnet")
local net = sbnet
local Color = Color

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
    return className == "RDBeam"
end

function C:init(target, material, width, color)
    self.target = target
    self.material = material or "cable/cable2"
    self.width = width or 2
    self.color = color or Color(255, 255, 255, 255)
end

function C:getTarget()
    return self.target
end

function C:getTargetEntity()
    return self.target and Entity(self.target)
end

function C:getMaterial()
    return self.material
end

function C:getWidth()
    return self.width
end

function C:getColor()
    return self.color
end

function C:send(modified, ply)
    net.writeShort(self.target)
    net.WriteString(self.material)
    net.writeTiny(self.width)
    net.writeTiny(self.color.r)
    net.writeTiny(self.color.g)
    net.writeTiny(self.color.b)
    net.writeTiny(self.color.a)
end

function C:receive()
    self.target = net.readShort()
    self.material = net.ReadString()
    self.width = net.readTiny()
    local r, g, b, a = net.readTiny(), net.readTiny(), net.readTiny(), net.readTiny()
    self.color = Color(r, g, b, a)
end



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
local net = net
-- Class specific
local C = CLASS
local sb = sb;
local core = sb.core

function C:isA(className)
    return className == "LegacyColorInfo"
end

function C:init(data)
    if data then
        self.data = data
        if string.len(data[2]) > 0 then
            local case2 = data[2]
            self.AddColor_r = tonumber(string.Left(case2, string.find(case2," ") - 1))
            case2 = string.Right(case2, (string.len(case2) - string.find(case2," ")))
            self.AddColor_g = tonumber(string.Left(case2, string.find(case2," ") - 1))
            case2 = string.Right(case2, (string.len(case2) - string.find(case2," ")))
            self.AddColor_b = tonumber(case2)
        end
        if string.len(data[3]) > 0 then
            local case3 = data[3]
            self.MulColor_r = tonumber(string.Left(case3, string.find(case3," ") - 1))
            case3 = string.Right(case3, (string.len(case3) - string.find(case3," ")))
            self.MulColor_g = tonumber(string.Left(case3, string.find(case3," ") - 1))
            case3 = string.Right(case3, (string.len(case3) - string.find(case3," ")))
            self.MulColor_b = tonumber(case3)
        end
        self.brightness = data[4] and tonumber(data[4]) or nil
        self.contrast = data[5] and tonumber(data[5]) or nil
        self.color = data[6] and tonumber(data[6]) or nil
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

function C:send(modified, ply)
    if self.modified > modified then
        net.Start("SBMU")
        core.net.writeTiny(1)
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

function C:_sendContent(modified)
    net.WriteFloat(self.AddColor_r or -1)
    net.WriteFloat(self.AddColor_g or -1)
    net.WriteFloat(self.AddColor_b or -1)
    net.WriteFloat(self.MulColor_r or -1)
    net.WriteFloat(self.MulColor_g or -1)
    net.WriteFloat(self.MulColor_b or -1)
    net.WriteFloat(self.brightness or -1)
    net.WriteFloat(self.contrast or -1)
    net.WriteFloat(self.color or -1)
end

function C:receive()
    self.AddColor_r = net.ReadFloat()
    self.AddColor_g = net.ReadFloat()
    self.AddColor_b = net.ReadFloat()
    self.MulColor_r = net.ReadFloat()
    self.MulColor_g = net.ReadFloat()
    self.MulColor_b = net.ReadFloat()
    self.brightness = net.ReadFloat()
    self.contrast = net.ReadFloat()
    self.color = net.ReadFloat()
end
--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 27/12/12
-- Time: 23:29
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
    return className == "BaseEnvironment"
end

function C:init(entid, data)
    self.entid = entid
    self.data = data

    self.temperature = 0
    self.gravity = 0
    self.atmosphere = 0

    self.resources = {}
    self.attributes = {}

    self.modified = CurTime()
    self.start_sync_after = CurTime() + 1
end

function C:getID()
   return self.entid
end

function C:setID(id)
   self.entid = id
end

function C:getEntity()
   return self.entid and Entity(self.entid) or nil
end

function C:getTemperature(ent)
   return self.temperature
end

function C:getGravity()
   return self.gravity
end

function C:getAtmosphere()
   return self.atmosphere
end

function C:getPressure()
   return self:getGravity() * self:getAtmosphere()
end

function C:getVolume()
   return 0
end

-- Resource stuff

function C:getResourceAmount(resource)
   return (self.resources[resource] and self.resources[resource]:getAmount()) or 0
end

function C:getResourcePercentage(resource)
   local am = self:getResourceAmount(resource)
    local max = self:getMaxAmountOfResources()
    if max > 0 then
        return math.Round((min/max) * 10000)/100 --round to 2 decimals after the ,
    end
    return 0
end

function C:getMaxAmountOfResources()
   return self:getVolume() * self:getAtmosphere() * 5
end

function C:convertResource(from, to, amount)
    -- TODO
end

-- Sync stuff

function C:send(modified, ply)
    if self.modified > modified then
        net.Start("SBEU")
        net.WriteString(self:getClass())
        core.net.writeShort(self.entid)
        self:_sendContent(modified)
        if ply then
            net.Send(ply)
        else
            net.Broadcast()
        end
    end
end

function C:_sendContent(modified)
    -- nothing needed here
end

function C:receive()
    -- nothing needed here
end






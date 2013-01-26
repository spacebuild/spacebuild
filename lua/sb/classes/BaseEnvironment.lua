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
require("class")
local class = class
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

function C:addAttribute(attribute)
    table.insert(self.attributes, attribute)
    self.modified = CurTime()
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

-- Override
function C:getEnvironmentColor()
    return nil
end

-- Override
function C:getEnvironmentBloom()
    return nil
end

function C:hasName()
   return false
end

function C:getName()
   return ""
end

-- Resource stuff

function C:getResourceAmount(resource)
   return (self.resources[resource] and self.resources[resource]:getAmount()) or 0
end

function C:getResourcePercentage(resource)
   local am = self:getResourceAmount(resource)
    local max = self:getMaxAmountOfResources()
    if max > 0 then
        return math.Round((am/max) * 10000)/100 --round to 2 decimals after the ,
    end
    return 0
end

function C:getMaxAmountOfResources()
    return self:getVolume() * self:getAtmosphere()
end

function C:getUnusedResourceAmountInEnvironment()
    local max = self:getMaxAmountOfResources()
    for k, v in pairs(self.resources) do
       max = max - v:getAmount()
    end
    return max
end

function C:convertResource(from, to, amount)
    local res_to = self.resources[to]
    local not_enough = 0
    if not res_to then
        res_to = class.new("Resource", to, self:getMaxAmountOfResources(), 0);
        self.resources[to] = res_to
    end
    if not from then
        local max = self:getUnusedResourceAmountInEnvironment()
        if max < amount then
            not_enough = amount - max
            amount = max
        end
        if amount > 0 then
            res_to:setAmount(amount)
            self.modified = CurTime()
        end
    elseif self.resources[from] then
        not_enough = self.resources[from]:consume(amount)
        if not_enough < amount then
            res_to:supply(amount - not_enough)
            self.modified = CurTime()
        end
    else
        not_enough = amount
    end
    return not_enough
end

function C:hasEnoughOxygen()
   return self:getResourcePercentage("oxygen") > 5
end

-- Environment checking

function C:updateEnvironmentOnEntities() --TODO call this when certain things get updated (gravity, ...)
    for k, v in pairs(self.entities) do
        self:updateEnvironmentOnEntity(v)
    end
end

function C:updateEnvironmentOnEntity(ent)
    if ent.environment == self then
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then -- the physobject can become NULL somehow :s
            if self.gravity <= 0 then
                ent:SetGravity( 0.00001 ) -- if gravity is 0, put gravity to 0.00001
            else
                ent:SetGravity( self.gravity ) -- if gravity is 0, put gravity to 0.00001
            end
            if self.gravity  > 0.01 then
                phys:EnableGravity(true)
            else
                phys:EnableGravity(false)
            end
            if self:getPressure() > 0.1 then
                phys:EnableDrag( true )
            else
                phys:EnableDrag( false )
            end
        end
    end
end

-- Sync stuff

function C:send(modified, ply)
    if modified >= self.start_sync_after then
        if self.start_sync_after > 0 then
            modified = 0
            self.start_sync_after = 0
        end
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
end

function C:_sendContent(modified)
    core.net.writeShort(self.temperature)
    net.WriteFloat(self.gravity)
    net.WriteFloat(self.atmosphere)
    core.net.writeTiny(table.Count(self.resources))
    for k, v in pairs(self.resources) do
       v:send(modified)
    end
    core.net.writeTiny(#self.attributes)
    for k, v in pairs(self.attributes) do
       net.WriteString(v)
    end
end

function C:receive()
    self.temperature = core.net.readShort()
    self.gravity = net.ReadFloat()
    self.temperature = net.ReadFloat()
    local nrRes = core.net.readTiny()
    local am
    local name
    local id
    for am = 1, nrRes do
        id = core.net.readTiny()
        name = sb.getResourceInfoFromID(id):getName()
        if not self.resources[name] then
            self.resources[name] = class.new("Resource", name);
        end
        self.resources[name]:receive()
    end
    local nrAttributes = core.net.readTiny()
    for am = 1, nrAttributes do
       self:addAttribute(net.ReadString())
    end
end






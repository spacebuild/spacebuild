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

-- Lua specific
local type = type;
local tostring = tostring;
local pairs = pairs;
local table = table

-- Gmod Specific
local CurTime = CurTime
local net = net

-- Class specific
local C = CLASS
local sb = sb;
local class = sb.core.class
local core = sb.core

function C:isA(className)
    return className == "ResourceContainer"
end

function C:init(syncid)
    self.syncid = syncid;
    self.resources = {}
    self.modified = CurTime()
end

function C:getID()
    return self.syncid;
end

function C:addResources(resources)
    for k, v in pairs(resources) do
        self:addResource(v.name, v.maxamount, v.amount)
    end
end

function C:addResource(name, maxAmount, amount)
    if not name then error("ResourceContainer:addResource requires a name!") end
    name = tostring(name)
    if not amount or type(amount) ~= "number" or amount < 0 then amount = 0 end
    if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = amount end
    local res = self.resources[name];
    if not res then
        res = class.create("Resource", name, maxAmount, amount);
        self.resources[name] = res
    else
        res:setMaxAmount(res:getMaxAmount() + maxAmount)
        res:supply(amount)
    end
    if self.modified < res:getModified() then
        self.modified = res:getModified()
    end
end

function C:removeResource(name, maxAmount, amount)
    if not name then error("ResourceContainer:removeResource requires a name!") end
    name = tostring(name)
    if not amount or type(amount) ~= "number" or amount < 0 then amount = 0 end
    if not maxAmount or type(maxAmount) ~= "number" or maxAmount < 0 then maxAmount = amount end
    if not self.resources[name] then error("ResourceContainer:removeResource couldn't find the resource") end

    local res = self.resources[name];
    res:consume(amount)
    res:setMaxAmount(res:getMaxAmount() - maxAmount)

    if self.modified < res:getModified() then
        self.modified = res:getModified()
    end
end

local res, ret

function C:supplyResource(name, amount)
    if not self.resources[name] then error("ResourceContainer:supplyResource: resource " .. tostring(name) .. " not found") end
    res = self.resources[name]
    ret = res:supply(amount)
    if self.modified < res:getModified() then
        self.modified = res:getModified()
    end
    return ret
end

function C:consumeResource(name, amount)
    if not self.resources[name] then error("ResourceContainer:consumeResource: resource " .. tostring(name) .. " not found") end
    res = self.resources[name]
    ret = res:consume(amount)
    if self.modified < res:getModified() then
        self.modified = res:getModified()
    end
    return ret
end

function C:getResource(name)
    return self.resources[name]
end

function C:getResources()
    return self.resources
end

function C:getResourceAmount(name)
    if not self.resources[name] then return 0 end
    return self.resources[name]:getAmount()
end

function C:getMaxResourceAmount(name)
    if not self.resources[name] then return 0 end
    return self.resources[name]:getMaxAmount()
end

function C:link(container, dont_link)
    error("ResourceContainer:link is not supported")
end

function C:unlink(container, dont_unlink)
    error("ResourceContainer:unlink is not supported")
end

function C:canLink(container)
    return false
end

function C:send(modified, ply, partial)
    if self.modified > modified then
        if not partial then
            net.Start("SBRU")
            core.net.writeShort(self.syncid)
        end
        core.net.writeShort(table.Count(self.resources))
        for k, v in pairs(self.resources) do
            v:send(modified, ply, true)
        end
        if not partial then
            if ply then
                net.Send(ply)
                --net.Broadcast()
            else
                net.Broadcast()
            end
        end
    end
end

function C:receive()
    local nrRes = core.net.readShort()
    local am
    local name
    local id
    for am = 1, nrRes do
        id = core.net.readShort()
        name = sb.getResourceInfoFromID(id):getName()
        if not self.resources[name] then
            self.resources[name] = class.create("Resource", name);
        end
        self.resources[name]:receive()
    end
end

function C:getModified()
    return self.modified;
end

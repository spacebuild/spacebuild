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

include("sb/classes/ResourceContainer.lua")

-- Lua Specific
local type = type

-- Gmod specific
local Entity = Entity
local CurTime = CurTime
local net = net

-- Class Specific
local C = CLASS
local sb = sb;
local core = sb.core

-- Function Refs
local funcRef = {
    isA = C.isA,
    init = C.init,
    addResource = C.addResource,
    removeResource = C.removeResource,
    supplyResource = C.supplyResource,
    consumeResource = C.consumeResource,
    getResourceAmount = C.getResourceAmount,
    getMaxResourceAmount = C.getMaxResourceAmount,
    sendSignal = C.send, --Less Ambiguous networking functions
    receiveSignal = C.receive
}

function C:isA(className)
    return funcRef.isA(self, className) or className == "ResourceEntity"
end

function C:init(entID)
    if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceEntity") end
    funcRef.init(self, entID)
    self.network = nil
end

function C:addResource(name, maxAmount, amount)
    funcRef.addResource(self, name, maxAmount, amount)
    if self.network then
        self.network:addResource(name, maxAmount, amount)
    end
end

function C:removeResource(name, maxAmount, amount)
    funcRef.removeResource(self, name, maxAmount, amount)
    if self.network then
        self.network:removeResource(name, maxAmount, amount)
    end
end

function C:supplyResource(name, amount)
    if self.network then
        return self.network:supplyResource(name, amount)
    end
    return funcRef.supplyResource(self, name, amount)
end

function C:consumeResource(name, amount)
    if self.network then
        return self.network:consumeResource(name, amount)
    end
    return funcRef.consumeResource(self, name, amount)
end

function C:getResourceAmount(name)
    if self.network then
        return self.network:getResourceAmount(name)
    end
    return funcRef.getResourceAmount(self, name);
end

function C:getMaxResourceAmount(name, visited)
    if self.network then
        return self.network:getMaxResourceAmount(name, visited)
    end
    return funcRef.getMaxResourceAmount(self, name)
end

function C:link(container, dont_link)
    if not container.isA or not container:isA("ResourceContainer") then error("We can only link ResourceContainer (and derivate) classes") end
    if not container:isA("ResourceNetwork") then
        error("ResourceEntity: We only support links between entities and networks atm!")
    end
    self.network = container;
    if not dont_link then
        container:link(self, true);
    end
    self.modified = CurTime()
end

function C:unlink(container, dont_unlink)
    if not container.isA or not container:isA("ResourceContainer") then error("We can only unlink ResourceContainer (and derivate) classes") end
    if not container:isA("ResourceNetwork") then
        error("ResourceEntity: We only support links between entities and networks atm!")
    end
    self.network = nil
    if not dont_unlink then
        container:unlink(self, true);
    end
    self.modified = CurTime()
end

function C:canLink(container)
    return container.isA and container:isA("ResourceNetwork")
end

function C:getEntity()
    return self.syncid and Entity(self.syncid);
end

function C:getNetwork()
    return self.network
end

function C:send(modified, ply, partial)
    if self.modified > modified then
        if not partial then
            net.Start("SBRU")
            core.net.writeShort(self.syncid)
        end
        funcRef.sendSignal(self, modified, ply, true);
        -- Add specific class code here
        if not partial then
            if ply then
                net.Send(ply)
            else
                net.Broadcast()
            end
        end
    end
end

function C:receive()
    funcRef.receiveSignal(self)
end

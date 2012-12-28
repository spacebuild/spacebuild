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
    sendContent = C._sendContent,
    receiveSignal = C.receive,
    onSave = C.onSave,
    onLoad = C.onLoad
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
    local res = funcRef.addResource(self, name, maxAmount, amount)
    if self.network then
        self.network:addResource(name, maxAmount, amount)
    end
    return res
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
    if not container then return end
    if container == self.network then return end
    if not container.isA or not container:isA("ResourceContainer") then error("We can only link ResourceContainer (and derivate) classes") end
    if not container:isA("ResourceNetwork") then
        error("ResourceEntity: We only support links between entities and networks atm!")
    end
    -- Unlink from the old network
    if self.network then
       self.network:unlink(self)
    end
    -- Link to the new
    self.network = container;
    if not dont_link then
        container:link(self, true);
    end
    self.modified = CurTime()
end

function C:unlink(container, dont_unlink)
    if not self.network then return end
    if not container then
        self.network:unlink(self, true)
    elseif self.network == container then
        self.network = nil
        if not dont_unlink then
            container:unlink(self, true);
        end
    end
    self.modified = CurTime()
end

function C:canLink(container)
    return container.isA and container:isA("ResourceNetwork")
end

function C:getNetwork()
    return self.network
end

function C:_sendContent(modified)
        if self.network then
            core.net.writeShort(self.network:getID())
        else
            core.net.writeShort(0)
        end
        funcRef.sendContent(self, modified);
end

function C:receive()
    self.network = sb.getDeviceInfo(core.net.readShort())
    funcRef.receiveSignal(self)
end

-- Start Save/Load functions

function C:onLoad(data)
    funcRef.onLoad(self, data)
    local ent = self
    timer.Simple(0.1, function()
       ent.network = sb.getDeviceInfo(data.network.syncid)
    end)
end

-- End Save/Load functions

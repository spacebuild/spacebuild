-- Copyright 2016 SB Dev Team (http://github.com/spacebuild)
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.


--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 21/05/2016
-- Time: 23:51
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD
local internal = SB.internal
local class = SB.class
local device_table = {}
local resourceRegistry = class.new("rd/ResourceRegistry", class)

internal.device_table = device_table

SB.RDTYPES = SB.internal.readOnlyTable({
    STORAGE = 1,
    GENERATOR = 2,
    NETWORK = 3
})

SB.RESTYPES = SB.internal.readOnlyTable({
    ENERGY = 1,
    GAS = 2,
    LIQUID = 3,
    COOLANT = 4,
    FLAMABLE = 5
})

resourceRegistry:registerResourceInfo(0, "vacuum", "Vacuum", "", { })
resourceRegistry:registerResourceInfo(1, "energy", "Energy", "W", { SB.RESTYPES.ENERGY })
resourceRegistry:registerResourceInfo(2, "oxygen", "Oxygen", "l", { SB.RESTYPES.GAS })
resourceRegistry:registerResourceInfo(3, "water", "Water", "l", { SB.RESTYPES.LIQUID, SB.RESTYPES.COOLANT })
resourceRegistry:registerResourceInfo(4, "hydrogen", "Hydrogen","l", { SB.RESTYPES.GAS, SB.RESTYPES.FLAMABLE })
resourceRegistry:registerResourceInfo(5, "nitrogen", "Nitrogen","l", { SB.RESTYPES.GAS, SB.RESTYPES.COOLANT }, {1, 2})
resourceRegistry:registerResourceInfo(6, "carbon dioxide", "Carbon Dioxide", "l", { SB.RESTYPES.GAS })
resourceRegistry:registerResourceInfo(7, "steam", "Steam","l", { SB.RESTYPES.GAS })
resourceRegistry:registerResourceInfo(8, "heavy water", "Heavy water","l", { SB.RESTYPES.LIQUID })
resourceRegistry:registerResourceInfo(9, "liquid nitrogen", "Liquid Nitrogen","l", { SB.RESTYPES.LIQUID })

function SB:getResourceRegistry()
    return resourceRegistry
end

function SB:registerDevice(ent, rdtype)
    local entid, obj = ent:EntIndex(), nil
    if rdtype == self.RDTYPES.STORAGE then
        obj = class.new("rd/ResourceStorage", entid, resourceRegistry, class)
    elseif rdtype == self.RDTYPES.GENERATOR then
        obj = class.new("rd/ResourceGenerator", entid, resourceRegistry, class)
    elseif rdtype == self.RDTYPES.NETWORK then
        obj = class.new("rd/ResourceNetwork", entid, resourceRegistry, class)
    else
        error("type is not supported")
    end
    ent.rdobject = obj
    device_table[entid] = obj
    if not ent.rdobject then
        log.error("Something went wrong registering the device")
    end
    hook.Call("onDeviceAdded", GAMEMODE, ent)
    return obj
end

function SB:removeDevice(ent)
    local entid = ent:EntIndex()
    device_table[entid] = nil
    if ent.rdobject ~= nil then
        ent.rdobject:unlink()
        ent.rdobject:removeBeams()
    end
    ent.rdobject = nil
    hook.Call("onDeviceRemoved", GAMEMODE, ent)
end

function SB:getDeviceInfo(entid)
    return device_table[entid]
end

function SB:isValidRDEntity(ent)
    return ent and ent.rdobject ~= nil
end

function SB:canLink(ent1, ent2)
    return self:isValidRDEntity(ent1) and self:isValidRDEntity(ent2) and ent1.rdobject:canLink(ent2.rdobject)
end



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

local sb = sb;
local core = sb.core;

require("class")
local class = class

require("sbnet")
local net = sbnet

local space = class.new("SpaceEnvironment")

-- RD
core.device_table = {}
core.resources_names_table = {}
core.resources_ids_table = {}
core.missing_devices = {}

-- SB
core.environments = {}
core.mod_tables = {}
core.mod_tables.color = {}
core.mod_tables.bloom = {}
core.sb_hooks = {}
core.sb_hooks.onEnter = {}
core.sb_hooks.onLeave = {}
core.sb_hooks.onToolCreated = {}

sb.RDTYPES = {
    STORAGE = 1,
    GENERATOR = 2,
    NETWORK = 3
}

local obj;

function sb.registerDevice(ent, rdtype)
   local entid = ent:EntIndex()
   if rdtype == sb.RDTYPES.STORAGE or rdtype == sb.RDTYPES.GENERATOR then
       obj = class.new("ResourceEntity", entid)
   elseif rdtype == sb.RDTYPES.NETWORK then
       obj = class.new("ResourceNetwork", entid)
   else
        error("type is not supported")
   end
   ent.rdobject = obj;
   ent._synctimestamp = CurTime()  --Time stamp on registration, for use with timers.
   core.device_table[entid] = obj;

    if not ent.rdobject then
       MsgN("Something went wrong registering the device")
    end
    --TODO mss naar client/spacebuild.lua verhuizen?
    if CLIENT and core.missing_devices[entid] then
        core.missing_devices[entid] = nil
        net.Start("SBRU")
        net.writeShort(entid)
        net.SendToServer()
    end
end

function sb.removeDevice(ent)
    local entid = ent:EntIndex()
    core.device_table[entid] = nil
    ent.rdobject:unlink()
    ent.rdobject = nil
end

function sb.getDeviceInfo(entid)
    return core.device_table[entid];
end

local resourceinfo;
function sb.registerResourceInfo(id, name, displayName, attributes)
    resourceinfo = class.new("ResourceInfo", id, name, displayName, attributes)
    core.resources_names_table[name] = resourceinfo
    core.resources_ids_table[id] = resourceinfo
end

function sb.getResourceInfoFromID(id)
   return core.resources_ids_table[id]
end

function sb.getResourceInfoFromName(name)
   return core.resources_names_table[name]
end

local coolant_resources
function sb.getRegisteredCoolants()
    if coolant_resources == nil then
        coolant_resources = {}
        for k, v in pairs(core.resources_names_table) do
           if v:hasAttribute("COOLANT") then
              table.insert(coolant_resources , v:getName())
           end
        end
    end
    return coolant_resources
end

function sb.addEnvironment(environment)
   core.environments[environment:getID()] = environment
end

function sb.removeEnvironment(environment)
    core.environments[environment:getID()] = nil
end

function sb.removeEnvironmentFromEntity(ent)
    core.environments[ent:EntIndex()] = nil
end


function sb.getEnvironment(id)
    if id == -1 then
       return sb.getSpace()
    end
    return core.environments[id]
end

function sb.onSBMap()
   return table.Count(core.environments) > 0
end

function sb.getSpace()
   return space
end

function sb.addEnvironmentColor(env_color)
    core.mod_tables.color[env_color:getID()] = env_color
end

function sb.getEnvironmentColor(id)
    return core.mod_tables.color[id]
end

function sb.addEnvironmentBloom(env_bloom)
    core.mod_tables.bloom[env_bloom:getID()] = env_bloom
end

function sb.getEnvironmentBloom(id)
   return core.mod_tables.bloom[id]
end

function sb.isValidRDEntity(ent)
   return ent.rdobject ~= nil
end

function sb.canLink(ent1, ent2)
    return sb.isValidRDEntity(ent1) and sb.isValidRDEntity(ent2) and ent1.rdobject:canLink(ent2.rdobject)
end

function sb.addOnEnterEnvironmentHook(name, func)
   core.sb_hooks.onEnter[name] = func
end

function sb.removeOnEnterEnvironmentHook(name)
   core.sb_hooks.onEnter[name] = nil
end

function sb.addOnLeaveEnvironmentHook(name, func)
    core.sb_hooks.onLeave[name] = func
end

function sb.removeOnLeaveEnvironmentHook(name)
    core.sb_hooks.onLeave[name] = nil
end

function sb.callOnEnterEnvironmentHook(environment, ent)
   if environment then
       for k, v in pairs(core.sb_hooks.onEnter) do
          v(environment, ply)
       end
   end
end

function sb.callOnLeaveEnvironmentHook(environment, ent)
    if environment then
        for k, v in pairs(core.sb_hooks.onLeave) do
            v(environment, ply)
        end
    end
end

function sb.addOnToolCreatedHook(toolname, func )
    if not core.sb_hooks.onToolCreated[toolname] then core.sb_hooks.onToolCreated[toolname] = {} end
   table.insert(core.sb_hooks.onToolCreated[toolname], func)
end

function sb.callOnToolCreatedHook(toolname, tool)
   if core.sb_hooks.onToolCreated[toolname] then
       for k, v in pairs(core.sb_hooks.onToolCreated[toolname]) do
          v(tool)
       end
   end
end

-- Basic resources
sb.registerResourceInfo(1, "energy", "Energy", {"ENERGY"})
sb.registerResourceInfo(2, "oxygen", "Oxygen", {"GAS"})
sb.registerResourceInfo(3, "water", "Water", {"LIQUID", "COOLANT"})
sb.registerResourceInfo(4, "hydrogen", "Hydrogen", {"GAS", "FLAMABLE"})
sb.registerResourceInfo(5, "nitrogen", "Nitrogen", {"GAS", "COOLANT"})
sb.registerResourceInfo(6, "co2", "Carbon Dioxide", {"GAS"})


--[[
    Register hooks
]]

sb.addOnToolCreatedHook("sb4_generators", function(tool)
    local generators = {
        {
            Name  = "Test Solar Panel",
            Model = "models/props_phx/life_support/panel_medium.mdl",
            EntityClass = "resource_generator_energy",
            EntityDescription = "Solar panel used for testing"
        },
        {
            Name  = "Test Oxygen generator",
            Model = "models/hunter/blocks/cube1x1x1.mdl",
            EntityClass = "resource_generator_oxygen",
            EntityDescription = "Oxygen generator used for testing"
        },
        {
            Name  = "Test Water Pump",
            Model = "models/props_phx/life_support/gen_water.mdl",
            EntityClass = "resource_generator_water",
            EntityDescription = "Water pump used for testing"
        }

    }
    tool:AddRDEntities(generators, "Generators")

    local storages = {
        {
            Name  = "Test Energy Storage",
            Model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
            EntityClass = "resource_storage_energy",
            EntityDescription = "Test energy storage device"
        },
        {
            Name  = "Test Oxygen generator",
            Model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
            EntityClass = "resource_storage_oxygen",
            EntityDescription = "Test oxygen storage device"
        },
        {
            Name  = "Test Water Storage",
            Model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
            EntityClass = "resource_storage_water",
            EntityDescription = "Test water storage device"
        },
        {
            Name  = "Test Blackhole Storage",
            Model = "models/ce_ls3additional/resource_cache/resource_cache_small.mdl",
            EntityClass = "resource_storage_blackhole",
            EntityDescription = "Test energy/oxygen/water storage device"
        }
    }
    tool:AddRDEntities(storages, "Storage")

    local networks = {


    }
    tool:AddRDEntities(networks, "Resource Nodes")

    local ls_devices = {

    }
    tool:AddRDEntities(ls_devices, "Life Support")
end)





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

core.device_table = {}
core.resources_names_table = {}
core.resources_ids_table = {}

sb.RDTYPES = {
    STORAGE = 1,
    GENERATOR = 2,
    NETWORK = 3
}

local obj;

function sb.registerDevice(ent, rdtype)
   local entid = ent:EntIndex()
   if(entid < 1) then -- LocalPlayer bug??
       entid = 1
   end
   if rdtype == sb.RDTYPES.STORAGE or rdtype == sb.RDTYPES.GENERATOR then
       obj = core.class.create("ResourceEntity", entid)
   elseif rdtype == sb.RDTYPES.NETWORK then
       obj = core.class.create("ResourceNetwork", entid)
   else
        error("type is not supported")
   end
   ent.rdobject = obj;
   core.device_table[entid] = obj;
end

local resourceinfo;
function sb.registerResourceInfo(id, name, displayName, attributes)
    resourceinfo = core.class.create("ResourceInfo", id, name, displayName, attributes)
    core.resources_names_table[name] = resourceinfo
    core.resources_ids_table[id] = resourceinfo
end

function sb.getResourceInfoFromID(id)
   return core.resources_ids_table[id]
end

function sb.getResourceInfoFromName(name)
   return core.resources_names_table[name]
end



local sb = sb;
local core = sb.core;

core.resource_tables = {}

sb.RDTYPES = {
    STORAGE = 1,
    GENERATOR = 2,
    NETWORK = 3
}

local obj;

function sb.registerDevice(ent, rdtype)
   local entid = ent:EntIndex()
   if rdtype == sb.RDTYPES.STORAGE or rdtype == sb.RDTYPES.GENERATOR then
       obj = core.class.create("ResourceEntity", entid)
   elseif rdtype == sb.RDTYPES.NETWORK then
       obj = core.class.create("ResourceNetwork", entid)
   else
        error("type is not supported")
   end
   ent.rdobject = obj;
   core.resource_tables[entid] = obj;
end


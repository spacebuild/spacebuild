
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
   if(entid < 1) then -- LocalPlayer bug??
       entid = 1
   end
   Msg("Registering: " ..tostring(entid))
   if rdtype == sb.RDTYPES.STORAGE or rdtype == sb.RDTYPES.GENERATOR then
       obj = core.class.create("ResourceEntity", entid)
   elseif rdtype == sb.RDTYPES.NETWORK then
       obj = core.class.create("ResourceNetwork", entid)
   else
        error("type is not supported")
   end
   if SERVER then
        ent.rdobject = obj;
        PrintTable(obj)
        PrintTable(ent.rdobject)
   end
   core.resource_tables[entid] = obj;
end


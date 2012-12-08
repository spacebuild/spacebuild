
local core = sb.core;
local to_sync;
net.Receive("SBRU", function(bytesreceived)
    Msg("receiving data")
    local syncid = core.net.readShort()
    to_sync = core.resource_tables[syncid]
    to_sync:receive()
    PrintTable(to_sync);
end)

local core = sb.core;
local to_sync;
net.Receive("SBRU", function(bytesreceived)
    local syncid = net.Read
    to_sync = core.resource_tables(syncid)
    to_sync.receive()
    PrintTable(to_sync);
end)
-- Add data to be pooled here
local net_pools = { "SBRU", "ResourceContainer", "ResourceEntity", "ResourceNetwork" };
for _, v in pairs(net_pools) do
    print("Pooling ", v, " for net library");
    util.AddNetworkString(v)
end
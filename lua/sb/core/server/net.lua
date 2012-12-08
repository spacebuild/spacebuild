--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 8/12/12
-- Time: 21:50
-- To change this template use File | Settings | File Templates.
--

local corenet = net
local net = sb.core.net;

function net.writeBool(bool)
    corenet.WriteBit(bool)
end

function net.writeShort(short)
    return corenet.WriteInt(short, 2);
end

function net.writeLong(long)
    return corenet.WriteInt(long, 8);
end
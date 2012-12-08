--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 8/12/12
-- Time: 21:50
-- To change this template use File | Settings | File Templates.
--
local corenet = net
local net = sb.core.net;

function net.readBool()
    return corenet.ReadBit() == 1
end

function net.readShort()
    return corenet.ReadInt(2);
end

function net.readLong()
    return corenet.ReadInt(8);
end
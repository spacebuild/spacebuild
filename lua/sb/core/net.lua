local sb = sb
local corenet = net
local net = sb.core.net


net.TYPES_INT = {
    -- Default types
    TINY = {
        length = 1 * 8,
        min = -128,
        max = 127,
        umax = 255
    },
    SHORT = {
        length = 2 * 8,
        min = -32768,
        max = 32767,
        umax = 65535
    },
    INT = {
        length = 4 * 8,
        min = -2147483648,
        max = 2147483647,
        umax = 4294967295
    },
    -- TODO LONG seems to mess up!!!
    LONG = {
        length = 8 * 8,
        min =  -36028797018963968,
        max =  36028797018963968,
        umax = 7257594037927936
    }
}

net.TYPES_INT.AMOUNT = net.TYPES_INT.INT -- Send amounts as long

-- util

-- Returns the MAX amount that can be using the net library!!!
function net.getMaxAmount()
    return net.TYPES_INT.AMOUNT.max
end

-- Write
function net.writeBool(bool)
    corenet.WriteBit(bool)
end

function net.writeShort(short)
    return corenet.WriteInt(short, net.TYPES_INT.SHORT.length);
end

function net.writeLong(long)
    return corenet.WriteInt(long, net.TYPES_INT.LONG.length);
end

function net.writeTiny(tiny)
    return corenet.WriteInt(tiny, net.TYPES_INT.TINY.length);
end

function net.writeAmount(amount)
    if amount > net.getMaxAmount() then
        amount = net.getMaxAmount()  --Prevent syncing more then is allowed!!
    end
    return corenet.WriteUInt(amount, net.TYPES_INT.AMOUNT.length);
end

-- Read
function net.readBool()
    return corenet.ReadBit() == 1
end

function net.readShort()
    return corenet.ReadInt(net.TYPES_INT.SHORT.length);
end

function net.readLong()
    return corenet.ReadInt(net.TYPES_INT.LONG.length);
end

function net.readTiny()
    return corenet.ReadInt(net.TYPES_INT.TINY.length)
end

function net.readAmount()
    return corenet.ReadUInt(net.TYPES_INT.AMOUNT.length)
end
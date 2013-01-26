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

-- Write
function net.writeBool(bool)
    corenet.WriteBit(bool)
end

function net.writeShort(short)
    corenet.WriteInt(short, net.TYPES_INT.SHORT.length);
end

function net.writeLong(long)
    corenet.WriteInt(long, net.TYPES_INT.LONG.length);
end

function net.writeTiny(tiny)
    corenet.WriteInt(tiny, net.TYPES_INT.TINY.length);
end

function net.writeAmount(amount)
    local mul = 0;
    if amount > net.TYPES_INT.AMOUNT.max then
        net.writeBool(true)
        mul = math.floor(amount/net.TYPES_INT.AMOUNT.max)
        net.writeTiny(mul)
        amount = amount - (mul * net.TYPES_INT.AMOUNT.max)   --Prevent syncing more then is allowed!!
    else
        net.writeBool(false)
    end
    corenet.WriteUInt(amount, net.TYPES_INT.AMOUNT.length);
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
    local base = 0;
    if net.readBool() then
        base = net.readTiny() * net.TYPES_INT.AMOUNT.max
    end
    return base + corenet.ReadUInt(net.TYPES_INT.AMOUNT.length)
end
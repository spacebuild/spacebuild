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
    LONG = {
        length = 8 * 8,
        min =  -36028797018963968,
        max =  36028797018963968,
        umax = 7257594037927936
    }
}
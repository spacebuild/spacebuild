local bit = bit
module("caf_util")
local list = {}
list.__index = list

function isBitSet(value, b)
	return bit.band(value, bit.lshift(1, b - 1)) ~= 0
end
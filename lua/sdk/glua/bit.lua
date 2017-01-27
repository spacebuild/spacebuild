---
-- @description Library bit
 module("bit")

--- bit.arshift
-- @usage shared_m
-- Returns the arithmetically shifted value.
--
-- @param  value number  The value to be manipulated.
-- @param  shiftCount number  Amounts of bits to shift.
-- @return number shiftedValue
function arshift( value,  shiftCount) end

--- bit.band
-- @usage shared_m
-- Returns the bitwise and of all values specified.
--
-- @param  value number  The value to be manipulated.
-- @param  otherValues=nil number  Values bit and with. Optional.
-- @return number bitwiseAnd
function band( value,  otherValues) end

--- bit.bnot
-- @usage shared_m
-- Returns the bitwise not of the value.
--
-- @param  value number  The value to be inverted.
-- @return number bitwiseNot
function bnot( value) end

--- bit.bor
-- @usage shared_m
-- Returns the bitwise OR of all values specified.
--
-- @param  value1 number  The first value.
-- @param  ... vararg  Extra values to be evaluated. (must all be numbers)
-- @return number The bitwise OR result between all numbers.
function bor( value1,  ...) end

--- bit.bswap
-- @usage shared_m
-- Swaps the byte order.
--
-- @param  value number  The value to be byte swapped.
-- @return number swapped
function bswap( value) end

--- bit.bxor
-- @usage shared_m
-- Returns the bitwise xor of all values specified.
--
-- @param  value number  The value to be manipulated.
-- @param  otherValues=nil number  Values bit xor with. Optional.
-- @return number bitwiseXOr
function bxor( value,  otherValues) end

--- bit.lshift
-- @usage shared_m
-- Returns the left shifted value.
--
-- @param  value number  The value to be manipulated.
-- @param  shiftCount number  Amounts of bits to shift left by.
-- @return number shiftedValue
function lshift( value,  shiftCount) end

--- bit.rol
-- @usage shared_m
-- Returns the left rotated value.
--
-- @param  value number  The value to be manipulated.
-- @param  shiftCount number  Amounts of bits to rotate left by.
-- @return number shiftedValue
function rol( value,  shiftCount) end

--- bit.ror
-- @usage shared_m
-- Returns the right rotated value.
--
-- @param  value number  The value to be manipulated.
-- @param  shiftCount number  Amounts of bits to rotate right by.
-- @return number shiftedValue
function ror( value,  shiftCount) end

--- bit.rshift
-- @usage shared_m
-- Returns the right shifted value.
--
-- @param  value number  The value to be manipulated.
-- @param  shiftCount number  Amounts of bits to shift right by.
-- @return number shiftedValue
function rshift( value,  shiftCount) end

--- bit.tobit
-- @usage shared_m
-- Normalizes the specified value and clamps it in the range of a signed 32bit integer.
--
-- @param  value number  The value to be normalized.
-- @return number swapped
function tobit( value) end

--- bit.tohex
-- @usage shared_m
-- Returns the hexadecimal representation of the number with the specified digits.
--
-- @param  value number  The value to be normalized.
-- @param  digits=8 number  The number of digits. Optional
-- @return string hexString
function tohex( value,  digits) end

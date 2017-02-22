--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

---
-- @description Library math
 module("math")

--- math.abs
-- @usage shared_m
-- Calculates the absolute value of a number (effectively removes any negative sign).
--
-- @param  x number  The number to get the absolute value of.
-- @return number absolute_value
function abs( x) end

--- math.acos
-- @usage shared_m
-- Returns the arc cosine of the given number.
--
-- @param  normal number  Value in range of -1 - 1.
-- @return number acos
function acos( normal) end

--- math.AngleDifference
-- @usage shared_m
-- Calculates the difference between two angles.
--
-- @param  a number  The first angle.
-- @param  b number  The second angle.
-- @return number The difference between the angles between -180 and 180
function AngleDifference( a,  b) end

--- math.Approach
-- @usage shared_m
-- Gradually approaches the target value by the specified amount.
--
-- @param  current number  The value we're currently at.
-- @param  target number  The target value. This function will never overshoot this value.
-- @param  change number  The amount that the current value is allowed to change by to approach the target. (It makes no difference whether this is positive or negative.)
-- @return number New current value, closer to the target than it was previously.
function Approach( current,  target,  change) end

--- math.ApproachAngle
-- @usage shared_m
-- Increments an angle towards another by specified rate.
--
-- @param  currentAngle number  The current angle to increase
-- @param  targetAngle number  The angle to increase towards
-- @param  rate number  The amount to approach the target angle by
-- @return number Modified angle
function ApproachAngle( currentAngle,  targetAngle,  rate) end

--- math.asin
-- @usage shared_m
-- Returns the arc sine of the given number.
--
-- @param  normal number  Value in range of -1 - 1.
-- @return number asin
function asin( normal) end

--- math.atan
-- @usage shared_m
-- Returns the arc tangents of the given number.
--
-- @param  normal number  Value in range of -1 - 1.
-- @return number atan
function atan( normal) end

--- math.atan2
-- @usage shared_m
-- Returns math.atan(y / x) in radians. The result is between -math.pi and math.pi.
--
-- @param  y number  Y coordinate.
-- @param  x number  X coordinate.
-- @return number atan2
function atan2( y,  x) end

--- math.BinToInt
-- @usage shared_m
-- Converts a binary string into a number.
--
-- @param  string string  Binary string to convert
-- @return number Base 10 number.
function BinToInt( string) end

--- math.BSplinePoint
-- @usage shared_m
-- Basic code for Bézier-Spline algorithm.
--
-- @param  tDiff number 
-- @param  tPoints table  A table of Vectors
-- @param  tMax number 
-- @return Vector Point on Bezier curve, related to tDiff.
function BSplinePoint( tDiff,  tPoints,  tMax) end

--- math.calcBSplineN
-- @usage shared_m
-- Basic code for Bezier-Spline algorithm.
--
-- @param  i number 
-- @param  k number 
-- @param  t number 
-- @param  tinc number 
function calcBSplineN( i,  k,  t,  tinc) end

--- math.ceil
-- @usage shared_m
-- Ceils or rounds a number up.
--
-- @param  number number  The number to be rounded up.
-- @return number ceiled numbers
function ceil( number) end

--- math.Clamp
-- @usage shared_m
-- Clamps a number between a minimum and maximum value
--
-- @param  input number  The number to clamp.
-- @param  min number  The minimum value, this function will never return a number less than this.
-- @param  max number  The maximum value, this function will never return a number greater than this.
-- @return number The clamped value.
function Clamp( input,  min,  max) end

--- math.cos
-- @usage shared_m
-- Returns cosine of given angle.
--
-- @param  number number  Angle in radians
-- @return number Cosine of given angle
function cos( number) end

--- math.cosh
-- @usage shared_m
-- Returns hyperbolic cosine of the given number.
--
-- @param  number number  Value in radians.
-- @return number hcos
function cosh( number) end

--- math.deg
-- @usage shared_m
-- Converts radians to degrees.
--
-- @param  radians number  Value to be converted to degrees.
-- @return number degrees
function deg( radians) end

--- math.Dist
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use math.Distance instead
-- @param  x1 number  X position of first point
-- @param  y1 number  Y position of first point
-- @param  x2 number  X position of second point
-- @param  y2 number  Y position of second point
-- @return number Distance between the two points.
function Dist( x1,  y1,  x2,  y2) end

--- math.Distance
-- @usage shared_m
-- Returns the difference between two points in 2D space.
--
-- @param  x1 number  X position of first point
-- @param  y1 number  Y position of first point
-- @param  x2 number  X position of second point
-- @param  y2 number  Y position of second point
-- @return number Distance between the two points
function Distance( x1,  y1,  x2,  y2) end

--- math.EaseInOut
-- @usage shared_m
-- Calculates the progress of a value fraction, taking in to account given easing fractions
--
-- @param  progress number  Fraction of the progress to ease
-- @param  easeIn number  Fraction of how much easing to begin with
-- @param  easeOut number  Fraction of how much easing to end with
-- @return number Eased Value
function EaseInOut( progress,  easeIn,  easeOut) end

--- math.exp
-- @usage shared_m
-- Returns the x power of the euler constant.
--
-- @param  exponent number  The exponent for the function.
-- @return number result
function exp( exponent) end

--- math.floor
-- @usage shared_m
-- Floors or rounds a number down.
--
-- @param  number number  The number to be rounded down.
-- @return number floored numbers
function floor( number) end

--- math.fmod
-- @usage shared_m
-- Returns the modulus of the specified values.
--
-- @param  base number  The base value.
-- @param  modulator number  The modulator.
-- @return number The calculated modulus.
function fmod( base,  modulator) end

--- math.frexp
-- @usage shared_m
-- used to split the number value into a normalized fraction and an exponent. Two values are returned: the first is a value always in the range 1/2 (inclusive) to 1 (exclusive) and the second is an exponent.
--
-- @param  inputValue number  The value to get the normalized fraction and the exponent from.
-- @return number normalizedFraction
function frexp( inputValue) end

--- math.huge
-- @usage shared_m
-- No description
function huge() end

--- math.IntToBin
-- @usage shared_m
-- Converts an integer to a binary (base-2) string.
--
-- @param  int number  Number to be converted.
-- @return string Binary number string. The length of this will always be a multiple of 3.
function IntToBin( int) end

--- math.ldexp
-- @usage shared_m
-- Takes a normalised number and returns the floating point representation.
--
-- @param  normalizedFraction number  The value to get the normalized fraction and the exponent from.
-- @param  exponent number  The value to get the normalized fraction and the exponent from.
-- @return number result
function ldexp( normalizedFraction,  exponent) end

--- math.log
-- @usage shared_m
-- With one argument, return the natural logarithm of x (to base e).
--
-- @param  x number  The value to get the base from exponent from.
-- @param  base=math.exp(1) number 
function log( x,  base) end

--- math.log10
-- @usage shared_m
-- Returns the base-10 logarithm of x. This is usually more accurate than math.log(x, 10).
--
-- @param  x number  The value to get the base from exponent from.
function log10( x) end

--- math.max
-- @usage shared_m
-- Returns the largest value of all arguments.
--
-- @param  numbers vararg  Numbers to get the largest from
-- @return number The largest number
function max( numbers) end

--- math.min
-- @usage shared_m
-- Returns the smallest value of all arguments.
--
-- @param  numbers vararg  Numbers to get the smallest from.
-- @return number The smallest number
function min( numbers) end

--- math.mod
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--This is removed in Lua versions later than what GMod is currently using. You should use the % operator or math.fmod instead.
-- @param  base number  The base value
-- @param  modulator number  Modulator
-- @return number The calculated modulus
function mod( base,  modulator) end

--- math.modf
-- @usage shared_m
-- Returns the integral and fractional component of the modulo operation.
--
-- @param  base number  The base value.
-- @param  modulator number  The modulator.
-- @return number The integral component.
-- @return number The fractional component.
function modf( base,  modulator) end

--- math.NormalizeAngle
-- @usage shared_m
-- Normalizes angle, so it returns value between -180 and 180.
--
-- @param  angle number  The angle to normalize, in degrees.
-- @return number The normalized angle, in the range of -180 to 180 degrees.
function NormalizeAngle( angle) end

--- math.pi
-- @usage shared_m
-- No description
function pi() end

--- math.pow
-- @usage shared_m
-- Returns x raised to the power y.
--In particular, math.pow(1.0, x) and math.pow(x, 0.0) always return 1.0, even when x is a zero or a NaN. If both x and y are finite, x is negative, and y is not an integer then math.pow(x, y) is undefined.
--
-- @param  x number  Base.
-- @param  y number  Exponent.
-- @return number y power of x
function pow( x,  y) end

--- math.rad
-- @usage shared_m
-- Converts an angle in degrees to it's equivalent in radians.
--
-- @param  degrees number  The angle measured in degrees.
-- @return number radians
function rad( degrees) end

--- math.Rand
-- @usage shared_m
-- Returns a random float between min and max.
--
-- @param  min number  The minimum value.
-- @param  max number  The maximum value.
-- @return number Random float between min and max.
function Rand( min,  max) end

--- math.random
-- @usage shared_m
-- When called without arguments, returns a uniform pseudo-random real number in the range 0 to 1 which includes 0 but excludes 1.
--
-- @param  m number  If m is the only parameter: upper limit. If n is also provided: lower limit.  If provided, this must be an integer.
-- @param  n number  Upper limit.  If provided, this must be an integer.
-- @return number Random value
function random( m,  n) end

--- math.randomseed
-- @usage shared_m
-- Seeds the "seed" for the random generator, which will cause math.random to return the same sequence of numbers.
--
-- @param  seed number  The new seed.
function randomseed( seed) end

--- math.Remap
-- @usage shared_m
-- Remaps the value from one range to another
--
-- @param  value number  The value
-- @param  inMin number  The minimum of the initial range
-- @param  inMax number  The maximum of the initial range
-- @param  outMin number  The minimum of new range
-- @param  outMax number  The maximum of new range
-- @return number The number in the new range
function Remap( value,  inMin,  inMax,  outMin,  outMax) end

--- math.Round
-- @usage shared_m
-- Rounds the given value to the nearest whole number or to the given decimal places.
--
-- @param  value number  The value to round.
-- @param  decimals=0 number  The decimal places to round to.
-- @return number The rounded value.
function Round( value,  decimals) end

--- math.sin
-- @usage shared_m
-- Returns sine of given angle.
--
-- @param  number number  Angle in radians
-- @return number Sine for given angle
function sin( number) end

--- math.sinh
-- @usage shared_m
-- Returns hyperbolic sine of the given number.
--
-- @param  number number  Value in radians.
-- @return number sinh
function sinh( number) end

--- math.sqrt
-- @usage shared_m
-- Returns the square root of the number.
--
-- @param  value number  Value to get the square root of.
-- @return number squareRoot
function sqrt( value) end

--- math.tan
-- @usage shared_m
-- Returns tangents of given angle.
--
-- @param  value number  Angle in radians
-- @return number tangents
function tan( value) end

--- math.tanh
-- @usage shared_m
-- Returns hyperbolic tangents of the given number.
--
-- @param  number number  Value in radians.
-- @return number tanh
function tanh( number) end

--- math.TimeFraction
-- @usage shared_m
-- Returns the fraction of where the current time is relative to the start and end times
--
-- @param  start number  Start time in seconds
-- @param  endTime number  End time in seconds
-- @param  current number  Current time in seconds
-- @return number Fraction
function TimeFraction( start,  endTime,  current) end

--- math.Truncate
-- @usage shared_m
-- Rounds towards zero.
--
-- @param  num number  The number to truncate
-- @param  digits number  The amount of digits to keep after the point.
function Truncate( num,  digits) end

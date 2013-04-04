--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 06/01/13
-- Time: 02:03
-- To change this template use File | Settings | File Templates.
--

AddCSLuaFile()

local print = print
local pairs = pairs
local ipairs = ipairs

TestQuats = {} --class


local checkComponents = function(q, data)
	local n = 0
	for k, v in ipairs({ q.w, q.i, q.j, q.k }) do
		-- The 0.0000005 is a tolerance range for floating point issues.
		if data[k] == v or (data[k] + 0.0000005 > v and data[k] - 0.0000005 < v) then n = n + 1 end
	end
	if n >= 4 then return true end
	return false
end

-- Any test functions should start with test :/

function TestQuats:setUp()
	-- this function is run before each test, so that multiple
	-- tests can share initialisations
	require("quaternion")
end

function TestQuats:tearDown()
	-- this function is executed after each test
	-- here, we have nothing to do so we could have avoid
	-- declaring it
end

function TestQuats:testZeroQaut()
	-- Zero Quat check
	local q = quaternion.create(1, 0, 0, 0) --Hopefully a new zero quaternion
	assert(q)
	assertEquals(checkComponents(q, { 1, 0, 0, 0 }), true)
end

function TestQuats:testScalarVectorQuatCreation()
	-- Test if we can make a quat from a scalar and a gmod vector
	local q = quaternion.create(10, Vector(5, 6, 7))
	assert(q)
	assertEquals(checkComponents(q, { 10, 5, 6, 7 }), true)
end


function TestQuats:testNil()
	-- Nil Test, checks to see if nil will break the constructor
	local q = quaternion.create(nil, nil, nil, nil) -- LOL
	assert(q)
	assertEquals(checkComponents(q, { 1, 0, 0, 0 }), true)
end

function TestQuats:testUnm()
	-- Checks if unary minus does infact work :D
	local q = quaternion.create(2, 3, 5, 7) -- Primes hehe
	local nq = -q
	assert(q)
	assert(nq)
	assertEquals(checkComponents(nq, { -2, -3, -5, -7 }), true)
	assertEquals(checkComponents(-nq, { q.w, q.i, q.j, q.k }), true)
end

function TestQuats:testToString()
	-- See if printing would work
	local q = quaternion.create(1, 3, 3, 7) -- L337
	assert(q)
	assertEquals(tostring(q), "(1.000000+3.000000i+3.000000j+7.000000k)")
end

function TestQuats:testScalarMult()
	-- Check if both versions of the scalar multiplication work
	local q = quaternion.create(3, 5, 8, 13)
	assert(q)
	local q = 5 * q
	assert(q)
	assertEquals(checkComponents(q, { 15, 25, 40, 65 }), true)

	local q = quaternion.create(3, 5, 8, 13)
	assert(q)
	local q = q * 5
	assert(q)
	assertEquals(checkComponents(q, { 15, 25, 40, 65 }), true)
end

function TestQuats:testQuatMult()
	-- Check if we can multiply a quat by another quat :s
	local q = quaternion.create(2, 4, 6, 8)
	local e = quaternion.create(1, 3, 5, 7)

	assert(q)
	assert(e)

	-- Test both ways as quaternion multiplication is non-commutative
	local result = q * e
	assert(result)
	local testData1 = { -96.000000, 12.000000, 12.000000, 24.000000 }
	assertEquals(checkComponents(result, testData1), true)

	local result = e * q
	assert(result)
	local testData2 = { -96.000000, 8.000000, 20.000000, 20.000000 }
	assertEquals(checkComponents(result, testData2), true)
end

function TestQuats:testQuatAddSub()
	-- See if we can add or sub a number to a scalar and quats ofc
	local q = quaternion.create(1, 2, 3, 4)
	assert(q)
	local result = q + 5
	assertEquals(checkComponents(result, { 6, 2, 3, 4 }), true)

	local q = result - 5
	assert(q)
	assertEquals(checkComponents(q, { 1, 2, 3, 4 }), true)

	local result = 5 - q
	assert(result)
	assertEquals(checkComponents(result, { 4, 2, 3, 4 }), true)

	local q = quaternion.create(4, 5, 6, 7)
	local e = quaternion.create(3, 4, 5, 6)
	assert(q)
	assert(e)
	local result = q + e
	assert(result)
	assertEquals(checkComponents(result, { 7, 9, 11, 13 }), true)

	local result = q - e
	assert(result)
	assertEquals(checkComponents(result, { 1, 1, 1, 1 }), true)

	local result = e - q
	assert(result)
	assertEquals(checkComponents(result, { -1, -1, -1, -1 }), true)
end

function TestQuats:testQuatDiv()
	-- See if we can divide number by quat, quat by number, and quat by quat.
	local q = quaternion.create(3, 6, 9, 12)
	local e = quaternion.create(3, 3, 3, 3)

	assert(q)
	assert(e)
	local testObj = q * e:conj() -- as q.q^-1 =1 therefore 1/q = q^-1. Thus q/e = q.1/e = q.e^-1
	assert(testObj)
	assertEquals(checkComponents(q / e, { 90.000000, 18.000000, 0.000000, 36.000000 }), true)
end

function TestQuats:testNormalise()
	-- Normalise and test if correct
	local q = quaternion.create(5, 9, 16, 29)
	assert(q)
	local result = q:normalise()
	assert(result)
	assertEquals(checkComponents(result, { 0.144157, 0.259483, 0.461304, 0.836113 }), true)
end


function TestQuats:testQuatComplexConjugate()
	-- Check if we invert correctly
	-- Since we invert the vector and not the scalar be careful
	local q = quaternion.create(5, 6, 7, 8)
	assert(q)
	assertEquals(checkComponents(q:conj(), { 5, -6, -7, -8 }), true)

	local q2 = q:conj()
	assert(q2)
	q:normalise()
	q2:normalise()
	assertEquals(checkComponents(q * q2, { 1.000000, 0.000000, 0.000000, 0.000000 }), true)
end

function TestQuats:testQuatfromEuler()
	-- Check if we can correctly covert from Euler angles to Quaternions :D
	local q = quaternion.create(1, 0, 0, 0)

	q:fromEuler(90, 0, 0)
	assertEquals(checkComponents(q, { 0.707107, 0.000000, 0.707107, 0.000000 }), true)

	q:fromEuler(0, 90, 0)
	assertEquals(checkComponents(q, { 0.707107, 0.000000, 0.000000, 0.707107 }), true)

	q:fromEuler(0, 0, 90)
	assertEquals(checkComponents(q, { 0.707107, 0.707107, 0.000000, 0.000000 }), true)

	q:fromEuler(-38, 147, -9005) --Inprecision seems to be a bitch here :/ different online calculators conflict, in sign and magnitude, and my answers also differ.
	assertEquals(checkComponents(q, { -0.281902, -0.300150, 0.1319228898994782, -0.9016856793017153 }), true)
end

function TestQuats:testQuattoVec()

	local q = quaternion.create(1, 0, 0, 0)
	local qv = q:toVec()
	assertEquals(type(qv), "table")
	assertEquals(qv[1], 0)
	assertEquals(qv[2], 0)
	assertEquals(qv[3], 0)

	local q = quaternion.create(1, 5, 7, 9)
	local qv = q:toVec()
	assertEquals(type(qv), "table")
	assertEquals(qv[1], 5)
	assertEquals(qv[2], 7)
	assertEquals(qv[3], 9)
end

function TestQuats:testQuattoAng()

	local function checkWithin(var, value, tol)

		if var >= value - tol and var <= value + tol then return true
		else return false
		end
	end


	local q = quaternion.create(5, 9, 16, 29):normalise()
	local qa = q:toAngle()
	assertEquals(type(qa), "table")
	assertEquals(checkWithin(qa[1], 28.715809154701, 0.0000005), true)
	assertEquals(checkWithin(qa[2], -159.93337875619, 0.0000005), true)
	assertEquals(checkWithin(qa[3], -127.41296933957, 0.0000005), true)
end








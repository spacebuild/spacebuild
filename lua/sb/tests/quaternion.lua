--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 06/01/13
-- Time: 02:03
-- To change this template use File | Settings | File Templates.
--
local print = print
local pairs = pairs
local ipairs = ipairs

TestQuats = {} --class


local checkComponents = function (q,data)
    local n = 0
    for k, v in ipairs({q.w,q.i,q.j,q.k}) do
        if data[k] == v then n = n + 1 end
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
    local q = quaternion.create(0,0,0,0) --Hopefully a new zero quaternion
    assert(q)
    assertEquals( checkComponents(q,{0,0,0,0}), true )
end

function TestQuats:testNil()
    -- Nil Test, checks to see if nil will break the constructor
    local q = quaternion.create(nil,nil,nil,nil) -- LOL
    assert(q)
    assertEquals( checkComponents(q,{1,0,0,0}), true)
end

function TestQuats:testUnm()
    -- Checks if unary minus does infact work :D
    local q = quaternion.create(2,3,5,7) -- Primes hehe
    local nq = -q
    assert(q)
    assert(nq)
    assertEquals( checkComponents(nq,{-2,-3,-5,-7}), true)
    assertEquals( checkComponents(-nq,{q.w,q.i,q.j,q.k}), true)
end

function TestQuats:testToString()
    -- See if printing would work
    local q = quaternion.create(1,3,3,7) -- L337
    assert(q)
    assertEquals( tostring(q), "(1.000000+3.000000i+3.000000j+7.000000k)")
end

function TestQuats:testScalarMult()
    -- Check if both versions of the scalar multiplication work
    local q = quaternion.create(3,5,8,13)
    assert(q)
    local q = 5*q
    assertEquals( checkComponents(q,{15,25,40,65}), true)

    local q = quaternion.create(3,5,8,13)
    local q = q*5
    assertEquals( checkComponents(q,{15,25,40,65}), true)
end

function TestQuats:testQuatMult()
    -- Check if we can multiply a quat by another quat :s
    local q = quaternion.create(2,4,6,8)
    local e = quaternion.create(1,3,5,7)

    -- Test both ways as quaternion multiplication is non-commutative
    local result = q*e
    local testData1 = {-82,22,6,22}
    assertEquals( checkComponents(result,testData1), true)

    local result = e*q
    local testData2 = {-80,20,12,16 }
    assertEquals( checkComponents(result, testData2), true)

end

function TestQuats:testQuatAddSub()
    -- See if we can add or sub a number to a scalar and quats ofc
    local q = quaternion.create(1,2,3,4)
    local q = q+5
    assertEquals( checkComponents(q,{6,7,8,9}), true)

    local q = q-5
    assertEquals( checkComponents(q,{1,2,3,4}), true)

    local q = 5-q
    assertEquals( checkComponents(q,{4,2,3,4}), true)

    local q = quaternion.create(4,5,6,7)
    local e = quaternion.create(3,4,5,6)
    local result = q+e
    assertEquals( checkComponents(result,{7,9,11,13}))

    local result = q-e
    assertEquals( checkComponents(result,{1,1,1,1}), true)

    local result = e-q
    assertEquals( checkComponents(result,{-1,-1,-1,-1}), true)

end

function TestQuats:testQuatDiv()
    -- See if we can divide number by quat, quat by number, and quat by quat.

end

function TestQuats:testQuatComplexConjugate()
    -- Check if we invert correctly
    -- Since we invert the vector and not the scalar be careful
    local q = quaternion.create(5,6,7,8)
    assertEquals( checkComponents(q:conj(),{5,-6,-7,-8}) or checkComponents(q:conj(),{-5,6,7,8}), true)
end






--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 06/01/13
-- Time: 02:03
-- To change this template use File | Settings | File Templates.
--


TestQuats = {} --class
local print = print
local pairs = pairs
local ipairs = ipairs

local checkComponents = function (q,data)
    local n = 0
    for k, v in ipairs({q.w,q,i,q.j,q.k}) do
        if data[k] == v then n = n + 1 end
    end
    if n >= 4 then return true
    end
end

-- Any test functions should start with test :/

function TestQuats:setUp()
    -- this function is run before each test, so that multiple
    -- tests can share initialisations

    require("quaternion")
    local print = print
    local pairs = pairs
    local ipairs = ipairs


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
    local q = -q
    assert(q)
    assertEquals( checkComponents(-q,{-2,-3,-5,-7}), true)
end

function TestQuats:testToString()
    -- See if printing would work
    local q = quaternion.create(1,3,3,7) -- L337
    assert(q)
    assertEquals( tostring(q), "(1+3i+3j+7k)")
end

function TestQuats:testScalarMult()
    -- Check if both versions of the scalar multiplication work
    local q = quaternion.create(3,5,8,13)
    assert(q)
    local q = 5*q
    assertEquals( checkComponents(q,{15,25,40,65}), true)
end
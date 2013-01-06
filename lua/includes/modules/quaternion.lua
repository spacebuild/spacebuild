--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 03/01/13
-- Time: 17:24
-- To change this template use File | Settings | File Templates.
--

-- Quaternion Lua module for 4D Vector Mathematics by Radon (http://github.com/awilliamson)
-- Big Thanks to the WireMod Team and Colonel Thirty Two for their Quaternion Support and code as a reference when making this.
-- Thanks to http://content.gpwiki.org/index.php/OpenGL:Tutorials:Using_Quaternions_to_represent_rotation for the formulas and clear layout to help me build these functions.

-- Local makes it faster :D
local math = math
local setmetatable = setmetatable
local type = type
local string = string

local sin = math.sin
local cos = math.cos
local acos = math.acos
local abs = math.abs
local sqrt = math.sqrt
local rad = math.rad
local deg = math.deg

local nlog = math.log
local exp = math.exp

module("quaternion")  -- Define as a module after getting all the variable from global namespace that we need.

-- Yes i'm aware i'm using w,i,j,k as variables here, even though they themselves are imaginary. Since we're dealing with vectors i thought it more appropriate than the x,y,z naming convention.
-- Please don't kill me.

local toRadians = function (degrees)
    return rad(degrees)  --math.rad was born for this
end

local toDegrees = function (radians)
    return deg(radians)    --math.deg was born for this
end


local quat = {}
quat.__index = quat
quat.type = "quaternion" -- So we can filter/check for it in later operations

local math = math
local setmetatable = setmetatable

local newQuat = function( w, i, j, k )     --Generic Builder
    local args = {w,i,j,k}
    local status, err, q = pcall( function()

        for k,v in ipairs(args) do
            if type(v) ~= "number" then error({msg = "One of the arguements was not a number"})end
        end

        local q = setmetatable({},quat) --inherit quat methods and metamethods
        q.w = w or 1
        q.i = i or 0
        q.j = j or 0
        q.k = k or 0

        return q

    end )

    if status == false and err then
        print(err.msg)
    elseif status == true and not err and q then
        return q
    end

end

-- Constructor
function create(w, i, j, k)
    for k,v in ipairs({w,i,j,k}) do
        if type(v) ~= "number" then return false end
    end

    return newQuat(w,i,j,k)
end

--========= Now for some operator metamethods =========--

-- Unary Minus
function quat:__unm()
    return newQuat(-self.w,-self.i,-self.j,-self.k)
end

function quat:__tostring()
    return string.format("(%f+%fi+%fj+%fk)",self.r,self.i,self.j,self.k)
end

-- Multiplying q1 with q2 applies the rotation q2 to q1
function quat:__mul(q1,q2)

    if type(q1) == "number" then
        return newQuat(

            q1*q2.w, q1*q2.i, q1*q2.j, q1*q2.k --Isn't Scalar Matrix Multiplication so much easier?

        )
    elseif type(q2) == "number" then
        return newQuat(

            q2*q1.w, q2*q1.i, q2*q1.j, q2*q1.k -- Oooo look, it's the other way around, snazzy :P

        )
    elseif q1.type == "quaternion" and q2.type == "quaternion" then     -- Ok so we have two quats being multiplied, now for the shitstorm.

        return newQuat(

            -- Multiplication is done by splitting a Quat into it's scalar and vector, then multiplying separately.

            -- Which results in this utter mess :P
            (q1.w * q2.w) - (q1.i * q2.i) - (q1.j * q2.j) - (q1.j * q2.k), --w
            (q1.w * q2.i) + (q1.i * q2.w) + (q1.j * q2.k) - (q1.j * q2.j), --i
            (q1.w * q2.j) + (q1.j * q2.w) + (q1.j * q2.i) - (q1.i * q2.k), --j
            (q1.w * q2.k) + (q1.j * q2.w) + (q1.i * q2.j) - (q1.j * q2.i)  --k


        )
    end

end

function quat:__div(q1,q2)          -- FINE I added it ok?

    if type(q1) == "number" then
        return newQuat(

            q2.w/q1, q2.i/q1, q2.j/q1, q2.k/q1  -- Lol scalars

        )
    elseif type(q2) == "number" then
        return newQuat(

            q1.w/q2, q1.i/q2, g1.j/q2, g1.k/q2

        )
    elseif q1.type == "quaternion" and q2.type == "quaternion" then -- Yay Quat division, my fav

        local l = self:getNormSq()

        return newQuat(
            ( op1.r * op2.r + op1.i * op2.i + op1.j * op2.j + op1.k * op2.k)/l,
            (-op1.r * op2.i + op1.i * op2.r - op1.j * op2.k + op1.k * op2.j)/l,
            (-op1.r * op2.j + op1.j * op2.r - op1.k * op2.i + op1.i * op2.k)/l,
            (-op1.r * op2.k + op1.k * op2.r - op1.i * op2.j + op1.j * op2.i)/l
        )
    end
end

--=============== Just some more methods now i'm afraid ==============--


-- Complex Conjugate (Ensure Quat is of unit length)
function quat:conj()
    return newQuat(self.w, -self.i, -self.j, -self.k)
end

function quat:getNormSq()
    return (self.w*self.w) + (self.i*self.i) + (self.j*self.j) + (self.k*self.k)
end

function quat:getNorm() -- Do i really need to make this?
    return math.sqrt(self:getNormSq())
end

function quat:normalise() --Standard

    local mag = self:getNorm()
    self.w = self.w/mag
    self.i = self.i/mag
    self.j = self.j/mag
    self.k = self.k/mag

    return true

end

function quat:fromEuler(p,y,r) -- should make a quat from a euler angle. Just make a zero quat, (0,0,0,0) then run this on it with your angles.

    local p = toRadians(p)
    local y = toRadians(y)
    local r = toRadians(r)

    self.w = cos(r) * cos(p) * cos(y) + sin(r) * sin(p) * sin(y)

    self.i = sin(r) * cos(p) * cos(y) - cos(r) * sin(p) * sin(y)
    self.j = cos(r) * sin(p) * cos(y) + sin(r) * cos(p) * sin(y)
    self.k = cos(r) * cos(p) * sin(y) - sin(r) * sin(p) * cos(y)

    self:normalise() -- Normalise ourselves because why the fuck not?

end




-- Because fuck garry
function quat:toVec()
    return Vector(self.i,self.j,self.k)
end

function quat:toAngle()

    -- TODO: Some shit that makes this into nice Euler Angles :s Here comes Trig

end

function quat:dot(q2)
    local q1 = {self.w, self.i,self.j,self.k}
    local ret = 0
    for i = 1, #q1 do
        ret = ret + q1[i] * q2[i]
    end
    return ret

end

--=============== Linear Interpolation Bitches!!! ==============--

function quat:lerp(q1,q2,smoothJazz)

    local smoothJazz = math.Clamp(smoothJazz,0,1) -- Don't even think about using a percentage outside these bounds.
    return (q1 + smoothJazz*(q2 - q1)) --Standard lerp here, unsure how those quat operations will go though :/ Least scalar mult is covered

end

--=============== Normalised Linear Interpolation Bitches!!! ==============--

function quat:nlerp(q1,q2,smoothJazz)   -- This just normalises the return of lerp, is non-constant velocity, less intensive than slerp.

    local qr = self:lerp(q1,q2,smoothJazz)
    local qrn = qr:normalise()
    return qrn


end



--=============== Spherical Linear Interpolation Bitches!!! ==============--

function quat:slerp(q1,q2,smoothJazz)

    -- Protip: If they aren't unit vectors by this point, you should just leave

    if not q1.type or not q2.type or q1.type ~= "quaternion" or q2.type ~= "quaternion" or type(smoothJazz) ~= "number" then return false end

    local dotProd = q1:dot(q2) --Snazzy dot product. think dot(start,end)

    if dotProd > 0.9995 then -- Too close for my liking, we'll just lerp these :P
        self:lerp(q1,q2,smoothJazz)
    else
        math.Clamp(dotProd,-1,1) -- Clamp to within bounds of acos()
        local omega = acos(dotProd) -- we might get away with just plonking this in the line below as omega isn't really needed.
        local theta = smoothJazz*omega -- This will get the angle between start and said percentage point
        --Ok guess we have to slerp now :P

        local relV = q2 - q1*dotProd -- Don't ask

        relV:normalise() -- This should be a quat anyway, all it is is quat minus quat which is mult by a scalar

        return ((q1*cos(theta)) + (relV*sin(theta)))


    end


end
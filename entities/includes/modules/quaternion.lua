--
--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 03/01/13
-- Time: 17:24
-- To change this template use File | Settings | File Templates.
--

-- Quaternion Lua module for 4D Vector Mathematics by Radon (http://github.jom/awilliamson)
-- Big Thanks to the WireMod Team and Colonel Thirty Two for their Quaternion Support and code as a reference when making this.
-- Thanks to http://content.gpwiki.org/index.php/OpenGL:Tutorials:Using_Quaternions_to_represent_rotation for the formulas and clear layout to help me build these functions.
-- Big thanks to http://www.euclideanspace.com for their insightful pdfs on the topic.

-- Local makes it faster :D
local math = math
local setmetatable = setmetatable
local type = type
local string = string
local Vector = Vector
local Angle = Angle

local ipairs = ipairs
local pcall = pcall

local sin = math.sin
local cos = math.cos
local acos = math.acos
local asin = math.asin
local atan2 = math.atan2
local abs = math.abs
local sqrt = math.sqrt
local rad = math.rad
local deg = math.deg
local nlog = math.log
local exp = math.exp

local setmetatable = setmetatable

local print = MsgN

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

--local math = math   -- Why is this even here?
--local setmetatable = setmetatable

function newQuat( w, i, j, k )     --Generic Builder

    local status, err = pcall( function()

		if type(w) == "Entity" then
			local ent = w

			local ang = ent:GetAngles()
			local p, y, r = ang.p, ang.y, ang.r
			p = toRadians(p*0.5)
			y = toRadians(y*0.5)
			r = toRadians(r*0.5)
			return newQuat(cos(y), 0, 0, sin(y) )*(newQuat(cos(p), 0, sin(p), 0) * newQuat(cos(r), sin(r), 0, 0)  )
			--[[local qr = newQuat(cos(r), sin(r), 0, 0)
			local qp = newQuat(cos(p), 0, sin(p), 0)
			local qy = newQuat(cos(y), 0, 0, sin(y) )
			local pr = qp*qr
			return qy*pr     ]]
		end

		if type(w) == "Angle" then
			local ang = w
			local p, y, r = ang[1], ang[2], ang[3]
			p = toRadians(p*0.5)
			y = toRadians(y*0.5)
			r = toRadians(r*0.5)
			local qr = quaternion.newQuat(cos(r), sin(r), 0, 0)
			local qp = quaternion.newQuat(cos(p), 0, sin(p), 0)
			local qy = quaternion.newQuat(cos(y), 0, 0, sin(y) )
			local pr = qp*qr
			local qpr = qy*pr
			w,i,j,k = qpr.w,qpr.i,qpr.j,qpr.k
		end


        if type(i) == "Vector" then
            i,j,k = i.x,i.y,i.z
        else
            for k,v in ipairs({w,i,j,k}) do
                if type(v) ~= "number" then error("One of the arguements was not a number") end
            end
        end

        local q = setmetatable({},quat) --inherit quat methods and metamethods
        q.w = w or 1
        q.i = i or 0
        q.j = j or 0
        q.k = k or 0
        return q

    end )

    if status == false and err then
        print(err)
    elseif status == true and err then
        return err
    end

end

-- Constructor
function create(w, i, j, k)
    return newQuat(w,i,j,k)
end

function rotationVector(q)

	local l2 = q:getNormSq()
	local m2 = math.max( q.i*q.i + q.j*q.j + q.k*q.k, 0 )
	if l2 == 0 or m2 == 0 then return { 0, 0, 0 } end
	local s = toDegrees(2 * acos( math.Clamp( q.i / sqrt(l2), -1, 1 ) ) )
	if s > 180 then s = s - 360 end
	s = s / sqrt(m2)
	return { q.i * s, q.j * s, q.k * s }
end


--========= Now for some operator metamethods =========--

-- Unary Minus
function quat:__unm()
    return newQuat(-self.w,-self.i,-self.j,-self.k) -- You know this is the exact same quat right?
end

function quat.__add( q1, q2 )
    if type( q1) == "number" then
        return newQuat( q1+q2.w, q2.i, q2.j, q2.k )
    elseif type( q2 ) == "number" then
        return newQuat( q1.w+q2, q1.i, q1.j, q1.k )
    else
        return newQuat( q1.w+q2.w, q1.i+q2.i, q1.j+q2.j, q1.k+q2.k )
    end
end

function quat.__sub( q1, q2 )
    if type( q1) == "number" then
        return newQuat( q1-q2.w, q2.i, q2.j, q2.k )
    elseif type( q2 ) == "number" then
        return newQuat( q1.w-q2, q1.i, q1.j, q1.k )
    else
        return newQuat( q1.w-q2.w, q1.i-q2.i, q1.j-q2.j, q1.k-q2.k )
    end
end

function quat:__tostring()
    return string.format("(%f+%fi+%fj+%fk)",self.w,self.i,self.j,self.k)
end

-- Multiplying q1 with q2 applies the rotation q2 to q1
function quat.__mul(q1,q2)

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
            (q1.w * q2.w) - (q1.i * q2.i) - (q1.j * q2.j) - (q1.k * q2.k), --w
            (q1.w * q2.i) + (q1.i * q2.w) + (q1.j * q2.k) - (q1.k * q2.j), --i
            (q1.w * q2.j) + (q1.j * q2.w) + (q1.k * q2.i) - (q1.i * q2.k), --j
            (q1.w * q2.k) + (q1.k * q2.w) + (q1.i * q2.j) - (q1.j * q2.i)  --k


        )
    end

end

function quat.__div(q1,q2)          -- FINE I added it ok?

    if type(q1) == "number" then
        return newQuat(

            q2.w/q1, q2.i/q1, q2.j/q1, q2.k/q1  -- Lol scalars

        )
    elseif type(q2) == "number" then
        return newQuat(

            q1.w/q2, q1.i/q2, q1.j/q2, q1.k/q2

        )
    elseif q1 and q2 and q1.type == "quaternion" and q2.type == "quaternion" then -- Yay Quat division, my fav

		local lhs1, lhs2, lhs3, lhs4 = q1.w,q1.i,q1.j,q1.k
		local rhs1, rhs2, rhs3, rhs4 = q2.w,q2.i,q2.j,q2.k
		local l = rhs1*rhs1 + rhs2*rhs2 + rhs3*rhs3 + rhs4*rhs4
		return newQuat(
			( lhs1 * rhs1 + lhs2 * rhs2 + lhs3 * rhs3 + lhs4 * rhs4)/l,
			(-lhs1 * rhs2 + lhs2 * rhs1 - lhs3 * rhs4 + lhs4 * rhs3)/l,
			(-lhs1 * rhs3 + lhs3 * rhs1 - lhs4 * rhs2 + lhs2 * rhs4)/l,
			(-lhs1 * rhs4 + lhs4 * rhs1 - lhs2 * rhs3 + lhs3 * rhs2)/l
		)

		--[[local rtn =  q1*q2:conj()
		return rtn      ]]

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

    return self

end

function quat:fromEuler(p,y,r) -- should make a quat from a euler angle. Just make a zero quat, (0,0,0,0) then run this on it with your angles.
	--[[
    local p = toRadians(p)  /2
    local y = toRadians(y)  /2
    local r = toRadians(r)  /2

    local sinp,cosp = sin(p),cos(p)
    local siny,cosy = sin(y),cos(y)
    local sinr,cosr = sin(r),cos(r)

    local qr = newQuat(cosr,sinr,0,0) --Three quaternions representing each rotation
    local qp = newQuat(cosp,0,sinp,0)
    local qy = newQuat(cosy,0,0,siny)
    local q = qy*(qp*qr)   -- Smash them together

    self.w = q.w        -- Assign the components
    self.i = q.i
    self.j = q.j
    self.k = q.k

    self:normalise() -- Normalise ourselves because why not?

    return self  -- Return self so we can chain :D eg, q:fromEuler(p,y,r):toVec()  ]]


	local RAD = math.pi/180

	local hPhi = (r * RAD) / 2;
	local hTheta  = (y * RAD) / 2;
	local hPsi = (p * RAD) / 2;

	local sin_hPhi = math.sin(  hPhi)
	local cos_hPhi = math.cos(  hPhi)
	local sin_hTheta = math.sin(hTheta)
	local cos_hTheta = math.cos(hTheta)
	local sin_hPsi = math.sin(  hPsi)
	local cos_hPsi = math.cos(  hPsi)

	self.w = cos_hPhi * cos_hTheta * cos_hPsi + sin_hPhi * sin_hTheta * sin_hPsi
	self.i = sin_hPhi * cos_hTheta * cos_hPsi - cos_hPhi * sin_hTheta * sin_hPsi
	self.j = cos_hPhi * sin_hTheta * cos_hPsi + sin_hPhi * cos_hTheta * sin_hPsi
	self.k = cos_hPhi * cos_hTheta * sin_hPsi - sin_hPhi * sin_hTheta * cos_hPsi

	return self

end

function quat:toVec()
    return {self.i,self.j,self.k} -- Because you can do horrible Vector stuff
end

function quat:toAngle()
	--[[
    --local q = self:normalise()

	local q = self

	local sqw = q.w * q.w
	local sqx = q.i * q.i
	local sqy = q.j * q.j
	local sqz = q.k * q.k

	local unit = sqx + sqy + sqz + sqw
    local test = q.i*q.j - q.k*q.w

    if (test > 0.499 * unit) then -- singularity at north pole
        --local heading = 2 * atan2(q.i,q.w)
		local heading = 2 * atan2(q.w, q.i)
        local attitude = math.pi/2
        local bank = math.pi
        return {toDegrees(attitude),toDegrees(heading),toDegrees(bank)}

    elseif (test < -0.499 * unit) then-- singularity at south pole
        --local heading = atan2(q.i,q.w) *-2
		local heading = atan2(q.w, q.i) *-2
        local attitude = (math.pi*-1)/2
        local bank = math.pi
        return {toDegrees(attitude),toDegrees(heading),toDegrees(bank)}
    else

        local sqx = q.i*q.i
        local sqy = q.j*q.j
        local sqz = q.k*q.k
        --local heading = atan2(2*q.j*q.w-2*q.i*q.k , sqx - sqy - sqz + sqw)
        --local attitude = asin(2*test/unit)
        --local bank = atan2(2*q.i*q.w-2*q.j*q.k , -sqx + sqy - sqz + sqw)

		local heading = atan2(  2 * (q.w * q.k + q.i * q.j) , 1 - 2 * (sqy + sqz) )

		local attitude = asin(  2 *  test )

		local bank = atan2(  2 * (q.w * q.i + q.j * q.k) , 1 - 2 * (sqx + sqy) )

        return {toDegrees(attitude),toDegrees(heading),toDegrees(bank)}

    end       ]]

	local q = self

	local sqw = q.w * q.w
	local sqx = q.i * q.i
	local sqy = q.j * q.j
	local sqz = q.k * q.k

	local unit = sqx + sqy + sqz + sqw

	if unit == 0 then return {0,0,0} end
	local q1, q2, q3, q4 = q.w/unit, q.i/unit, q.j/unit, q.k/unit

	local x = Vector(q1*q1 + q2*q2 - q3*q3 - q4*q4,
		2*q3*q2 + 2*q4*q1,
		2*q4*q2 - 2*q3*q1)

	local y = Vector(2*q2*q3 - 2*q4*q1,
		q1*q1 - q2*q2 + q3*q3 - q4*q4,
		2*q2*q1 + 2*q3*q4)

	local ang = x:Angle()
	if ang.p > 180 then ang.p = ang.p - 360 end
	if ang.y > 180 then ang.y = ang.y - 360 end

	local yyaw = Vector(0,1,0)
	yyaw:Rotate(Angle(0,ang.y,0))

	local roll = toDegrees( acos(math.Clamp(y:Dot(yyaw), -1, 1)) )

	local dot = q2*q1 + q3*q4
	if dot < 0 then roll = -roll end

	return {ang.p, ang.y, roll}


end

function quat:dot(q2)
    return self.i * q2.i + self.j * q2.j + self.k * q2.k + self.w * q2.w
end

--=============== Linear Interpolation Bitches!!! ==============--

function lerp(q1,q2,smoothJazz)

    local smoothJazz = math.Clamp(smoothJazz,0,1) -- Don't even think about using a percentage outside these bounds.
    return (q1 + smoothJazz*(q2 - q1)) --Standard lerp here, unsure how those quat operations will go though :/ Least scalar mult is covered

end

--=============== Normalised Linear Interpolation Bitches!!! ==============--

nlerp = function(q1,q2,smoothJazz)   -- This just normalises the return of lerp, is non-constant velocity, less intensive than slerp.

    local qr = lerp(q1,q2,smoothJazz)
    local qrn = qr:normalise()
    return qrn


end



--=============== Spherical Linear Interpolation Bitches!!! ==============--

function slerp(q1,q2,smoothJazz)

    -- Protip: If they aren't unit vectors by this point, you should just leave
    if not q1.type or not q2.type or q1.type ~= "quaternion" or q2.type ~= "quaternion" or type(smoothJazz) ~= "number" then return false end

    local q1 = q1:normalise()
    local q2 = q2:normalise()

    local dotProd = q1:dot(q2) --Snazzy dot product. think dot(start,end)

    if dotProd > 0.9995 then -- Too close for my liking, we'll just lerp these :P
        lerp(q1,q2,smoothJazz)
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


--==== Some right forward up stuf ====

function quat:right()

	local this1, this2, this3, this4 = self.w, self.i, self.j, self.k
	local t2, t3, t4 = this2 * 2, this3 * 2, this4 * 2
	return Vector(
		t4 * this1 - t2 * this3,
		this2 * this2 - this1 * this1 + this4 * this4 - this3 * this3,
		- t2 * this1 - t3 * this4
	)

end

function quat:up()

	local this1, this2, this3, this4 = self.w, self.i, self.j, self.k
	local t2, t3, t4 = this2 * 2, this3 * 2, this4 * 2
	return Vector(
		t3 * this1 + t2 * this4,
		t3 * this4 - t2 * this1,
		this1 * this1 - this2 * this2 - this3 * this3 + this4 * this4
	)

end

function quat:forward()

	local this1, this2, this3, this4 = self.w, self.i, self.j, self.k
	local t2, t3, t4 = this2 * 2, this3 * 2, this4 * 2
	return Vector(
		this1 * this1 + this2 * this2 - this3 * this3 - this4 * this4,
		t3 * this2 + t4 * this1,
		t4 * this2 - t3 * this1
	)

end

function qRotation(axis, ang)

	local ax = Vector(axis[1], axis[2], axis[3])
	ax:Normalize()
	local ang2 = toRadians(ang*0.5)
	return newQuat( cos(ang2), ax.x*sin(ang2), ax.y*sin(ang2), ax.z*sin(ang2) )

end


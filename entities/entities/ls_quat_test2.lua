--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 07/03/13
-- Time: 23:22
-- To change this template use File | Settings | File Templates.
--

AddCSLuaFile()

DEFINE_BASECLASS("base_anim")

ENT.PrintName = "LS Quaternion Test 2"
ENT.Author = "Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminOnly = false

local sb = sb
require('quaternion')



function ENT:Initialize()
	if SERVER then

		self.NoGrav = true
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self.Entity:SetUseType(SIMPLE_USE)

		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:EnableGravity(false)
		end


	end
end

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("ls_quat_test2")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/props_lab/monitor01a.mdl")
	ent:Spawn()

	if ply:IsPlayer() then ent.owner = ply end

	return ent
end

function ENT:applyTorque(torque)

	if torque[1] == 0 and torque[2] == 0 and torque[3] == 0 then return end

	local phys = self:GetPhysicsObject()

	local tq = Vector(torque[1], torque[2], torque[3])
	local torqueamount = tq:Length()

	-- Convert torque from local to world axis
	tq = phys:LocalToWorld(tq) - phys:GetPos()

	-- Find two vectors perpendicular to the torque axis
	local off
	if math.abs(tq.x) > torqueamount * 0.1 or math.abs(tq.z) > torqueamount * 0.1 then
		off = Vector(-tq.z, 0, tq.x)
	else
		off = Vector(-tq.y, tq.x, 0)
	end
	off = off:GetNormal() * torqueamount * 0.5

	local dir = (tq:Cross(off)):GetNormal()

	phys:ApplyForceOffset(dir, off)
	phys:ApplyForceOffset(dir * -1, off * -1)
end

function ENT:Think()

	local ang = self:GetAngles()
	local curr = quaternion.create(ang.p, ang.y, ang.r):normalise()

	if self.active == true then

		local phys = self:GetPhysicsObject()

		self.currquat = quaternion.create(self)
		self.targquat = quaternion.create(self)

		local currquat = quaternion.create(self)
		local targquat = quaternion.create(self)

		local mods = {

			pitch = ( self.owner:KeyDown( KEY_W ) and 1 or 0 ),
			yaw = ( self.owner:KeyDown( KEY_D ) and 1 or 0 ),
			roll = ( self.owner:KeyDown( KEY_R ) and 1 or 0 )

		}

		--- TODO make this clientside and use input.IsKeyDown for the KEY_S enum types, serverside KeyDown are things like grenade and m1 m2 etc.
		if self.owner:KeyDown( KEY_S ) then mods.pitch = mods.pitch - ( self.owner:KeyDown( KEY_S ) and 1 or 0 )
		elseif self.owner:KeyDown( KEY_A ) then mods.yaw = mods.yaw - ( self.owner:KeyDown( KEY_A ) and 1 or 0 )
		elseif self.owner:KeyDown( KEY_F ) then mods.roll = mods.roll - ( self.owner:KeyDown( KEY_F ) and 1 or 0 )
		end

		local pQuat = quaternion.qRotation( targquat:right(), mods.pitch * 0.05 )
		local yQuat = quaternion.qRotation( targquat:up(), mods.yaw * 0.05 )
		local rQuat = quaternion.qRotation( targquat:forward(), mods.roll * 0.05 )

		PrintTable(mods)

		targquat = ( pQuat * yQuat * rQuat ) * targquat

		local resQuat = targquat/currquat

		local rv = quaternion.rotationVector(resQuat)
		local Tq = phys:WorldToLocal( Vector( rv[1], rv[2], rv[3] ) + phys:GetPos() )
		local Force = (Tq - phys:GetAngleVelocity()*0.05)*phys:GetInertia()

		if mods.pitch ~= 0 and mods.yaw ~= 0 and mods.roll ~= 0 then

			self:applyTorque(Force)

		else

			self:applyTorque(-Force)

		end


	end
end

function ENT:Use()

	self:GetPhysicsObject():SetMass(5000)
	self.active = true
	self.smoothJazz = 0

end
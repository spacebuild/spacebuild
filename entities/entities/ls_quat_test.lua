--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 07/03/13
-- Time: 23:22
-- To change this template use File | Settings | File Templates.
--

AddCSLuaFile()

DEFINE_BASECLASS("base_anim")

ENT.PrintName = "LS Quaternion Test"
ENT.Author = "Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminOnly = false

local sb = sb



require('quaternion')


if SERVER then
	function ENT:Initialize()
		if SERVER then
			self.NoGrav = true
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
			self.Entity:SetUseType(SIMPLE_USE)
			self.smoothJazz = 0
			self.active = false
			self.targquat = quaternion.create(90, 0, 0):normalise()
			local ang = self:GetAngles()
			self.currquat = quaternion.create(ang.p, ang.y, ang.r):normalise()

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

		local ent = ents.Create("ls_quat_test")
		ent:SetPos(tr.HitPos + Vector(0, 0, 50))
		ent:SetModel("models/props_lab/monitor01a.mdl")
		ent:Spawn()

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

		if curr:normalise() ~= self.targquat:normalise() and self.active == true then

			local phys = self:GetPhysicsObject()

			self.currquat = quaternion.create(self)
			self.targquat = quaternion.create(self)

			local currquat = quaternion.create(self)
			local targquat = quaternion.create(self)


			local pQuat = quaternion.qRotation( targquat:right(), 0.05 )
			local yQuat = quaternion.qRotation( targquat:right(), 0 )
			local rQuat = quaternion.qRotation( targquat:right(), 0 )

			targquat = ( pQuat * yQuat * rQuat ) * targquat

			local resQuat = targquat/currquat

			--local resQuat = quaternion.lerp(currquat, targquat, self.smoothJazz):normalise()

			--local AQuatAng = resQuat:toAngle()
			--[[local AQuatAng = resQuat:normalise():toAngle()
			local p, y, r = AQuatAng[1], AQuatAng[2], AQuatAng[3]

			if p ~= p or y ~= y or r ~= r then return end -- Best first 3 thinks produce nan for p,y and r. NaN is the only thing that x ~= x :D

			local velociraptor = phys:GetVelocity()
			phys:SetAngles(Angle(p, y, r))

			phys:SetVelocity(velociraptor) -- Correct for setAngles stopping velocity
			phys:AddAngleVelocity(-phys:GetAngleVelocity()) -- Negate any angular velocity from before the setAngles

			if self.smoothJazz < 1 then
				self.smoothJazz = self.smoothJazz + 0.01
			end
                       ]]

			--self:NextThink(CurTime() + 1)

			local rv = quaternion.rotationVector(resQuat)
			local Tq = phys:WorldToLocal( Vector( rv[1], rv[2], rv[3] ) + phys:GetPos() )
			local Force = (Tq - phys:GetAngleVelocity()*0.05)*phys:GetInertia()

			--print("Type:",type(Force))

			self:applyTorque(Force)

		end
	end

	function ENT:Use()

		print(self:GetPhysicsObject():GetAngles())
		local ang = self:GetAngles()
		self:GetPhysicsObject():SetMass(5000)
		self.currquat = quaternion.create(ang.p, ang.y, ang.r):normalise()
		self.active = true
		self.smoothJazz = 0
	end
end


AddCSLuaFile()

DEFINE_BASECLASS("base_resource_generator")

ENT.PrintName = "Energy Generator"
ENT.Author = "SnakeSVx & Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:Initialize()
	BaseClass.Initialize(self)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		self.rdobject:addResource("energy", 0, 0)
		self.energygen = 8
		self.active = true
	end
end

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_generator_energy")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/props_phx/life_support/panel_medium.mdl")
	ent:Spawn()

	return ent
end

function ENT:SetActive() --disable use, lol
end

if SERVER then

	function ENT:getBlocked(up, sun)

		local trace = {}
		local util = util
		local up = up or self:GetAngles():Up() or nil
		local sun = sun or GAMEMODE:getSun() or nil

		if up == nil or sun == nil then return true end

		if sun ~= nil then
			trace = util.QuickTrace(sun:getPos(), self:GetPos() - sun:getPos(), nil) -- Don't filter
			if trace.Hit and trace.Entity == self then
				return false
			else
				return true
			end
		else
			local sunAngle = Vector(0, 0, -1)

			local n = sunAngle:DotProduct(up * -1)
			if n > 0 then
				return true
			end
		end

		return false
	end

	function ENT:getRate()

		local up = self:GetAngles():Up()
		local sun = GAMEMODE:getSun() or nil

		local sunAngle = Vector(0, 0, -1)

		if sun ~= nil then
			sunAngle = (self:GetPos() - sun:getPos()) -- DO NOT ADD :Normalize() BECOMES NIL!
			sunAngle:Normalize() --Normalising doesn't work normally for some reason, hack implemented.
		end

		local n = sunAngle:DotProduct(up * -1)

		if n >= 0 and not self:getBlocked(up, sun) then
			return math.Round(self.energygen * n)
		else return 0
		end
	end

	function ENT:Think()

		if self:WaterLevel() > 0 then
			self.active = false
		else
			self.active = true
		end

		if self.active then
			self.rdobject:supplyResource("energy", self:getRate() or 0)
		end

		self:NextThink(CurTime() + 1)
		return true
	end
end



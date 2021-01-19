AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
-- Order is important, see https://github.com/Facepunch/garrysmod/blob/0ec74aab0858807677180bfde8bb0e109c3544cf/garrysmod/lua/includes/modules/baseclass.lua#L34
local BaseBaseClass = baseclass.Get("base_sb_environment")
DEFINE_BASECLASS("base_sb_star1")

function ENT:Initialize()
	BaseClass.Initialize(self, true)
end

function ENT:GetTemperature(ent)
	if not ent then return end
	self:TryApplyPlayerDamage(ent)
	local dist = pos:Distance(self:GetPos())
	local size = self:GetSize()
	if dist < size / 6 then return self.sbenvironment.temperature end
	if dist < size * 1 / 3 then return self.sbenvironment.temperature2 end
	if dist < size * 1 / 2 then return self.sbenvironment.temperature3 end
	if dist < size * 2 / 3 then return self.sbenvironment.temperature3 / 2 end
	if self.sbenvironment.temperature3 / 4 <= 14 then return 14 end --Check that it isn't colder then Space, else return Space temperature
	--All other checks failed, player is the farest away from the star, but temp is still warmer then space, return that temperature

	return self.sbenvironment.temperature3 / 4
end

function ENT:GetPriority()
	return 2
end

function ENT:CreateEnvironment(radius, temp1, temp2, temp3, name)
	if radius and type(radius) == "number" then
		if radius < 0 then
			radius = 0
		end

		self.sbenvironment.size = radius
	end

	if temp2 and type(temp2) == "number" then
		if temp2 < 0 then
			temp2 = 0
		end

		self.sbenvironment.temperature2 = temp2
	end

	if temp3 and type(temp3) == "number" then
		if temp3 < 0 then
			temp3 = 0
		end

		self.sbenvironment.temperature3 = temp3
	end

	BaseBaseClass.CreateEnvironment(self, 0, 100, temp1, 0, 0, 100, 0, name)
	self:SendSunBeam()
end

function ENT:UpdateEnvironment(radius, temp1, temp2, temp3)
	if radius and type(radius) == "number" then
		self:UpdateSize(self.sbenvironment.size, radius)
	end

	if temp1 and type(temp1) == "number" then
		self.sbenvironment.temperature = temp1
	end

	if temp2 and type(temp2) == "number" then
		self.sbenvironment.temperature2 = temp2
	end

	if temp3 and type(temp3) == "number" then
		self.sbenvironment.temperature3 = temp3
	end

	self:SendSunBeam()
end
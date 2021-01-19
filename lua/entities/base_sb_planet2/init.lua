AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
require("caf_util")
-- Order is important, see https://github.com/Facepunch/garrysmod/blob/0ec74aab0858807677180bfde8bb0e109c3544cf/garrysmod/lua/includes/modules/baseclass.lua#L34
local BaseBaseClass = baseclass.Get("base_sb_environment")
DEFINE_BASECLASS("base_sb_planet1")

function ENT:Initialize()
	BaseClass.Initialize(self, true)
end

function ENT:SetFlags(flags)
	if not flags or type(flags) ~= "number" then return end
	self.sbenvironment.unstable = caf_util.isBitSet(flags, 1)
	self.sbenvironment.sunburn = caf_util.isBitSet(flags, 2)
end

function ENT:CreateEnvironment(radius, gravity, atmosphere, pressure, temperature, temperature2, o2, co2, n, h, flags, name)
	self:SetFlags(flags)

	--set Radius if one is given
	if radius and type(radius) == "number" then
		if radius < 0 then
			radius = 0
		end

		self.sbenvironment.size = radius
	end

	--set temperature2 if given
	if temperature2 and type(temperature2) == "number" then
		self.sbenvironment.temperature2 = temperature2
	end

	BaseBaseClass.CreateEnvironment(self, gravity, atmosphere, pressure, temperature, o2, co2, n, h, name)
end
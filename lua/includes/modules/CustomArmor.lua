--=============================================================================--
-- 			Addon: CAF
-- 			Author: SnakeSVx
--			Version: 0.1
--
--
--=============================================================================--

local table 	= table
local setmetatable 	= setmetatable
local type = type
local tostring = tostring
local ErrorNoHalt = ErrorNoHalt
local IsValid = IsValid
local pairs = pairs

module( "CustomArmor" )

local list = {}
list.__index = list

function list:Create()
	self.armor = 0;
	self.muls = {}
end

--[[
	Add multiplier for a certain armor type
	@param type
	@param amount

]]
function list:setArmorMultiplier(damtype, amount)
	self.muls[damtype] = amount
	self.canreceivedamage = true;
end

--[[
	Return the multiplier done for the certain Armortype

]]
function list:GetArmormultiplier(damtype)
	return self.muls[damtype] or 0
end

function list:SetArmor(amount)
	self.armor = amount
end

function list:GetArmor()
	return self.armor or 0
end

---------------------------------------------------------

--[[
	Create,
]]
function Create()
	tmp = {}
	setmetatable( tmp, list )
	tmp:Create()
	return tmp
end




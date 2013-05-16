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

module( "CustomAttack" )

local list = {}
list.__index = list

function list:Create( target, weapon, attacker )
	self.target = target
	self.weapon = weapon
	self.attacker = attacker
	self.attacks = {}
	self.piercing = 0;
end

function list:GetTarget()
	return self.target;
end

function list:GetWeaponEntity()
	return self.weapon
end

function list:GetAttacker()
	return self.attacker;
end

--[[
	Add Damage for a certain attack type
	@param type
	@param amount

]]
function list:AddAttack(damtype, amount)
	self.attacks[damtype] = amount
end

list.SetAttack = list.AddAttack

function list:setPiercing(amount)
	self.piercing = amount
end

--[[
	Return the damage done for the certain attack

]]
function list:GetAttack(damtype)
	return self.attacks[damtype] or 0
end

function list:GetPiercing()
	return self.piercing or 0
end

---------------------------------------------------------

--[[
	Create,
	
	Create the Damage OBject
	
	@param target
	@param weapon
	@param Attacker
]]
function Create(target, weapon, attacker)
	tmp = {}
	setmetatable( tmp, list )
	tmp:Create(target, weapon, attacker)
	return tmp
end




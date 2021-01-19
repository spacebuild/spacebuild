AddCSLuaFile("includes/modules/caf_util.lua")
AddCSLuaFile("includes/modules/cache.lua")
require("caf_util")
require("cache")
local meta = FindMetaTable("Entity")

--[[meta.caf = {}
meta.caf.custom = {}
meta.caf.custom.canreceivedamage = true
meta.caf.custom.canreceiveheatdamage = true]]
function meta:getCustomArmor()
	return self.caf.custom.armor
end

function meta:setCustomArmor(armor)
	self.caf.custom.armor = armor
end

function meta:WaterLevel2()
	local waterlevel = self:WaterLevel()

	if (self:GetPhysicsObject():IsValid() and self:GetPhysicsObject():IsMoveable()) then
		--Msg("Normal WaterLEvel\n")
		--this doesn't look like it works when ent is welded to world, or not moveable
		return waterlevel
	else
		--Msg("Special WaterLEvel\n") --Broken in Gmod SVN!!!
		if (waterlevel ~= 0) then return waterlevel end
		local trace = {}
		trace.start = self:GetPos()
		trace.endpos = self:GetPos()

		trace.filter = {self}

		trace.mask = 16432 -- MASK_WATER
		local tr = util.TraceLine(trace)
		if (tr.Hit) then return 3 end
	end

	return 0
end
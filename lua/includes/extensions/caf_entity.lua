--=============================================================================--
-- 			Addon: Custom Addon Framework
-- 			Author: SnakeSVx
--			Version: 1.0
--
--  A really simple module to add some custom checks to entities
--
--=============================================================================--

if CLIENT then Msg("Not on server\n")return end --Only run on the server
local table 	= table
local FindMetaTable 	= FindMetaTable
local pairs = pairs
local Msg			= Msg
local Error			= Error
local tostring = tostring
local math = math
local util = util


module( "caf_entity" )

local ent = FindMetaTable( "Entity" )

function ent:WaterLevel2()
	local waterlevel = self:WaterLevel()
	if (self:GetPhysicsObject():IsValid() and self:GetPhysicsObject():IsMoveable()) then
		--Msg("Normal WaterLEvel\n")
		return waterlevel --this doesn't look like it works when ent is welded to world, or not moveable
	else
		--Msg("Special WaterLEvel\n") --Broken in Gmod SVN!!!
		if (waterlevel ~= 0) then
			return waterlevel
		end
		local trace = {}
		trace.start = self:GetPos()
		trace.endpos = self:GetPos()
		trace.filter = { self }
		trace.mask = 16432 -- MASK_WATER
		local tr = util.TraceLine( trace )
		if (tr.Hit) then
			return 3
		end
	end
	return 0
end







--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ]]

local GM = GM
local u = GM.util
local spawned_entities = {}

local function OnEntitySpawn(ent)
	if not table.HasValue(spawned_entities, ent) then
		table.insert(spawned_entities, ent)
		timer.Simple(0.1, function()
			if GM:onSBMap() and not ent.environment and GM:isValidSBEntity(ent) then
				ent.environment = GM:getSpace()
				GM:getSpace():updateEnvironmentOnEntity(ent)
			end
		end)
	end
end
hook.Add("OnEntityCreated", "SB_OnEntitySpawn", OnEntitySpawn)

function u.getSpawnedEntities()
	return spawned_entities
end

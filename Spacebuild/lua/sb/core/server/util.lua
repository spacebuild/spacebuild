--[[
		Addon: SB core
		Filename: core/server/config.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Server config file

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]

local u = sb.util
local spawned_entities = {}

local function OnEntitySpawn(ent)
	if not table.HasValue(spawned_entities, ent) then
		table.insert( spawned_entities, ent)
	end
end
hook.Add("OnEntitySpawn", "SB_OnEntitySpawn", OnEntitySpawn)

function u.getSpawnedEntities()
	return spawned_entities;
end

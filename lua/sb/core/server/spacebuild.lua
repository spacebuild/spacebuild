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

local sb = sb
local timer = timer
local core = sb.core;
local convars = sb.core.convars
require("class")
local class = class
require("sbnet")
local net = sbnet

local time_to_next_rd_sync = 1
local time_to_next_ls_sync = 0.2
local time_to_next_ls_env = 1
local time_to_next_sb_sync = 3

local time = 0;

local function AllowAdminNoclip(ply)
	if (ply:IsAdmin() or ply:IsSuperAdmin()) and convars.sb_adminspacenoclip.get() then return true end
	if ply:IsSuperAdmin() and convars.sb_superadminspacenoclip.get() then return true end
	return false
end

--- Players can't get damaged in a jeep, so kick them out
-- TODO filter for jeep entity!!
-- @param ply
--
local function JeepFix(ply)
	if ply:InVehicle() then --Kick them out of the vehicle first
		ply:ExitVehicle()
	end
end

--- Prevent players from noclipping in space if isn't not allowed
-- @param ply
--
local function NoClipCheck(ply)
	if sb.onSBMap() and ply.environment and ply.environment == sb.getSpace() and convars.sb_noclip.get() and not AllowAdminNoclip(ply) and convars.sb_planetnocliponly.get() and ply:GetMoveType() == MOVETYPE_NOCLIP then -- Now set their movetype to walk if in noclip and only admins allowed noclip.
		ply:SetMoveType(MOVETYPE_WALK)
	end
end

local function sbThink()
	time = CurTime();
	for _, ply in pairs(player.GetAll()) do
		-- RD
		if not ply.lastrdupdate or ply.lastrdupdate + time_to_next_rd_sync < time then
			for k, v in pairs(core.device_table) do
				v:send(ply.lastrdupdate or 0, ply)
			end
			ply.lastrdupdate = time
		end
		-- SB
		if not ply.lastsbupdate or ply.lastsbupdate + time_to_next_sb_sync < time then
			if ply.lastsbupdate then
				for k, v in pairs(core.device_table) do
					v:send(ply.lastsbupdate or 0, ply)
				end
				for _, v in pairs(core.mod_tables) do
					for _, w in pairs(v) do
						w:send(ply.lastsbupdate or 0, ply)
					end
				end
				for _, v in pairs(core.environments) do
					v:send(ply.lastsbupdate or 0, ply)
				end
				ply.lastsbupdate = time
			else
				ply.lastsbupdate = (-time_to_next_sb_sync)
			end
		end
		-- Noclip from planets check?
		if ply.environment and ply.environment == sb.getSpace() and ply:Alive() then --Generic check to see if we can get space and they're alive.
			JeepFix(ply)
			NoClipCheck(ply)
		end
		--LS
		if not ply.lastlsEnvupdate or ply.lastlsEnvupdate + time_to_next_ls_env < time then
			if ply.ls_suit then
				ply.ls_suit:processEnvironment()
				ply.lastlsEnvupdate = time
			end
		end
		if not ply.lastlsupdate or ply.lastlsupdate + time_to_next_ls_sync < time then
			if ply.ls_suit --[[and ply:Alive()]] then
				ply.ls_suit:send(ply.lastlsupdate or 0)
				ply.lastlsupdate = time
			end
		end
	end
end

hook.Add("Think", "spacebuild_think", sbThink)

local to_sync
net.Receive("SBRU", function(bitsreceived, ply)
	local syncid = net.readShort()
	to_sync = core.device_table[syncid]
	to_sync:send(0, ply) -- Send fully to client on request :)
end)

local function spawn(ply)
	if not ply.ls_suit or not ply.ls_suit.reset then
		ply.ls_suit = class.new("PlayerSuit", ply)
	end
	ply.ls_suit:reset()

	if sb.onSBMap() and ply:Team() ~= TEAM_SPECTATOR then
		timer.Simple(5, function()
			if ply.ls_suit.environment == nil then
				ply.ls_suit:setEnvironment(sb.getSpace())
			end
		end)
	end
end

local function initial_spawn(ply)
	if not ply.ls_suit or not ply.ls_suit.reset then
		ply.ls_suit = class.new("PlayerSuit", ply)
	end
	ply.ls_suit:reset()
end



hook.Add("PlayerSpawn", "spacebuild_spawn", spawn)
hook.Add("PlayerInitialSpawn", "spacebuild_initial_spawn", initial_spawn)


local function PlayerNoClip(ply)
	return not (sb.onSBMap() and ply.environment and ply.environment == sb.getSpace() and convars.sb_noclip.get() and not AllowAdminNoclip(ply) and convars.sb_planetnocliponly.get())
end

hook.Add("PlayerNoClip", "SB_PlayerNoClip_Check", PlayerNoClip)

-- Spacebuild

local sun = class.new("SunEnvironment", nil)

local function addSun(data)
	MsgN("Spawn Sun")
	--PrintTable(data)
	--TODO spawn sunEntity
	local ent = data.ent
	sun = class.new("SunEnvironment", ent:EntIndex(), data)
	--PrintTable(sun)
end

local function spawnEnvironmentEnt(name, pos, angles)
	local ent = ents.Create(name)
	ent:SetAngles(angles)
	ent:SetPos(pos)
	ent:Spawn()
	return ent
end

local function addLegacyEnvironment(data)
	if data[1] == "planet" or data[1] == "planet2" or data[1] == "star" or data[1] == "star2" then
		local ent = spawnEnvironmentEnt("LegacyPlanet", data.ent:GetPos(), data.ent:GetAngles())
		local environment = class.new("LegacyPlanet", ent:EntIndex(), data)
		ent.envobject = environment
		sb.addEnvironment(environment)
		ent:InitEnvironment()
	elseif data[1] == "planet_color" then
		local colorinfo = class.new("LegacyColorInfo", data)
		sb.addEnvironmentColor(colorinfo)
	elseif data[1] == "planet_bloom" then
		local bloominfo = class.new("LegacyBloomInfo", data)
		sb.addEnvironmentBloom(bloominfo)
	end
end

function sb.getSun()
	return sun
end



local environment_data = {}
local environment_classes = { env_sun = addSun, logic_case = addLegacyEnvironment }

local function getKey(key)
	if key == "Case01" then
		return 1
	elseif key == "Case02" then
		return 2
	elseif key == "Case03" then
		return 3
	elseif key == "Case04" then
		return 4
	elseif key == "Case05" then
		return 5
	elseif key == "Case06" then
		return 6
	elseif key == "Case07" then
		return 7
	elseif key == "Case08" then
		return 8
	elseif key == "Case09" then
		return 9
	elseif key == "Case10" then
		return 10
	elseif key == "Case11" then
		return 11
	elseif key == "Case12" then
		return 12
	elseif key == "Case13" then
		return 13
	elseif key == "Case14" then
		return 14
	elseif key == "Case15" then
		return 15
	elseif key == "Case16" then
		return 16
	else
		return key
	end
end

local function SpawnEnvironments()
	for k, v in pairs(environment_data) do
		environment_classes[v["classname"]](v)
	end
end

local function Register_Environments_Data()
	MsgN("Registering environment info")
	local entities;
	local data
	local values
	for k, _ in pairs(environment_classes) do
		entities = ents.FindByClass(k)
		for _, ent in ipairs(entities) do
			data = { ent = ent }
			values = ent:GetKeyValues()
			for key, value in pairs(values) do
				data[getKey(key)] = value
			end
			table.insert(environment_data, data)
		end
	end
	SpawnEnvironments()
end

hook.Add("InitPostEntity", "sb4_load_data", Register_Environments_Data)


local ignoredClasses = {}
ignoredClasses["func_door"] = true
ignoredClasses["prop_combine_ball"] = true

function sb.isValidSBEntity(ent)
	return IsValid(ent)
			and not ent:IsWorld()
			and IsValid(ent:GetPhysicsObject()) -- only valid physics
			and not ent.NoGrav -- ignore entities that mentioned they want to be ignored
			and not ignoredClasses[ent:GetClass()] -- ignore certain types of entities
end

function sb.registerIgnoredEntityClass(class)
	ignoredClasses[class] = true
end

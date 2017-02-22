--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

--[[ Serverside Custom Addon file Base ]]--
--require("sb_space")

player_manager.AddValidModel( "MedicMarine", "models/player/samzanemesis/MarineMedic.mdl" )
player_manager.AddValidModel( "SpecialMarine", "models/player/samzanemesis/MarineSpecial.mdl" )
player_manager.AddValidModel( "OfficerMarine", "models/player/samzanemesis/MarineOfficer.mdl" )
player_manager.AddValidModel( "TechMarine", "models/player/samzanemesis/MarineTech.mdl" )

util.PrecacheModel( "models/player/samzanemesis/MarineMedic.mdl" )
util.PrecacheModel( "models/player/samzanemesis/MarineSpecial.mdl" )
util.PrecacheModel( "models/player/samzanemesis/MarineOfficer.mdl" )
util.PrecacheModel( "models/player/samzanemesis/MarineTech.mdl" )

local SPACEBUILD = SPACEBUILD
local SB = {}

local status = false

--local NextUpdateTime

SB.Override_PlayerHeatDestroy = 0
SB.Override_EntityHeatDestroy = 0
SB.Override_PressureDamage = 0
SB.PlayerOverride = 0
local volumes = {}

local VolCheckIterations = CreateConVar( "SB_VolumeCheckIterations", "11",{ FCVAR_CHEAT, FCVAR_ARCHIVE } )
local ForceModel = CreateConVar( "SB_Force_Model", "0",{ FCVAR_ARCHIVE } )

local function ForcePlyModel(ply)
	if ForceModel:GetInt() == 1 then
		if not ply.sbmodel then
			local i = math.Rand(0, 4)
			if i <= 1 then
				ply.sbmodel = "models/player/samzanemesis/MarineMedic.mdl"
			elseif i <= 2 then
				ply.sbmodel = "models/player/samzanemesis/MarineSpecial.mdl"
			elseif i <= 3 then 
				ply.sbmodel = "models/player/samzanemesis/MarineOfficer.mdl"
			else --if i <= 4 then
				ply.sbmodel = "models/player/samzanemesis/MarineTech.mdl"
			end
		end
		ply:SetModel(ply.sbmodel )
		return true
	end
end
  
--End Local Stuff


--[[
	The Constructor for this Custom Addon Class
	Required
	Return True if succesfully able to start up this addon
	Return false, the reason of why it wasn't able to start
]]
function SB.__Construct()
	if status then return false , CAF.GetLangVar("This Addon is already Active!") end
	if SPACEBUILD:onSBMap() then
		hook.Add("PlayerSetModel", "SB_Force_Model_Check", ForcePlyModel)
		status = true;
		return true
	end
	return false, CAF.GetLangVar("Not on a Spacebuild Map!")
end

--[[
	The Destructor for this Custom Addon Class
	Required
	Return true if disabled correctly
	Return false + the reason if disabling failed
]]
function SB.__Destruct()
	if not status then return false , CAF.GetLangVar("This Addon is already disabled!") end
	hook.Remove("PlayerSetModel", "SB_Force_Model_Check")
	status = false;
	return true;
end

--[[
	Get the required Addons for this Addon Class
	Optional
	Put the string names of the Addons in here in table format
	The CAF startup system will use this to decide if the Addon can be Started up or not. If a required addon isn't installed then Construct will not be called
	Example: return {"Resource Distribution", "Life Support"}
	
	Works together with the startup Level number at the bottom of this file
]]
function SB.GetRequiredAddons()
	return {}
end

--[[
	Get the Boolean Status from this Addon Class
	Required, used to know if this addon is active or not
]]
function SB.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
	Optional (but should be put it in most cases!)
]]
function SB.GetVersion()
	return SPACEBUILD.version:longVersion(), SPACEBUILD.version.tag
end

--[[
	Get any custom options this Custom Addon Class might have
	Not implemented yet
]]
function SB.GetExtraOptions()
	return {}
end

--[[
	Get the Custom String Status from this Addon Class
	Optional, returns a custom String status, could be used if your addon has more then 1 status based on the options activated?
]]
function SB.GetCustomStatus()
	return
end

--[[
	You can send all the files from here that you want to add to send to the client
	Optional
]]
function SB.AddResourcesToSend()
	resource.AddFile( "models/player/samzanemesis/MarineMedic.mdl" )
	resource.AddFile( "models/player/samzanemesis/MarineSpecial.mdl" )
	resource.AddFile( "models/player/samzanemesis/MarineOfficer.mdl" )
	resource.AddFile( "models/player/samzanemesis/MarineTech.mdl" )
	
	resource.AddFile( "materials/models/player/male/medic_body.vmt")
	resource.AddFile( "materials/models/player/male/medic_body_female.vmt")
	resource.AddFile( "materials/models/player/male/medic_helmet.vmt")
	resource.AddFile( "materials/models/player/male/medic_helmet_female.vmt")
	resource.AddFile( "materials/models/player/male/officer_body.vmt")
	resource.AddFile( "materials/models/player/male/medic_helmet.vmt")
	resource.AddFile( "materials/models/player/male/special_weapons_body.vmt")
	resource.AddFile( "materials/models/player/male/special_weapons_body_female.vmt")
	resource.AddFile( "materials/models/player/male/special_weapons_helmet.vmt")
	resource.AddFile( "materials/models/player/male/special_weapons_helmet_female.vmt")
	resource.AddFile( "materials/models/player/male/tech_body.vmt")
	resource.AddFile( "materials/models/player/male/tech_helmet.vmt")
	
	resource.AddFile( "materials/models/player/male/back_unit/medic_back_unit.vmt")
	resource.AddFile( "materials/models/player/male/back_unit/medic_back_unit_female.vmt")
	resource.AddFile( "materials/models/player/male/back_unit/officer_back_unit.vmt")
	resource.AddFile( "materials/models/player/male/back_unit/special_weapons_back_unit.vmt")
	resource.AddFile( "materials/models/player/male/back_unit/special_weapons_back_unit_female.vmt")
	resource.AddFile( "materials/models/player/male/back_unit/tech_back_unit.vmt")
end
CAF.RegisterAddon("Spacebuild",  SB, "1")

-- Override functions
function SB.AddOverride_PlayerHeatDestroy()
	SB.Override_PlayerHeatDestroy = SB.Override_PlayerHeatDestroy + 1
end

function SB.RemoveOverride_PlayerHeatDestroy()
	SB.Override_PlayerHeatDestroy = SB.Override_PlayerHeatDestroy - 1
end

function SB.AddOverride_EntityHeatDestroy()
	SB.Override_EntityHeatDestroy = SB.Override_EntityHeatDestroy + 1
end

function SB.RemoveOverride_EntityHeatDestroy()
	SB.Override_EntityHeatDestroy = SB.Override_EntityHeatDestroy - 1
end

function SB.AddOverride_PressureDamage()
	SB.Override_PressureDamage = SB.Override_PressureDamage + 1
end

function SB.RemoveOverride_PressureDamage()
	SB.Override_PressureDamage = SB.Override_PressureDamage - 1
end

function SB.AddPlayerOverride()
	SB.PlayerOverride = SB.PlayerOverride + 1
end

function SB.RemovePlayerOverride()
	SB.PlayerOverride = SB.PlayerOverride - 1
end

-- Environment Functions

---
--
-- @deprecated use the new spacebuild methods for this!
function SB.GetPlanets()
	return SPACEBUILD:getPlanets()
end

---
--
-- @deprecated use the new spacebuild methods for this!
function SB.GetStars()
	return SPACEBUILD:getStars()
end

---
--
-- @deprecated use the new spacebuild methods for this!
function SB.GetArtificialEnvironments() --not 100 sure this is correct
	return SPACEBUILD:getOtherEnvironments()
end

---
--
-- @deprecated use the new spacebuild methods for this!
function SB.GetSpace()
	return SPACEBUILD:getSpace()
end

---
--
-- @deprecated use the new spacebuild methods for this!
function SB.AddEnvironment(env)
	SPACEBUILD:addEnvironment(env)
	return env:getID()
end

---
--
-- @deprecated use the new spacebuild methods for this!
function SB.RemoveEnvironment(env)
	SPACEBUILD:removeEnvironment(env)
end

---
--
-- @deprecated use the new spacebuild methods for this!
function SB.GetEnvironments()
	return SPACEBUILD:getEnvironments()
end

--Volume Functions

--[[
* @param name
* @return Volume(table) or nil
*
]]
function SB.GetVolume(name)
	return volumes[name]
end

--[[
* @param name
* @param radius
* @return Volume(table) or ( false + errormessage)
*
* Notes: If the volume name already exists, that volume is returned!
*
]]
function SB.CreateVolume(name, radius)
	return SB.FindVolume(name, radius)
end

--[[
* @param name
* @param radius
* @return Volume(table) or ( false + errormessage)
*
* Notes: If the volume name already exists, that volume is returned! 
*
]]
function SB.FindVolume(name, radius)
	if not name then return false, "No Name Entered!" end
	if not radius or radius < 0 then radius = 0 end
	if not volumes[name] then
		volumes[name] = {}
		volumes[name].radius = radius
		volumes[name].pos = Vector(0, 0 ,0 )
		local tries = VolCheckIterations:GetInt()
		local found = 0
		while ( ( found == 0 ) and ( tries > 0 ) ) do
			tries = tries - 1
			local pos = VectorRand()*16384
			if (util.IsInWorld( pos ) == true) then
				found = 1
				for k, v in pairs(volumes) do
					--if v and v.pos and (v.pos == pos or v.pos:Distance(pos) < v.radius) then -- Hur hur. This is why i had planetary collisions.
					if v and v.pos and (v.pos == pos or v.pos:Distance(pos) < v:getRadius()+radius) then
						found = 0
					end
				end
				if found == 1 then
					for k, v in pairs(SPACEBUILD:getPlanets()) do
						local ent = v:getEntity()
						if ent:GetPos() == pos or ent:GetPos():Distance(pos) < v:getRadius() then
							found = 0
							break
						end
					end
					for k, v in pairs(SPACEBUILD:getStars()) do
						local ent = v:getEntity()
						if ent:GetPos() == pos or ent:GetPos():Distance(pos) < v:getRadius() then
							found = 0
							break
						end
					end
				end
				if (found == 1) and radius > 0 then
					local edges = {
						pos+(Vector(1, 0, 0)*radius),
						pos+(Vector(0, 1, 0)*radius),
						pos+(Vector(0, 0, 1)*radius),
						pos+(Vector(-1, 0, 0)*radius),
						pos+(Vector(0, -1, 0)*radius),
						pos+(Vector(0, 0, -1)*radius)
					}
					local trace = {}
					trace.start = pos
					for _, edge in pairs( edges ) do
						trace.endpos = edge
						trace.filter = { }
						local tr = util.TraceLine( trace )
						if (tr.Hit) then
							found = 0
							break
						end
					end
				end
				if (found == 0) then Msg( "Rejected Volume.\n" ) end
			end
			if (found == 1) then
				volumes[name].pos = pos
			elseif tries <= 0 then
				volumes[name] = nil
			end
		end
	end
	return volumes[name]
end

--[[
* @param name
* @return nil
*
]]
function SB.DestroyVolume(name)
	SB.RemoveVolume(name);
end

--[[
* @param name
* @return nil
*
]]
function SB.RemoveVolume(name)
	if name and volumes[name] then volumes[name] = nil end
end

--[[
* @param name
* @param pos
* @param radius
* @return nil
*
* Note: this is meant for people who spawn their props in space using a custom Spawner (like the Stargate Spawner)
]]
function SB.AddCustomVolume(name, pos, radius)
	if not name or not radius or not pos then return false, "Invalid Parameters" end
	if volumes[name] then return false, "this volume already exists!" end
	volumes[name] = {}
	volumes[name].pos = pos
	volumes[name].radius = radius
end

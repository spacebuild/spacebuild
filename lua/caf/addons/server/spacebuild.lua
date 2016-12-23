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

--Local stuff
SB_DEBUG = true

--local NextUpdateTime

local SB_InSpace = 0
--SetGlobalInt("InSpace", 0)
TrueSun = {}
SunAngle = nil

SB.Override_PlayerHeatDestroy = 0
SB.Override_EntityHeatDestroy = 0
SB.Override_PressureDamage = 0
SB.PlayerOverride = 0
local sb_spawned_entities = {}
local volumes = {}

local VolCheckIterations = CreateConVar( "SB_VolumeCheckIterations", "11",{ FCVAR_CHEAT, FCVAR_ARCHIVE } )
local ForceModel = CreateConVar( "SB_Force_Model", "0",{ FCVAR_ARCHIVE } )

--Think + Environments
local Environments = {}
local Planets = {}
local Stars = {}
local numenv = 0


local function PlayerSay( ply, txt )
	if not ply:IsAdmin() then return --[[tostring(txt)]] end
	if (string.sub(txt, 1, 10 ) == "!freespace") then
		SB.RemoveSBProps()
	elseif (string.sub(txt, 1, 10 ) == "!freeworld") then
		SB.RemoveSBProps(true)
	end
	--if not txt then txt = "" end
	--return tostring(txt)
end

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

local function ResetGravity()
	for k, ent in ipairs( sb_spawned_entities) do
		if ent and IsValid(ent) then
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() and not (ent.IgnoreGravity and ent.IgnoreGravity == true) then
				ent:SetGravity(1)
				ent.gravity = 1
				phys:EnableGravity( true )
				phys:EnableDrag( true )
			end
		else
			table.remove(sb_spawned_entities, k)
		end
	end
end


--[[
	The Constructor for this Custom Addon Class
	Required
	Return True if succesfully able to start up this addon
	Return false, the reason of why it wasn't able to start
]]
function SB.__Construct()
	if status then return false , CAF.GetLangVar("This Addon is already Active!") end
	if SB_InSpace == 1 then
		hook.Add("PlayerSay", "SB_PlayerSay_Check", PlayerSay)
		hook.Add("PlayerSetModel", "SB_Force_Model_Check", ForcePlyModel)
		ResetGravity()
		for k, v in pairs(player.GetAll()) do
			PlayerInitialSpawn(v);
		end
		CAF.AddServerTag("SB")
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
	hook.Remove("PlayerSay", "SB_PlayerSay_Check")
	hook.Remove("PlayerSetModel", "SB_Force_Model_Check")
	ResetGravity()
	CAF.RemoveServerTag("SB")
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
	return 3.5, CAF.GetLangVar("Beta")
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

function SB.GetPlanets()
	local tmp = {}
	if table.Count(Planets) > 0 then
		for k, v in pairs(Planets) do
			--if v.IsPlanet and v:IsPlanet() then
			table.insert(tmp, v)
			--end
		end
	end
	return tmp
end

function SB.GetStars()
	local tmp = {}
	if table.Count(Stars) > 0 then
		for k, v in pairs(Stars) do
			--if v.IsStar and v:IsStar() then
			table.insert(tmp, v)
			--end
		end
	end
	return tmp
end

function SB.GetArtificialEnvironments() --not 100 sure this is correct
	local tmp = {}
	if table.Count(Environments) > 0 then
		for k, v in pairs(Environments) do
			--if v.IsStar and not v:IsStar() and v.IsPlanet and not v:IsPlanet() then
				table.insert(tmp, v)
			--end
		end
	end
	return tmp
end

function SB.OnEnvironmentChanged(ent)
	if not ent.oldsbtmpenvironment or ent.oldsbtmpenvironment ~= ent.environment then
		local tmp = ent.oldsbtmpenvironment
		ent.oldsbtmpenvironment = ent.environment
		if tmp then
			gamemode.Call( "OnEnvironmentChanged", ent, tmp, ent.environment )
		end
	end
end

function SB.GetSpace()
	return SPACEBUILD:getSpace()
end

function SB.AddEnvironment(env)
	if not env or not env.GetEnvClass or env:GetEnvClass() ~= "SB ENVIRONMENT" then return 0 end
	--if v.IsStar and not v:IsStar() and v.IsPlanet and not v:IsPlanet() then
	if env.IsStar and env:IsStar() then
		if not table.HasValue(Stars, env) then
			table.insert(Stars, env)
			numenv = numenv + 1
			env:SetEnvironmentID(numenv)
			return numenv
		end
	elseif env.IsPlanet and env:IsPlanet() then
		if not table.HasValue(Planets, env) then
			table.insert(Planets, env)
			numenv = numenv + 1
			env:SetEnvironmentID(numenv)
			return numenv
		end
	elseif not table.HasValue(Environments, env) then
			table.insert(Environments, env)
			numenv = numenv + 1
			env:SetEnvironmentID(numenv)
			return numenv
	end
	return env:GetEnvironmentID()
end

function SB.RemoveEnvironment(env)
	if not env or not env.GetEnvClass or env:GetEnvClass() ~= "SB ENVIRONMENT" then return end
	if env.IsStar and env:IsStar() then
		for k, v in pairs(Stars) do
			if env == v then
				table.remove(Stars, k)
			end
		end
	elseif env.IsPlanet and env:IsPlanet() then
		for k, v in pairs(Planets) do
			if env == v then
				table.remove(Planets, k)
			end
		end
	else
		for k, v in pairs(Environments) do
			if env == v then
				table.remove(Environments, k)
			end
		end
	end
	
end

function SB.GetEnvironments()
	local tmp = {}
	for k, v in pairs(Planets) do
		table.insert(tmp, v)
	end
	for k, v in pairs(Stars) do
		table.insert(tmp, v)
	end
	for k, v in pairs(Environments) do
		table.insert(tmp, v)
	end

	return tmp
end

--Chat Commands

function SB.RemoveSBProps(world)
	for _, ent in pairs( sb_spawned_entities ) do
		if world and ent.environment and ent.environment:IsPlanet() then
			if not (ent:IsPlayer() or (ent.IsPlanet and ent:IsPlanet()) or (ent.IsStar and ent:IsStar())) then
				ent:Remove()
			end
		elseif not world and (not ent.environment or ent.environment:IsSpace()) then
			if not (ent:IsPlayer() or (ent.IsPlanet and ent:IsPlanet()) or (ent.IsStar and ent:IsStar())) then
				ent:Remove()
			end
		end
	end
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
			pos = VectorRand()*16384
			if (util.IsInWorld( pos ) == true) then
				found = 1
				for k, v in pairs(volumes) do
					--if v and v.pos and (v.pos == pos or v.pos:Distance(pos) < v.radius) then -- Hur hur. This is why i had planetary collisions.
					if v and v.pos and (v.pos == pos or v.pos:Distance(pos) < v.radius+radius) then
						found = 0
					end
				end
				if found == 1 then
					for k, v in pairs(Environments) do
						if v and IsValid(v) and ((v.IsPlanet and v.IsPlanet()) or (v.IsStar and v.IsStar())) and (v:GetPos() == pos or v:GetPos():Distance(pos) < v:GetSize()) then
							found = 0
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

function SB.FindClosestPlanet(pos, starsto)
	local closestplanet = nil
	if table.Count(Planets) > 0 then
		for k, v in pairs(Planets) do
			if v and IsValid(v) and v.IsPlanet and v.IsPlanet() then
				if not closestplanet then
					closestplanet = v
				else
					if (v:GetPos():Distance(pos) - v:GetSize() < closestplanet:GetPos():Distance(pos) - closestplanet:GetSize()) then
						closestplanet = v
					end
				end
			end
		end
	end
	if starsto and table.Count(Stars) > 0 then
		for k, v in pairs(Stars) do
			if v and IsValid(v) and v.IsStar and v.IsStar() then
				if not closestplanet then
					closestplanet = v
				else
					if (v:GetPos():Distance(pos) - v:GetSize() < closestplanet:GetPos():Distance(pos) - closestplanet:GetSize()) then
						closestplanet = v
					end
				end
			end
		end
	end
	return closestplanet
end

function SB.FindEnvironmentOnPos(pos)
	local env = nil
	if table.Count(Planets) > 0 then
		for k, v in pairs(Planets) do
			if v and IsValid(v) and v.IsEnvironment and v:IsEnvironment() then
				env = v:PosInEnvironment(pos, env)
			end
		end
	end
	if not env and table.Count(Stars) > 0 then
		for k, v in pairs(Stars) do
			if v and IsValid(v) and v.IsEnvironment and v:IsEnvironment() then
				env = v:PosInEnvironment(pos, env)
			end
		end
	end
	if table.Count(Environments) > 0 then
		for k, v in pairs(Environments) do
			if v and IsValid(v) and v.IsEnvironment and v:IsEnvironment() then
				env = v:PosInEnvironment(pos, env)
			end
		end
	end
	return env or SB.GetSpace()
end

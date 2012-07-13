/*------------------------------------------------
	SPACEBUILD2 GAMEMODE
	
	Made by SB Team, original made by Shanjaq

------------------------------------------------*/
Complete_Planet_Backup = {}
--Send to client
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_sun.lua" )
AddCSLuaFile( "shared.lua" )

--include files for use in here
include( 'shared.lua' )
include( 'environments.lua' )
include( 'hooks.lua' )
include( 'volumes.lua' )
include( 'brush_environments.lua' )

--Variables needed
util.PrecacheSound( "Player.FallGib" )
util.PrecacheSound( "HL2Player.BurnPain" )

local version = "SVN(1.0.7)"

local function registerPF()
	if SVX_PF then
		function SB2_isActive()
			return true
		end
		PF_RegisterPlugin("Spacebuild2", version, SB2_isActive, nil, nil, "Gamemode")
		PF_RegisterConVar("Spacebuild2", "SB_NoClip", "1", "Spacebuild Noclip System")
		PF_RegisterConVar("Spacebuild2", "SB_PlanetNoClipOnly", "1", "Planet only Noclip")
		PF_RegisterConVar("Spacebuild2", "SB_AdminSpaceNoclip", "1", "Admins allowed to noclip in space")
		PF_RegisterConVar("Spacebuild2", "SB_SuperAdminSpaceNoclip", "1", "Superadmins allowed to noclip in space")
	else
		CreateConVar( "SB_NoClip", "1" )
		CreateConVar( "SB_PlanetNoClipOnly", "1" )
		CreateConVar( "SB_AdminSpaceNoclip", "1" )
		CreateConVar( "SB_SuperAdminSpaceNoclip", "1" )
	end
end
timer.Simple(5, registerPF)--Needed to make sure the Plugin Framework gets loaded first



local NextUpdate = 0
local NextUpdateTime

InSpace = 0
SetGlobalInt("InSpace", 0)
TrueSun = nil
SunAngle = nil
SB_DEBUG = false --Turn this off if you don't want to get debug data in console!!

local Energy_Increment = 5
local Coolant_Increment = 5

--Think

function GM:Think()
	if (InSpace == 0) then return end
	if CurTime() < (NextUpdateTime or 0) then return end
	self:Space_Affect_Players()
	if NextUpdate == 1 then
		SB_Planet_Quake()
		for _, class in ipairs( self.affected ) do
			local ents = ents.FindByClass( class )
			for _, ent in ipairs( ents ) do
				if not ent.IsInBrushEnv then
					self:Space_Affect_Ent( ent )
				end
			end
		end
		local ents = ents.FindByClass( "entityflame" )
		for _, ent in ipairs( ents ) do
			ent:Remove()
		end
		NextUpdate = 0
	else
		NextUpdate = 1
	end
	NextUpdateTime = CurTime() + 0.5
end

function GM:Space_Affect_Shared( ent, gravity)
	local phys = ent:GetPhysicsObject()
	if not phys:IsValid() then return end
	if (not gravity) or (gravity == 0) then
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		ent:SetGravity(0.00001)
		ent.gravity = 0
		if not ent.spawn then
			ent.spawn = true 
		end
	else
		ent:SetGravity(gravity)
		ent.gravity = gravity
		phys:EnableGravity( true )
		phys:EnableDrag( true )
	end	
end

function GM:GetTemperature(ent, ltemp, stemp, sunburn)
	local entpos = ent:GetPos()
	local temperature = 14
	local trace = {}
	if not ( TrueSun == nil ) then
		SunAngle = (entpos - TrueSun)
		SunAngle:Normalize()
	end
	local startpos = (entpos - (SunAngle * 4096))
	trace.start = startpos
	trace.endpos = entpos + Vector(0,0,30)
	local tr = util.TraceLine( trace )
	if (tr.Hit) then
		if (tr.Entity == ent) then
			if (ent:IsPlayer()) then
				if sunburn and (sunburn == 1) then
					if (ent:Health() > 0) then
						ent:TakeDamage( 5, 0 )
						ent:EmitSound( "HL2Player.BurnPain" )
					end
				end
			end
			temperature = ltemp
		else
			temperature = stemp
		end
	else
		temperature = ltemp
	end
	return temperature
end

function GM:GravityCheck(ent)
	local trace = {}
	local pos = ent:GetPos()
	trace.start = pos
	trace.endpos = pos - Vector(0,0,512)
	trace.filter = { ent }
	local tr = util.TraceLine( trace )
	if (tr.Hit) then
		if (tr.Entity.grav_plate == 1) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function GM:Space_Affect_Players()
	for _, ply in pairs(player:GetAll()) do
		if not ply.IsInBrushEnv then 
			if not ply:Alive() then ply.planet = nil end
			local pos = ply:GetPos()
			local onplanet, num = SB_OnEnvironment(pos)
			if onplanet then
				local valid, planet, pos , radius, gravity, habitat, air, co2, n, atmosphere, pressure, ltemperature, stemperature, sunburn = SB_Get_Environment_Info(num)
				if not ply.planet or ply.reset or not (ply.planet == num) then
					if valid then
						self:Space_Affect_Shared( ply, gravity)
						ply.planet = num
						ply.onplanet = planet
						if ply.suit then
							ply.suit.atmosphere = atmosphere
							ply.suit.pressure = pressure
							ply.suit.habitat = habitat
							ply.suit.pair = air
							ply.suit.co2 = co2
							ply.suit.n = n
							if planet then
								ply.suit.temperature = self:GetTemperature(ply, ltemperature, stemperature, sunburn)
							else
								ply.suit.temperature = ltemperature
							end
						end	
						if ply.reset then
							ply.reset = false
						end					
					end
				end
				if ply.suit and ply.onplanet then
					ply.suit.temperature = self:GetTemperature(ply, ltemperature, stemperature, sunburn)
				end
				if gravity ~= 1 then
					if self:GravityCheck(ply) then
						ply:SetGravity(1)
					else
						ply:SetGravity(gravity)
					end
				end
			else
				if ply.planet or not ply.spawn or ply.reset then
					self:Space_Affect_Shared(ply)
					ply.planet = nil
					ply.onplanet = false
					if ply.suit then
						ply.suit.atmosphere = 0
						ply.suit.pressure = 0
						ply.suit.habitat = 0
						ply.suit.pair = 0
						ply.suit.co2 = 0
						ply.suit.n = 0
						ply.suit.temperature = 14
					end
					if not ply:InVehicle() or not SinglePlayer() then
						if not AllowAdminNoclip(ply) then
							if ply:GetMoveType() == MOVETYPE_NOCLIP then
								ply:SetMoveType(MOVETYPE_WALK)
							end
						end
					end
					if ply.reset then
						ply.reset = false
					end
				end
				if self:GravityCheck(ply) then
					ply:GetPhysicsObject():EnableGravity( true )
					ply:GetPhysicsObject():EnableDrag( true )
					ply:SetGravity(1)
				else
					ply:GetPhysicsObject():EnableGravity( false )
					ply:GetPhysicsObject():EnableDrag( false )
					ply:SetGravity(0.00001)
				end
			end
		end
	end
end

function GM:Space_Affect_Ent(ent)
	if (ent.IsInBrushEnv or
	not ent:IsValid())
	or not ent:GetPhysicsObject():IsValid() 
	or ent:GetPhysicsObject():IsAsleep()
	or ent:IsPlayer() 
	then return end
	local pos = ent:GetPos()
	local onplanet, num = SB_OnEnvironment(pos, ent.num, nil, ent.IgnoreClasses) --ignoreClasses so the check won't check if the ent is in an environment that exists out of the certain ent
	if SB_DEBUG then Msg(ent:GetClass().." is on environment("..num..")\n") end
	if onplanet then
		local valid, planet, _ , ig, gravity, habitat, air, co2, n, atmosphere, pressure,  ltemperature, stemperature, sunburn = SB_Get_Environment_Info(num)
		if not ent.planet or not (ent.planet == num) or ent.reset then
			if valid then
				self:Space_Affect_Shared( ent, gravity)
				ent.planet = num
				ent.onplanet = planet
				if ent.environment then
					ent.environment.atmosphere = atmosphere
					ent.environment.pressure = pressure
					ent.environment.habitat = habitat
					ent.environment.air = air
					ent.environment.co2 = co2
					ent.environment.n = n
					if planet then
						ent.environment.temperature = self:GetTemperature(ent, ltemperature, stemperature, sunburn)
					else
						ent.environment.temperature = ltemperature
					end
				end	
				if ent.reset then
					ent.reset = false
				end			
			end
		end
		if ent.environment and ent.onplanet then
			ent.environment.temperature = self:GetTemperature(ent, ltemperature, stemperature, sunburn)
			if not SB2_Override_HeatDestroy and ent.environment.temperature > 100000 and sunburn == 1 then
				ent:Remove()
			end
		end
	else
		if ent.planet or not ent.spawn or ent.reset then
			if ent.environment and ent.environment.type and ent.environment.type == "TerraForm" then
				local tf = SB_GetTerraformer(ent.planet)
				if ent.planet and tf and tf == ent then 
					if SB_RemTerraformer(ent.planet, ent) and ent.Active == 1 then
						SB_Terraform_UnStep(ent, ent.planet)
					end
				end
				ent.planetset = false
				if ent.reset then
					ent.reset = false
				end
			end
			self:Space_Affect_Shared(ent)
			ent.planet = nil
			ent.onplanet = false
			if ent.environment then
				ent.environment.atmosphere = 0
				ent.environment.pressure = 0
				ent.environment.habitat = 0
				ent.environment.air = 0
				ent.environment.co2 = 0
				ent.environment.n = 0
				ent.environment.temperature = 14
			end
			if ent.reset then
				ent.reset = nil
			end
		end
	end
end

--Start init functions

function GM:InitPostEntity()
	self:Register_Sun()
	self:Register_Environments()
	self:AddSentsToList()
end

function GM:Register_Sun()
	local suns = ents.FindByClass( "env_sun" )
	for _, ent in ipairs( suns ) do
		if ent:IsValid() then
			local values = ent:GetKeyValues()
			for key, value in pairs(values) do
				if ((key == "target") and (string.len(value) > 0)) then
					local targets = ents.FindByName( "sun_target" )
					for _, target in pairs( targets ) do
						SunAngle = (target:GetPos() - ent:GetPos()):Normalize()
						return --Sunangle set, all that was needed
					end
				end
			end
			--Sun angle still not set, but sun found
		    local ang = ent:GetAngles()
			ang.p = ang.p - 180
			ang.y = ang.y - 180
		    --get within acceptable angle values no matter what...
			ang.p = math.NormalizeAngle( ang.p )
			ang.y = math.NormalizeAngle( ang.y )
			ang.r = math.NormalizeAngle( ang.r )
			SunAngle = ang:Forward()
			return
		end
	end
	--no sun found, so just set a default angle
	if not SunAngle then SunAngle = Vector(0,0,-1) end	
end

function GM:AddSentsToList()
	local SEntList = scripted_ents.GetList()
	for _, item in pairs( SEntList ) do
		local name =  item.t.Classname
		local found = 0
		for _, check in pairs( self.affected ) do
			if ( check == name ) then
				found = 1
				break
			end
		end
		if ( found == 0 ) then table.insert(self.affected, name) end
	end
end

function GM:Register_Environments()
	local Blooms = {}
	local Colors = {}
	local Planets = {}
	--Load the planets/stars/bloom/color
	local entities = ents.FindByClass( "logic_case" )
	for _, ent in ipairs( entities ) do
		local values = ent:GetKeyValues()
		for key, value in pairs(values) do
   			if key == "Case01" then
				if value == "star" then 
					local radius
					for key2, value2 in pairs(values) do
						if (key2 == "Case02") then radius = tonumber(value2) end
					end
					local num =  SB_Add_Environment(ent, radius, 0, 0, 0, 100000, 100000, 0, 1, true, nil, nil)
					--Msg("Registered Outside Star = "..tostring(num).."\n")
					num = SB_Add_Environment(ent, radius/2, 0, 0, 0, 300000, 300000, 0, 1, true, nil, nil)
					--Msg("Registered Middle Star = "..tostring(num).."\n")
					num = SB_Add_Environment(ent, radius/3, 0, 0, 0, 500000, 500000, 0, 1, true, nil, nil)
					--Msg("Registered Core Star = "..tostring(num).."\n")
					TrueSun = ent:GetPos()
					local hash = {}
					hash.radius = radius
					hash.num = num
					hash.pos = ent:GetPos()
					if RES_DISTRIB and RES_DISTRIB == 2 then
						BeamNetVars.SB2UpdateStar( hash )
					end
				elseif value == "planet" then
					InSpace = 1
					SetGlobalInt("InSpace", 1)
					if not TrueSun or not (ent:GetPos() == TrueSun) then
						local radius
						local gravity
						local atmosphere
						local stemperature
						local ltemperature
						local ColorID
						local BloomID
						local unstable
						local habitat
						local sunburn
						for key2, value2 in pairs(values) do
							if (key2 == "Case02") then radius = tonumber(value2) end
							if (key2 == "Case03") then gravity = tonumber(value2) end
							if (key2 == "Case04") then atmosphere = tonumber(value2) end
							if (key2 == "Case05") then stemperature = tonumber(value2) end
							if (key2 == "Case06") then ltemperature = tonumber(value2) end
							if (key2 == "Case07") then
								if (string.len(value2) > 0) then
									ColorID = value2
								end
							end
							if (key2 == "Case08") then
								if (string.len(value2) > 0) then
									BloomID = value2
								end
							end
							if (key2 == "Case16") then habitat, unstable, sunburn = SB_CalculateHabUnStSun(tonumber(value2)) end
						end
						local num = SB_Add_Environment(ent, radius, gravity, habitat, atmosphere, ltemperature, stemperature, unstable, sunburn, true, nil, nil)
						--Msg("Registered Planet = "..tostring(num).."\n")
						if num then
							Planets[num] = {}
							Planets[num].ColorID = ColorID
							Planets[num].BloomID = BloomID
						end
					--else
						--Msg("Not registering planet => Same location as a star!\n")
					end
				elseif value == "planet_color" then
					local AddColor_r
					local AddColor_g
					local AddColor_b
					local MulColor_r
					local MulColor_g
					local MulColor_b
					local Brightness
					local Contrast
					local Color
					local ColorID
					for key2, value2 in pairs(values) do
						if (key2 == "Case02") then
							AddColor_r = tonumber(string.Left(value2, string.find(value2," ") - 1))
							value2 = string.Right(value2, (string.len(value2) - string.find(value2," ")))
							AddColor_g = tonumber(string.Left(value2, string.find(value2," ") - 1))
							value2 = string.Right(value2, (string.len(value2) - string.find(value2," ")))
							AddColor_b = tonumber(value2)
						end
						if (key2 == "Case03") then
							MulColor_r = tonumber(string.Left(value2, string.find(value2," ") - 1))
							value2 = string.Right(value2, (string.len(value2) - string.find(value2," ")))
							MulColor_g = tonumber(string.Left(value2, string.find(value2," ") - 1))
							value2 = string.Right(value2, (string.len(value2) - string.find(value2," ")))
							MulColor_b = tonumber(value2)
						end
						if (key2 == "Case04") then Brightness = tonumber(value2) end
						if (key2 == "Case05") then Contrast = tonumber(value2) end
						if (key2 == "Case06") then Color = tonumber(value2) end
						if (key2 == "Case16") then ColorID = value2 end
					end
					Colors[ColorID] = SB_Color(ent, AddColor_r, AddColor_g, AddColor_b, MulColor_r, MulColor_g, MulColor_b, Brightness, Contrast, Color)
				elseif value == "planet_bloom" then
					local Col_r
					local Col_g
					local Col_b
					local SizeX
					local SizeY 
					local Passes
					local Darken
					local Multiply
					local Color
					local BloomID
					for key2, value2 in pairs(values) do
						if (key2 == "Case02") then
							Col_r = tonumber(string.Left(value2, string.find(value2," ") - 1))
							value2 = string.Right(value2, (string.len(value2) - string.find(value2," ")))
							Col_g = tonumber(string.Left(value2, string.find(value2," ") - 1))
							value2 = string.Right(value2, (string.len(value2) - string.find(value2," ")))
							Col_b = tonumber(value2)
						end
						if (key2 == "Case03") then
							SizeX = tonumber(string.Left(value2, string.find(value2," ") - 1))
							value2 = string.Right(value2, (string.len(value2) - string.find(value2," ")))
							SizeY = tonumber(value2)
						end
						if (key2 == "Case04") then Passes = tonumber(value2) end
						if (key2 == "Case05") then Darken = tonumber(value2) end
						if (key2 == "Case06") then Multiply = tonumber(value2) end
						if (key2 == "Case07") then Color = tonumber(value2) end
						if (key2 == "Case16") then BloomID = value2 end
					end
					Blooms[BloomID] = SB_Bloom(ent, Col_r, Col_g, Col_b, SizeX, SizeY, Passes, Darken, Multiply, Color)
				end
			end
		end
	end
	for num, p in pairs( Planets ) do
		local color
		local bloom
		if (Colors[p.ColorID]) then color = Colors[p.ColorID] end
		if (Blooms[p.BloomID]) then bloom = Blooms[p.BloomID] end
		if color or bloom then
			if not SB_Update_Environment(num, nil, nil, nil, nil, nil, nil, nil, nil, true, bloom, color) then
				Msg("Update failed!\n")
			else
				Msg("Update Succesfull!\n")
			end
		end
	end
	Msg ( "Registered " .. table.Count(Planets) .. " planets\n" )
	BackupPlanetData = table.Copy(Planets)
	Msg ("Created backup value table.")
end
BackupPlanetData = {}

function GM:SB_SentCheck(ply, ent)
	if not (ent and ent:IsValid()) then return end
	local c = ent:GetClass()
	if table.HasValue(self.affected, c) then return end
	table.insert(self.affected, c)
end
function GM:SB_Ragdoll(ply)
	if ply:GetRagdollEntity() and ply:GetRagdollEntity():IsValid() then
		ply:GetRagdollEntity():SetGravity(0)
	else
		ply:CreateRagdoll()
		ply:GetRagdollEntity():SetGravity(0)
	end
end

--DPF: Overriding original PlayerSpawn
/*---------------------------------------------------------
   Name: gamemode:PlayerSpawn( )
   Desc: Called when a player spawns
---------------------------------------------------------*/
function GM:PlayerSpawn( pl )

	--
	-- If the player doesn't have a team in a TeamBased game
	-- then spawn him as a spectator
	--
	if ( self.TeamBased and ( pl:Team() == TEAM_SPECTATOR or pl:Team() == TEAM_UNASSIGNED ) ) then

		self:PlayerSpawnAsSpectator( pl )
		return
	
	end

	-- Stop observer mode
	pl:UnSpectate()

	-- Call item loadout function
	hook.Call( "PlayerLoadout", GAMEMODE, pl )
	
	-- Set player model
	hook.Call( "PlayerSetModel", GAMEMODE, pl )
	
	-- Set the player's speed
	GAMEMODE:SetPlayerSpeed( pl, 250, 500 )
	
end

hook.Add( "PlayerSpawnedSENT", "SBSpawnedSent", GM.SB_SentCheck)
hook.Add("PlayerKilled","SBRagdoll",GM.SB_Ragdoll)
SB_BrushEnvironments	= {}
SB_BrushEnvironments.Envs = {}
SB_BrushSystemActive	= true
local debugz = true

function SB_BrushEnvironments.Add(ID, gravity, habitat, pressure, ltemp, stemp, unstable, sunburn, isplanet, bloom, colour)
	local tbl 				= {}
	tbl.ID 					= ID or Error("YOUR SCREWED!\n KJASLDFASHKJDHAKJSHFDKAJSBNDKJASHNB!!!!!\n NOOOOOOOOOOOB!!!!!\nInvalid ID for brush entered.\n")
	tbl.Gravity 			= gravity or 1
	tbl.Habitat 			= habitat or 0
	tbl.Pressure 			= pressure or 1
	tbl.SunlightTemperture 	= ltemp or 273
	tbl.ShadowTemperture 	= stemp or 300
	tbl.Unstable 			= unstable or false
	tbl.Sunburn				= sunburn or false
	tbl.IsPlanet			= isplanet or false
	tbl.BloomData			= bloom or nil
	tbl.ColourData			= colour or nil
	tbl.IsBrush				= true
	
	if not SB_BrushEnvironments.Envs[ID] then
		SB_BrushEnvironments.Envs[ID] = tbl
	else
		Msg("WARNING: Environment ID: ",ID," already exists for another brush! Overriding!\n")
		SB_BrushEnvironments.Envs[ID] = tbl
	end
	return tbl
end

function SB_BrushEnvironments.Remove(ID)
	SB_BrushEnvironments.Envs[ID] = nil
	Msg("WARNING: REMOVED ENVIRONMENT ",ID,"!\n")
end

function SB_BrushEnvironments.GetEnvData(ID)
	local tbl = SB_BrushEnvironments.Envs[ID]
	if tbl then
		return true, tbl.ID, tbl.Gravity, tbl.Habitat, tbl.Pressure, tbl.SunlightTemperture, tbl.ShadowTemperture, tbl.Unstable, tbl.Sunburn, tbl.IsPlanet, tbl.BloomData, tbl.ColourData, tbl.IsBrush
	else
		return false
	end
end

function SB_BrushEnvironments.SpaceEnt(ent)
	GAMEMODE:Space_Affect_Shared(ent)
	
	ent.IsInBrushEnv = nil
	ent.planet = nil
	ent.onplanet = false
	
	local tbl = ent.suit or ent.environment
	tbl = tbl or {}
	
	tbl.atmosphere = 0
	tbl.pressure = 0
	tbl.habitat = 0
	tbl.air = 0
	tbl.co2 = 0
	tbl.n = 0
	tbl.temperature = 14

	if ent:IsPlayer() then
		if not ent:InVehicle() or not game.SinglePlayer() and
		   not AllowAdminNoclip(ent) and ent:GetMoveType() == MOVETYPE_NOCLIP then
			ent:SetMoveType(MOVETYPE_WALK)
		end
		ent.suit = tbl
	else
		ent.environment = tbl
	end
	
	if ent.reset then
		ent.reset = false
	end
end

function SB_BrushEnvironments.ApplyEnv(ID, ent)
	if debugz then
		Msg("Entity ",ent," is having it's properties changed for brush env ",ID,"'s properties ")
	end
	local valid, ID, Gravity, Habitat, Pressure, SunlightTemperture, ShadowTemperture, Unstable, Sunburn, IsPlanet, BloomData, ColourData, IsBrush = SB_BrushEnvironments.GetEnvData(ID)
	if valid then
		if debugz then
			Msg("and the brush was valid.\n")
		end
		local phys = ent:GetPhysicsObject()
		if phys:IsValid() then 
			phys:EnableGravity(true)
			phys:EnableDrag(true)
		end
		
		ent:SetGravity(Gravity)
		ent.gravity = 1	
		ent.planet = num
		ent.onplanet = planet
		
		if ent:IsPlayer() then
			ent.suit = ent.suit or {}
			ent.suit.atmosphere = Atmosphere
			ent.suit.pressure = Pressure
			ent.suit.habitat = Habitat
			ent.suit.pair = Air
			ent.suit.co2 = CO2
			ent.suit.n = N
			if planet then
				ent.suit.temperature = GM:GetTemperature(ply, SunlightTemperture, ShadowTemperture, Sunburn)
			else
				ent.suit.temperature = SunlightTemperture
			end
		else
			ent.environment = ent.environment or {}
			ent.environment.atmosphere = Atmosphere
			ent.environment.pressure = Pressure
			ent.environment.habitat = Habitat
			ent.environment.air = Air
			ent.environment.co2 = CO2
			ent.environment.n = N
			if planet then
				ent.environment.temperature = GM:GetTemperature(ply, SunlightTemperture, ShadowTemperture, Sunburn)
			else
				ent.environment.temperature = SunlightTemperture
			end
		end
		if ent.reset then
			if debugz then
				Msg("We also reset it to false.\n")
			end
			ent.reset = false
		end
	else
		if debugz then
			Msg("and the brush wasn't valid.\n")
		end
	end
end

function SB_BrushEnvironments.SendDataToClient(ID)
	if SB_BrushEnvironments.Envs[ID] then
		BeamNetVars.SB2UpdatePlanet(SB_BrushEnvironments.Envs[ID])
	end
end

function SB_BrushEnvironments.RestoreEnv(ID)

end

function SB_BrushEnvironments.SetPressure(ID, data)

end

function SB_BrushEnvironments.SetSunTemp(ID, data)

end

function SB_BrushEnvironments.SetShadowTemp(ID, data)

end

function SB_BrushEnvironments.SetGravity(ID, data)

end

function SB_BrushEnvironments.SetHasSunburn(ID, data)

end

function SB_BrushEnvironments.SetIsUnstable(ID, data)

end

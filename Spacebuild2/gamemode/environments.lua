/*
	ENVIRONMENTS: Planets, Artificial
*/

local environments = {}
local Backup = {}

--Compatibility
function SB_Add_Environment(ent, radius, gravity, habitat, atmosphere, ltemperature, stemperature, unstable, sunburn, isplanet, bloom, color)
	local air = 0
	local co2 = 0
	local n = 0
	local pressure = atmosphere
	/*if atmosphere > 1 then
		atmosphere = 1
	end*/
	if habitat == 0 then
		co2 = 100
	else
		air = 100
	end
	return SB_Add_Environment2(ent, radius, gravity, habitat, air, co2, n, atmosphere, pressure, ltemperature, stemperature, unstable, sunburn, isplanet, bloom, color)
	
end

function SB_Add_Environment2(ent, radius, gravity, habitat, air, co2, n, atmosphere, pressure, ltemperature, stemperature, unstable, sunburn, isplanet, bloom, color)
	local hash = {}
	hash.num =  #environments + 1
	if not radius then radius = ent:BoundingRadius() end
	if SB_DEBUG then
		Msg("--------------------------\n")
		Msg("Adding Environment "..tostring(hash.num).."\n")
		Msg("Pos: "..tostring(ent:GetPos()).."\n")
		Msg("Radius: "..tostring(radius).."\n")
		Msg("Gravity: "..tostring(gravity).."\n")
		Msg("Habitat: "..tostring(habitat).."\n")
		Msg("Atmosphere: "..tostring(atmosphere).."\n")
		Msg("LTemperature: "..tostring(ltemperature).."\n")
		Msg("Stemperature: "..tostring(stemperature).."\n")
		Msg("Unstable: "..tostring(unstable).."\n")
		Msg("Sunburn: "..tostring(sunburn).."\n")
		Msg("IsPlanet: "..tostring(isplanet).."\n")
		Msg("Bloom: "..tostring(bloom).."\n")
		Msg("Color: "..tostring(color).."\n")
		Msg("--------------------------\n")
	end
	hash.IsPlanet = isplanet
	hash.radius = radius
	hash.ent = ent
	hash.habitat = habitat
	hash.air = air
	hash.co2 = co2
	hash.n = n
	hash.atmosphere = atmosphere
	hash.pressure = pressure
	hash.gravity = gravity
	if isplanet then
		hash.prior = 1
		hash.ltemperature = ltemperature
		hash.stemperature = stemperature
		hash.sunburn = sunburn
		hash.unstable = unstable
		hash.Bloom = bloom
		hash.Color = color
		hash.pos = ent:GetPos() --RD2 update needed
		Backup[hash.num] = hash
	else
		hash.prior = 2
		hash.temperature = ltemperature
		ent.num = hash.num
	end
	environments[hash.num] = hash
	if isplanet and RES_DISTRIB and RES_DISTRIB == 2 and BeamNetVars.SB2UpdatePlanet then
		if SB_DEBUG then Msg("sending planet data\n") end
		BeamNetVars.SB2UpdatePlanet( environments[hash.num] )
	end
	return hash.num
end

--Compatibility
function SB_Update_Environment(num, radius, gravity, habitat, atmosphere, ltemperature, stemperature, unstable, sunburn, ok, bloom, color)
	local air = nil
	local co2 = nil
	local pressure = atmosphere
	atmosphere = nil
	if habitat then
		if habitat == 0 then
			co2 = 100
		else
			air = 100
		end
	end
	return SB_Update_Environment2(num, radius, gravity, habitat, air, co2, n, atmosphere, pressure, ltemperature, stemperature, unstable, sunburn, ok, bloom, color)
end

function SB_Update_Environment2(num, radius, gravity, habitat, air, co2, n, atmosphere, pressure, ltemperature, stemperature, unstable, sunburn, ok, bloom, color)
	if environments[num] then
		ResetEntsOnEnv(num)
		local hash = environments[num]
		if radius then hash.radius = radius end
		if gravity then hash.gravity = gravity end
		if habitat then hash.habitat = habitat end
		if air then hash.air = air end
		if co2 then hash.co2 = co2 end
		if n then hash.n = n end
		if atmosphere then hash.atmosphere = atmosphere end
		if pressure then hash.pressure = pressure end
		if environments[num].IsPlanet then
			if ltemperature then hash.ltemperature = ltemperature end
			if stemperature then hash.stemperature = stemperature end
			if sunburn then hash.sunburn = sunburn end
			if unstable then hash.unstable = unstable end
			if ok then
				hash.Bloom = bloom
				hash.Color = color
				if RES_DISTRIB and RES_DISTRIB == 2 and BeamNetVars.SB2UpdatePlanet then
					if SB_DEBUG then Msg("Updating planet data\n") end
					BeamNetVars.SB2UpdatePlanet( environments[num] )
				end
			end
		else
			if ltemperature then hash.temperature = ltemperature end
		end
		return true
	end
	return false
end

function SB_Remove_Environment(num)
	if environments[num] and not environments[num].IsPlanet then
		ResetEntsOnEnv(num)
		environments[num] = nil
		return true
	end
	return false
end

function SB_Get_Environment_Info(num)
	if environments[num] then
		if environments[num].IsPlanet then
			return true, true, environments[num].ent:GetPos(),environments[num].radius, environments[num].gravity, environments[num].habitat, environments[num].air, environments[num].co2, environments[num].n, environments[num].atmosphere, environments[num].pressure, environments[num].ltemperature, environments[num].stemperature, environments[num].sunburn
		else
			return true, false, environments[num].ent:GetPos(),environments[num].radius, environments[num].gravity, environments[num].habitat, environments[num].air, environments[num].co2, environments[num].n, environments[num].atmosphere, environments[num].pressure, environments[num].temperature
		end
	end
	return false
end

function SB_GetBloomColor(num)
	if environments[num] then
		if environments[num].IsPlanet then
			return environments[num].Bloom,environments[num].Color
		else
			return 
		end
	end
	return
end

function SB_OnEnvironment(pos, art,  extra, ignoredata)
	if not extra then extra = 0 end
	local radius = 10000 --max is about 4096(planets) stars = 8500
	local found = false
	local env_num = 0
	local env_prior = 0
	for num, env in pairs( environments ) do
		if(not ignoredata or not table.HasValue(ignoredata, env.ent:GetClass())) then
			if env and env.ent and env.ent:IsValid() then
				if (pos:Distance(env.ent:GetPos()) < env.radius + extra) and (env.prior > env_prior or (env.radius > 0 and env.radius <= radius and env.prior >= env_prior)) then
					if not art or not (art == num) then
						if SB_DEBUG then Msg("ent is on environment("..num..")\n") end
						found = true
						env_num = num
						radius = env.radius
						env_prior = env.prior
					end
				end
			end
		end
	end
	return found, env_num
end

function SB_Bloom(ent, Col_r, Col_g, Col_b, SizeX, SizeY, Passes, Darken, Multiply, Color)
	local bloom = {} --bloomid in init combine to planet
	if SB_DEBUG then
		Msg("Creating bloom for "..tostring(ent).."\n")
		Msg("Col_r/b/g: "..tostring(Col_r).."/"..tostring(Col_b).."/"..tostring(Col_g).."\n")
		Msg("SizeX/Y: "..tostring(SizeX).."/"..tostring(SizeY).."\n")
		Msg("Passes: "..tostring(Passes).."\n")
		Msg("Darken: "..tostring(Darken).."\n")
		Msg("Multiply: "..tostring(Multiply).."\n")
		Msg("Color: "..tostring(Color).."\n")
	end
	bloom.ent = ent
	bloom.Col_r = Col_r
	bloom.Col_g = Col_g
	bloom.Col_b = Col_b
	bloom.SizeX = SizeX
	bloom.SizeY = SizeY
	bloom.Passes = Passes
	bloom.Darken = Darken
	bloom.Multiply = Multiply
	bloom.Color = Color
	return bloom
end

function SB_Color(ent, AddColor_r, AddColor_g, AddColor_b, MulColor_r, MulColor_g, MulColor_b, Brightness, Contrast, Color)
	local color = {}--colorid in init combine to planet
	if SB_DEBUG then
		Msg("Creating color for "..tostring(ent).."\n")
		Msg("AddColor_r/b/g: "..tostring(AddColor_r).."/"..tostring(AddColor_b).."/"..tostring(AddColor_g).."\n")
		Msg("AddColor_r/b/g: "..tostring(MulColor_r).."/"..tostring(MulColor_b).."/"..tostring(MulColor_g).."\n")
		Msg("Brightness: "..tostring(Brightness).."\n")
		Msg("Contrast: "..tostring(Contrast).."\n")
		Msg("Color: "..tostring(Color).."\n")
	end
	color.ent = ent
	color.AddColor_r = AddColor_r
	color.AddColor_g = AddColor_g
	color.AddColor_b = AddColor_b
	color.MulColor_r = MulColor_r
	color.MulColor_g = MulColor_g
	color.MulColor_b = MulColor_b
	color.Brightness = Brightness
	color.Contrast = Contrast
	color.Color = Color
	return color
end

function SB_Terraform_Step(ent, num, lt, st, hab,atm)
	if ent:IsValid() and environments[num].tf and environments[num].tf == ent and ent.Active == 1 then
		local ok = true 
		local tmp = 0
		local hb = 0
		local at = 0
		if ent.health < (ent.maxhealth/2) then --unstable terraforming when damaged!
			tmp = math.random(-50, 50)
			hb = math.random(-10, 0)
			at = math.random(-10, 10)
		end
		--ltemperature
		if environments[num].ltemperature < lt then
			if environments[num].ltemperature + 2 < lt then
				environments[num].ltemperature =environments[num].ltemperature + 4 + (tmp/10)
				ok = false
			else
				environments[num].ltemperature = lt + (tmp/10)
			end
		elseif environments[num].ltemperature > lt then
			if environments[num].ltemperature - 2 > lt then
				environments[num].ltemperature = environments[num].ltemperature - 2 + (tmp/10)
				ok = false
			else
				environments[num].ltemperature = lt + (tmp/10)
			end
		end
		--stemperature
		if environments[num].stemperature < st then
			if environments[num].stemperature + 2 < st then
				environments[num].stemperature = environments[num].stemperature + 2 + (tmp/10)
				ok = false
			else
				environments[num].stemperature = st + (tmp/10)
			end
		elseif environments[num].stemperature > st then
			if environments[num].stemperature - 2 > st then
				environments[num].stemperature = environments[num].stemperature - 2 + (tmp/10)
				ok = false
			else
				environments[num].stemperature = st + (tmp/10)
			end
		end
		-- habitat
		if environments[num].habitat < hab then
			if environments[num].habitat + 0.05 < hab then
				environments[num].habitat = environments[num].habitat + 0.05 + (hb/100)
				ok = false
			else
				environments[num].habitat = hab + (hb/100)
			end
		elseif environments[num].habitat > hab then
			if environments[num].habitat - 0.05 > hab then
				environments[num].habitat = environments[num].habitat - 0.05 + (hb/100)
				ok = false
			else
				environments[num].habitat = hab + (hb/100)
			end
		end
		--atmosphere
		if environments[num].atmosphere < atm then
			if environments[num].atmosphere + 0.05 < atm then
				environments[num].atmosphere = environments[num].atmosphere + 0.05 + (at/100)
				ok = false
			else
				environments[num].atmosphere = atm + (at/100)
			end
		elseif environments[num].atmosphere > atm then
			if environments[num].atmosphere - 0.05 > atm then
				environments[num].atmosphere = environments[num].atmosphere - 0.05 + (at/100)
				ok = false
			else
				environments[num].atmosphere = atm + (at/100)
			end
		end
		if not ok then
			timer.Simple(6, function() SB_Terraform_Step(ent, num, lt, st, hab,atm) end )
		end
	end
end

function SB_Terraform_UnStep(ent, num, other)
	if not other and not ent:IsValid() or (ent.Active == 0 and environments[num].tf and environments[num].tf == ent) then 
		local lt = Backup[num].ltemperature
		local st = Backup[num].stemperature
		local hab = Backup[num].habitat
		local atm = Backup[num].atmosphere
		local ok = true 
		local tmp = 0
		local hb = 0
		local at = 0
		--ltemperature
		if environments[num].ltemperature < lt then
			if environments[num].ltemperature + 2 < lt then
				environments[num].ltemperature =environments[num].ltemperature + 2 + (tmp/10)
				ok = false
			else
				environments[num].ltemperature = lt + (tmp/10)
			end
		elseif environments[num].ltemperature > lt then
			if environments[num].ltemperature - 2 > lt then
				environments[num].ltemperature = environments[num].ltemperature - 2 + (tmp/10)
				ok = false
			else
				environments[num].ltemperature = lt + (tmp/10)
			end
		end
		--stemperature
		if environments[num].stemperature < st then
			if environments[num].stemperature + 2 < st then
				environments[num].stemperature = environments[num].stemperature + 2 + (tmp/10)
				ok = false
			else
				environments[num].stemperature = st + (tmp/10)
			end
		elseif environments[num].stemperature > st then
			if environments[num].stemperature - 2 > st then
				environments[num].stemperature = environments[num].stemperature - 2 + (tmp/10)
				ok = false
			else
				environments[num].stemperature = st + (tmp/10)
			end
		end
		-- habitat
		if environments[num].habitat < hab then
			if environments[num].habitat + 0.05 < hab then
				environments[num].habitat = environments[num].habitat + 0.05 + (hb/100)
				ok = false
			else
				environments[num].habitat = hab + (hb/100)
			end
		elseif environments[num].habitat > hab then
			if environments[num].habitat - 0.05 > hab then
				environments[num].habitat = environments[num].habitat - 0.05 + (hb/100)
				ok = false
			else
				environments[num].habitat = hab + (hb/100)
			end
		end
		--atmosphere
		if environments[num].atmosphere < atm then
			if environments[num].atmosphere + 0.05 < atm then
				environments[num].atmosphere = environments[num].atmosphere + 0.05 + (at/100)
				ok = false
			else
				environments[num].atmosphere = atm + (at/100)
			end
		elseif environments[num].atmosphere > atm then
			if environments[num].atmosphere - 0.05 > atm then
				environments[num].atmosphere = environments[num].atmosphere - 0.05 + (at/100)
				ok = false
			else
				environments[num].atmosphere = atm + (at/100)
			end
		end
		if not ok then
			timer.Simple(6, function() SB_Terraform_UnStep(ent, num, other) end )
		end
	end
end

function Extract_Bit ( bit, field )
	--highest bit is 4
	local retval = 0
	if ((field <= 7) and (bit <= 4)) then
		if (field >= 4) then
			field = field - 4
			if (bit == 4) then return 1 end
		end
		if (field >= 2) then
			field = field - 2
			if (bit == 2) then return 1 end
		end
		if (field >= 1) then
			field = field - 1
			if (bit == 1) then return 1 end
		end
	else
		return 0
	end
	return 0
end

function SB_Planet_Quake()
	for _, env in pairs( environments ) do
		if (env.unstable == 1) then
			if (math.random(1, 20) < 2) then
				env.ent:Fire("invalue","shake","0") 
				env.ent:Fire("invalue","rumble","0") 
			end
		end
	end
end

function ResetEntsOnEnv(num)
	if not environments[num] then return end
	if SB_DEBUG then Msg("reseting ents on env! -" .. environments[num].radius .. "\n" ) end
	local tmp = ents.FindInSphere(environments[num].ent:GetPos(), environments[num].radius + 256)
	for _, ent in pairs(tmp) do
		if not ent.environment or (ent.environment and (not ent.environment.type == "TerraForm" or (ent.environment.type == "TerraForm" and not ent.Active == 1))) then
			if SB_DEBUG then Msg("resetting "..ent:GetClass().."\n") end
			ent.planet = false
			ent.reset = true
			if SB_DEBUG then Msg("ent.planet: "..tostring(ent.planet).."\n") end
			if SB_DEBUG then Msg("ent.reset: "..tostring(ent.reset).."\n") end
		end
	end
end

function SB_CalculateHabUnStSun(flags)
	return Extract_Bit(1, flags), Extract_Bit(2, flags), Extract_Bit(4, flags)
end

function SB_SetTerraformer(num, tf)
	if environments[num] then
		local hash = environments[num]
		if not hash.tf then
			hash.tf = tf
			return true
		end
	end
	return false
end

function SB_GetTerraformer(num)
	if environments[num] then
		return environments[num].tf
	end
	return
end

function SB_RemTerraformer(num, tf)
	if environments[num] then
		local hash = environments[num]
		if hash.tf and hash.tf == tf then
			hash.tf = nil
			return true
		end
	end
	return false
end

function SB_GetEnvNumRadPlan()
	local hash = {}
	for num, env in pairs(environments) do
		hash[num] = {}
		hash[num].radius = env.radius
		hash[num].planet = env.IsPlanet	
	end
	PrintTable(hash)
	return hash --will return a table will all the current environment numbers, radius and if it's a planet.
end

function SB_GetEnvPos(num)
	if not environments[num] then return 0 end
	return environments[num].ent:GetPos() --will return the current position of an environment
end

function SB_GetPlanetRad(num)
	if not environments[num] then return 0 end
	return environments[num].radius --will return the radius of an environment
end

function SB_IsPlanet(num)
	if not environments[num] then return false end
	return environments[num].IsPlanet --will return the if the environment is a planet or not
end
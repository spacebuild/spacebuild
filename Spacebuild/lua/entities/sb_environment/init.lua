include("Extensions/sv_brush_env_base_funcs.lua")

ENT.Base		= "base_brush"
ENT.Type		= "brush"
ENT.Debugging	= true
ENT.Enabled		= true
ENT.GetEnvClass	= "SB ENVIRONMENT"

SB_Environments_Brush_List = SB_Environments_Brush_List or {}
local Init_Debugging_Override = true

function ENT:Initialize()
	if not self.Initialized then
		self:InitEnvBrush()
	end
	
	CAF.GetAddon("Spacebuild").AddEnvironment(self)


	self.SpacedVector = Vector(self.sbenvironment.DecompressionSettings.X or 0, 
							   self.sbenvironment.DecompressionSettings.Y or 0, 
							   self.sbenvironment.DecompressionSettings.Z or 0)

	if Init_Debugging_Override or self.Debugging then
		Msg("Initialized a new brush env: ", self, "\n")
		Msg("ID is: ", self.ID, "\n")
		Msg("Dumping stats:\n")
		Msg("\n\n------------ START DUMP ------------\n\n")
		PrintTable(self)
		Msg("\n\n------------- END DUMP -------------\n\n")
	end
end

function ENT:StartTouch(entity)
	if not self.Enabled then 
		if self.Debugging then Msg("Entity ", entity, " tried to enter but ", self, " wasn't on.\n") end
		
		return
	elseif self.Debugging then 
		Msg("Entity ", entity, " has started touching ", self, " in unusual places....\n")
	end
	
	entity.IsInEnvBrush = true
	entity.environment = self
	self:UpdateGravity(entity)
	self.Entities[entity] = entity
end

function ENT:EndTouch(entity)
	if self.Debugging then
		Msg("Entity ", entity, " has stopped touching ", self, " in unusual places....\n")
	end
	
	if SB_Environments_Brush_List[self.ParentID] then
		entity.environment = SB_Environments_Brush_List[self.ParentID]
		if self.Debugging then
			Msg("...and has started touching our parent, ", SB_Environments_Brush_List[self.ParentID], " in unusual places....\n")
		end
	else --SPACE TEH BASTERD
		entity.IsInBrushEnv = false
		entity.environment = nil
		
		if self.Debugging then Msg("...and has decided to get spaced.\n") end
	end
	
	self.Entities[entity] = nil
end

function ENT:Space()
	for k, v in pairs(self.Entities) do
		-- I'm assuming that even if they have LS devices that unsuited people have a tendency to DIE when explosive decompression occures
		-- Of course this is dependent on the amount of gases inside
		self.sbenvironment.air.max = self.sbenvironment.air.max or 100 --math.Round(100 * data * 5) * self.sbenvironment.pressure
		if v and v.IsNPC and v:IsNPC() then
			local dmg = self.sbenvironment.pressure *  math.random(1,9001)
			v:TakeDamage(dmg, self, self)
		elseif v and v.IsPlayer and v:IsPlayer() and (not v:InVehicle()) then
			local dmg = self.sbenvironment.pressure * math.random(1,9001)
			v:TakeDamage(dmg, self, self)
		end
		
		local phys = v:GetPhysicsObject()
		
		if phys and phys:IsValid() then
			phys:ApplyForceCenter(self.SpacedVector)
		end
		--and for good measure
		if v.SetVelocityInstantaneous then
			v:SetVelocityInstantaneous(self.SpacedVector)
		elseif v.SetVelocity then
			v:SetVelocity(self.SpacedVector)
		end
		
		v.IsInBrushEnv = false
	end
	
	self.Enabled = false
end

function ENT:AcceptInput(name, activator, caller, data)
	if not self.Initialized then
		self:InitEnvBrush()
	end
	
	if name == "SpaceEnv" then
		self:Space()
		
		return true
	elseif name == "RestoreEnv" then
		self.Enabled = true
		
		return true
	elseif name == "SetPressure" then
		if not (data and (type(data) == "number")) then return Error("Invalid parameter for new pressure in env brush ID" .. self.ID .. "\n") end
		
		if data < 0 then
			data = 0
		elseif data > 1 then
			data = 1
		end
		
		if self.sbenvironment.atmosphere ~= 0 then
			self.sbenvironment.pressure = self.sbenvironment.pressure * (data / self.sbenvironment.atmosphere)
		else
			self.sbenvironment.pressure = self.sbenvironment.pressure * data
		end
		
		if data > self.sbenvironment.atmosphere then
			local tmp = self.sbenvironment.air.max - (self.sbenvironment.air.o2 + self.sbenvironment.air.co2 + self.sbenvironment.air.n + self.sbenvironment.air.h)
			
			self.sbenvironment.air.max = math.Round(100 * data * 5)

			self.sbenvironment.air.empty = tmp
			self.sbenvironment.air.emptyper = self:GetOtherGasPercentage()
		else
			self.sbenvironment.air.o2		= math.Round(self:GetO2Percentage() * data * 5)
			self.sbenvironment.air.co2		= math.Round(self:GetCO2Percentage() * data * 5)
			self.sbenvironment.air.n		= math.Round(self:GetNPercentage() * data * 5)
			self.sbenvironment.air.h		= math.Round(self:GetHPercentage() * data * 5)
			self.sbenvironment.air.empty	= math.Round(self:GetOtherGasPercentage() * data * 5)
			self.sbenvironment.air.max		= math.Round(100 * data * 5)
		end
		
		self.sbenvironment.atmosphere = data
		
		return true
	elseif name == "Temp" then
		SB_BrushEnvironments.SetSunTemp(self.ID, tonumber(data))
		
		
		return true
	elseif name == "SetGravity" then
		if (not data) and (type(data) == "number") then return Error("Invalid parameter for new gravity in env brush ID" .. self.ID .. "\n") end
		
		if self.sbenvironment.gravity ~= 0 then
			self.sbenvironment.pressure = self.sbenvironment.pressure * (data/self.sbenvironment.gravity)
		else
			self.sbenvironment.pressure = self.sbenvironment.pressure * newgravityz
		end
		
		self.sbenvironment.gravity = data
		
		return true
	elseif name == "SetUnstable" then
		self.sbenvironment.unstable = (tonumber(data) == 1)
		
		return true
	end
	
	return false
end

function ENT:OnRemove()

end

function ENT:PassesTriggerFilters(entity)
	if not self.Initialized then
		self:InitEnvBrush()
	end
	
	do
		return true
	end
	
	if self.Debugging then
		Msg("Filtering ", entity, "...\n")
	end
	
	if (not entity.ProcessesEnvChanges) or (not GM.affected[entity.SB_ClassName or entity:GetClass()]) then
		if self.Debugging then
			Msg("Attempting to pass entity: ", entity, "; This was denied.\n")
			Msg("The marker for it was set to ", entity.DontProcessesEnvChanges, ".\n")
		end
		
		entity.ProcessesEnvChanges = false
		return false
	end
	
	entity.SB_ClassName = entity:GetClass()
	entity.ProcessesEnvChanges = true
	
	if self.Debugging then
		Msg("Entity ", entity, " was cleared.\n")
	end
	
	return true
end

function ENT:Think()
end

function ENT:Touch(entity)
end

function ENT:InitEnvBrush()
	SB_Brush_Environment_Load_Base_Func_Extensions1(self) -- HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ!
	
	self.sbenvironment							= {}
	self.sbenvironment.air						= {}
	self.sbenvironment.name						= "Aperture Science Extremely Inelegant Singly Developed Incomprehensible Undocumented Atmospheric Phenomenon Simulation Chamber(r) 2008 - 9001 by Cynical Fruits Productions, a division of Aperture Science Shower Curtains Manufactures Inc."
	self.sbenvironment.BloomSettings			= {}
	self.sbenvironment.ColourModSettings		= {}
	self.sbenvironment.DecompressionSettings	= {}
	
	self.ParentID		= self.ParentID or -1
	self.Enabled		= true
	
	self.Entities		= self.Entities or {}
	self.SpacedVector	= self.SpacedVector or Vector(0, 0, 0)
	
	self.Initialized = true or false -- for the lulz
end

function ENT:SetEnvironmentID(duh)
	self.GazeboOfDeath = duh or 1337
end

function ENT:GetEnvironmentID()
	return self.GazeboOfDeath or 1337
end


function ENT:KeyValue(k, v)
	if not self.Initialized then
		self:InitEnvBrush()
	end
	
	if k == "BrushName" then
		self.EnvName = v
		self.sbenvironment.name = self.EnvName
		return
	end
	
	v = tonumber(v) or 0
	
	-------------------------------------------------------------------------------
	---------			Std. Env Stuff				---------
	-------------------------------------------------------------------------------
	
	
	if k == "BrushEnvID" then
		self.ID = v
		
		if SB_Environments_Brush_List[self.ID] then ErrorNoHalt("NON FATALE ERROR: THERE ARE MULTIPLE USES OF " .. self.ID .. " AS A ENVIRONMENT BRUSH! OVERRIDING!\n") end
		
		SB_Environments_Brush_List[self.ID] = self
	elseif k == "ParentBrushEnvID" then
		self.ParentID = v
	elseif k == "Gravity" then
		self.sbenvironment.gravity = v
	elseif k == "Atmosphere" then
		self.sbenvironment.atmosphere = v
	elseif k == "Pressure" then
		self.sbenvironment.pressure = v
	elseif k == "Temp" then
		self.sbenvironment.temperature = v
	elseif k == "Oxygen" then
		self.sbenvironment.air.o2 = v
	elseif k == "Carbon_Dioxide" then
		self.sbenvironment.air.co2 = v
	elseif k == "Nitrogen" then
		self.sbenvironment.air.n = v
	elseif k == "Hydrogen" then
		self.sbenvironment.air.h = v
	elseif k == "AirThickness" then
		self.sbenvironment.air.AirThickness = v
	elseif k == "Habitable" then
		self.sbenvironment.habitable = v
	elseif k == "Stable" then
		self.sbenvironment.unstable = (v ~= 1)
		
	-------------------------------------------------------------------------------
	---------			Bloom  Stuff					---------
	-------------------------------------------------------------------------------
	
	elseif k == "HasBloom" then
		self.sbenvironment.BloomSettings.Has = (v == 1)
	elseif k == "Bloom_R" then
		self.sbenvironment.BloomSettings.AddRed = v
	elseif k == "Bloom_G" then
		self.sbenvironment.BloomSettings.AddGreen = v
	elseif k == "Bloom_B" then
		self.sbenvironment.BloomSettings.AddBlue = v
	elseif k == "Bloom_X" then
		self.sbenvironment.BloomSettings.Passes_X = v
	elseif k == "Bloom_Y" then
		self.sbenvironment.BloomSettings.Passes_Y = v
	elseif k == "Bloom_Passes" then
		self.sbenvironment.BloomSettings.Passes = v
	elseif k == "Bloom_Darken" then
		self.sbenvironment.BloomSettings.Darken = v
	elseif k == "Bloom_Multiplier" then
		self.sbenvironment.BloomSettings.Multi = v
		
	-------------------------------------------------------------------------------
	---------			Colour Modification Stuff		---------
	-------------------------------------------------------------------------------
		
	elseif k == "Colour_Mod" then
		self.sbenvironment.ColourModSettings.Has = (v == 1)
	elseif k == "Colour_Mod_R" then
		self.sbenvironment.ColourModSettings.AddRed = v
	elseif k == "Colour_Mod_G" then
		self.sbenvironment.ColourModSettings.AddGreen = v
	elseif k == "Colour_Mod_B" then
		self.sbenvironment.ColourModSettings.AddBlue = v
	elseif k == "Colour_Mod_M_R" then
		self.sbenvironment.ColourModSettings.MultiRed = v
	elseif k == "Colour_Mod_M_G" then
		self.sbenvironment.ColourModSettings.MultiGreen = v
	elseif k == "Colour_Mod_M_B" then
		self.sbenvironment.ColourModSettings.MultiBlue = v
	elseif k == "Colour_Mod_Brightness" then
		self.sbenvironment.ColourModSettings.Brightness = v
	elseif k == "Colour_Mod_Contrast" then
		self.sbenvironment.ColourModSettings.Contrast = v
	elseif k == "Colour_Mod_Range" then
		self.sbenvironment.ColourModSettings.Range = v
		
	-------------------------------------------------------------------------------
	---------			Decompression Stuff			---------
	-------------------------------------------------------------------------------
	
	elseif k == "Decompression_Explosion_X" then
		self.sbenvironment.DecompressionSettings.X = v
	elseif k == "Decompression_Explosion_Y" then
		self.sbenvironment.DecompressionSettings.Y = v
	elseif k == "Decompression_Explosion_Z" then		
		self.sbenvironment.DecompressionSettings.Z = v
	else
		ErrorNoHalt("Unhandled KV pair!\n")
		ErrorNoHalt("Key: " .. tostring(k) .. " | Value: " .. tostring(v) .. "\n")
	end
end


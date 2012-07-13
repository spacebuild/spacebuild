ENT.Base		= "base_brush"
ENT.Type		= "brush"
ENT.Debugging	= false

function ENT:Initialize()
	self.SpacedVector = Vector(self.Data.Decompression.X,
								   self.Data.Decompression.Y,
								   self.Data.Decompression.Z)
													
	self.ProcessedData = SB_BrushEnvironments.Add(self.ID, 
							 self.Data.Grav, self.Data.Habitable,
							 self.Data.Pressure, self.Data.SunTemp, 
							 self.Data.ShadowTemp, self.Data.Stable,
							 self.Data.Sunburn, self.Data.IsPlanet,
							 self.Data.Bloom, self.Data.Colour)
							 
	if true or self.Debugging then
		Msg("Initialized a new brush env: ",self,"\n")
		Msg("ID is: ",self.ID,"\n")
		Msg("Dumping stats:\n")
		Msg("\n\n\n------------ START DUMP ------------\n\n\n")
		PrintTable(self.Data)
		Msg("\n\n\n------------- END DUMP -------------\n\n\n")
	end
end

function ENT:StartTouch(entity)
	if not self.Enabled then 
		if true or self.Debugging then
			Msg("Entity ",entity," tried to enter but we weren't on.\n")
		end
		return
	end
	if true or self.Debugging then
		Msg("Entity ",entity," has started touching us in unusual places....\n")
	end
	entity.IsInBrushEnv = true
	SB_BrushEnvironments.ApplyEnv(self.ID,entity)
	
	self.Entities[tostring(entity)] = entity
end

function ENT:EndTouch(entity)
	if true or self.Debugging then
		Msg("Entity ",entity," has stopped touching us in unusual places....\n")
	end
	
	if SB_BrushEnvironments[self.ParentEnvID] then
		SB_BrushEnvironments.ApplyEnv(self.ParentEnvID,entity)
		if true or self.Debugging then
			Msg("...And has started touching our parent in unusual places....\n")
		end
	else --SPACE TEH BASTERD
		entity.IsInBrushEnv = false
		SB_BrushEnvironments.SpaceEnt(entity)
		if true or self.Debugging then
			Msg("...And has decided to get spaced.\n")
		end
	end
	
	self.Entities[tostring(entity)] = nil
end

function ENT:Space()
	for k,v in pairs(self.Entities) do
		local phys = v:GetPhysicsObject()
		local dir = self.SpacedVector*self.Data.Decompression.Power
		
		if phys and phys:IsValid() then
			plys:ApplyForceCenter(dir)
		else
			v:SetVelocity(dir)
		end
		
		v.IsInBrushEnv = false
	end
end

function ENT:AcceptInput(name, activator, caller, data)
	if name == "SpaceEnv" then
		self:Space()
		return true
	elseif name == "RestoreEnv" then
		self.Enabled = true
		return true
	elseif name == "SetPressure" then
		SB_BrushEnvironments.SetPressure(self.ID,tonumber(data))
		return true
	elseif name == "SetSunTemp" then
		SB_BrushEnvironments.SetSunTemp(self.ID,tonumber(data))
		return true
	elseif name == "SetShadowTemp" then
		SB_BrushEnvironments.SetShadowTemp(self.ID,tonumber(data))
		return true
	elseif name == "SetGravity" then
		SB_BrushEnvironments.SetGravity(self.ID,tonumber(data))
		return true
	elseif name == "SetSunburn" then
		SB_BrushEnvironments.SetHasSunburn(self.ID,tonumber(data))
		return true
	elseif name == "SetUnstable" then
		SB_BrushEnvironments.SetIsUnstable(self.ID,tonumber(data))
		return true
	end
	
	return false
end

function ENT:OnRemove()
	if self.ID ~= -1 then
		SB_BrushEnvironments.Remove(self.ID)
	end
end

function ENT:PassesTriggerFilters(entity)
	do
		return true
	end
	if self.Debugging then
		Msg("Filtering ",entity,"...\n")
	end
	
	if (entity.DontProcessesEnvChanges == true) or (not GM.affected[entity.SB_ClassName or entity:GetClass()]) then
		if self.Debugging then
			Msg("Attempting to pass entity: ",entity,"; This was denied.\n")
			Msg("The marker for it was set to ", entity.DontProcessesEnvChanges,".\n")
		end
		entity.SB_ClassName = entity:GetClass()
		entity.DontProcessesEnvChanges = true
		return false
	end
	
	if self.Debugging then
		Msg("Entity ",entity," was cleared.\n")
	end
	
	return true
end

function ENT:Think()
end

function ENT:Touch(entity)
end

function ENT:KeyValue(k,v)
	v = tonumber(v) or 0
	if not self.Data then
		self.ParentEnvID	    = -1
		self.Enabled		    = true
		self.Entities			= {}
		self.Data				= {}
		self.Data.Bloom			= {}
		self.Data.Colour		= {}
		self.Data.Decompression	= {}
		self.ProcessedData		= {}
		self.SpacedVector		= Vector(0,0,0)
	end
	
	if k == "EnvID" then
		self.Data.ID = v
		self.ID = v
	elseif k == "Parent_ID" then
		self.Data.P_ID = v
		self.ParentEnvID = v
	elseif k == "Grav" then
		self.Data.Grav = v
	elseif k == "Atmosphere" then
		self.Data.Pressure = v
	elseif k == "SunTemp" then
		self.Data.SunTemp = v
	elseif k == "ShadowTemp" then
		self.Data.ShadowTemp = v
	elseif k == "Habitable" then
		self.Data.Habitable = v
	elseif k == "Stable" then
		self.Data.Stable = (v == 1)
	elseif k == "IsPlanet" then
		self.Data.IsPlanet = (v == 1)
	elseif k == "Sunburn" then
		self.Data.Sunburn = (v == 1)
	elseif k == "HasBloom" then
		self.Data.Bloom.Has = (v == 1)
	elseif k == "Bloom_R" then
		self.Data.Bloom.AddRed = v
	elseif k == "Bloom_G" then
		self.Data.Bloom.AddGreen = v
	elseif k == "Bloom_B" then
		self.Data.Bloom.AddBlue = v
	elseif k == "Bloom_X" then
		self.Data.Bloom.Passes_X = v
	elseif k == "Bloom_Y" then
		self.Data.Bloom.Passes_Y = v
	elseif k == "Bloom_Passes" then
		self.Data.Bloom.Passes = v
	elseif k == "Bloom_Darken" then
		self.Data.Bloom.Darken = v
	elseif k == "Bloom_Multi" then
		self.Data.Bloom.Multi = v
	elseif k == "Colour_Mod" then
		self.Data.Colour.Has = (v == 1)
	elseif k == "Colour_Mod_R" then
		self.Data.Colour.AddRed = v
	elseif k == "Colour_Mod_G" then
		self.Data.Colour.AddGreen = v
	elseif k == "Colour_Mod_B" then
		self.Data.Colour.AddBlue = v
	elseif k == "Colour_Mod_M_R" then
		self.Data.Colour.MultiRed = v
	elseif k == "Colour_Mod_M_G" then
		self.Data.Colour.MultiGreen = v
	elseif k == "Colour_Mod_M_B" then
		self.Data.Colour.MultiBlue = v
	elseif k == "Colour_Mod_Brightness" then
		self.Data.Colour.Brightness = v
	elseif k == "Colour_Mod_Contrast" then
		self.Data.Colour.Contrast = v
	elseif k == "Decompression_Explosion" then
		self.Data.Decompression.Has = (v == 1)
	elseif k == "Decompression_Explosion_Power" then
		self.Data.Decompression.Power = v
	elseif k == "Decompression_Explosion_X" then
		self.Data.Decompression.X = v
	elseif k == "Decompression_Explosion_Y" then
		self.Data.Decompression.Y = v
	elseif k == "Decompression_Explosion_Z" then		
		self.Data.Decompression.Z = v
	end
end
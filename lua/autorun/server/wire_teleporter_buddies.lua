-- these teleport functions depends on CPPI buddies
local playerMeta = FindMetaTable("Player")

function playerMeta:CPPICanBeTeleportedBy(ply)
    if (CPPI and self.Buddies and self.Buddies[ply]) then
    	if (self.Buddies[ply]["Physgun"]) then
    		return true
    	end
    end

    return false
end


-- this is the ENT:Jump function from gmod_wire_teleporter.lua with gravity plate handling added
function JumpWithPlayers( self, withangles )
	--------------------------------------------------------------------
	-- Check for errors
	--------------------------------------------------------------------

	-- Is already teleporting
	if (self.Jumping) then
		return
	end

	-- The target position is outside the world
	if (!util.IsInWorld( self.TargetPos )) then
		self:EmitSound("buttons/button8.wav")
		return
	end

	-- The position or angle hasn't changed
	if (self:GetPos() == self.TargetPos and self:GetAngles() == self.TargetAng) then
		self:EmitSound("buttons/button8.wav")
		return
	end



	--------------------------------------------------------------------
	-- Find other entities
	--------------------------------------------------------------------

	-- Get the localized positions
	local teleEnts = constraint.GetAllConstrainedEntities( self )

	-- If the teleporter is parented, and not constrained, then get the contraption of the parent instead
	local val = next(teleEnts) -- the first value of GetAllConstrainedEntities is always 'self', so we skip this value and check the next
	if next(teleEnts,val) == nil and IsValid(self:GetParent()) then
		teleEnts = constraint.GetAllConstrainedEntities( self:GetParent() )
	end

	--[[-------------------------------------------------------------------------
	Begin SA Override
	---------------------------------------------------------------------------]]
	
	-- for each ent in the hoverdrives radius

	local TeleOwner,id = self:CPPIGetOwner()

	for _, ent in pairs( ents.FindInSphere(self:GetPos(), self.TeleportRadius or 0) ) do

		-- if the entity is balls or we already know about it move on
		if ((not IsValid(ent)) or table.HasValue(teleEnts,ent) ) then continue end

		-- if it's a player
		if ( ent:IsPlayer() )  then
			-- if they can be teleported by the owner of the teleporter
			if (ent:CPPICanBeTeleportedBy(TeleOwner)) then
				print(1)
				-- if they're in a vehicle
				if (ent:InVehicle()) then
					-- add each entity if it's not already in there
					for __, vConstrainedEnt in pairs(constraint.GetAllConstrainedEntities( ent )) do
						if (not table.HasValue(teleEnts, vConstrainedEnt)) then
							table.insert(teleEnts, vConstrainedEnt)
						end
					end
				else
					-- only add the player if they're not in a vehicle! if they're in a vehicle the vehicle will be added instead
					table.insert(teleEnts, ent)
				end
			end
		-- if it's not a player
		elseif (!ent:IsWorld()) then
			-- if it can be teleported by the owner of the teleporter
			local propOwner, propid = ent:CPPIGetOwner()

			if (not IsValid(propOwner)) or propOwner:IsWorld() or propOwner:GetClass()=="bodyque" then continue end

			if (propOwner and propOwner:CPPICanBeTeleportedBy(TeleOwner)) then
				-- add the whole contraption
				for __, vConstrainedEnt in pairs(constraint.GetAllConstrainedEntities( ent )) do
					-- but only add each ent if it's not already in there
					if (not table.HasValue(teleEnts, vConstrainedEnt)) then
						table.insert(teleEnts, vConstrainedEnt)
					end
				end
			end
		end
			
	end
	--[[-------------------------------------------------------------------------
	End SA Override
	---------------------------------------------------------------------------]]

	-- Check world
	self.Entities = {}
	self.OtherEntities = {}
	for _, ent in pairs( teleEnts ) do
		-- Calculate the position after teleport, without actually moving the entity
		local pos = self:WorldToLocal( ent:GetPos() )
		pos:Rotate( self.TargetAng )
		pos = pos + self.TargetPos

		local b = util.IsInWorld( pos )
		if not b then -- If an entity will be outside the world after teleporting..
			self:EmitSound("buttons/button8.wav")
			return
		elseif ent ~= self then -- if the entity is not equal to self
			if self:CheckAllowed( ent ) then -- If the entity can be teleported
				self.Entities[#self.Entities+1] = ent
			else -- If the entity can't be teleported
				self.OtherEntities[#self.OtherEntities+1] = ent
			end
		end
	end

	-- All error checking passed
	self.Jumping = true

	--------------------------------------------------------------------
	-- Sound and visual effects
	--------------------------------------------------------------------
	if self.UseSounds then self:EmitSound("ambient/levels/citadel/weapon_disintegrate2.wav") end -- Starting sound

	if self.UseEffects then
		-- Effect out
		local effectdata = EffectData()
		effectdata:SetEntity( self )
		local Dir = (self.TargetPos - self:GetPos())
		Dir:Normalize()
		effectdata:SetOrigin( self:GetPos() + Dir * math.Clamp( self:BoundingRadius() * 5, 180, 4092 ) )
		util.Effect( "jump_out", effectdata, true, true )

		DoPropSpawnedEffect( self )

		for _, ent in pairs( teleEnts ) do
			-- Effect out
			local effectdata = EffectData()
			effectdata:SetEntity( ent )
			effectdata:SetOrigin( self:GetPos() + Dir * math.Clamp( ent:BoundingRadius() * 5, 180, 4092 ) )
			util.Effect( "jump_out", effectdata, true, true )
		end
	end

	-- Call the next stage after a short time. This small delay is necessary for sounds and effects to work properly.
	timer.Simple( 0.05, function() self:Jump_Part2( withangles ) end )

	
end

-- this is the original teleporter triggerinput with TeleportRadius added
function TriggerInputOverride(self, iname, value)
	if (iname == "Jump") then
		if (value ~= 0 and not self.Jumping) then
			self:Jump(self.UseAngle or self.Inputs.TargetAngle.Src ~= nil)
			self.UseAngle = false
		end
	elseif (iname == "TargetPos") then
		self.TargetPos = value
	elseif (iname == "X") then
		self.TargetPos.x = value
	elseif (iname == "Y") then
		self.TargetPos.y = value
	elseif (iname == "Z") then
		self.TargetPos.z = value
	elseif (iname == "TargetAngle") then
		self.TargetAng = value
		-- if the angle is set, we should use it for jumping
		-- even if there's nothing connected to the angle wire.
		-- otherwise, we can't use wirelink for angles.
		self.UseAngle = true
	elseif (iname == "Sound") then
		self.UseSounds = value ~= 0
	elseif (iname == "Radius") then
		self.TeleportRadius = value
	end

	self:ShowOutput()
end

-- this is the original init with inputs and resources added, because we need it to not create the default inputs
function InitializeOverride(self)
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.Jumping = false
	self.TargetPos = self:GetPos()
	self.TargetAng = self:GetAngles()
	self.Entities = {}
	self.LocalPos = {}
	self.LocalAng = {}
	self.LocalVel = {}
	self.UseSounds = true
	self.UseEffects = true

	self.ClassSpecificActions = {
		gmod_wire_hoverball = function( ent, oldpos, newpos ) ent:SetZTarget( newpos.z ) end,
		gmod_toggleablehoverball = function( ent, oldpos, newpos ) ent:SetTargetZ( newpos.z ) end,
		gmod_hoverball = function( ent, oldpos, newpos ) ent.dt.TargetZ = newpos.z end,
	}

	self:ShowOutput()

	self.Inputs = Wire_CreateInputs( self, { "Jump", "TargetPos [VECTOR]", "X", "Y", "Z", "TargetAngle [ANGLE]", "Sound", "Radius" })

end



hook.Add( "InitPostEntity", "override_tele_jump_with_grav_plating", function()
	local gmod_wire_teleporter_meta = scripted_ents.GetStored( "gmod_wire_teleporter" )

	gmod_wire_teleporter_meta.t.Jump = JumpWithPlayers
	gmod_wire_teleporter_meta.t.Initialize = InitializeOverride
	gmod_wire_teleporter_meta.TeleportRadius = 0
	gmod_wire_teleporter_meta.t.TriggerInput = TriggerInputOverride

end)
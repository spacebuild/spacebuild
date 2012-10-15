--load our other stools first
--include( "RD2/tool_manifest.lua" )

--dev link stool
--TOOL			= ToolObj:Create()
TOOL.Mode		= "rd3_dev_link"
TOOL.Category		= "Resource Distribution"
TOOL.Name		= "#Link Tool"
TOOL.Command		= nil
TOOL.ConfigName	= ''

if (CLIENT and GetConVarNumber("CAF_UseTab") == 1) then TOOL.Tab = "Custom Addon Framework" end

if ( CLIENT ) then
	language.Add( "tool.rd3_dev_link.name", "Link Tool" )
	language.Add( "tool.rd3_dev_link.desc", "Links Resource-Carrying Devices together to a Resource Node, including Vehicle Pods." )
	language.Add( "tool.rd3_dev_link.0", "Left Click: Link Devices.  Right Click: Unlink Two Devices.  Reload: Unlink Device from All." )
	language.Add( "tool.rd3_dev_link.1", "Click on another Resource-Carrying Device(or Vehicle Pod)" )
	language.Add( "tool.rd3_dev_link.2", "Right-Click on another Resource-Carrying Device(or the same one to unlink ALL)" )
	language.Add( "rd3_dev_link_addlength", "Add Length:" )
	language.Add( "rd3_dev_link_width", "Width:" )
	language.Add( "rd3_dev_link_material", "Material:" )
	language.Add( "rd3_dev_link_colour", "Color:")
end

TOOL.ClientConVar[ "material" ] = "cable/cable2"
TOOL.ClientConVar[ "width" ] = "2"
TOOL.ClientConVar[ "color_r" ] = "255"
TOOL.ClientConVar[ "color_g" ] = "255"
TOOL.ClientConVar[ "color_b" ] = "255"
TOOL.ClientConVar[ "color_a" ] = "255"

function TOOL:LeftClick( trace )
	--if not valid or player, exit
	if ( trace.Entity:IsValid() and trace.Entity:IsPlayer() ) then return end
	--if client exit
	if ( CLIENT ) then return true end
	-- If there's no physics object then we can't constraint it!
	if ( !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	--how many objects stored
	local iNum = self:NumObjects() + 1

	--save clicked postion
	self:SetObject( iNum, trace.Entity, trace.HitPos, trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone ), trace.PhysicsBone, trace.HitNormal )

	--first clicked object
	if iNum == 1 then
		--remove from any LS system since we are changing its link
		CAF.GetAddon("Resource Distribution").Unlink(self:GetEnt(1))
		if self:GetEnt(1).IsNode then
			CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(1) )
		end
		--save beam settings
		CAF.GetAddon("Resource Distribution").Beam_settings( self:GetEnt(1), self:GetClientInfo("material"), self:GetClientInfo("width"), Color(self:GetClientInfo("color_r"), self:GetClientInfo("color_g"), self:GetClientInfo("color_b"), self:GetClientInfo("color_a")) )
	end
	if iNum == 2 then
		if self:GetEnt(2).IsNode then
			CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(2) )
		end
	end

	--add beam point
	CAF.GetAddon("Resource Distribution").Beam_add(self:GetEnt(1), trace.Entity, trace.Entity:WorldToLocal(trace.HitPos+trace.HitNormal))

	--if finishing, run StartTouch on Resource Node to do link
	if ( iNum > 1 ) then
		local Ent1 = self:GetEnt(1) 	--get first ent
		local Ent2 = self:GetEnt(iNum) 	--get last ent
		local length = ( self:GetPos(1) - self:GetPos(iNum)):Length()

		if Ent1.IsNode and Ent2.IsNode then
			if length <= Ent1.range or length <= Ent2.range then
				CAF.GetAddon("Resource Distribution").linkNodes(Ent1.netid, Ent2.netid)
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('These 2 Nodes are to far appart!', NOTIFY_GENERIC, 7);" )

				--clear beam points
				CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(1) )

				self:ClearObjects()	--clear objects
				return			--failure
			end
		elseif Ent1.IsNode and table.Count(CAF.GetAddon("Resource Distribution").GetEntityTable(Ent2)) > 0 then
			if length <= Ent1.range then
				CAF.GetAddon("Resource Distribution").Link(Ent2, Ent1.netid)
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('The Entity and the Node are to far appart!', NOTIFY_GENERIC, 7);" )

				--clear beam points
				CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(1) )

				self:ClearObjects()	--clear objects
				return			--failure
			end
		elseif Ent2.IsNode and table.Count(CAF.GetAddon("Resource Distribution").GetEntityTable(Ent1)) > 0 then
			if length <= Ent2.range then
				CAF.GetAddon("Resource Distribution").Link(Ent1, Ent2.netid)
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('The Entity and the Node are to far appart!', NOTIFY_GENERIC, 7);" )

				--clear beam points
				CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(1) )

				self:ClearObjects()	--clear objects
				return			--failure
			end
		elseif Ent1.IsNode and Ent2.IsPump then
			if length <= Ent1.range then
				Ent2:SetNetwork(Ent1.netid)
				Ent2:SetResourceNode(Ent1)
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('The Pump and the Node are to far appart!', NOTIFY_GENERIC, 7);" )

				--clear beam points
				CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(1) )

				self:ClearObjects()	--clear objects
				return			--failure
			end
		elseif Ent2.IsNode and Ent1.IsPump then
			if length <= Ent2.range then
				Ent1:SetNetwork(Ent2.netid)
				Ent1.node = Ent2
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('The Pump and the Node are to far appart!', NOTIFY_GENERIC, 7);" )

				--clear beam points
				CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(1) )

				self:ClearObjects()	--clear objects
				return			--failure
			end
		else
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Invalid Combination!', NOTIFY_GENERIC, 7);" )

			--clear beam points
			CAF.GetAddon("Resource Distribution").Beam_clear( self:GetEnt(1) )

			self:ClearObjects()	--clear objects
			return			--failure
		end

		--if first ent is the node, transfer beam info to last ent
		if Ent1.IsNode then CAF.GetAddon("Resource Distribution").Beam_switch( self:GetEnt(1), self:GetEnt(iNum) ) end

		self:ClearObjects()	--clear objects
	else
		self:SetStage( iNum )
	end

	--success!
	return true
end

function TOOL:RightClick( trace )
	--if not valid or player, exit
	if ( trace.Entity:IsValid() and trace.Entity:IsPlayer() ) then return end
	--if client exit
	if ( CLIENT ) then return true end
	-- If there's no physics object then we can't constraint it!
	if ( SERVER and !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	--how many objects stored
	local iNum = self:NumObjects() + 1

	--save clicked postion
	self:SetObject( iNum, trace.Entity, trace.HitPos, trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone ), trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 1 ) then
		-- Get information we're about to use
		local Ent1, Ent2 = self:GetEnt(1), self:GetEnt(2)

		if (Ent1 == Ent2) then
			if Ent1.IsNode then
				CAF.GetAddon("Resource Distribution").UnlinkAllFromNode(Ent1.netid)
			elseif Ent1.IsValve then
				if Ent1.IsEntityValve then
					Ent1:SetRDEntity(nil)
					Ent1:SetNode(nil)
				else
					Ent1:SetNode1(nil)
					Ent1:SetNode2(nil)
				end
			elseif Ent1.IsPump then
				Ent1.node = nil
				Ent1:SetNetwork(0)
				CAF.GetAddon("Resource Distribution").Beam_clear( Ent1 )
			else
				CAF.GetAddon("Resource Distribution").Unlink(Ent1)
			end
		else
			if Ent1.IsNode and Ent2.IsNode then
				CAF.GetAddon("Resource Distribution").UnlinkNodes(Ent1.netid, Ent2.netid)
			elseif Ent1.IsValve and Ent2.IsNode then
				if Ent1.IsEntityValve then
					if Ent1:GetNode() and Ent1:GetNode() == Ent2 then
						Ent1:SetNode(nil)
					else
						self:GetOwner():SendLua( "GAMEMODE:AddNotify('This Entity Valve and Resource Node weren't connected!', NOTIFY_GENERIC, 7);" )
					end
				else
					if Ent1:GetNode() and Ent1:GetNode1() == Ent2 then
						Ent1:SetNode1(nil)
					elseif Ent1:GetNode2() and Ent1:GetNode2() == Ent2 then
						Ent1:SetNode2(nil)
					else
						self:GetOwner():SendLua( "GAMEMODE:AddNotify('This Resource Node Valve and Resource Node weren't connected!', NOTIFY_GENERIC, 7);" )
					end
				end
			elseif Ent2.IsValve and Ent1.IsNode then
				if Ent2.IsEntityValve then
					if Ent2:GetNode() and Ent2:GetNode() == Ent1 then
						Ent2:SetNode(nil)
					else
						self:GetOwner():SendLua( "GAMEMODE:AddNotify('This Entity Valve and Resource Node weren't connected!', NOTIFY_GENERIC, 7);" )
					end
				else
					if Ent2:GetNode() and Ent2:GetNode1() == Ent1 then
						Ent2:SetNode1(nil)
					elseif Ent2:GetNode2() and Ent2:GetNode2() == Ent1 then
						Ent2:SetNode2(nil)
					else
						self:GetOwner():SendLua( "GAMEMODE:AddNotify('This Resource Node Valve and Resource Node weren't connected!', NOTIFY_GENERIC, 7);" )
					end
				end
			elseif Ent1.IsPump and Ent2.IsNode then
				Ent1.node = nil
				Ent1:SetNetwork(0)
				CAF.GetAddon("Resource Distribution").Beam_clear( Ent1 )
			elseif Ent2.IsPump and Ent1.IsNode then
				Ent2.node = nil
				Ent2:SetNetwork(0)
				CAF.GetAddon("Resource Distribution").Beam_clear( Ent2 )
			elseif Ent1.IsValve and Ent1.IsEntityValve and table.Count(CAF.GetAddon("Resource Distribution").GetEntityTable(Ent2)) > 0 then
				if Ent1:GetRDEntity() and Ent1:GetRDEntity() == Ent2 then
					Ent1:SetRDEntity(nil)
				else
					self:GetOwner():SendLua( "GAMEMODE:AddNotify('This Entity Valve and Entity weren't connected!', NOTIFY_GENERIC, 7);" )
				end
			elseif Ent2.IsValve and Ent2.IsEntityValve and table.Count(CAF.GetAddon("Resource Distribution").GetEntityTable(Ent1)) > 0 then
				if Ent2:GetRDEntity() and Ent2:GetRDEntity() == Ent1 then
					Ent2:SetRDEntity(nil)
				else
					self:GetOwner():SendLua( "GAMEMODE:AddNotify('This Entity Valve and Entity weren't connected!', NOTIFY_GENERIC, 7);" )
				end
			elseif Ent1.IsNode and table.Count(CAF.GetAddon("Resource Distribution").GetEntityTable(Ent2)) > 0 and CAF.GetAddon("Resource Distribution").GetEntityTable(Ent2).network == Ent1.netid then
				CAF.GetAddon("Resource Distribution").Unlink(Ent2)
			elseif Ent2.IsNode and table.Count(CAF.GetAddon("Resource Distribution").GetEntityTable(Ent1)) > 0 and CAF.GetAddon("Resource Distribution").GetEntityTable(Ent1).network == Ent2.netid  then
				CAF.GetAddon("Resource Distribution").Unlink(Ent1)
			else
				self:GetOwner():SendLua( "GAMEMODE:AddNotify('Invalid Combination!', NOTIFY_GENERIC, 7);" )
			end
		end

		-- Clear the objects so we're ready to go again
		self:ClearObjects()
	else
		self:SetStage( iNum )
	end

	return true
end

function TOOL:Reload(trace)
	--if not valid or player, exit
	if ( trace.Entity:IsValid() and trace.Entity:IsPlayer() ) then return end
	--if client exit
	if ( CLIENT ) then return true end

	if trace.Entity.IsNode then
		CAF.GetAddon("Resource Distribution").UnlinkAllFromNode(trace.Entity.netid)
	elseif trace.Entity.IsValve then
		if trace.Entity.IsEntityValve then
			trace.Entity:SetRDEntity(nil)
			trace.Entity:SetNode(nil)
		else
			trace.Entity:SetNode1(nil)
			trace.Entity:SetNode2(nil)
		end
	elseif trace.Entity.IsPump then
		trace.Entity.node = nil
		trace.Entity:SetNetwork(0)
		CAF.GetAddon("Resource Distribution").Beam_clear( trace.Entity )
	else
		CAF.GetAddon("Resource Distribution").Unlink(trace.Entity)
	end

	self:ClearObjects()	--clear objects
	return true
end

function TOOL.BuildCPanel( panel )
	panel:AddControl( "Header", { Text = "#tool.rd3_dev_link.name", Description	= "#tool.rd3_dev_link.desc" }  )

	panel:AddControl("Slider", {
		Label = "#rd3_dev_link_width",
		Type = "Float",
		Min = ".1",
		Max = "20",
		Command = "rd3_dev_link_width"
	})

	panel:AddControl( "MatSelect", {
		Height = "1",
		Label = "#rd3_dev_link_material",
		ItemWidth = 24,
		ItemHeight = 64,
		ConVar = "rd3_dev_link_material",
		Options = list.Get( "BeamMaterials" )
	})

	panel:AddControl("Color", {
		Label = "#rd3_dev_link_colour",
		Red = "rd3_dev_link_color_r",
		Green = "rd3_dev_link_color_g",
		Blue = "rd3_dev_link_color_b",
		ShowAlpha = "1",
		ShowHSV = "1",
		ShowRGB = "1",
		Multiplier = "255"
	})
end


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
	if trace.Entity:IsValid() and trace.Entity:IsPlayer() then return end
	--if client exit
	if CLIENT  then return true end
	-- If there's no physics object then we can't constraint it!
	if not util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone )  then return false end
	if not trace.Entity.rdobject then self:GetOwner():SendLua( "GAMEMODE:AddNotify('Not a valid RD entity!', NOTIFY_GENERIC, 7);" ) return false end

	--how many objects stored
	local iNum = self:NumObjects() + 1

	--save clicked postion
	self:SetObject( iNum, trace.Entity, trace.HitPos, trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone ), trace.PhysicsBone, trace.HitNormal )

	if iNum > 1 then
		local ent1 = self:GetEnt(1) 	--get first ent
		local ent2 = self:GetEnt(iNum) 	--get last ent
		local length = ( self:GetPos(1) - self:GetPos(iNum)):Length()
		local inRange1 = not ent1.range or ent1.range >= length
		local inRange2 = not ent2.range or ent2.range >= length

		if not ent1.rdobject:canLink(ent2.rdobject) then
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Invalid Combination!', NOTIFY_GENERIC, 7);" )
		elseif not inRange1 or not inRange2 then
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('These 2 entities are too far apart!', NOTIFY_GENERIC, 7);" )
		else
			ent1.rdobject:link(ent2.rdobject)
			local material = self:GetClientInfo("material")
			local width = tonumber(self:GetClientInfo("width"))
			local color =  Color(self:GetClientInfo("color_r"), self:GetClientInfo("color_g"), self:GetClientInfo("color_b"), self:GetClientInfo("color_a"))

			ent1.rdobject:addBeam(ent2.rdobject:getID(), material, width, color);
			ent2.rdobject:addBeam(ent1.rdobject:getID(), material, width, color);
		end

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
	if ( SERVER and not util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	--how many objects stored
	local iNum = self:NumObjects() + 1

	--save clicked postion
	self:SetObject( iNum, trace.Entity, trace.HitPos, trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone ), trace.PhysicsBone, trace.HitNormal )

	if iNum > 1  then
		-- Get information we're about to use
		local Ent1, Ent2 = self:GetEnt(1), self:GetEnt(2)

		if Ent1 == Ent2 and Ent1.rdobject then
			Ent1.rdobject:unlink()
			Ent1.rdobject:removeBeams()
		elseif Ent1.rdobject and Ent2.rdobject then
			Ent1.rdobject:unlink(Ent2.rdobject)
			Ent1.rdobject:removeBeam(Ent2.rdobject:getID());
			Ent2.rdobject:removeBeam(Ent1.rdobject:getID());
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

	if trace.Entity.rdobject then
		trace.entity.rdobject:unlink()
		trace.entity.rdobject:removeBeams()
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


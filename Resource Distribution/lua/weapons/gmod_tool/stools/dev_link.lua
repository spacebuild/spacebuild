if not ( RES_DISTRIB == 2 ) then Error("Please Install Resource Distribution 2 Addon.'" ) return end

TOOL.Category = '(Resource Dist.)'
TOOL.Name = '#Link Tool'
TOOL.Command = nil
TOOL.ConfigName = ''
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end

if ( CLIENT ) then
	language.Add( "tool.dev_link.name", "Link Tool" )
	language.Add( "tool.dev_link.desc", "Links Resource-Carrying Devices together, including Vehicle Pods." )
	language.Add( "tool.dev_link.0", "Left Click: Link Devices.  Right Click: Unlink Two Devices.  Reload: Unlink Device from All." )
    language.Add( "tool.dev_link.1", "Click on another Resource-Carrying Device(or Vehicle Pod)" )
    language.Add( "tool.dev_link.2", "Right-Click on another Resource-Carrying Device(or the same one to unlink ALL)" )
	
    language.Add( "LinkTool_addlength", "Add Length:" )
    language.Add( "LinkTool_width", "Width:" )
    language.Add( "LinkTool_material", "Material:" )
end

TOOL.ClientConVar[ "width" ] = "2"
TOOL.ClientConVar[ "material" ] = "cable/cable2"
TOOL.ClientConVar[ "color_r" ] = "255"
TOOL.ClientConVar[ "color_g" ] = "255"
TOOL.ClientConVar[ "color_b" ] = "255"

function TOOL:LeftClick( trace )
	if (!trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	
	local iNum = self:NumObjects()
	
	if (SERVER and !trace.Entity.resources2) then
		self:ClearObjects()
		if ( iNum > 0 ) then
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Conduit source invalid!', NOTIFY_GENERIC, 7);" )
		else
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Conduit destination invalid!', NOTIFY_GENERIC, 7);" )
		end
		return
	end
	
	if (CLIENT) then return true end
	
	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )
	
	if ( iNum > 0 ) then
		-- Get client's CVars
		--local addlength	 = self:GetClientNumber( "addlength" )
		local material	= self:GetClientInfo( "material" )
		local width		= self:GetClientNumber( "width" ) 
		local color		= Color(self:GetClientNumber("color_r"), self:GetClientNumber("color_g"), self:GetClientNumber("color_b"))
		
		-- Get information we're about to use
		local Ent1,  Ent2  = self:GetEnt(1),		self:GetEnt(2)
		local Bone1, Bone2 = self:GetBone(1),		self:GetBone(2)
		local WPos1, WPos2 = self:GetPos(1),		self:GetPos(2)
		local LPos1, LPos2 = self:GetLocalPos(1),	self:GetLocalPos(2)
		local length = ( WPos1 - WPos2):Length()
		
		if (!Ent1.resources2)or (!Ent2.resources2) then
			self:ClearObjects()
	        self:GetOwner():SendLua( "GAMEMODE:AddNotify('Conduit invalid!', NOTIFY_GENERIC, 7);" )
			return
		end
		if (Ent1.is_valve) and (Ent2.is_valve) then
			self:ClearObjects()
	        self:GetOwner():SendLua( "GAMEMODE:AddNotify('Valves cannot be link to each other!', NOTIFY_GENERIC, 7);" )
			return
		end
		
		local matched = 0
		
		local Ent1_class = Ent1:GetClass()
		local Ent2_class = Ent2:GetClass()
		if ((Ent1_class == "res_pump") or (Ent1_class == "res_valve") or (Ent1_class == "res_junction"))
		or ((Ent2_class == "res_pump") or (Ent2_class == "res_valve") or (Ent2_class == "res_junction")) then
			matched = 1
		end
		
		if (matched == 0) then
			for res_ID, r1 in pairs( Ent1.resources2 ) do
				if ( Ent2.resources2[ res_ID ] ) then 
					matched = 1
					break
				end
			end
		end
		
		if (matched == 0) then
			self:ClearObjects()
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Device does not require this resource!', NOTIFY_GENERIC, 7);" )
			return
		end
		
		if (Ent1 == Ent2) or (Ent1.resources2links and Ent1.resources2links[ Ent2:EntIndex() ] and Ent2.resources2links and Ent2.resources2links[ Ent1:EntIndex() ]) then
			self:ClearObjects()
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Devices already connected!', NOTIFY_GENERIC, 7);" )
			return
		end
		
		if Ent1:GetPos():Distance(Ent2:GetPos()) > RD_MAX_LINK_LENGTH then
			self:ClearObjects()
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Distance is too great!', NOTIFY_GENERIC, 7);" )
			return
		end
		
		Dev_Link(Ent1, Ent2, LPos1, LPos2, material, color, width)
		
		-- Clear the objects so we're ready to go again
		self:ClearObjects()
		
	else
		self:SetStage( iNum+1 )
	end

	return true
end

function TOOL:RightClick( trace )
	if (!trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	
	local iNum = self:NumObjects()
	
	if (SERVER and !trace.Entity.resources2) then
		self:ClearObjects()
		if ( iNum > 0 ) then
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Conduit source invalid!', NOTIFY_GENERIC, 7);" )
		else
			self:GetOwner():SendLua( "GAMEMODE:AddNotify('Conduit destination invalid!', NOTIFY_GENERIC, 7);" )
		end
		return
	end
	
	if (CLIENT) then return true end
	
	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 ) then
		-- Get information we're about to use
		local Ent1,  Ent2  = self:GetEnt(1),	 self:GetEnt(2)
		
		if (not Ent1.resources2) or (not Ent2.resources2) then
			self:ClearObjects()
	        self:GetOwner():SendLua( "GAMEMODE:AddNotify('Conduit invalid!', NOTIFY_GENERIC, 7);" )
			return
		end
		
		if (Ent1 == Ent2) then
			Dev_Unlink_All(Ent1)
		else
			Dev_Unlink(Ent1, Ent2)
		end
		
		-- Clear the objects so we're ready to go again
		self:ClearObjects()
	else
		self:SetStage( iNum+1 )
	end

	return true

end

function TOOL:Reload(trace)
	if (!trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	if (CLIENT) then return true end
	
	if (!trace.Entity.resources2) then
		self:ClearObjects()
        self:GetOwner():SendLua( "GAMEMODE:AddNotify('Conduit invalid!', NOTIFY_GENERIC, 7);" )
		return
	end
	
	Dev_Unlink_All(trace.Entity)
	
	return true
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Text = "#Tool.dev_link.name", Description	= "#Tool.dev_link.desc" }  )
	
	CPanel:AddControl("Slider", {
		Label = "#LinkTool_width",
		Type = "Float",
		Min = "1",
		Max = "20",
		Command = "dev_link_width"
	})
	
	CPanel:AddControl("MaterialGallery", {
		Label = "#LinkTool_material",
		Height = "64",
		Width = "32",
		Rows = "1",
		Stretch = "1",
		Options = {
			["Link"] = {			Material = "cable/rope_icon",	dev_link_material = "cable/rope" },
			["Cable 2"] = {			Material = "cable/cable_icon",	dev_link_material = "cable/cable2" },
			["XBeam"] = {			Material = "cable/xbeam",		dev_link_material = "cable/xbeam" },
			["Red Laser"] = {		Material = "cable/redlaser",	dev_link_material = "cable/redlaser" },
			["Blue Electric"] = {	Material = "cable/blue_elec",	dev_link_material = "cable/blue_elec" },
			["Physics Beam"] = {	Material = "cable/physbeam",	dev_link_material = "cable/physbeam" },
			["Hydra"] = {			Material = "cable/hydra",		dev_link_material = "cable/hydra" }
		}
	})
	
	CPanel:AddControl("Color", {
		Label = "#LinkTool_colour",
		Red = "dev_link_color_r",
		Green = "dev_link_color_g",
		Blue = "dev_link_color_b",
		ShowAlpha = "0",
		ShowHSV = "1",
		ShowRGB = "1",
		Multiplier = "255"
	})
end


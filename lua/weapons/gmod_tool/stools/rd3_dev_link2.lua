--load our other stools first
--include( "RD2/tool_manifest.lua" )

--dev link stool
--TOOL			= ToolObj:Create()
TOOL.Mode		= "rd3_dev_link2"
TOOL.Category	= 'Resource Distribution'
TOOL.Name		= '#Smart Link Tool'
TOOL.Command	= nil
TOOL.ConfigName	= ''
if (CLIENT and GetConVarNumber("CAF_UseTab") == 1) then TOOL.Tab = "Custom Addon Framework" end

if ( CLIENT ) then
	language.Add( "tool.rd3_dev_link2.name", "Smart Link Tool" )
	language.Add( "tool.rd3_dev_link2.desc", "Links Resource-Carrying Devices to a Resource Node, including Vehicle Pods." )
	language.Add( "tool.rd3_dev_link2.0", "Left Click: Select Devices.  Right Click: Link All devices to the selected Node.  Reload: Reset selected devices." )
    language.Add( "tool.rd3_dev_link2.1", "Click on another Resource-Carrying Device(or Vehicle Pod)" )
   	language.Add( "rd3_dev_link2_addlength", "Add Length:" )
	language.Add( "rd3_dev_link2_width", "Width:" )
	language.Add( "rd3_dev_link2_material", "Material:" )
	language.Add( "rd3_dev_link2_colour", "Color:")
end

TOOL.ClientConVar[ "width" ] = "2"
TOOL.ClientConVar[ "material" ] = "cable/cable2"
TOOL.ClientConVar[ "color_r" ] = "255"
TOOL.ClientConVar[ "color_g" ] = "255"
TOOL.ClientConVar[ "color_b" ] = "255"
TOOL.ClientConVar[ "color_a" ] = "255"

function TOOL:LeftClick( trace )
	if (!trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	if (CLIENT) then return true end
	local enttable = CAF.GetAddon("Resource Distribution").GetEntityTable(trace.Entity)
	if table.Count(enttable) > 0 or trace.Entity.IsNode or trace.Entity.IsValve or trace.Entity.IsPump then
		local iNum = self:NumObjects()
		local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
		self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )
		trace.Entity:SetColor(Color(0, 0, 255, 200))
	end
	return true
end

function TOOL:RightClick( trace )
	if (!trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	
	if (CLIENT) then return true end
	local iNum = self:NumObjects()
	--local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	--self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 and trace.Entity.IsNode ) then
		-- Get information we're about to use
		for k, v in pairs(self.Objects) do
			local Ent1,  Ent2  = self:GetEnt(k), trace.Entity
			--local Bone1, Bone2 = self:GetBone(k),	trace.PhysicsBone
			local WPos1, WPos2 = self:GetPos(k),		trace.Entity:GetPos()
			--local LPos1, LPos2 = self:GetLocalPos(k),	self:GetLocalPos(2)
			local length = ( WPos1 - WPos2):Length()
			Ent1:SetColor(Color(255, 255, 255, 255))
			
			-- Get client's CVars
			--local addlength	 = self:GetClientNumber( "addlength" )
			local material	= self:GetClientInfo( "material" )
			local width		= self:GetClientNumber( "width" ) 
			local color		= Color(self:GetClientNumber("color_r"), self:GetClientNumber("color_g"), self:GetClientNumber("color_b"))
			--Possible
			---- Ent - Node V
			---- Node - Ent V
			---- Node - Node V
			---- Ent - Cutoff valve V
			---- Node - Cutoff valve V
			---- Cutoff valve - node V
			---- Cutoff valve - ent V
			---- pump - node
			---- node - pump
			
			if Ent1.IsNode then
				if length <= Ent1.range or length <= Ent2.range then
					CAF.GetAddon("Resource Distribution").linkNodes(Ent1.netid, Ent2.netid)
				else
					 self:GetOwner():SendLua( "GAMEMODE:AddNotify('The 2 Nodes are to far appart!', NOTIFY_GENERIC, 7);" )
				end
			elseif table.Count(CAF.GetAddon("Resource Distribution").GetEntityTable(Ent1)) > 0 then
				if length <= Ent2.range then
					CAF.GetAddon("Resource Distribution").Link(Ent1, Ent2.netid)
				else
					 self:GetOwner():SendLua( "GAMEMODE:AddNotify('The Entity and the Node are to far appart!', NOTIFY_GENERIC, 7);" )
				end
			elseif Ent1.IsPump then
				if length <= Ent2.range then
					Ent1:SetNetwork(Ent2.netid)
					Ent1.node = Ent2
				else
					 self:GetOwner():SendLua( "GAMEMODE:AddNotify('The Pump and the Node are to far appart!', NOTIFY_GENERIC, 7);" )
				end
			else
		        self:GetOwner():SendLua( "GAMEMODE:AddNotify('Invalid Combination!', NOTIFY_GENERIC, 7);" )
			end
		end
		self:ClearObjects()
	else
		 self:GetOwner():SendLua( "GAMEMODE:AddNotify('You didn't click on a Resource node to link to!', NOTIFY_GENERIC, 7);" )
	end
	return true
end

function TOOL:Reload(trace)
	local iNum = self:NumObjects()
	if iNum > 0 then
		for k, v in pairs(self.Objects) do
			local Ent1  = self:GetEnt(k)
			Ent1:SetColor(Color(255, 255, 255, 255))
		end
	end
	self:ClearObjects()
	return true
end

function TOOL.BuildCPanel( panel )
	panel:AddControl( "Header", { Text = "#tool.rd3_dev_link.name", Description	= "#tool.rd3_dev_link.desc" }  )

	panel:AddControl("Slider", {
		Label = "#rd3_dev_link2_width",
		Type = "Float",
		Min = ".1",
		Max = "20",
		Command = "rd3_dev_link2_width"
	})

	panel:AddControl( "MatSelect", {
		Height = "1",
		Label = "#rd3_dev_link2_material",
		ItemWidth = 24,
		ItemHeight = 64,
		ConVar = "rd3_dev_link2_material",
		Options = list.Get( "BeamMaterials" )
	})

	panel:AddControl("Color", {
		Label = "#rd3_dev_link2_colour",
		Red = "rd3_dev_link2_color_r",
		Green = "rd3_dev_link2_color_g",
		Blue = "rd3_dev_link2_color_b",
		ShowAlpha = "1",
		ShowHSV = "1",
		ShowRGB = "1",
		Multiplier = "255"
	})
end


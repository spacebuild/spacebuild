--load our other stools first
--include( "RD2/tool_manifest.lua" )

--dev link stool
--TOOL			= ToolObj:Create()
TOOL.Mode		= "rd3_dev_link2"
TOOL.Category	= 'Resource Distribution'
TOOL.Name		= '#Smart Link Tool'
TOOL.Command	= nil
TOOL.ConfigName	= ''
TOOL.Tab = "Spacebuild"

local SB = SPACEBUILD

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
	if (not trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	if (CLIENT) then return true end
	if trace.Entity.rdobject then
		local iNum = self:NumObjects()
		local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
		self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )
		trace.Entity:SetColor(Color(0, 0, 255, 200))
	end
	return true
end

function TOOL:RightClick( trace )
	if (not trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	
	if (CLIENT) then return true end
	local iNum = self:NumObjects()
	--local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	--self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if iNum > 0 and trace.Entity.rdobject and trace.Entity.rdobject:isA("ResourceNetwork") then
		-- Get information we're about to use
		for k, v in pairs(self.Objects) do
			local Ent1, nodeEntity = self:GetEnt(k), trace.Entity
			--local Bone1, Bone2 = self:GetBone(k),	trace.PhysicsBone
			local WPos1, WPos2 = self:GetPos(k),		trace.Entity:GetPos()
			--local LPos1, LPos2 = self:GetLocalPos(k),	self:GetLocalPos(2)
			local length = ( WPos1 - WPos2):Length()
			Ent1:SetColor(Color(255, 255, 255, 255))
			local inRange1 = not Ent1.range or Ent1.range >= length
			local inRange2 = not nodeEntity.range or nodeEntity.range >= length

			if not nodeEntity.rdobject:canLink(Ent1.rdobject) then
				SB.util.messages.notify(self:GetOwner(), "Invalid Combination!" )
			elseif not inRange1 or not inRange2 then
				SB.util.messages.notify(self:GetOwner(), "These 2 entities are too far apart!'" )
			else
				nodeEntity.rdobject:link(Ent1.rdobject)
				local material = self:GetClientInfo("material")
				local width = tonumber(self:GetClientInfo("width"))
				local color =  Color(self:GetClientInfo("color_r"), self:GetClientInfo("color_g"), self:GetClientInfo("color_b"), self:GetClientInfo("color_a"))

				Ent1.rdobject:addBeam(nodeEntity.rdobject:getID(), material, width, color);
				nodeEntity.rdobject:addBeam(Ent1.rdobject:getID(), material, width, color);
			end
		end
		self:Reload(trace) --Reset colors and clear objects
	else
		SB.util.messages.notify(self:GetOwner(), "You didn't click on a Resource node to link to!" )
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


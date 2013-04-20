--load our other stools first
--include( "RD2/tool_manifest.lua" )

--dev link stool
--TOOL			= ToolObj:Create()
TOOL.Mode = "resource_link"
TOOL.Category = "Resource utilities"
TOOL.Name = "#Link Tool"
TOOL.Command = nil
TOOL.ConfigName = ''
TOOL.Tab = "Spacebuild"

if (CLIENT) then
	language.Add("tool.resource_link.name", "Link Tool")
	language.Add("tool.resource_link.desc", "Links Resource-Carrying Devices together to a Resource Node, including Vehicle Pods.")
	language.Add("tool.resource_link.0", "Left Click: Link Devices.  Right Click: Unlink Two Devices.  Reload: Unlink Device from All.")
	language.Add("tool.resource_link.1", "Click on another Resource-Carrying Device(or Vehicle Pod)")
	language.Add("tool.resource_link.2", "Right-Click on another Resource-Carrying Device(or the same one to unlink ALL)")
	language.Add("resource_link_addlength", "Add Length:")
	language.Add("resource_link_width", "Width:")
	language.Add("resource_link_material", "Material:")
	language.Add("resource_link_colour", "Color:")
end

TOOL.ClientConVar["material"] = "cable/cable2"
TOOL.ClientConVar["width"] = "2"
TOOL.ClientConVar["color_r"] = "255"
TOOL.ClientConVar["color_g"] = "255"
TOOL.ClientConVar["color_b"] = "255"
TOOL.ClientConVar["color_a"] = "255"

function TOOL:LeftClick(trace)
	--if not valid or player, exit
	if (trace.Entity:IsValid() and trace.Entity:IsPlayer()) then return end
	--if client exit
	if (CLIENT) then return true end
	-- If there's no physics object then we can't constraint itnot
	if (not util.IsValidPhysicsObject(trace.Entity, trace.PhysicsBone)) then return false end

	--how many objects stored
	local iNum = self:NumObjects() + 1

	--save clicked postion
	self:SetObject(iNum, trace.Entity, trace.HitPos, trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone), trace.PhysicsBone, trace.HitNormal)
	--first clicked object
	if not self:GetEnt(iNum).rdobject then
		self:GetOwner():SendLua("GAMEMODE:AddNotify('You need to select a resource entitynot ', NOTIFY_GENERIC, 7);")
		self:ClearObjects() --clear objects
		return
	end

	--if finishing, run StartTouch on Resource Node to do link
	if (iNum > 1) then
		local Ent1 = self:GetEnt(1) --get first ent
		local Ent2 = self:GetEnt(2) --get last ent
		local length = (self:GetPos(1) - self:GetPos(iNum)):Length() --TODO
		if Ent1.rdobject:canLink(Ent2.rdobject) then
			Ent1.rdobject:link(Ent2.rdobject)
			self:GetOwner():SendLua("GAMEMODE:AddNotify('Successfully linkednot ', NOTIFY_GENERIC, 7);")
		else
			self:GetOwner():SendLua("GAMEMODE:AddNotify('These 2 devices cant be linkednot ', NOTIFY_GENERIC, 7);")
			self:ClearObjects() --clear objects
			return
		end

		self:ClearObjects() --clear objects
	else
		self:SetStage(iNum)
	end

	--successnot
	return true
end

function TOOL:RightClick(trace)
	--if not valid or player, exit
	if (trace.Entity:IsValid() and trace.Entity:IsPlayer()) then return end
	--if client exit
	if (CLIENT) then return true end
	-- If there's no physics object then we can't constraint itnot
	if (SERVER and not util.IsValidPhysicsObject(trace.Entity, trace.PhysicsBone)) then return false end

	--how many objects stored
	local iNum = self:NumObjects() + 1

	--save clicked postion
	self:SetObject(iNum, trace.Entity, trace.HitPos, trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone), trace.PhysicsBone, trace.HitNormal)

	--first clicked object
	if not self:GetEnt(iNum).rdobject then
		self:GetOwner():SendLua("GAMEMODE:AddNotify('You need to select a resource entitynot ', NOTIFY_GENERIC, 7);")
		self:ClearObjects() --clear objects
		return
	end

	--if finishing, run StartTouch on Resource Node to do link
	if (iNum > 1) then
		local Ent1 = self:GetEnt(1) --get first ent
		local Ent2 = self:GetEnt(2) --get last ent
		local length = (self:GetPos(1) - self:GetPos(iNum)):Length() --TODO
		Ent1.rdobject:unlink(Ent2.rdobject)
		self:GetOwner():SendLua("GAMEMODE:AddNotify('Successfully unlinkednot ', NOTIFY_GENERIC, 7);")
		self:ClearObjects() --clear objects
	else
		self:SetStage(iNum)
	end

	return true
end

function TOOL:Reload(trace)
	--if not valid or player, exit
	if (trace.Entity:IsValid() and trace.Entity:IsPlayer()) then return end
	--if client exit
	if (CLIENT) then return true end



	self:ClearObjects() --clear objects
	return true
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", { Text = "#tool.resource_link.name", Description = "#tool.resource_link.desc" })

	panel:AddControl("Slider", {
		Label = "#resource_link_width",
		Type = "Float",
		Min = ".1",
		Max = "20",
		Command = "resource_link_width"
	})

	panel:AddControl("MatSelect", {
		Height = "1",
		Label = "#resource_link_material",
		ItemWidth = 24,
		ItemHeight = 64,
		ConVar = "resource_link_material",
		Options = list.Get("BeamMaterials")
	})

	panel:AddControl("Color", {
		Label = "#resource_link_colour",
		Red = "resource_link_color_r",
		Green = "resource_link_color_g",
		Blue = "resource_link_color_b",
		ShowAlpha = "1",
		ShowHSV = "1",
		ShowRGB = "1",
		Multiplier = "255"
	})
end


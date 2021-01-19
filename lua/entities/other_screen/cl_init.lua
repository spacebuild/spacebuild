include("shared.lua")
language.Add("other_screen", "Life Support Screen")
local MainFrames = {}

function ENT:Initialize()
	self.resources = {}
end

local function loadSelectedResourcesTree(ent)
	local RD = CAF.GetAddon("Resource Distribution")

	if MainFrames[ent:EntIndex()] and MainFrames[ent:EntIndex()]:IsVisible() then
		local LeftTree = MainFrames[ent:EntIndex()].lefttree
		LeftTree:Clear()

		for k, v in pairs(ent.resources) do
			local title = RD.GetProperResourceName(v)
			local node = LeftTree:AddLine(title)
			node.res = v
		end
	end
end

local function OpenMenu()
	local ent = net:ReadEntity()
	if not ent then return end

	if MainFrames[ent:EntIndex()] and MainFrames[ent:EntIndex()]:IsActive() and MainFrames[ent:EntIndex()]:IsVisible() then
		MainFrames[ent:EntIndex()]:Close()
	end

	local MainFrame = vgui.Create("DFrame")
	MainFrames[ent:EntIndex()] = MainFrame
	MainFrame:SetDeleteOnClose()
	MainFrame:SetDraggable(false)
	MainFrame:SetTitle("LS Screen Control Panel")
	MainFrame:SetSize(600, 350)
	MainFrame:Center()
	local RD = CAF.GetAddon("Resource Distribution")
	local resources = RD.GetRegisteredResources()
	local res2 = RD.GetAllRegisteredResources()

	for k, v in pairs(res2) do
		if not table.HasValue(resources, k) then
			table.insert(resources, k)
		end
	end

	MainFrame.SelectedNode = nil
	local LeftTree = vgui.Create("DListView", MainFrame)
	LeftTree:SetMultiSelect(false)
	LeftTree:SetSize(180, 300)
	LeftTree:SetPos(20, 25)
	LeftTree:AddColumn("monitored resources")
	MainFrame.lefttree = LeftTree
	loadSelectedResourcesTree(ent)
	local RightTree = vgui.Create("DListView", MainFrame)
	RightTree:SetMultiSelect(false)
	RightTree:SetSize(180, 300)
	RightTree:SetPos(400, 25)
	RightTree:AddColumn("available resources")
	local RightPanel = vgui.Create("DPanel", MainFrame)
	RightPanel:SetSize(180, 250)
	RightPanel:SetPos(210, 25)

	if resources then
		for k, v in pairs(resources) do
			local title = RD.GetProperResourceName(v)
			local node = RightTree:AddLine(title)
			node.res = v
		end
	end

	function LeftTree:OnRowSelected(rowIndex, row)
		MainFrame.SelectedNode = row
	end

	function RightTree:OnRowSelected(rowIndex, row)
		MainFrame.SelectedNode = row
	end

	local RButton2 = vgui.Create("DButton", RightPanel)
	RButton2:SetPos(20, 90)
	RButton2:SetSize(140, 30)
	RButton2:SetText("Remove Selected Resource")

	function RButton2:DoClick()
		if MainFrame.SelectedNode and MainFrame.SelectedNode.res then
			RunConsoleCommand("RemoveLSSCreenResource", ent:EntIndex(), tostring(MainFrame.SelectedNode.res))
		end
	end

	local RButton3 = vgui.Create("DButton", RightPanel)
	RButton3:SetPos(20, 60)
	RButton3:SetSize(140, 30)
	RButton3:SetText("Add Resource")

	function RButton3:DoClick()
		if MainFrame.SelectedNode and MainFrame.SelectedNode.res then
			RunConsoleCommand("AddLSSCreenResource", ent:EntIndex(), tostring(MainFrame.SelectedNode.res))
		end
	end

	local button = vgui.Create("DButton", MainFrame)
	button:SetPos(225, 290)
	button:SetSize(140, 30)
	local on = ent:GetOOO() == 1
	local txt = on and "Turn off" or "Turn on"
	button:SetText(txt)
	button.turnOff = on

	function button:DoClick()
		if not IsValid(ent) then return MainFrame:Close() end

		if self.turnOff then
			RunConsoleCommand("LSScreenTurnOff", ent:EntIndex())
		else
			RunConsoleCommand("LSScreenTurnOn", ent:EntIndex())
		end
	end

	function button:Think()
		if not IsValid(ent) then return MainFrame:Close() end
		self.turnOff = ent:GetOOO() == 1

		if self.turnOff then
			self:SetText("Turn off")
		else
			self:SetText("Turn on")
		end
	end

	function MainFrame:Think()
		if not IsValid(ent) then return self:Close() end
		DFrame.Think(self)
	end

	MainFrame:MakePopup()
end

net.Receive("LS_Open_Screen_Menu", OpenMenu)

local function AddResource()
	local ent = net:ReadEntity()
	local res = net:ReadString()
	if not ent or not ent.resources then return end
	table.insert(ent.resources, res)
	loadSelectedResourcesTree(ent)
end

net.Receive("LS_Add_ScreenResource", AddResource)

local function RemoveResource()
	local ent = net:ReadEntity()
	local res = net:ReadString()
	if not ent or not ent.resources then return end

	for k, v in pairs(ent.resources) do
		if v == res then
			table.remove(ent.resources, k)
			break
		end
	end

	loadSelectedResourcesTree(ent)
end

net.Receive("LS_Remove_ScreenResource", RemoveResource)

function ENT:DoNormalDraw(bDontDrawModel)
	local rd_overlay_dist = 512

	if RD_OverLay_Distance then
		if RD_OverLay_Distance.GetInt then
			local nr = RD_OverLay_Distance:GetInt()

			if nr >= 256 then
				rd_overlay_dist = nr
			end
		end
	end

	if (EyePos():Distance(self:GetPos()) < rd_overlay_dist and self:GetOOO() == 1) then

		if (not bDontDrawModel) then
			self:DrawModel()
		end

		local enttable = CAF.GetAddon("Resource Distribution").GetEntityTable(self)
		local TempY = 0
		local mul_up = 5.2
		local mul_ri = -16.5
		local mul_fr = -12.5
		local res = 0.05
		local mul = 1

		if string.find(self:GetModel(), "s_small_screen") then
			mul_ri = -8.25
			mul_fr = -6.25
			res = 0.025
			mul = 0.5
		elseif string.find(self:GetModel(), "small_screen") then
			mul_ri = -16.5
			mul_fr = -12.5
			res = 0.05
		elseif string.find(self:GetModel(), "medium_screen") then
			mul_ri = -33
			mul_fr = -25
			res = 0.1
			mul = 1.5
		elseif string.find(self:GetModel(), "large_screen") then
			mul_ri = -66
			mul_fr = -50
			res = 0.2
			mul = 2
		end

		--local pos = self:GetPos() + (self:GetForward() ) + (self:GetUp() * 40 ) + (self:GetRight())
		local pos = self:GetPos() + (self:GetUp() * mul_up) + (self:GetRight() * mul_ri) + (self:GetForward() * mul_fr)
		--[[local angle =  (LocalPlayer():GetPos() - trace.HitPos):Angle()
          angle.r = angle.r  + 90
          angle.y = angle.y + 90
          angle.p = 0]]
		local angle = self:GetAngles()
		local textStartPos = -375
		cam.Start3D2D(pos, angle, res)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(textStartPos, 0, 1250, 675)
		surface.SetDrawColor(155, 155, 255, 255)
		surface.DrawRect(textStartPos, 0, -5, 675)
		surface.DrawRect(textStartPos, 0, 1250, -5)
		surface.DrawRect(textStartPos, 675, 1250, -5)
		surface.DrawRect(textStartPos + 1250, 0, 5, 675)
		TempY = TempY + 10
		surface.SetFont("Flavour")
		surface.SetTextColor(200, 200, 255, 255)
		surface.SetTextPos(textStartPos + 15, TempY)
		surface.DrawText("Resource: amount/maxamount\t[amount/maxamount in other nodes]")
		TempY = TempY + (70 / mul)

		if (table.Count(self.resources) > 0) then
			local i = 0

			for k, v in pairs(self.resources) do
				surface.SetFont("Flavour")
				surface.SetTextColor(200, 200, 255, 255)
				surface.SetTextPos(textStartPos + 15, TempY)
				local firstNetworkCapacity = 0
				local firstNetworkAmount = 0
				local otherNetworksCapacity = 0
				local otherNetworksAmount = 0

				if enttable.network and enttable.network ~= 0 then
					local nettable = CAF.GetAddon("Resource Distribution").GetNetTable(enttable.network)

					if nettable.resources and nettable.resources[v] then
						firstNetworkCapacity = nettable.resources[v].localmaxvalue or 0
						firstNetworkAmount = nettable.resources[v].localvalue or 0
						otherNetworksCapacity = CAF.GetAddon("Resource Distribution").GetNetNetworkCapacity(enttable.network, v) - firstNetworkCapacity
						otherNetworksAmount = CAF.GetAddon("Resource Distribution").GetNetResourceAmount(enttable.network, v) - firstNetworkAmount
					else
						otherNetworksCapacity = CAF.GetAddon("Resource Distribution").GetNetNetworkCapacity(enttable.network, v)
						otherNetworksAmount = CAF.GetAddon("Resource Distribution").GetNetResourceAmount(enttable.network, v)
					end
				end

				surface.DrawText(tostring(CAF.GetAddon("Resource Distribution").GetProperResourceName(v)) .. ": " .. tostring(firstNetworkAmount) .. "/" .. tostring(firstNetworkCapacity) .. "\t[" .. tostring(otherNetworksAmount) .. "/" .. tostring(otherNetworksCapacity) .. "]")
				TempY = TempY + (70 / mul)
				i = i + 1
				if i >= 8 * mul then break end
			end
		else
			surface.SetFont("Flavour")
			surface.SetTextColor(200, 200, 255, 255)
			surface.SetTextPos(textStartPos + 15, TempY)
			surface.DrawText("No resources Selected")
			TempY = TempY + 70
		end

		--Stop rendering
		cam.End3D2D()
	else
		if (not bDontDrawModel) then
			self:DrawModel()
		end
	end
end
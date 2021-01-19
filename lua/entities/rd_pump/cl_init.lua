include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
local OOO = {}
OOO[0] = "Off"
OOO[1] = "On"
OOO[2] = "Overdrive"
local MainFrames = {}

function ENT:Initialize()
	self.ResourcesToSend = {}
	self.ConnectedPump = nil
end

local function GetPumps(ent, range)
	if not ent or not IsValid(ent) or not range or range < 1 then return {} end
	local pumps = {}

	for k, v in pairs(ents.FindInSphere(ent:GetPos(), range)) do
		if v and IsValid(v) and v.IsPump and v ~= ent then
			table.insert(pumps, v)
		end
	end

	return pumps
end

local function OpenMenu()
	local ent = net.ReadEntity()
	if not ent then return end

	if MainFrames[ent:EntIndex()] and MainFrames[ent:EntIndex()]:IsActive() and MainFrames[ent:EntIndex()]:IsVisible() then
		MainFrames[ent:EntIndex()]:Close()
	end

	local MainFrame = vgui.Create("DFrame")
	MainFrames[ent:EntIndex()] = MainFrame
	MainFrame:SetDeleteOnClose()
	MainFrame:SetDraggable(false)
	MainFrame:SetTitle("Pump " .. tostring(ent:EntIndex()) .. " Control Panel")
	MainFrame:SetSize(600, 350)
	MainFrame:Center()
	local SelectedNode = nil
	local LeftTree = vgui.Create("DTree", MainFrame)
	LeftTree:SetSize(180, 300)
	LeftTree:SetPos(20, 25)
	LeftTree:SetShowIcons(false)
	local RLabel = vgui.Create("DLabel", MainFrame)
	RLabel:SetPos(400, 25)
	RLabel:SetSize(140, 30)
	RLabel:SetText("Pumps in range")
	local RightTree = vgui.Create("DTree", MainFrame)
	RightTree:SetSize(180, 265)
	RightTree:SetPos(400, 60)
	RightTree:SetShowIcons(false)
	local RightPanel = vgui.Create("DPanel", MainFrame)
	RightPanel:SetSize(180, 250)
	RightPanel:SetPos(210, 25)
	local NameText = vgui.Create("DTextEntry", RightPanel)
	NameText:SetPos(20, 25)
	NameText:SetSize(120, 20)
	NameText:AllowInput(true)
	NameText:SetValue(ent:GetNWString("name"))
	local nameButton = vgui.Create("DImageButton", RightPanel)
	nameButton:SetImage("icon16/folder_go.png")
	nameButton:SetPos(140, 25)
	nameButton:SetSize(20, 20)
	nameButton:SetTooltip("Update Pump Name")

	nameButton.DoClick = function()
		RunConsoleCommand("SetPumpName", ent:EntIndex(), tostring(NameText:GetValue()))
	end

	local NumSelector = vgui.Create("DNumberWang", RightPanel)
	NumSelector:SetPos(20, 60)
	NumSelector:SetSize(140, 30)
	NumSelector:SetMin(0)
	NumSelector:SetMax(4000000000) -- 4 billion per tick, pretty much infinte (limited by uint32)
	NumSelector:SetDecimals(0)
	local RButton = vgui.Create("DButton", RightPanel)
	RButton:SetPos(20, 95)
	RButton:SetSize(140, 30)
	RButton:SetDisabled(true)
	RButton:SetText("Update Amount")

	function RButton:DoClick()
		if SelectedNode then
			RunConsoleCommand("SetResourceAmount", ent:EntIndex(), SelectedNode.res, NumSelector:GetValue())
			ent.ResourcesToSend[SelectedNode.res] = tonumber(NumSelector:GetValue())
		end
	end

	local RLabel2 = vgui.Create("DLabel", RightPanel)
	RLabel2:SetPos(20, 130)
	RLabel2:SetSize(70, 30)
	RLabel2:SetText("Pump: ")
	local RText2 = vgui.Create("DTextEntry", RightPanel)
	RText2:SetPos(90, 130)
	RText2:SetSize(70, 30)
	RText2:AllowInput(false)
	RText2:SetValue("")
	local pumps = GetPumps(ent, 768)

	if pumps then
		for k, v in pairs(pumps) do
			local title = v:GetNWString("name")
			local node = RightTree:AddNode(title)
			node.index = v:EntIndex()

			function node:DoClick()
				RText2:SetValue(tostring(self.index))
			end
		end
	end

	local RButton2 = vgui.Create("DButton", RightPanel)
	RButton2:SetPos(20, 165)
	RButton2:SetSize(140, 30)
	RButton2:SetText("Connect Pumps")

	function RButton2:DoClick()
		if RText2:GetValue() ~= "" then
			RunConsoleCommand("LinkToPump", ent:EntIndex(), tostring(RText2:GetValue()))
		end
	end

	local RButton3 = vgui.Create("DButton", RightPanel)
	RButton3:SetPos(20, 200)
	RButton3:SetSize(140, 30)
	RButton3:SetText("Disconnect Pump")

	function RButton3:DoClick()
		if ent.ConnectedPump then
			RunConsoleCommand("UnlinkPump", ent:EntIndex())
		end
	end

	local button = vgui.Create("DButton", MainFrame)
	button:SetPos(210, 290)
	button:SetSize(180, 30)
	local on = ent:GetOOO() == 1
	local txt = on and "Turn off" or "Turn on"
	button:SetText(txt)
	button.turnOff = on

	function button:DoClick()
		if not IsValid(ent) then return MainFrame:Close() end

		if self.turnOff then
			RunConsoleCommand("PumpTurnOff", ent:EntIndex())
		else
			RunConsoleCommand("PumpTurnOn", ent:EntIndex())
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

	local netid = ent:GetNWInt("netid")
	local nettable = CAF.GetAddon("Resource Distribution").GetNetTable(netid)

	if nettable and nettable.resources then
		for k, v in pairs(nettable.resources) do
			local title = k
			local node = LeftTree:AddNode(title)
			node.res = k

			function node:DoClick()
				SelectedNode = self

				if ent.ResourcesToSend[self.res] then
					NumSelector:SetValue(ent.ResourcesToSend[self.res])
				else
					NumSelector:SetValue(0)
				end

				RButton:SetDisabled(false)
			end
		end
	end

	MainFrame:MakePopup()
end

net.Receive("RD_Open_Pump_Menu", OpenMenu)

local function AddResource()
	local ent = net.ReadEntity()
	local res = net.ReadString()
	local val = net.ReadUInt(32)
	if not ent or not ent.IsPump then return end
	ent.ResourcesToSend[res] = val
end

net.Receive("RD_Add_ResourceRate_to_Pump", AddResource)

function ENT:Draw(bDontDrawModel)
	self:DoNormalDraw()
	--draw beams by MadDog
	CAF.GetAddon("Resource Distribution").Beam_Render(self)

	if (Wire_Render) then
		Wire_Render(self)
	end
end

function ENT:DrawTranslucent(bDontDrawModel)
	if (bDontDrawModel) then return end
	self:Draw()
end

function ENT:GetOOO()
	return self:GetNWInt("OOO") or 0
end

function ENT:DoNormalDraw(bDontDrawModel)
	local mode = self:GetNWInt("overlaymode")

	-- Don't enable it if disabled by default!
	if RD_OverLay_Mode and mode ~= 0 then
		if RD_OverLay_Mode.GetInt then
			local nr = math.Round(RD_OverLay_Mode:GetInt())

			if nr >= 0 and nr <= 2 then
				mode = nr
			end
		end
	end

	local rd_overlay_dist = 512

	if RD_OverLay_Distance then
		if RD_OverLay_Distance.GetInt then
			local nr = RD_OverLay_Distance:GetInt()

			if nr >= 256 then
				rd_overlay_dist = nr
			end
		end
	end

	if (LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance(self:GetPos()) < rd_overlay_dist and mode ~= 0) then
		--overlaysettings
		self.ConnectedPump = self:GetNWInt("connectedpump")
		local OverlaySettings = list.Get("LSEntOverlayText")[self:GetClass()]
		local HasOOO = OverlaySettings.HasOOO
		--End overlaysettings
		local trace = LocalPlayer():GetEyeTrace()

		if (not bDontDrawModel) then
			self:DrawModel()
		end

		local netid = self:GetNWInt("netid")
		local playername = self:GetPlayerName()

		if playername == "" then
			playername = "World"
		end

		-- 0 = no overlay!
		-- 1 = default overlaytext
		-- 2 = new overlaytext
		if not mode or mode ~= 2 then
			local OverlayText = ""
			OverlayText = OverlayText .. self:GetNWString("name") .. " (" .. tostring(self:EntIndex()) .. ")\n"

			if netid == 0 then
				OverlayText = OverlayText .. "Not connected to a network\n"
			else
				OverlayText = OverlayText .. "Network " .. netid .. "\n"
			end

			if self.ConnectedPump and self.ConnectedPump > 0 then
				OverlayText = OverlayText .. "Connect to pump " .. tostring(self.ConnectedPump) .. "\n"
			else
				OverlayText = OverlayText .. "Not connected to another pump\n"
			end

			OverlayText = OverlayText .. "Owner: " .. playername .. "\n"

			if HasOOO then
				local runmode = "UnKnown"

				if self:GetOOO() >= 0 and self:GetOOO() <= 2 then
					runmode = OOO[self:GetOOO()]
				end

				OverlayText = OverlayText .. "Mode: " .. runmode .. "\n"
			end

			if (table.Count(self.ResourcesToSend) > 0) then
				for k, v in pairs(self.ResourcesToSend) do
					OverlayText = OverlayText .. CAF.GetAddon("Resource Distribution").GetProperResourceName(k) .. ": " .. tostring(v) .. "\n"
				end
			else
				OverlayText = OverlayText .. "No Resources Are Being Transfered\n"
			end

			AddWorldTip(self:EntIndex(), OverlayText, 0.5, self:GetPos(), self)
		else
			local TempY = 0
			--local pos = self:GetPos() + (self:GetForward() ) + (self:GetUp() * 40 ) + (self:GetRight())
			local pos = self:GetPos() + (self:GetUp() * (self:BoundingRadius() + 10))
			local angle = (LocalPlayer():GetPos() - trace.HitPos):Angle()
			angle.r = angle.r + 90
			angle.y = angle.y + 90
			angle.p = 0
			local textStartPos = -375
			cam.Start3D2D(pos, angle, 0.03)
			surface.SetDrawColor(0, 0, 0, 125)
			surface.DrawRect(textStartPos, 0, 1250, 500)
			surface.SetDrawColor(155, 155, 155, 255)
			surface.DrawRect(textStartPos, 0, -5, 500)
			surface.DrawRect(textStartPos, 0, 1250, -5)
			surface.DrawRect(textStartPos, 500, 1250, -5)
			surface.DrawRect(textStartPos + 1250, 0, 5, 500)
			TempY = TempY + 10
			surface.SetFont("ConflictText")
			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(textStartPos + 15, TempY)
			surface.DrawText(self:GetNWString("name") .. " (" .. tostring(self:EntIndex()) .. ")")
			TempY = TempY + 70
			surface.SetFont("Flavour")
			surface.SetTextColor(155, 155, 255, 255)
			surface.SetTextPos(textStartPos + 15, TempY)
			surface.DrawText("Owner: " .. playername)
			TempY = TempY + 70
			surface.SetFont("Flavour")
			surface.SetTextColor(155, 155, 255, 255)
			surface.SetTextPos(textStartPos + 15, TempY)

			if netid then
				surface.DrawText("Not connected to a network")
			else
				surface.DrawText("Network " .. netid)
			end

			TempY = TempY + 70
			surface.SetFont("Flavour")
			surface.SetTextColor(155, 155, 255, 255)
			surface.SetTextPos(textStartPos + 15, TempY)

			if self.ConnectedPump and self.ConnectedPump > 0 then
				surface.DrawText("Connected to pump " .. tostring(self.ConnectedPump))
			else
				surface.DrawText("Not connected to another pump")
			end

			TempY = TempY + 70

			if HasOOO then
				local runmode = "UnKnown"

				if self:GetOOO() >= 0 and self:GetOOO() <= 2 then
					runmode = OOO[self:GetOOO()]
				end

				surface.SetFont("Flavour")
				surface.SetTextColor(155, 155, 255, 255)
				surface.SetTextPos(textStartPos + 15, TempY)
				surface.DrawText("Mode: " .. runmode)
				TempY = TempY + 70
			end

			-- Print the used resources
			local stringUsage = ""

			if (table.Count(self.ResourcesToSend) > 0) then
				local i = 0
				surface.SetFont("Flavour")
				surface.SetTextColor(155, 155, 255, 255)
				surface.SetTextPos(textStartPos + 15, TempY)
				surface.DrawText("Resources Being Transfered: ")
				TempY = TempY + 70

				for k, v in pairs(self.ResourcesToSend) do
					stringUsage = stringUsage .. "[" .. CAF.GetAddon("Resource Distribution").GetProperResourceName(k) .. ": " .. tostring(v) .. "] "
					i = i + 1

					if i == 3 then
						surface.SetTextPos(textStartPos + 15, TempY)
						surface.DrawText("   " .. stringUsage)
						TempY = TempY + 70
						stringUsage = ""
						i = 0
					end
				end

				surface.SetTextPos(textStartPos + 15, TempY)
				surface.DrawText("   " .. stringUsage)
				TempY = TempY + 70
			else
				surface.SetFont("Flavour")
				surface.SetTextColor(155, 155, 255, 255)
				surface.SetTextPos(textStartPos + 15, TempY)
				surface.DrawText("No resources Being Transfered")
				TempY = TempY + 70
			end

			--Stop rendering
			cam.End3D2D()
		end
	else
		if (not bDontDrawModel) then
			self:DrawModel()
		end
	end
end

if Wire_UpdateRenderBounds then
	function ENT:Think()
		Wire_UpdateRenderBounds(self)
		self:NextThink(CurTime() + 3)
	end
end
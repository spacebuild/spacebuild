include("shared.lua")
language.Add("base_terraformer", "Base Terraformer")
local OOO = {}
OOO[0] = "Off"
OOO[1] = "On"
OOO[2] = "Overdrive"
local MainFrames = {}

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
	MainFrame:SetTitle("Terraformer " .. tostring(ent:EntIndex()) .. "'s Control Panel")
	MainFrame:SetSize(600, 350)
	MainFrame:Center()
	local button = vgui.Create("DButton", MainFrame)
	button:SetPos(225, 290)
	button:SetSize(180, 30)
	local on = ent:GetOOO() == 1
	local txt = on and "Turn off" or "Turn on"
	button:SetText(txt)
	button.turnOff = on

	function button:DoClick()
		if not IsValid(ent) then return MainFrame:Close() end

		if self.turnOff then
			RunConsoleCommand("TFTurnOff", ent:EntIndex())
		else
			RunConsoleCommand("TFTurnOn", ent:EntIndex())
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

net.Receive("TF_Open_Menu", OpenMenu)
include('shared.lua')

language.Add("base_terraformer", "Base Terraformer")

local OOO = {}
OOO[0] = "Off"
OOO[1] = "On"
OOO[2] = "Overdrive"

local MainFrames = {}

local function OpenMenu(um)
    local ent = um:ReadEntity()
    if not ent then return end
    if MainFrames[ent:EntIndex()] and MainFrames[ent:EntIndex()]:IsActive() and MainFrames[ent:EntIndex()]:IsVisible() then MainFrames[ent:EntIndex()]:Close() end

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
    if ent:GetOOO() == 1 then
        button:SetText("Turn off")
        function button:DoClick()
            RunConsoleCommand("TFTurnOff", ent:EntIndex())
        end
    else
        button:SetText("Turn on")
        function button:DoClick()
            RunConsoleCommand("TFTurnOn", ent:EntIndex())
        end
    end

    MainFrame:MakePopup()
end

usermessage.Hook("TF_Open_Menu", OpenMenu)
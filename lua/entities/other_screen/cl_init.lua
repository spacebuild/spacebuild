include('shared.lua')
language.Add("other_screen", "Life Support Screen")

local MainFrames = {}

function ENT:Initialize()
    self.resources = {}
end

local function OpenMenu(um)
    local ent = um:ReadEntity()
    if not ent then return end
    if MainFrames[ent:EntIndex()] and MainFrames[ent:EntIndex()]:IsActive() and MainFrames[ent:EntIndex()]:IsVisible() then MainFrames[ent:EntIndex()]:Close() end
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
    if table.Count(res2) > 0 then
        for k, v in pairs(res2) do
            if not table.HasValue(resources, k) then
                table.insert(resources, k)
            end
        end
    end

    MainFrame.SelectedNode = nil
    local LeftTree = vgui.Create("DTree", MainFrame)
    LeftTree:SetSize(180, 300)
    LeftTree:SetPos(20, 25);
    LeftTree:SetShowIcons(false)
    MainFrame.lefttree = LeftTree

    local RightTree = vgui.Create("DTree", MainFrame)
    RightTree:SetSize(180, 300)
    RightTree:SetPos(400, 25);
    RightTree:SetShowIcons(false)

    local RightPanel = vgui.Create("DPanel", MainFrame)
    RightPanel:SetSize(180, 250);
    RightPanel:SetPos(210, 25)

    local RText2 = vgui.Create("DTextEntry", RightPanel)
    RText2:SetPos(20, 25)
    RText2:SetSize(140, 30)
    RText2:AllowInput(true)
    RText2:SetValue("")

    if resources and table.Count(resources) > 0 then
        for k, v in pairs(resources) do
            local title = RD.GetProperResourceName(v);
            local node = RightTree:AddNode(title)
            node.res = v
            function node:DoClick()
                RText2:SetValue(tostring(self.res))
            end
        end
    end

    local RButton2 = vgui.Create("DButton", RightPanel)
    RButton2:SetPos(20, 90)
    RButton2:SetSize(140, 30)
    RButton2:SetText("Remove Selected Resource")
    function RButton2:DoClick()
        if MainFrame.SelectedNode then
            RunConsoleCommand("RemoveLSSCreenResource", ent:EntIndex(), tostring(MainFrame.SelectedNode.res))
        end
    end

    local RButton3 = vgui.Create("DButton", RightPanel)
    RButton3:SetPos(20, 60)
    RButton3:SetSize(140, 30)
    RButton3:SetText("Add Resource")
    function RButton3:DoClick()
        if RText2:GetValue() ~= "" then
            RunConsoleCommand("AddLSSCreenResource", ent:EntIndex(), tostring(RText2:GetValue()))
        end
    end

    local button = vgui.Create("DButton", MainFrame)

    button:SetPos(225, 290)
    button:SetSize(140, 30)
    if ent:GetOOO() == 1 then
        button:SetText("Turn off")
        function button:DoClick()
            RunConsoleCommand("LSScreenTurnOff", ent:EntIndex())
        end
    else
        button:SetText("Turn on")
        function button:DoClick()
            RunConsoleCommand("LSScreenTurnOn", ent:EntIndex())
        end
    end
    if ent.resources and table.Count(ent.resources) > 0 then
        for k, v in pairs(ent.resources) do
            local title = v;
            local node = LeftTree:AddNode(title)
            node.res = v
            function node:DoClick()
                MainFrame.SelectedNode = self
            end
        end
    end
    MainFrame:MakePopup()
end

usermessage.Hook("LS_Open_Screen_Menu", OpenMenu)

local function AddResource(um)
    local ent = um:ReadEntity()
    local res = um:ReadString()
    if not ent then return end
    table.insert(ent.resources, res)
    if MainFrames[ent:EntIndex()] and MainFrames[ent:EntIndex()]:IsActive() and MainFrames[ent:EntIndex()]:IsVisible() then
        local LeftTree = MainFrames[ent:EntIndex()].lefttree
        LeftTree.Items = {}
        if ent.resources and table.Count(ent.resources) > 0 then
            for k, v in pairs(ent.resources) do
                local title = v;
                local node = LeftTree:AddNode(title)
                node.res = v
                function node:DoClick()
                    MainFrames[ent:EntIndex()].SelectedNode = self
                end
            end
        end
    end
end

usermessage.Hook("LS_Add_ScreenResource", AddResource)

local function RemoveResource(um)
    local ent = um:ReadEntity()
    local res = um:ReadString()
    if not ent then return end
    for k, v in pairs(ent.resources) do
        if v == res then
            table.remove(ent.resources, k)
            break
        end
    end
    if MainFrames[ent:EntIndex()] and MainFrames[ent:EntIndex()]:IsActive() and MainFrames[ent:EntIndex()]:IsVisible() then
        local LeftTree = MainFrames[ent:EntIndex()].lefttree
        LeftTree.Items = {}
        if ent.resources and table.Count(ent.resources) > 0 then
            for k, v in pairs(ent.resources) do
                local title = v;
                local node = LeftTree:AddNode(title)
                node.res = v
                function node:DoClick()
                    MainFrames[ent:EntIndex()].SelectedNode = self
                end
            end
        end
    end
end

usermessage.Hook("LS_Remove_ScreenResource", RemoveResource)


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
        local trace = LocalPlayer():GetEyeTrace()
        if (not bDontDrawModel) then self:DrawModel() end
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
        surface.DrawText("Resource: amount/maxamount\t[where amount/maxamount from other nodes]")
        TempY = TempY + (70 / mul)

        if (table.Count(self.resources) > 0) then
            local i = 0
            for k, v in pairs(self.resources) do
                surface.SetFont("Flavour")
                surface.SetTextColor(200, 200, 255, 255)
                surface.SetTextPos(textStartPos + 15, TempY)
                local othernetworks = 0
                local othernetworksres = 0
                if enttable.network and enttable.network ~= 0 then
                    local nettable = CAF.GetAddon("Resource Distribution").GetNetTable(enttable.network)
                    if table.Count(nettable) > 0 then
                        if nettable.resources and nettable.resources[v] then
                            local currentnet = nettable.resources[v].maxvalue
                            local currentnet2 = nettable.resources[v].value
                            if currentnet then
                                othernetworks = CAF.GetAddon("Resource Distribution").GetNetworkCapacity(self, v) - (currentnet or 0)
                            end
                            if currentnet2 then
                                othernetworksres = CAF.GetAddon("Resource Distribution").GetResourceAmount(self, v) - (currentnet2 or 0)
                            end
                        else
                            othernetworks = CAF.GetAddon("Resource Distribution").GetNetworkCapacity(self, v)
                            othernetworksres = CAF.GetAddon("Resource Distribution").GetResourceAmount(self, v)
                        end
                    end
                end
                surface.DrawText(tostring(CAF.GetAddon("Resource Distribution").GetProperResourceName(v)) .. ": " .. tostring(CAF.GetAddon("Resource Distribution").GetResourceAmount(self, v)) .. "/" .. tostring(CAF.GetAddon("Resource Distribution").GetNetworkCapacity(self, v)) .. "\t[" .. tostring(othernetworksres) .. "/" .. tostring(othernetworks) .. "]")
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
        if (not bDontDrawModel) then self:DrawModel() end
    end
end
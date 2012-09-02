include('shared.lua')

ENT.RenderGroup = RENDERGROUP_BOTH

local OOO = {}
OOO[0] = "Off"
OOO[1] = "On"
OOO[2] = "Overdrive"

local client_chosen_number = CreateClientConVar("number_to_send", "0", true, false)
local client_chosen_hold = CreateClientConVar("number_to_hold", "1", true, false)

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
    return self:GetNetworkedInt("OOO") or 0
end

function ENT:DoNormalDraw(bDontDrawModel)
    local mode = self:GetNetworkedInt("overlaymode")
    if RD_OverLay_Mode and mode ~= 0 then -- Don't enable it if disabled by default!
        if RD_OverLay_Mode.GetInt then
            local nr = math.Round(RD_OverLay_Mode:GetInt())
            if nr >= 0 and nr <= 2 then
                mode = nr;
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
        local OverlaySettings = list.Get("LSEntOverlayText")[self:GetClass()]
        local HasOOO = OverlaySettings.HasOOO
        local num = OverlaySettings.num or 0
        local strings = OverlaySettings.strings
        local resnames = OverlaySettings.resnames
        local genresnames = OverlaySettings.genresnames
        --End overlaysettings
        local trace = LocalPlayer():GetEyeTrace()
        if (not bDontDrawModel) then self:DrawModel() end
        local nettable = CAF.GetAddon("Resource Distribution").GetEntityTable(self)
        if table.Count(nettable) == 0 then return end
        local playername = self:GetPlayerName()
        if playername == "" then
            playername = "World"
        end
        -- 0 = no overlay!
        -- 1 = default overlaytext
        -- 2 = new overlaytext
        local empty_value = { value = 0, maxvalue = 0 }
        if not mode or mode ~= 2 then
            local OverlayText = ""
            OverlayText = OverlayText .. self.PrintName .. "\n"
            if nettable.network == 0 then
                OverlayText = OverlayText .. "Not connected to a network\n"
            else
                OverlayText = OverlayText .. "Network " .. nettable.network .. "\n"
            end
            OverlayText = OverlayText .. "Owner: " .. playername .. "\n"
            if HasOOO then
                local runmode = "UnKnown"
                if self:GetOOO() >= 0 and self:GetOOO() <= 2 then
                    runmode = OOO[self:GetOOO()]
                end
                OverlayText = OverlayText .. "Mode: " .. runmode .. "\n"
            end
            OverlayText = OverlayText .. "\n"
            local resources = nettable.resources
            if num == -1 then
                if (table.Count(resources) > 0) then
                    for k, v in pairs(resources) do
                        OverlayText = OverlayText .. CAF.GetAddon("Resource Distribution").GetProperResourceName(k) .. ": " .. v.value .. "/" .. v.maxvalue .. "\n"
                    end
                else
                    OverlayText = OverlayText .. "No Resources Connected\n"
                end
            else
                local v
                if resnames and table.Count(resnames) > 0 then
                    for _, k in pairs(resnames) do
                        v = resources[k] or empty_value
                        OverlayText = OverlayText .. CAF.GetAddon("Resource Distribution").GetProperResourceName(k) .. ": " .. v.value .. "/" .. v.maxvalue .. "\n"
                    end
                end
                if genresnames and table.Count(genresnames) > 0 then
                    OverlayText = OverlayText .. "\nGenerates:\n"
                    for _, k in pairs(genresnames) do
                        v = resources[k] or empty_value
                        OverlayText = OverlayText .. CAF.GetAddon("Resource Distribution").GetProperResourceName(k) .. ": " .. v.value .. "/" .. v.maxvalue .. "\n"
                    end
                end
            end
            AddWorldTip(self:EntIndex(), OverlayText, 0.5, self:GetPos(), self)
        else
            local rot = Vector(0, 0, 90)
            local TempY = 0
            local maxvector = self:OBBMaxs()
            local getpos = self:GetPos()
            --local pos = self:GetPos() + (self:GetForward() ) + (self:GetUp() * 40 ) + (self:GetRight())

            local pos = getpos + (self:GetUp() * (maxvector.y + 10))

            local angle = (LocalPlayer():GetPos() - trace.HitPos):Angle()
            angle.r = angle.r + 90
            angle.y = angle.y + 90
            angle.p = 0

            local textStartPos = -375

            cam.Start3D2D(pos, angle, 0.03)

            pcall(function()
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
                surface.DrawText(self.PrintName)
                TempY = TempY + 70

                surface.SetFont("Flavour")
                surface.SetTextColor(155, 155, 255, 255)
                surface.SetTextPos(textStartPos + 15, TempY)
                surface.DrawText("Owner: " .. playername)
                TempY = TempY + 70

                surface.SetFont("Flavour")
                surface.SetTextColor(155, 155, 255, 255)
                surface.SetTextPos(textStartPos + 15, TempY)
                if nettable.network == 0 then
                    surface.DrawText("Not connected to a network")
                else
                    surface.DrawText("Network " .. nettable.network)
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
                local resources = nettable.resources
                local RD = CAF.GetAddon("Resource Distribution");
                if (table.Count(resources) > 0) then
                    local i = 0
                    surface.SetFont("Flavour")
                    surface.SetTextColor(155, 155, 255, 255)
                    surface.SetTextPos(textStartPos + 15, TempY)
                    surface.DrawText("Resources: ")
                    TempY = TempY + 70
                    if num == -1 then
                        for k, v in pairs(resources) do
                            stringUsage = stringUsage .. "[" .. RD.GetProperResourceName(k) .. ": " .. v.value .. "/" .. v.maxvalue .. "] "
                            i = i + 1
                            if i == 3 then
                                surface.SetTextPos(textStartPos + 15, TempY)
                                surface.DrawText("   " .. stringUsage)
                                TempY = TempY + 70
                                stringUsage = ""
                                i = 0
                            end
                        end
                    else
                        local v
                        if resnames and table.Count(resnames) > 0 then
                            for _, k in pairs(resnames) do
                                v = resources[k] or empty_value
                                stringUsage = stringUsage .. "[" .. RD.GetProperResourceName(k) .. ": " .. v.value .. "/" .. v.maxvalue .. "] "
                                i = i + 1
                                if i == 3 then
                                    surface.SetTextPos(textStartPos + 15, TempY)
                                    surface.DrawText("   " .. stringUsage)
                                    TempY = TempY + 70
                                    stringUsage = ""
                                    i = 0
                                end
                            end
                        end
                        if genresnames and table.Count(genresnames) > 0 then
                            if stringUsage ~= "" then
                                surface.SetTextPos(textStartPos + 15, TempY)
                                surface.DrawText("   " .. stringUsage)
                                TempY = TempY + 70
                                stringUsage = ""
                            end
                            surface.SetTextPos(textStartPos + 15, TempY)
                            surface.DrawText("Generates: ")
                            TempY = TempY + 70
                            for _, k in pairs(genresnames) do
                                v = resources[k] or empty_value
                                stringUsage = stringUsage .. "[" .. RD.GetProperResourceName(k) .. ": " .. v.value .. "/" .. v.maxvalue .. "] "
                                i = i + 1
                                if i == 3 then
                                    surface.SetTextPos(textStartPos + 15, TempY)
                                    surface.DrawText("   " .. stringUsage)
                                    TempY = TempY + 70
                                    stringUsage = ""
                                    i = 0
                                end
                            end
                        end
                    end
                    surface.SetTextPos(textStartPos + 15, TempY)
                    surface.DrawText("   " .. stringUsage)
                    TempY = TempY + 70
                elseif genresnames and table.Count(genresnames) > 0 then
                    local i = 0
                    surface.SetFont("Flavour")
                    surface.SetTextColor(155, 155, 255, 255)
                    surface.SetTextPos(textStartPos + 15, TempY)
                    surface.DrawText("Generates: ")
                    TempY = TempY + 70
                    stringUsage = ""
                    local v
                    for _, k in pairs(genresnames) do
                        v = resources[k] or empty_value
                        stringUsage = stringUsage .. "[" .. RD.GetProperResourceName(k) .. ": " .. v.value .. "/" .. v.maxvalue .. "] "
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
                    surface.DrawText("No resources connected")
                    TempY = TempY + 70
                end
            --Stop rendering
            end);
            cam.End3D2D()
        end
    else
        if (not bDontDrawModel) then self:DrawModel() end
    end
end

if Wire_UpdateRenderBounds then
    function ENT:Think()
        Wire_UpdateRenderBounds(self)
        self:NextThink(CurTime() + 3)
    end
end

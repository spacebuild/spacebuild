include('shared.lua')
language.Add("other_probe", "Environment Probe")

local OOO = {}
OOO[0] = "Off"
OOO[1] = "On"
OOO[2] = "Overdrive"

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
        local trace = LocalPlayer():GetEyeTrace()
        if (not bDontDrawModel) then self:DrawModel() end
        local nettable = CAF.GetAddon("Resource Distribution").GetEntityTable(self)
        if table.Count(nettable) <= 0 then return end
        local playername = self:GetPlayerName()
        if playername == "" then
            playername = "World"
        end
        -- 0 = no overlay!
        -- 1 = default overlaytext
        -- 2 = new overlaytext

        if not mode or mode ~= 2 then
            local OverlayText = ""
            OverlayText = OverlayText .. self.PrintName .. "\n"
            if nettable.network == 0 then
                OverlayText = OverlayText .. "Not connected to a network\n"
            else
                OverlayText = OverlayText .. "Network " .. nettable.network .. "\n"
            end
            OverlayText = OverlayText .. "Owner: " .. playername .. "\n"
            local runmode = "UnKnown"
            if self:GetOOO() >= 0 and self:GetOOO() <= 2 then
                runmode = OOO[self:GetOOO()]
            end
            OverlayText = OverlayText .. "Mode: " .. runmode .. "\n"
            OverlayText = OverlayText .. CAF.GetAddon("Resource Distribution").GetProperResourceName("energy") .. ": " .. CAF.GetAddon("Resource Distribution").GetResourceAmount(self, "energy") .. "/" .. CAF.GetAddon("Resource Distribution").GetNetworkCapacity(self, "energy") .. "\n"
            if self:GetOOO() == 1 then
                OverlayText = OverlayText .. "Environment Info:\n"
                OverlayText = OverlayText .. "Name:" .. tostring(self:GetNetworkedString(8)) .. "\n"
                OverlayText = OverlayText .. "O2 Level: " .. string.format("%g", self:GetNetworkedInt(1)) .. "%" .. "\n"
                OverlayText = OverlayText .. "CO2 Level: " .. string.format("%g", self:GetNetworkedInt(2)) .. "%" .. "\n"
                OverlayText = OverlayText .. "Nitrogen Level: " .. string.format("%g", self:GetNetworkedInt(3)) .. "%" .. "\n"
                OverlayText = OverlayText .. "Hydrogen Level: " .. string.format("%g", self:GetNetworkedInt(4)) .. "%" .. "\n"
                OverlayText = OverlayText .. "Vacuum: " .. string.format("%g", self:GetNetworkedInt(9)) .. "%" .. "\n"
                OverlayText = OverlayText .. "Pressure: " .. tostring(self:GetNetworkedInt(5)) .. "\n"
                OverlayText = OverlayText .. "Temperature: " .. tostring(self:GetNetworkedInt(6)) .. "\n"
                OverlayText = OverlayText .. "Gravity: " .. tostring(self:GetNetworkedInt(7)) .. "\n"
            end
            AddWorldTip(self:EntIndex(), OverlayText, 0.5, self:GetPos(), self)
        else
            local rot = Vector(0, 0, 90)
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
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            stringUsage = stringUsage .. "[" .. CAF.GetAddon("Resource Distribution").GetProperResourceName("energy") .. ": " .. CAF.GetAddon("Resource Distribution").GetResourceAmount(self, "energy") .. "/" .. CAF.GetAddon("Resource Distribution").GetNetworkCapacity(self, "energy") .. "] "
            surface.DrawText("Resources: " .. stringUsage)
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("Name: " .. tostring(self:GetNetworkedString(8)))
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("O2 Level: " .. string.format("%g", self:GetNetworkedInt(1)) .. "%")
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("CO2 Level: " .. string.format("%g", self:GetNetworkedInt(2)) .. "%")
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("Nitrogen Level: " .. string.format("%g", self:GetNetworkedInt(3)) .. "%")
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("Hydrogen Level: " .. string.format("%g", self:GetNetworkedInt(4)) .. "%")
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("'Empty' air Level: " .. string.format("%g", self:GetNetworkedInt(9)) .. "%")
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("Pressure: " .. tostring(self:GetNetworkedInt(5)))
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("Temperature: " .. tostring(self:GetNetworkedInt(6)))
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            surface.DrawText("Gravity: " .. tostring(self:GetNetworkedInt(7)))
            TempY = TempY + 70
            --Stop rendering
            cam.End3D2D()
        end
    else
        if (not bDontDrawModel) then self:DrawModel() end
    end
end
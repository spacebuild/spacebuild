include('shared.lua')

ENT.RenderGroup = RENDERGROUP_BOTH

local OOO = {}
OOO[0] = "Closed"
OOO[1] = "Open"

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
        local HasOOO = true
        local trace = LocalPlayer():GetEyeTrace()
        if (not bDontDrawModel) then self:DrawModel() end
        local playername = self:GetPlayerName()
        local netid = self:GetNetworkedInt("netid1")
        local netid2 = self:GetNetworkedInt("netid2")
        if playername == "" then
            playername = "World"
        end
        -- 0 = no overlay!
        -- 1 = default overlaytext
        -- 2 = new overlaytext

        if not mode or mode ~= 2 then
            local OverlayText = ""
            OverlayText = OverlayText .. self.PrintName .. "\n"
            if netid == 0 then
                OverlayText = OverlayText .. "Not connected to a Resource Node\n"
            else
                OverlayText = OverlayText .. "Connected to Resource Node " .. tostring(netid) .. "\n"
            end
            if netid2 == 0 then
                OverlayText = OverlayText .. "Not connected to a 2nd Resource Node\n"
            else
                OverlayText = OverlayText .. "Connected to Resource Node " .. tostring(netid2) .. "\n"
            end
            OverlayText = OverlayText .. "Owner: " .. playername .. "\n"
            if HasOOO then
                local runmode = "UnKnown"
                if self:GetOOO() >= 0 and self:GetOOO() <= 2 then
                    runmode = OOO[self:GetOOO()]
                end
                OverlayText = OverlayText .. "Mode: " .. runmode .. "\n"
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
            if netid == 0 then
                surface.DrawText("Not connected to a Resource Node")
            else
                surface.DrawText("Connected to Resource Node " .. netid)
            end
            TempY = TempY + 70
            surface.SetFont("Flavour")
            surface.SetTextColor(155, 155, 255, 255)
            surface.SetTextPos(textStartPos + 15, TempY)
            if netid2 == 0 then
                surface.DrawText("Not connected to a 2nd Resource Node")
            else
                surface.DrawText("Connected to Resource Node " .. netid2)
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
            --Stop rendering
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

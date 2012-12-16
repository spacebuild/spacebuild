--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 14/12/12
-- Time: 19:22
-- To change this template use File | Settings | File Templates.
--

include('shared.lua')

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw(bDontDrawModel)
    self:DoNormalDraw()
end

function ENT:DrawTranslucent(bDontDrawModel)
    if (bDontDrawModel) then return end
    self:Draw()
end

function ENT:DoNormalDraw(bDontDrawModel)
    local rd_overlay_dist = 512
    if (LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance(self:GetPos()) < rd_overlay_dist) then

        if (not bDontDrawModel) then self:DrawModel() end

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
        if (not bDontDrawModel) then self:DrawModel() end
    end
end
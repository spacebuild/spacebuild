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
    if (not bDontDrawModel) then self:DrawModel() end
end

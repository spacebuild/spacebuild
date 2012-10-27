include('shared.lua')

function ENT:Draw()
	self:DoNormalDraw()
	
	if (Wire_Render) then
		Wire_Render(self)
	end
end

function ENT:DrawTranslucent( bDontDrawModel )
	if ( bDontDrawModel ) then return end
	self:Draw()
end

function ENT:DoNormalDraw()

	if ( LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 ) and ( self:GetOverlayText() != "" ) then
		AddWorldTip( self:EntIndex(), self:GetOverlayText(), 0.5, self:GetPos(), self  )
	end
	
	self:DrawModel()
	
end

function ENT:Think()
	if (Wire_UpdateRenderBounds and CurTime() >= (self.NextRBUpdate or 0)) then
		self.NextRBUpdate = CurTime()+2
		Wire_UpdateRenderBounds(self)
	end
end

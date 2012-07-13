
include('shared.lua')

	
function ENT:Draw()
	//self:DrawModel()
	RDbeamlib.BeamRender( self:GetEnt() )
end

function ENT:Think()
	if ( CurTime() >= ( self.NextRBUpdate or 0 ) ) then
		RDbeamlib.UpdateRenderBounds( self:GetEnt() )
		self.NextRBUpdate = CurTime() + 3
	end
end



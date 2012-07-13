--Beam Drawer by TAD2020
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize()
	//self:SetModel("models/props_c17/oildrum001.mdl") --for debuging
	self:DrawShadow( false )
end

function ENT:SetEnt( ent, CheckLength )
	self.ent = ent
	self:SetNetworkedEntity( 1, ent )
	self.CheckLength = CheckLength
end

function ENT:OnRemove()
	RDbeamlib.ClearAllBeamsOnEnt( self.ent )
	RDbeamlib.ClearAllWireBeam( self.ent )
end

function ENT:Think()
	if ( self.CheckLength ) then
		RDbeamlib.CheckLength( self.ent )
		self:NextThink( CurTime() + ( math.random(30, 60) / 100 ))
		return true
	end
end


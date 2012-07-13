--Beam Drawer by TAD2020
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')


function ENT:Initialize()
	--self.Entity:SetModel("models/props_c17/oildrum001.mdl") --for debuging
	self.Entity:DrawShadow( false )
end

function ENT:SetEnt( ent, CheckLength )
	self.ent = ent
	self.Entity:SetNetworkedEntity( 1, ent )
	self.CheckLength = CheckLength
end

function ENT:OnRemove()
	RDbeamlib.ClearAllBeamsOnEnt( self.ent )
	RDbeamlib.ClearAllWireBeam( self.ent )
end

function ENT:Think()
	if ( self.CheckLength ) then
		RDbeamlib.CheckLength( self.ent )
		self.Entity:NextThink( CurTime() + ( math.random(30, 60) / 100 ))
		return true
	end
end


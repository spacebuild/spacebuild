
ENT.Type 			= "anim"

ENT.PrintName		= "RDBeam Drawer"
ENT.Author			= "TAD2020"
ENT.Contact			= "http://www.wiremod.com/"


function ENT:GetEnt()
	return self.Entity:GetNetworkedEntity( 1 )
end


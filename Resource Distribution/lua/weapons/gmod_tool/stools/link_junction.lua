if not ( RES_DISTRIB == 2 ) then Error("Please Install Resource Distribution 2 Addon.'" ) return end

TOOL.Category = '(Resource Dist.)'
TOOL.Name = '#Link Junction'
TOOL.Command = nil
TOOL.ConfigName = ''
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end

local MODEL = "models/props_pipes/pipe03_connector01.mdl"
util.PrecacheModel( MODEL )

cleanup.Register('linkjunctions')

if ( CLIENT ) then
	language.Add( 'tool.link_junction.name', 'Link Junction' )
	language.Add( 'tool.link_junction.desc', 'Create a resource link junction attached to any surface.' )
	language.Add( 'tool.link_junction.0', 'Left-Click: Spawn a Device.' )

	language.Add( 'Undone_LinkJunctions', 'Link Junction Undone' )
	language.Add( 'Cleanup_LinkJunctions', 'Link Junction' )
	language.Add( 'Cleaned_LinkJunctions', 'Cleaned up all Link Junctions' )
	language.Add( 'SBoxLimit_linkjunctions', 'Maximum Link Junctions Reached' )
end

function TOOL:LeftClick( trace )
	if trace.Entity and (trace.Entity:IsPlayer() ) then return false end
	if(CLIENT) then return true end
	
	if ( !self:GetSWEP():CheckLimit( "linkjunctions" ) ) then return false end
	
	local ply = self:GetOwner()
	local Pos = trace.HitPos
	local Ang = trace.HitNormal:Angle()
	
	local ent = MakeLinkJunction( ply, Ang, Pos )
	ent:SetPos( trace.HitPos - trace.HitNormal * ent:OBBMins().x)
	
	local const, nocollide
	if ( trace.Entity:IsValid() ) then
		const = constraint.Weld(ent, trace.Entity,0, trace.PhysicsBone, 0, systemmanager )
		nocollide = constraint.NoCollide( ent, trace.Entity, 0, trace.PhysicsBone )
		trace.Entity:DeleteOnRemove( ent )
	end
	
	undo.Create('LinkJunctions')
		undo.AddEntity( ent )
		undo.AddEntity( const )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()
	ply:AddCleanup( 'linkjunctions', ent )
	return true
end

if SERVER then 
	CreateConVar('sbox_maxlinkjunctions', 20)
	
	function MakeLinkJunction( ply, Ang, Pos )
		if ( !ply:CheckLimit( "linkjunctions" ) ) then return nil end
		
		local ent = ents.Create( "res_junction" )
		if !ent:IsValid() then return false end
			ent:SetModel( MODEL )
			ent:SetAngles(Ang)
			ent:SetPos(Pos)
			ent:SetPlayer(ply)
		ent:Spawn()
		
		ent.Active = 0
		ent.resources2 = {}
		
		ply:AddCount('linkjunctions', ent)
		
		return ent
	end
	duplicator.RegisterEntityClass("res_junction", MakeLinkJunction, "Ang", "Pos", "Active", "Vel", "aVel", "frozen")
	
end

function TOOL.BuildCPanel( cp )
	cp:AddControl( 'Header', { Text = '#Tool.link_junction.name', Description	= '#Tool.link_junction.desc' }  )
end

function TOOL:Think()
	if (RD2_UpdateToolGhost) then RD2_UpdateToolGhost( self, "models/props_pipes/pipe03_connector01.mdl", "x" ) end
end

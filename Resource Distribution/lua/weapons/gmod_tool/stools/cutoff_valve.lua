if not ( RES_DISTRIB == 2 ) then Error("Please Install Resource Distribution 2 Addon.'" ) return end

TOOL.Category = '(Resource Dist.)'
TOOL.Name = '#Cutoff Valve'
TOOL.Command = nil
TOOL.ConfigName = ''
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end

local MODEL = "models/props_c17/utilityconnecter006.mdl"
util.PrecacheModel( MODEL )

cleanup.Register('cutoffvalves')

if ( CLIENT ) then
	language.Add( 'tool.cutoff_valve.name', 'Cutoff Valve' )
	language.Add( 'tool.cutoff_valve.desc', 'Create a Cutoff Valve attached to any surface.' )
	language.Add( 'tool.cutoff_valve.0', 'Left-Click: Spawn a Device.' )

	language.Add( 'Undone_CutoffValves', 'Cutoff Valve Undone' )
	language.Add( 'Cleanup_CutoffValves', 'Cutoff Valve' )
	language.Add( 'Cleaned_CutoffValves', 'Cleaned up all Cutoff Valves' )
	language.Add( 'SBoxLimit_cutoffvalves', 'Maximum Cutoff Valves Reached' )
end

function TOOL:LeftClick( trace )
	if trace.Entity and (trace.Entity:IsPlayer() ) then return false end
	if (CLIENT) then return true end
	
	if ( !self:GetSWEP():CheckLimit( "cutoffvalves" ) ) then return false end
	
	local ply = self:GetOwner()
	local Pos = trace.HitPos
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch + 90
	
	local ent = MakeCutoffValve( ply, Ang, Pos )
	ent:SetPos( trace.HitPos - trace.HitNormal * ent:OBBMins().z)
	
	local const, nocollide
	if ( trace.Entity:IsValid() ) then
		const = constraint.Weld(ent, trace.Entity,0, trace.PhysicsBone, 0, systemmanager )
		nocollide = constraint.NoCollide( ent, trace.Entity, 0, trace.PhysicsBone )
		trace.Entity:DeleteOnRemove( ent )
	end
	
	undo.Create('CutoffValves')
		undo.AddEntity( ent )
		undo.AddEntity( const )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()
	ply:AddCleanup( 'cutoffvalves', ent )
	return true
end

if (SERVER) then 
	CreateConVar('sbox_maxcutoffvalves', 10)
	
	function MakeCutoffValve( ply, Ang, Pos )
		if ( !ply:CheckLimit( "cutoffvalves" ) ) then return nil end
		
		local ent = ents.Create( "res_valve" )
		if !ent:IsValid() then return false end
			ent:SetModel( MODEL )
			ent:SetAngles(Ang)
			ent:SetPos(Pos)
			ent:SetPlayer(ply)
		ent:Spawn()
		
		ply:AddCount('cutoffvalves', ent)
		
		return ent
	end
	duplicator.RegisterEntityClass("res_valve", MakeCutoffValve, "Ang", "Pos", "Active", "Vel", "aVel", "frozen")
	
end

function TOOL.BuildCPanel( cp )
	cp:AddControl( 'Header', { Text = '#Tool.cutoff_valve.name', Description	= '#Tool.cutoff_valve.desc' }  )
end

function TOOL:Think()
	if (RD2_UpdateToolGhost) then RD2_UpdateToolGhost( self, "models/props_c17/utilityconnecter006.mdl" ) end
end

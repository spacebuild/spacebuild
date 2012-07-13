if not ( RES_DISTRIB == 2 ) then Error("Please Install Resource Distribution 2 Addon.'" ) return end

TOOL.Category = '(Resource Dist.)'
TOOL.Name = '#Supply Connector'
TOOL.Command = nil
TOOL.ConfigName = ''
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end

TOOL.ClientConVar["pump"] =   "0"
TOOL.ClientConVar["rate"] = "100"
TOOL.ClientConVar["hoselength"] = "10"

local MODEL = "models/props_lab/tpplugholder_single.mdl"
util.PrecacheModel( MODEL )

cleanup.Register('supplyconnectors')

if ( CLIENT ) then
	language.Add( 'Tool_sup_connector_name', 'Supply Connector' )
	language.Add( 'Tool_sup_connector_desc', 'Create a Supply Connector attached to any surface.' )
	language.Add( 'Tool_sup_connector_0', 'Left-Click: Spawn a Device.' )

	language.Add( 'Undone_SupplyConnectors', 'Supply Connector Undone' )
	language.Add( 'Cleanup_SupplyConnectors', 'Supply Connector' )
	language.Add( 'Cleaned_SupplyConnectors', 'Cleaned up all Supply Connectors' )
	language.Add( 'SBoxLimit_connectors', 'Maximum Supply Connectors Reached' )
end

local function GetOffset( ang, offset )
	return ang:Up() * 2 + ang:Up() * offset.X + ang:Forward() * -1 * offset.Z + ang:Right() * offset.Y
end

function TOOL:LeftClick( trace )
	if trace.Entity and (trace.Entity:IsPlayer() ) then return false end
	if (CLIENT) then return true end
	
	if ( !self:GetSWEP():CheckLimit( "connectors" ) ) then return false end
	
	local pump = self:GetClientNumber("pump")
	local rate = math.floor(self:GetClientNumber("rate"))
	local hoselength = math.floor(self:GetClientNumber("hoselength") * 100) / 100

	local ply = self:GetOwner()
	local Pos = trace.HitPos
	local Ang = trace.HitNormal:Angle()
	Pos = Pos + GetOffset( trace.HitNormal:Angle(), Vector(-12, 13, 0) )
	
	local ent = MakeSupplyConnector( ply, Ang, Pos, pump, rate, hoselength )
	
	local const, nocollide
	if ( trace.Entity:IsValid() ) then
		const = constraint.Weld(ent, trace.Entity,0, trace.PhysicsBone, 0, systemmanager )
		nocollide = constraint.NoCollide( ent, trace.Entity, 0, trace.PhysicsBone )
		trace.Entity:DeleteOnRemove( ent )
	end
	
	undo.Create('SupplyConnectors')
		undo.AddEntity( ent )
		undo.AddEntity( const )
		undo.AddEntity( nocollide )
		undo.SetPlayer( ply )
	undo.Finish()
	ply:AddCleanup( 'supplyconnectors', ent )
	return true
end

if (SERVER) then 
	CreateConVar('sbox_maxconnectors',40)
	
	function MakeSupplyConnector( ply, Ang, Pos, pump, rate, hoselength )
		if ( !ply:CheckLimit( "connectors" ) ) then return nil end
		
		hoselength = hoselength or 10
		
		local ent = ents.Create( "res_pump" )
		if !ent:IsValid() then return false end
			ent:SetModel( MODEL )
			ent:SetAngles(Ang)
			ent:SetPos(Pos)
			ent:SetPlayer(ply)
		ent:Spawn()
		ent:Setup( pump, rate, hoselength )
		
		local rtable = {
			pump = pump,
			rate = rate,
			hoselength = hoselength,
		}
		table.Merge(ent:GetTable(), rtable )

		ply:AddCount('supplyconnectors', ent)
		
		return ent
	end
	duplicator.RegisterEntityClass("res_pump", MakeSupplyConnector, "Ang", "Pos", "pump", "rate", "hoselength", "Vel", "aVel", "frozen")
	
end

function TOOL.BuildCPanel( cp )
	cp:AddControl('Header', {Text = '#Tool_sup_connector_name', Description = '#Tool_sup_connector_desc' }  )
	cp:AddControl("Slider", {Label = "#Hose Length", Type = "Float", Min = 1, Max = 30, Command = "sup_connector_hoselength"})
	cp:AddControl("Checkbox", {Label = "#Uses Pump", Command = "sup_connector_pump"})
	cp:AddControl("Slider", {Label = "#Transfer Rate(using pump)", Type = "Integer", Min = -300, Max = 300, Command = "sup_connector_rate"})
end

function TOOL:Think()
	if (RD2_UpdateToolGhost) then RD2_UpdateToolGhost( self, "models/props_lab/tpplugholder_single.mdl", "x", GetOffset, Vector(-12, 13, 0) ) end
end

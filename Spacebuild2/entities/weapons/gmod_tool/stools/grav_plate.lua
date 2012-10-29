
TOOL.Category = '(Life Support)'
TOOL.Name = '#Gravity Plating'
TOOL.Command = nil
TOOL.ConfigName = ''
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end

-- Add Default Language translation (saves adding it to the txt files)
if ( CLIENT ) then
	language.Add( "Tool_grav_plate_name", "Gravity Plating" )
	language.Add( "Tool_grav_plate_desc", "Enables walking on a prop even in low-to-zero gravity." )
	language.Add( "Tool_grav_plate_0", "Left Click to attach Gravity Plating.  Right Click to take it off." )
end

local function SetGravPlating( ply, ent, data )
	if ( data.grav_plate ) then
		ent.grav_plate = 1
		if ( SERVER ) then
			ent.EntityMods = ent.EntityMods or {}
			ent.EntityMods.GravPlating = Data
		end
	else
		ent.grav_plate = nil
		if ( SERVER ) then
			if ent.EntityMods then ent.EntityMods.GravPlating = nil end
		end	
	end
end
duplicator.RegisterEntityModifier( "GravPlating", SetGravPlating )

function TOOL:LeftClick( trace )
	if trace.Entity then
		if !trace.Entity:IsValid() or trace.Entity:IsPlayer() or trace.HitWorld or trace.Entity:IsNPC() then
			return false
		end
	end
	if CLIENT then return true end
	SetGravPlating( self:GetOwner(), trace.Entity, { grav_plate = 1 } )
	self:GetOwner():SendLua( "GAMEMODE:AddNotify('Surface has received Gravity Plating.', NOTIFY_GENERIC, 7);" )
	return true
end

function TOOL:RightClick( trace )
	if trace.Entity then
		if !trace.Entity:IsValid() or trace.Entity:IsPlayer() or trace.HitWorld or trace.Entity:IsNPC() then
			return false
		end
	end
	if CLIENT then return true end
	SetGravPlating( self:GetOwner(), trace.Entity, { grav_plate = nil } ) 
	self:GetOwner():SendLua( "GAMEMODE:AddNotify('Gravity Plating removed from surface.', NOTIFY_GENERIC, 7);" )
	return true
end

function TOOL.BuildCPanel( CPanel )
	-- HEADER
	CPanel:AddControl( "Header", { Text = "#Tool_grav_plate_name", Description	= "#Tool_grav_plate_desc" }  )
end

local function OverrideCanTool(pl, rt, toolmode)
	-- We don't want any addons denying use of this tool. Even when using
	-- PropDefender, people should be able to use this tool on other people's
	-- stuff.
	if toolmode == "grav_plate" then
		return true
	end
end
hook.Add( "CanTool", "grav_plate_CanTool", OverrideCanTool );

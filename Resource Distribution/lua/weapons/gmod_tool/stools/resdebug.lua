if not ( RES_DISTRIB == 2 ) then Error("Please Install Resource Distribution 2 Addon.'" ) return end
if not game.SinglePlayer() then return end

TOOL.Category		= "(Resource Dist.)"
TOOL.Name			= "Res. Debuger"
TOOL.Command		= nil
TOOL.ConfigName		= nil
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end


if ( CLIENT ) then
	language.Add( "tool.resdebug.name",	"RD Resource Debuger" )
	language.Add( "tool.resdebug.desc",	"Spams teh ent's resource table to the console" )
	language.Add( "tool.resdebug.0", 	"Click an RD Ent" )
end

function TOOL:LeftClick( trace )
	if ( !trace.Entity:IsValid() ) then return false end
	if (CLIENT) then return true end
	
	RD_PrintResources(trace.Entity)
	
	return true
	
end

function TOOL:RightClick( trace )
	if ( !trace.Entity:IsValid() ) then return false end
	if (CLIENT) then return true end
	
	--for something else
	
	return true
end

function TOOL:Reload( trace )
	if ( !trace.Entity:IsValid() ) then return false end
	if (CLIENT) then return true end
	
	--for something else
	
	return true
end
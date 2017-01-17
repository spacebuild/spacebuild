local lang = SPACEBUILD.lang

TOOL.Category = lang.get("tool.category.rd")
TOOL.Mode 			= "rd3_resdebug"
TOOL.Name			= "#Res. Debuger"
TOOL.Command		= nil
TOOL.ConfigName		= nil
TOOL.Tab = "Spacebuild"


if ( CLIENT ) then
	lang.register( "tool.rd3_resdebug.name" )
	lang.register( "tool.rd3_resdebug.desc" )
	lang.register( "tool.rd3_resdebug.0" )
end

function TOOL:LeftClick( trace )
	if ( not trace.Entity:IsValid() ) then return false end
	if (CLIENT) then return true end
	CAF.GetAddon("Resource Distribution").PrintDebug(trace.Entity)
	return true
end

function TOOL:RightClick( trace )
	if ( not trace.Entity:IsValid() ) then return false end
	if (SERVER or not IsFirstTimePredicted()) then return true end
	CAF.GetAddon("Resource Distribution").PrintDebug(trace.Entity)
	return true
end

function TOOL:Reload( trace )
	if ( not trace.Entity:IsValid() ) then return false end
	if (CLIENT) then return true end
	--for something else
	return true
end

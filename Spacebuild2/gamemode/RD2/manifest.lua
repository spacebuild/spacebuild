if ( VERSION < 126 ) then
	Msg("Your GMod is out of date! RD2 will not work on version: ",VERSION,"\n")
	return
end


include( "RD2_Tools.lua" )

if (SERVER) then

	RD2Version = 8	--change this value to the current revision number when making a general release
	
	Msg("===============================\n===  RD2  "..RD2Version.."   Installed   ===\n===============================\n")
	
	local function initplayer(ply)
		umsg.Start( "rd2_initplayer", ply )
			umsg.Short( RD2Version or 0 )
		umsg.End()
	end
	hook.Add( "PlayerInitialSpawn", "RD2PlayerInitSpawn", initplayer )

	include( "sv_resource2.lua" )

	return
end


include( "cl_tab.lua" )

local function initplayer(um)
	RD2Version = um:ReadShort()
	Msg("===============================\n===  RD2  "..RD2Version.."   Installed   ===\n===============================\n")
end
usermessage.Hook( "rd2_initplayer", initplayer )


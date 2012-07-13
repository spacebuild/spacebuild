util.PrecacheSound( "vehicles/v8/skid_lowfriction.wav" )
util.PrecacheSound( "NPC_Stalker.BurnFlesh" )
util.PrecacheModel("models/player/charple01.mdl")


function zapme(pos, magnitude)
	zap = ents.Create("point_tesla")
	zap:SetKeyValue("targetname", "teslab")
	zap:SetKeyValue("m_SoundName" ,"DoSpark")
	zap:SetKeyValue("texture" ,"sprites/physbeam.spr")
	zap:SetKeyValue("m_Color" ,"200 200 255")
	zap:SetKeyValue("m_flRadius" ,tostring(magnitude*80))
	zap:SetKeyValue("beamcount_min" ,tostring(math.ceil(magnitude)+4))
	zap:SetKeyValue("beamcount_max", tostring(math.ceil(magnitude)+12))
	zap:SetKeyValue("thick_min", tostring(magnitude))
	zap:SetKeyValue("thick_max", tostring(magnitude*8))
	zap:SetKeyValue("lifetime_min" ,"0.1")
	zap:SetKeyValue("lifetime_max", "0.2")
	zap:SetKeyValue("interval_min", "0.05")
	zap:SetKeyValue("interval_max" ,"0.08")
	zap:SetPos(pos)
	zap:Spawn()
	zap:Fire("DoSpark","",0)
	zap:Fire("kill","", 1)
end


function burn_quiet(ent)
	ent:StopSound( "NPC_Stalker.BurnFlesh" )
end


function LS_Immolate(ent)
	ent:EmitSound( "NPC_Stalker.BurnFlesh" )
	ent:SetModel("models/player/charple01.mdl")
	timer.Simple(3, burn_quiet, ent)
end


function LS_Frosty(ent)
	ent:EmitSound( "vehicles/v8/skid_lowfriction.wav" )
end

function LS_Crush(ent)
	ent:EmitSound( "Player.FallGib" )
end

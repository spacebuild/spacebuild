function AllowAdminNoclip(ply)
	if (ply:IsAdmin() or ply:IsSuperAdmin()) and server_settings.Bool( "SB_AdminSpaceNoclip" ) then return true end
	if ply:IsSuperAdmin() and server_settings.Bool( "SB_SuperAdminSpaceNoclip" ) then return true end
	return false
end


function GM:PlayerNoClip( pl, on )
	--no clip allowed in singleplayer, on planets, is turning off noclip, is admin, or SB_PlanetNoClipOnly is off
	--TODO, allow a little margin away from planet for before disabing noclip so players do get stuck in the walls around the edges of the planets
	if (SinglePlayer() or( server_settings.Bool( "SB_NoClip" ) and (pl.planet or AllowAdminNoclip(pl) or not server_settings.Bool( "SB_PlanetNoClipOnly" )))) then return true end
	return false
end

function GM:PlayerSay( ply, txt )
	self.BaseClass:PlayerSay( ply, txt )
	if not ply:IsAdmin() then return true end

	if (string.sub(txt, 1, 10 ) == "!freespace") then
		self:RemoveSBProps(false)
		return false
	elseif (string.sub(txt, 1, 10 ) == "!freeworld") then
		self:RemoveSBProps(true)
		return false
	end
	return true
end

function GM:RemoveSBProps(world)
	for _, class in ipairs( self.affected ) do
		local stuff = ents.FindByClass( class )
		for _, ent in ipairs( stuff ) do
			if world==true and ent.planet then
				if not ent:IsPlayer() then
					local delay = (math.random(1, 500) / 100)
					ent:SetKeyValue("exploderadius","1")  
					ent:SetKeyValue("explodedamage","1")  
					ent:Fire("break","",tostring(delay)) 
					ent:Fire("kill","",tostring(delay + 1)) 
				end
			elseif world==false and not ent.planet then
				if not ent:IsPlayer() then
					local delay = (math.random(1, 500) / 100)
					ent:SetKeyValue("exploderadius","1")  
					ent:SetKeyValue("explodedamage","1")  
					ent:Fire("break","",tostring(delay)) 
					ent:Fire("kill","",tostring(delay + 1)) 
				end
			end
		end
	end
	return
end

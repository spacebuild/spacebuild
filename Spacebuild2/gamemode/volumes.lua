function Allocate_Volume( radius, name )
	local tries = 10
	local pos = Vector(0, 0, 0)
	local hash = {}	
	local found = 0
	while ( ( found == 0 ) and ( tries > 0 ) ) do
		tries = tries - 1
		pos = VectorRand()*16384
		if (util.IsInWorld( pos ) == true) then
			found = 1
			if (found == 1) then
				if SB_OnEnvironment(pos, nil, radius + 16) then
					found = 0
				end
			end
			if (found == 1) then
				local edges = {
					pos+(Vector(1, 0, 0)*radius),
					pos+(Vector(0, 1, 0)*radius),
					pos+(Vector(0, 0, 1)*radius),
					pos+(Vector(-1, 0, 0)*radius),
					pos+(Vector(0, -1, 0)*radius),
					pos+(Vector(0, 0, -1)*radius)
				}
				local trace = {}
				trace.start = pos
				for _, edge in pairs( edges ) do
					trace.endpos = edge
					trace.filter = { }
					local tr = util.TraceLine( trace )
					if (tr.Hit) then
						found = 0
						break
					end
				end
			end
			if (found == 0) then Msg( "Rejected Volume.\n" ) end
		end
		if (tries > 0) then
			hash.pos = pos
			hash.num = 1
		else
			hash.pos = Vector(0, 0, 0)
			hash.num = 0
		end
		return hash
	end
end

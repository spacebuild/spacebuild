-- draw sun effects
local stars = {}
local function DrawSunEffects( )
	-- no pixel shaders? no sun effects!
	if( !render.SupportsPixelShaders_2_0() ) then return; end
	-- render each star.
	for _, Sun in pairs( stars ) do
		-- calculate brightness.
		local dot = math.Clamp( EyeAngles():Forward():DotProduct( ( Sun.Position - EyePos() ):Normalize() ), 0, 1 );
		local dist = ( Sun.Position - EyePos() ):Length();
		-- draw sunbeams.
		local sunpos = EyePos() + ( Sun.Position - EyePos() ):Normalize() * ( dist * 0.5 );
		local scrpos = sunpos:ToScreen();
		if( dist <= Sun.BeamRadius and dot > 0 ) then
			local frac = ( 1 - ( ( 1 / ( Sun.BeamRadius ) ) * dist ) ) * dot;
			-- draw sun.
			DrawSunbeams(
				0.95,
				frac,
				0.255,
				scrpos.x / ScrW(),
				scrpos.y / ScrH()
			);
		end
		-- can the sun see us?
		local trace = {
			start = Sun.Position,
			endpos = EyePos(),
			filter = LocalPlayer(),
		};
		local tr = util.TraceLine( trace );
		-- draw!
		if( dist <= Sun.Radius and dot > 0 and tr.Fraction >= 1 ) then
			-- calculate brightness.
			local frac = ( 1 - ( ( 1 / Sun.Radius ) * dist ) ) * dot;
			-- draw bloom.
			DrawBloom(
				0.428, 
				3 * frac, 
				15 * frac, 15 * frac, 
				5, 
				0, 
				1, 
				1, 
				1
			);
			-- draw color.
			local tab = {
				['$pp_colour_addr']		= 0.35 * frac,
				['$pp_colour_addg']		= 0.15 * frac,
				['$pp_colour_addb']		= 0.05 * frac,
				['$pp_colour_brightness']	= 0.8 * frac,
				['$pp_colour_contrast']		= 1 + ( 0.15 * frac ),
				['$pp_colour_colour']		= 1,
				['$pp_colour_mulr']		= 0,
				['$pp_colour_mulg']		= 0,
				['$pp_colour_mulb']		= 0,
			};
			-- draw colormod.
			DrawColorModify( tab );
		end
	end

end
hook.Add( "RenderScreenspaceEffects", "SunEffects", DrawSunEffects );


-- receive sun information
local function recvSun( msg )
	local num = msg:ReadShort()
	local pos = msg:ReadVector()
	local radius = msg:ReadFloat()
	stars[ num ] = {
		Position = pos,
		Radius = radius * 2,
		BeamRadius = radius * 3,
	}
end
usermessage.Hook( "AddStar", recvSun );


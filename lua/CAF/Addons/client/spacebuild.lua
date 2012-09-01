list.Set( "PlayerOptionsModel",  "MedicMarine", "models/player/samzanemesis/MarineMedic.mdl" ) 
list.Set( "PlayerOptionsModel",  "SpecialMarine", "models/player/samzanemesis/MarineSpecial.mdl" ) 
list.Set( "PlayerOptionsModel",  "OfficerMarine", "models/player/samzanemesis/MarineOfficer.mdl" ) 
list.Set( "PlayerOptionsModel",  "TechMarine", "models/player/samzanemesis/MarineTech.mdl" ) 

local SB = {}

local status = false

SB3 = SB
include("CAF/Addons/shared/spacebuild.lua")
SB3 = nil;

--Local functions
-- used for sun effects
local stars = {}

-- Used for planet effects
local planets = {} --Clients hasn't been updated yet
-- enabled?
local Color_Enabled = false;
local Bloom_Enabled = false;

-- Color Variables.
local ColorModify = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 0,
	[ "$pp_colour_colour" ] = 0,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0,
};

-- Bloom Variables
local Bloom = {
	darken = 0,
	multiply = 0,
	sizex = 0,
	sizey = 0,
	passes = 0,
	color = 0,
	col = {
		r = 0,
		g = 0,
		b = 0,
	},
};
-- Color receive message
local function SetColor(planet)
	-- don't support colormod?
	if( not render.SupportsPixelShaders_2_0() ) then return; end
	-- enabled?
	Color_Enabled = planet.color
	if( not Color_Enabled ) then return; end
	-- read attributes
	ColorModify[ "$pp_colour_addr" ] 	= planet.AddColor_r
	ColorModify[ "$pp_colour_addg" ] 	= planet.AddColor_g
	ColorModify[ "$pp_colour_addb" ] 	= planet.AddColor_b
	ColorModify[ "$pp_colour_brightness" ] 	= planet.Brightness
	ColorModify[ "$pp_colour_contrast" ] 	= planet.Contrast
	ColorModify[ "$pp_colour_colour" ] 	= planet.CColor
	ColorModify[ "$pp_colour_mulr" ] 	= planet.AddColor_r
	ColorModify[ "$pp_colour_mulg" ] 	= planet.AddColor_g
	ColorModify[ "$pp_colour_mulb" ] 	= planet.AddColor_b
end

-- Bloom receive message
local function SetBloom(planet)
	-- don't support bloom?
	if( not render.SupportsPixelShaders_2_0() ) then return; end
	-- enabled?
	Bloom_Enabled = planet.bloom
	if( not Bloom_Enabled ) then return; end
	-- read attributes
	Bloom.darken 	= planet.Darken
	Bloom.multiply 	= planet.Multiply
	Bloom.sizex 	= planet.SizeX
	Bloom.sizey 	= planet.SizeY
	Bloom.passes 	= planet.Passes
	Bloom.color 	= planet.BColor
	Bloom.col.r 	= planet.Col_r
	Bloom.col.g 	= planet.Col_g
	Bloom.col.b 	= planet.Col_b
end

-- render.
local function Render( )
	if( Color_Enabled ) then
		-- draw colormod.
		DrawColorModify( ColorModify );
	end
	if( Bloom_Enabled ) then
		-- draw bloom.
		--DrawBloom( darken, multiply, sizex, sizey, passes, color, colr, colg, colb )
		DrawBloom(
			Bloom.darken, 
			Bloom.multiply, 
			Bloom.sizex, 
			Bloom.sizey, 
			Bloom.passes, 
			Bloom.color, 
			Bloom.col.r, 
			Bloom.col.g, 
			Bloom.col.b 
		);
	end
end

local function DrawSunEffects( )
	-- no pixel shaders? no sun effects!
	if( not render.SupportsPixelShaders_2_0() ) then return; end
	-- render each star.
	for ent, Sun in pairs( stars ) do
		-- calculate brightness.
		local entpos = Sun.Position --Sun.ent:LocalToWorld( Vector(0,0,0) )
		local dot = math.Clamp( EyeAngles():Forward():DotProduct( Vector( entpos - EyePos() ):Normalize() ), -1, 1 );
		dot = math.abs(dot)
		--local dist = Vector( entpos - EyePos() ):Length();
		local dist = entpos:Distance(EyePos())/1.5
		-- draw sunbeams.
		local sunpos = EyePos() + Vector( entpos - EyePos() ):Normalize() * ( dist * 0.5 );
		local scrpos = sunpos:ToScreen();
		if( dist <= Sun.BeamRadius and dot > 0 ) then
			local frac = ( 1 - ( ( 1 / ( Sun.BeamRadius ) ) * dist ) ) * dot;
			-- draw sun.
			--DrawSunbeams( darken, multiply, sunsize, sunx, suny )
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
			start = entpos,
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
			--[[DrawBloom(
				0, 
				0.75 * frac, 
				3 * frac, 3 * frac, 
				2, 
				3, 
				1, 
				1, 
				1
			);]]
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

local function recPlanet( msg )
	local ent = msg:ReadShort()
	local hash  = {}
	hash.ent = ents.GetByIndex(ent)
	hash.name = msg:ReadString()
	hash.position = msg:ReadVector()
	hash.radius = msg:ReadFloat()
	if msg:ReadBool() then
		hash.color = true
		hash.AddColor_r = msg:ReadShort()
		hash.AddColor_g = msg:ReadShort()
		hash.AddColor_b = msg:ReadShort()
		hash.MulColor_r = msg:ReadShort()		
		hash.MulColor_g = msg:ReadShort()
		hash.MulColor_b = msg:ReadShort()
		hash.Brightness = msg:ReadFloat()
		hash.Contrast = msg:ReadFloat()
		hash.CColor = msg:ReadFloat()
	else
		hash.color = false
	end
	if msg:ReadBool() then
		hash.bloom = true
		hash.Col_r = msg:ReadShort()
		hash.Col_g = msg:ReadShort()
		hash.Col_b = msg:ReadShort()
		hash.SizeX = msg:ReadFloat()
		hash.SizeY = msg:ReadFloat()
		hash.Passes = msg:ReadFloat()
		hash.Darken = msg:ReadFloat()
		hash.Multiply = msg:ReadFloat()
		hash.BColor = msg:ReadFloat()
	else
		hash.bloom = false
	end
	planets[ent] = hash
end
usermessage.Hook( "AddPlanet", recPlanet );

-- receive sun information
local function recvSun( msg )
	local ent = msg:ReadShort()
	local tmpname = msg:ReadString()
	local position = msg:ReadVector()
	local radius = msg:ReadFloat()
	stars[ ent] = {
		Ent = ents.GetByIndex(ent),
		name = tmpname,
		Position = position,
		Radius = radius, -- * 2
		BeamRadius = radius * 1.5, --*3
	}
end
usermessage.Hook( "AddStar", recvSun );

--End Local Functions



--The Class
--[[
	The Constructor for this Custom Addon Class
]]
function SB.__Construct()
	hook.Add( "RenderScreenspaceEffects", "VFX_Render", Render );
	hook.Add( "RenderScreenspaceEffects", "SunEffects", DrawSunEffects );
	CAF.AddHook("think2", Space_Affect_Cl)
	status = true;
	return true
end

--[[
	The Destructor for this Custom Addon Class
]]
function SB.__Destruct()
	hook.Remove( "RenderScreenspaceEffects", "VFX_Render");
	hook.Remove( "RenderScreenspaceEffects", "SunEffects");
	CAF.RemoveHook("think2", Space_Affect_Cl)
	status = false;
	return true
end

--Custom Functions
function SB.Space_Affect_Cl()
	if table.Count(planets) <= 0 then return end
	local ply = LocalPlayer()
	if not (ply and ply:IsValid() and ply:Alive()) then return end
	local plypos = ply:LocalToWorld( Vector(0,0,0) )
	for ent, p in pairs( planets ) do
		local ppos = p.position --:LocalToWorld( Vector(0,0,0) )
		if plypos:Distance(ppos) < p.radius then
			if not ply.planet or ply.planet ~= ent then
				ply:ChatPrint("Entering "..tostring(p.name))
				SetBloom(p)
				SetColor(p)
				ply.planet = ent
		  	end
			return
		end
	end
	if (ply.planet ~= nil) then
		Color_Enabled = false
		Bloom_Enabled = false
		ply.planet = nil
	end
end
--End

--[[
	Get the Boolean Status from this Addon Class
]]
function SB.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
]]
function SB.GetVersion()
	return 3.1, CAF.GetLangVar("Beta")
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function SB.GetExtraOptions()
	return {}
end

--[[
	Gets a menu from this Custom Addon Class
]]
function SB.GetMenu(menutype, menuname) --Name is nil for main menu, String for others
	local data = {}
	return data
end

--[[
	Get the Custom String Status from this Addon Class
]]
function SB.GetCustomStatus()
	return
end

--[[
	Returns a table containing the Description of this addon
]]
function SB.GetDescription()
	return {
				"Spacebuild Addon",
				"",
				"Prviously a Gamemode",
				""
			}
end

CAF.RegisterAddon("Spacebuild",  SB, "1") 



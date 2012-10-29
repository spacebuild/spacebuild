if not ( RES_DISTRIB == 2 ) then Error("Please Install Resource Distribution 2 Addon.'" ) return end

TOOL.Category = '(Life Support)'
TOOL.Name = '#Environmental Control'
TOOL.Command = nil
TOOL.ConfigName = ''
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end

TOOL.ClientConVar['type'] = 'air_tank'
TOOL.ClientConVar['model'] = 'models/props_combine/combine_emitter01.mdl'

cleanup.Register('lifesupport')

if ( CLIENT ) then
	language.Add( 'tool.life_support.name', 'Life Support Systems' )
	language.Add( 'tool.life_support.desc', 'Create Life Support Systems attached to any surface.' )
	language.Add( 'tool.life_support.0', 'Left-Click: Spawn a Device.  Right-Click: Repair Device.' )

	language.Add( 'Undone_life_support', 'Life Support Device Undone' )
	language.Add( 'Cleanup_life_support', 'LS: Environmental Control Device' )
	language.Add( 'Cleaned_life_support', 'Cleaned up all Environmental Control Devices' )
	language.Add( 'SBoxLimit_lifesupports', 'Maximum Environmental Control Devices Reached' )
end

local life_support = {}
if (SERVER) then
	
	life_support.dispenser = function( ply, ent, system_type, system_class, model )
		local maxhealth = 100
		local mass = 0
		RD_AddResource(ent, "air", 0)
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "coolant", 0)
		LS_RegisterEnt(ent, "Dispenser")
		return {}, maxhealth, mass
	end
	
	life_support.air_exchanger = function( ply, ent, system_type, system_class, model )
		local rtable, maxhealth, mass = {}, 0, 0
		if (model == "models/props_combine/combine_light001a.mdl") then
			rtable.radius = 256
			maxhealth = 500
			mass = 100
		elseif (model == "models/props_combine/combine_light001b.mdl") then
			rtable.radius = 768
			maxhealth = 600
			mass = 1200
		end
		rtable.HasAir = false
		RD_AddResource(ent, "air", 0)
		RD_AddResource(ent, "energy", 0)
		LS_RegisterEnt(ent, "Air", rtable.radius)
		return rtable, maxhealth, mass
	end
	
	life_support.heat_exchanger = function( ply, ent, system_type, system_class, model )
		local rtable, maxhealth, mass = {}, 0, 0
		if (model == "models/props_c17/utilityconnecter006c.mdl") then
			rtable.radius = 256
			maxhealth = 500
			mass = 100
		elseif (model == "models/props_c17/substation_transformer01d.mdl") then
			rtable.radius = 768
			maxhealth = 600
			mass = 1200
		end
		rtable.HasHeat = false
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "coolant", 0)
		LS_RegisterEnt(ent, "Heat", rtable.radius)
		return rtable, maxhealth, mass
	end
	
	life_support.climate_control = function( ply, ent, system_type, system_class, model )
		local rtable = {}
		local maxhealth = 1000
		local mass = 1200
		rtable.HasAir = false
		rtable.HasHeat = false
		RD_AddResource(ent, "air", 0)
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "coolant", 0)
		LS_RegisterEnt(ent, "Climate")
		return rtable, maxhealth, mass
	end
	
	life_support.terra_former = function( ply, ent, system_type, system_class, model )
		local rtable = {}
		local maxhealth = 1000
		local mass = 1200
		rtable.Active = 0
		RD_AddResource(ent, "terrajuice", 0)
		RD_AddResource(ent, "energy", 0)
		return rtable, maxhealth, mass
	end
	
	life_support.env_probe = function( ply, ent, system_type, system_class, model )
		local maxhealth = 100
		local mass = 20
		RD_AddResource(ent, "energy", 0)
		LS_RegisterEnt(ent, "Probe")
		return {}, maxhealth, mass
	end
	
	life_support.air_hydro = function( ply, ent, system_type, system_class, model )
		local rtable = {}
		local maxhealth = 50
		local mass = 10
		rtable.radius = 768
		LS_RegisterEnt(ent, "Hydro_Air")
		return rtable, maxhealth, mass
	end
end

local lifesupport_models
if (GAMEMODE.Name == "SpaceBuild" or SpaceBuild) then MsgAll("You need the new Spacebuild for this update!\n") end
if GAMEMODE.IsSpaceBuildDerived then --new update won't work with the old spacebuild!
	lifesupport_models = {
		{ 'Suit Dispenser', 'models/props_combine/combine_emitter01.mdl', 'dispenser' },
		{ 'Small Air Exchanger', 'models/props_combine/combine_light001a.mdl', 'air_exchanger' },
		{ 'Large Air Exchanger', 'models/props_combine/combine_light001b.mdl', 'air_exchanger' },
		{ 'Small Heat Exchanger', 'models/props_c17/utilityconnecter006c.mdl', 'heat_exchanger' },
		{ 'Large Heat Exchanger', 'models/props_c17/substation_transformer01d.mdl', 'heat_exchanger' },
		{ 'Climate Regulator', 'models/props_combine/combine_generator01.mdl', 'climate_control' },
		{ 'Atmospheric Probe', 'models/props_combine/combine_mine01.mdl', 'env_probe' },
		{ 'Air Hydroponics', 'models/props/cs_office/plant01.mdl', 'air_hydro' },
		{ 'Terra Former', 'models/props_wasteland/lighthouse_fresnel_light_base.mdl', 'terra_former'}
	}
else
	lifesupport_models = {
		{ 'Suit Dispenser', 'models/props_combine/combine_emitter01.mdl', 'dispenser' },
		{ 'Small Air Exchanger', 'models/props_combine/combine_light001a.mdl', 'air_exchanger' },
		{ 'Large Air Exchanger', 'models/props_combine/combine_light001b.mdl', 'air_exchanger' }
	}
end

RD2_ToolRegister( TOOL, lifesupport_models, nil, "life_support", 24, life_support )

if not ( RES_DISTRIB == 2 ) then Error("Please Install Resource Distribution 2 Addon.'" ) return end

TOOL.Category = '(Life Support)'
TOOL.Name = '#Generators'
TOOL.Command = nil
TOOL.ConfigName = ''
if (CLIENT and GetConVarNumber("RD_UseLSTab") == 1) then TOOL.Tab = "Life Support" end

TOOL.ClientConVar['type'] = 'air_compressor'
TOOL.ClientConVar['model'] = 'models/props_wasteland/laundry_washer003.mdl'

cleanup.Register('energysystem')

if ( CLIENT ) then
	language.Add( 'tool.energysystems.name', 'Life Support Generators' )
	language.Add( 'tool.energysystems.desc', 'Create Generators attached to any surface.' )
	language.Add( 'tool.energysystems.0',	'Left-Click: Spawn a Device.  Right-Click: Repair Device.' )

	language.Add( 'Undone_energysystems', 'Generator Undone' )
	language.Add( 'Cleanup_energysystems', 'LS: Generators' )
	language.Add( 'Cleaned_energysystems', 'Cleaned up all Life Support Generators' )
	language.Add( 'SBoxLimit_energysystems', 'Maximum Life Support Generators Reached' )
end

local energysystems = {}
if (SERVER) then
	energysystems.air_compressor = function( ply, ent, system_type, system_class, model )
		local maxhealth = 800
		local mass = 5500
		RD_AddResource(ent, "air", 0)
		RD_AddResource(ent, "energy", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.air_scrubber = function( ply, ent, system_type, system_class, model )
		local rtable = {}
		local maxhealth = 120
		local mass = 100
		rtable.radius = 175
		RD_AddResource(ent, "air", 0)
		RD_AddResource(ent, "energy", 0)
		LS_RegisterEnt(ent, "Generator")
		return rtable, maxhealth, mass
	end
	
	energysystems.coolant_compressor = function( ply, ent, system_type, system_class, model )
		local maxhealth = 400
		local mass = 1000
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "coolant", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.energy_solar = function( ply, ent, system_type, system_class, model )
		local rtable = {}
		local maxhealth = 100
		local mass = 150
		rtable.Active = 0
		RD_AddResource(ent, "energy", 0)
		LS_RegisterEnt(ent, "Generator")
		return rtable, maxhealth, mass
	end
	
	energysystems.energy_wind = function( ply, ent, system_type, system_class, model )
		local maxhealth = 800
		local mass = 5500
		RD_AddResource(ent, "energy", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.energy_hydro = function( ply, ent, system_type, system_class, model )
		local maxhealth = 800
		local mass = 5500
		RD_AddResource(ent, "energy", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.warp_core = function( ply, ent, system_type, system_class, model )
		local maxhealth = 1200
		local mass = 3000
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "coolant", 0)
		RD_AddResource(ent, "heavy water", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.water_pump = function( ply, ent, system_type, system_class, model )
		local maxhealth = 400
		local mass = 1000
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "water", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.hvywater_electrolyzer = function( ply, ent, system_type, system_class, model )
		local maxhealth = 600
		local mass = 5600
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "water", 0)
		RD_AddResource(ent, "heavy water", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.terra_juice_gen = function( ply, ent, system_type, system_class, model )
		local maxhealth = 800
		local mass = 5500
		RD_AddResource(ent, "terrajuice", 0)
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "water", 0)
		RD_AddResource(ent, "redterracrystal", 0)
		RD_AddResource(ent, "greenterracrystal", 0)
		RD_AddResource(ent, "coolant", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.water_heater = function( ply, ent, system_type, system_class, model )
		local maxhealth = 600
		local mass = 5600
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "water", 0)
		RD_AddResource(ent, "steam", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
	
	energysystems.water_air_extractor = function( ply, ent, system_type, system_class, model )
		local maxhealth = 600
		local mass = 5600
		RD_AddResource(ent, "energy", 0)
		RD_AddResource(ent, "water", 0)
		RD_AddResource(ent, "air", 0)
		LS_RegisterEnt(ent, "Generator")
		return {}, maxhealth, mass
	end
end

local energysystem_models = {
	{ 'Air Compressor', 'models/props_wasteland/laundry_washer003.mdl', 'air_compressor' },
	{ 'Oxygen Scrubber', 'models/props_c17/light_decklight01_off.mdl', 'air_scrubber' },
	{ 'Coolant Compressor', 'models/Gibs/airboat_broken_engine.mdl', 'coolant_compressor' },
	{ 'Solar Panel', 'models/props_trainstation/traincar_rack001.mdl', 'energy_solar' },
	{ 'Wind Generator', 'models/props_trainstation/pole_448Connection001a.mdl', 'energy_wind' },
	{ 'Hydro Generator', 'models/props_wasteland/coolingtank01.mdl', 'energy_hydro' },
	{ 'Water Pump', 'models/props_wasteland/buoy01.mdl', 'water_pump' },
	{ 'Heavy Water Electrolyzer', 'models/props/de_train/processor_nobase.mdl', 'hvywater_electrolyzer' },
	{ 'Water Air Extractor', 'models/props/de_train/processor_nobase.mdl', 'water_air_extractor' },
	{ 'Water Heater', 'models/props/de_train/processor_nobase.mdl', 'water_heater' },
	{ 'Fusion Generator', 'models/props_c17/substation_circuitbreaker01a.mdl', 'warp_core' },
	{ 'Terra Juice Generator', 'models/props_lab/reciever_cart.mdl', 'terra_juice_gen' }
}

RD2_ToolRegister( TOOL, energysystem_models, nil, "energysystems", 30, energysystems )

/********************************************************************
--Types are:
--1) Storage --> Default
--2) Generator  --> not really used yet, but something could be done with it in the future
--3) Air
--4) Heat
--5) Climate
--6) TerraForm => makes planets habitable(while they are on, requires lots of resource at start, but decreases after time till it reaches a minimum)
--             => only used in Spacebuild (the new one)
********************************************************************/

AddCSLuaFile( "autorun/client/cl_lifesupport.lua" )

--Compatibility Global
LIFESUPPORT = 2
LS_AllowNukeEffect = true

local version = "WORKSHOP"


local function registerPF()
	if SVX_PF then
		PF_RegisterPlugin("Life Support 2", version, nil, "LS_enabled", "1", "Addon")
		PF_RegisterConVar("Life Support 2", "LS_AllowNukeEffect", "1", "Nuke Effects")
		
		PF_AddHelpSection("Life Support 2", "Word by the author")
		PF_AddHelpToSection("Life Support 2", "Word by the author", "Life Support 2 and you!")
		PF_AddHelpToSection("Life Support 2", "Word by the author", "Life Support 2 can look very confusing when you first look at this add-on.")
		PF_AddHelpToSection("Life Support 2", "Word by the author", "Some of you may even forget about it and go into space without building any and dying in the deep coldness of space.")
		PF_AddHelpToSection("Life Support 2", "Word by the author", "")
		PF_AddHelpToSection("Life Support 2", "Word by the author", "Author: Killers2")
		
		PF_AddHelpSection("Life Support 2", "Your first Life Support 2 system")
		PF_AddHelpToSection("Life Support 2", "Your first Life Support 2 system", "Your first Life Support 2 system.")
		PF_AddHelpToSection("Life Support 2", "Your first Life Support 2 system", "To get the hang of how Life Support 2 works it is probably best if you build fully working systems on the planet that you spawn on that is habitable so that you can practice how to collect certain resources.")
		PF_AddHelpToSection("Life Support 2", "Your first Life Support 2 system", " I will try to tell you how to make a life support system that will explain everything but the Terra Juice generator and Terra-former.")
		PF_AddHelpToSection("Life Support 2", "Your first Life Support 2 system", "Resources are transported between devices and storage devices via \"Links\" you have to use the \"Link-Tool\" Included with \"Resource Distribution 2\".")
		PF_AddHelpToSection("Life Support 2", "Your first Life Support 2 system", "First I will teach you how to make a Life Support 2 system that collects energy. ")	
		
		PF_AddHelpSection("Life Support 2", "Collecting Energy!")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "Collecting Energy!")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "To collect energy you will need to spawn 1 Large energy cell ( Small will be fine if you want to use that instead ) and then spawn a link Junction.")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "Go to the Life Support 2 generators under the Life support tab and spawn 1 Fusion Generator, 1 Solar cell and 1 Wind generator.")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "Get your Link tool and left click the Wind generator and then left click the link junction and continue to do this until all the devices and storage devices are linked together. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "You will notice that you are getting some energy in the energy cell now, this energy is probably from your wind generator and solar panel. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "You say your Solar panel is off? Well your solar panel must be aimed at the sun on the map to work correctly. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "Move the solar panel around a bit with your Physics gun until it says the device is “ON” You have just built your first Energy Collecting system. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Energy!", "However the Wind generator will not work on all planets and will not work in space.")
		
		PF_AddHelpSection("Life Support 2", "Collecting Coolant!")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "Collecting Coolant!")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "We are going to add to the tutorial on \"Collecting Energy!\" system that you just built.")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "Spawn 2 Coolant Compressors and a Large Coolant Tank and link both to the Link Junction. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "Switch both of the Coolant compressors on by pressing E while standing close and looking at them. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "You are now collecting coolant but you may notice that your energy is going down now because your wind generator and solar panel is not putting out enough energy than the coolant compressors require to operate. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "When you run out of energy your Coolant Compressors will switch to the \"OFF\" Position automaticly. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "To fix the problem were we are running out of energy Press the E button on the Fusion Generator we built last tutorial. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Coolant!", "If it is smoking then read further down to \"Fusion Generators and Bombs\" and immediately switch off the Fusion generator.")
		
		PF_AddHelpSection("Life Support 2", "Collecting Air !")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "Collecting Air !")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "As you may or may not know we need Air to survive in space and some other planets. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "I will teach you the simplest way to collect Air. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "First spawn 1 Air compressor and 1 Large Air storage device and link both to the link junction using the link tool. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "You should have more than enough energy to keep the device active if the fusion generator is working correctly.")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "Now press the E button on your keyboard while looking at the air compressor and standing fairly close to it. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "You should hear it making a noise and in the overlay it should say “ON” and you should see some air coming into the Air storage device. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "However Air Compressors will not work in space. ")
		
		PF_AddHelpSection("Life Support 2", "Collecting Air in Space or a planet without Air!")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "Collecting Air in Space or a planet without Air!")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "To get air on a planet that does not have air in the first place you must use some other way besides air compressors. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "You cant compress air if there is no air to compress can you ? ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "Nope. One of the easiest ways to get air is to spawn some big flat prop for example a 4 x 4 PHX plate and spawn a bunch of oxygen scrubbers on. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "Do this now and link them to the link junction for the devices from the other tutorial or new ones if you did not transfer those into space you will notice you are getting a slow increase in air you may see. ")
		PF_AddHelpToSection("Life Support 2", "Collecting Air !", "You are also dying because I haven't explained how to output these devices into the air around you.")
		
		PF_AddHelpSection("Life Support 2", "Being alive on a uninhabitable planet or space!")
		PF_AddHelpToSection("Life Support 2", "Being alive on a uninhabitable planet or space!", "Being alive on a uninhabitable planet or space!")
		PF_AddHelpToSection("Life Support 2", "Being alive on a uninhabitable planet or space!", "There are 5 different ways of staying alive on a uninhabitable planet or in space.")
		PF_AddHelpToSection("Life Support 2", "Being alive on a uninhabitable planet or space!", "The best way is to use a climate regulator as this will allow you to No-Clip in space as long as you stay in its range and will manage all of the resource controlling tasks for you In that area. ")
		PF_AddHelpToSection("Life Support 2", "Being alive on a uninhabitable planet or space!", "However for small fighter like ships you can use the Large Air exchanger and Large Heat exchanger or the small ones. ")
		PF_AddHelpToSection("Life Support 2", "Being alive on a uninhabitable planet or space!", "There is another option. ")
		PF_AddHelpToSection("Life Support 2", "Being alive on a uninhabitable planet or space!", "You can use the link tool between your link junction and your chair and then as long as you sit in that chair your LS will be fully working. ")
		PF_AddHelpToSection("Life Support 2", "Being alive on a uninhabitable planet or space!", "The climate regulator has the AOE ( Area Of Effect )")
		
		
		PF_AddHelpSection("Life Support 2", "Water Devices !")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "Water Devices !")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "You will not need water for much as not many devices use it at all so you do not need to read this.")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "You may have noticed that the fusion generator has the “Heavy Water” option on its overlay if you give the fusion generator heavy water it will produce more energy I do not know if it s a lot more or a little more as I have never tested it.")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "You can also extract Air from from water by using the water pump and putting it in water ( the pole thing in the water the little bit on top of the water fiddle around with it until it stays on ) and spawn a huge water tank and link all the pumps and the water tank to the link junction and you will start to get water and link a water air extractor to the link junction and turn it on and you will start to convert water into air.")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "This is good on uninhabitable planets with water as oxygen scrubbers aren't that good at producing air.")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "The heavy water electrolyzer converts water to heavy water and it uses a lot of water to produce very little heavy water and heavy water as far as I know is only used for increasing the energy output on the fusion power generators.")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "The water heater converts water into steam. When you have linked it up and switched it on it takes  a while before it starts to output steam. As far as I know their isn't anything that uses steam unless you have the steam thrusters installed.")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "Hydrogen Generators and you!")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "")
		PF_AddHelpToSection("Life Support 2", "Water Devices !", "Hydrogen generators can be placed anywhere in water and they will give you energy. These are not as good as fusion generators but are good if you want a system without Life support they work the same as anything else. Link to link junction and the appropriate storage device in this case a energy cell is the appropriate storage device.")
		
	else
		CreateConVar( "LS_AllowNukeEffect", "1" )
		CreateConVar( "LS_enabled", "1" )
	end
end
timer.Simple(5, registerPF)--Needed to make sure the Plugin Framework gets loaded first

FairTemp_Min = 288 //15°C
FairTemp_Max = 303 //30°C
local DrownDamage = 10
local res_req = 5
local LSents = {}

util.PrecacheSound( "streetwar.slimegurgle04" )
util.PrecacheSound( "Player.FallGib" )

function LSEntCheck()
	for i ,a in pairs(LSents) do
		if IsValid(a) then
			local pos = a:GetPos()
			if (a.environment.lastpos == nil) or (a.environment.lastpos ~= pos) then --if it hasn't moved, it could not have entered/left any water
				a.environment.lastpos = pos
				if (a:GetPhysicsObject():IsValid() and a:GetPhysicsObject():IsMoveable() and a.environment.inwater ~= nil) then --causes it to do the trace method the first time
					a.environment.inwater = a:WaterLevel() --this doesn't look like it works when ent is welded to world
				else
					local trace = {}
						trace.start = pos
						trace.endpos = pos
						trace.filter = { a }
						trace.mask = MASK_WATER
					local tr = util.TraceLine( trace )
					if (tr.Hit) then
						a.environment.inwater = 1
					else
						a.environment.inwater = 0
					end
				end
			end
			if (a.environment.type == "TerraForm") then
				if a.planet and a.onplanet and not SB_GetTerraformer(a.planet) then 
					SB_SetTerraformer(a.planet, a)
				end
				if a.planet and a.onplanet and ( not SB_GetTerraformer(a.planet) or not(SB_GetTerraformer(a.planet) == a)) then
					a:TurnOff()
				end
				if a.Active == 1 then
					if a.planet and not a.planetset then
						--planet, gravity(0 - 1), atmosphere(1 = safe), temperature(shadow), temperature(light), flags) => see Spacebuild
						SB_Terraform_Step(a, a.planet, 288, 288, 1, 1)
						--todo : add bloom/color changing
						a.planetset = true
					end
				else
					if a.planet and a.planetset then
						SB_Terraform_UnStep(a, a.planet)
						a.planetset = false
					end
				end
			elseif (a.environment.type == "Air") then
			 	if (a.Active == 1) then
					a.environment.radius = math.Clamp(a.environment.radius, 64, 2048)
					local tmp = ents.FindInSphere(a:GetPos(), a.environment.radius)
					for _, b in ipairs(tmp) do
						if (b:IsPlayer())then
							--player needs air?
							if not(b.HasAir) then
								if (a.HasAir) then
									b.HasAir = true
									b.NoCrush = true
								end
							end
						end
					end
				end 
			elseif (a.environment.type == "Heat") then
				 if (a.Active == 1) then
					a.environment.radius = math.Clamp(a.environment.radius, 64, 2048)
					local tmp = ents.FindInSphere(a:GetPos(), a.environment.radius)
					for _, b in ipairs(tmp) do
						if (b:IsPlayer())then
							--player needs heat?
							if not(b.HasHeat) then
								if (a.HasHeat) then
									b.HasHeat = true
								end
							end
						end
					end
				end 
			else
				--the rest here
			end
		else
			table.remove(LSents, i)
		end
	end
end

function LSPlayerCheck()
	for _, ply in pairs(player.GetAll()) do
		if not ply:Alive() then Player_Reset(ply) end
		if not(ply.NoCrush) then Pressure_Update(ply)end
		if not(ply.HasAir) then Air_Update(ply)end
		if not(ply.HasHeat) then Temperature_Update(ply) end
		if (ply.suit.air > 0) and (ply.suit.recover > 0) and ply.HasHeat and ply.HasAir and ply.NoCrush then
			if ((ply:Health() + 5 )>= 100) then
				ply:SetHealth(100)
				ply.suit.recover = 0
			else
				ply:SetHealth(ply:Health() + 5)
				ply.suit.recover = ply.suit.recover - 5
			end
		end	
		if (ply:Alive()) then Suit_Update(ply) end
	end
end

function LS_RegisterEnt( ent, lstype, radius )
	if not ent then Msg("Invalid ent!\n") end
	if not lstype or ((lstype == "Air" or lstype == "Heat") and (not radius or not type(radius) == "number"))  then
		Msg("Invalid LS type (or radius not set) for "..tostring(ent.PrintName)..": Device not registered!\n")
		return	
	end
	local hash = {}
	hash.temperature = FairTemp_Min
	hash.atmosphere = 1
	hash.habitat = 1
	hash.inwater = 0
	hash.pressure = 0
	hash.air = 100
	hash.co2 = 0
	hash.n = 0
	hash.type = lstype
	if (lstype == "Air" or lstype == "Heat") then 
		radius = math.Clamp(radius, 64, 2048)
		hash.radius = radius
	end
	ent.environment = hash
	ent.LSent = true
	table.insert( LSents, ent )
end

function LS_Reg_Veh(ply, ent)
	LS_RegisterEnt(ent, "Pod")
	RD_AddResource(ent, "air", 0)
	RD_AddResource(ent, "energy", 0)
	RD_AddResource(ent, "coolant", 0)
end
hook.Add( "PlayerSpawnedVehicle", "LS_vehicle_spawn", LS_Reg_Veh )

function Player_Register( ply )
	local hash = {}
	hash.habitat = 1
	hash.inwater = 0
	hash.atmosphere = 1
	hash.temperature = FairTemp_Min
	hash.pressure = 0
	hash.pair = 100
	hash.co2 = 0
	hash.n = 0
	hash.air = 100
	hash.energy = 100
	hash.coolant = 100
	hash.recover = 0
	--Msg ( "Adding Player\n" )
	ply.suit = hash
	ply.HasAir = true
	ply.HasHeat = true
	ply.NoCrush = true
end

function LS_Setup()
	if (SunAngle == nil) then SunAngle = Vector(0,0,-1) end
end
hook.Add( "InitPostEntity", "LS_Setup", LS_Setup )

function Player_Reset(ply)
	ply.HasAir = true
	ply.HasHeat = true
	ply.NoCrush = true
	Suit_Reset(ply.suit)
end

function Suit_Reset( s )
	s.recover = 0
	s.inwater = 0
	s.air = 100
	s.energy = 100
	s.coolant = 100
	s.habitat = 1
	s.atmosphere = 1
	s.temperature = FairTemp_Min
end

util.AddNetworkString("LS_netmessage")

function Suit_Update( ply )
	net.Start( "LS_netmessage" )
		net.WriteFloat( ply.suit.habitat + 1 )
		net.WriteFloat( ply.suit.air )
		net.WriteFloat( ply.suit.temperature )
		net.WriteFloat( ply.suit.coolant )
		net.WriteFloat( ply.suit.energy )
	net.Send( ply )
end

function Pressure_Update( ply )
	if not ply.suit or not ply.suit.atmosphere then
		Player_Reset( ply )
		return
	end
	if (ply.suit.atmosphere > 1) then
		if (ply:Health() > 0) then
			ply:TakeDamage( ply.suit.atmosphere * 50, 0 )
			LS_Crush( ply )
		end
		if (ply:Health() <= 0) then
			Player_Reset( ply )
		end
	end
end

function Air_Update( ply )
	if not ply.suit or not ply.suit.air then
		Player_Reset( ply )
		return
	end
	if (ply.suit.air <= 0 ) then
		if (ply:Health() > DrownDamage) then
			ply:TakeDamage( DrownDamage, 0 )
			ply.suit.recover = ply.suit.recover + DrownDamage
			ply:EmitSound( "Player.DrownStart" )
		else
			if (ply:Health() > 0) then
				Player_Reset( ply )
				ply:TakeDamage( DrownDamage, 0 )
				ply:EmitSound( "streetwar.slimegurgle04" )
				ply:EmitSound( "streetwar.slimegurgle04" )
				ply:EmitSound( "streetwar.slimegurgle04" )
			end
		end
	else
		if ply.suit.atmosphere > 1 then
			ply.suit.air = ply.suit.air - (res_req + ((math.ceil((ply.suit.atmosphere - 1) * res_req))/10))
		else
			ply.suit.air = ply.suit.air - res_req
		end
		if ply.suit.air < 0 then
			ply.suit.air = 0
		end
	end
end

function Temperature_Update( ply )
	if not ply.suit or not ply.suit.temperature then
		Player_Reset( ply )
		return
	end
	if LS_Override_Heat then return end
	if (ply.suit.temperature >= FairTemp_Min and ply.suit.temperature <= FairTemp_Max) then return end
	local dec = 0
	local dam = 0
	if  ply.suit.temperature < FairTemp_Min  then
		dam = (FairTemp_Min - ply.suit.temperature) / 5
		if (ply.suit.atmosphere > 0) then
			dec = math.ceil(res_req * (4 - (ply.suit.temperature / 72)))
		else
			dec = res_req
		end
		if (ply.suit.energy > dec) then
			ply.suit.energy = ply.suit.energy - dec
		else
			ply.suit.energy = 0
			if (ply.suit.atmosphere > 0) then
				if (ply:Health() <= dam) then
					if (ply:Health() > 0) then
						ply:TakeDamage( dam, 0 )
						LS_Frosty(ply)
						Player_Reset( ply )
					end
				else
					ply:TakeDamage( dam, 0 )
					ply.suit.recover = ply.suit.recover + dam
				end
			else
				if (ply:Health() <= 7) and (ply:Health() > 0) then
					ply:TakeDamage( 7, 0 )
					LS_Frosty(ply)
					Player_Reset( ply )
				else
					ply:TakeDamage( 7, 0 )
					ply.suit.recover = ply.suit.recover + 7
				end
			end
		end
	elseif ply.suit.temperature and ply.suit.temperature > FairTemp_Max then
		dam = (ply.suit.temperature - FairTemp_Max) / 5
		dec = math.ceil(res_req * ((ply.suit.temperature - FairTemp_Max) / 72))
		if (ply.suit.coolant > dec) then
			ply.suit.coolant = ply.suit.coolant - dec
		else
			ply.suit.coolant = 0
			if (ply:Health() <= dam) and (ply:Health() > 0) then
				LS_Immolate(ply)
				ply:TakeDamage( dam, 0 )
				Player_Reset( ply )
			else
				ply:TakeDamage( dam, 0 )
				ply.suit.recover = ply.suit.recover + dam
			end
		end
	else
		Suit_Reset(ply.suit)
	end
end


function Life_Support_Update ()
	if not GetConVar("LS_enabled") or not GetConVar("LS_enabled"):GetBool() then return end
	if not RD2Version return end
	for _, ply in pairs(player.GetAll()) do	
		if not ply.suit then ply.suit = {} end
		if ply:Health() <= 0 then
			Suit_Reset(ply.suit)
		end
		--check if a player is in the water
		ply.suit.inwater = ply:WaterLevel()
		if not ply.suit.habitat then ply.suit.habitat = 1 end
		if (ply.suit.inwater > 2) or (ply.suit.habitat < 1) then
			if ply.suit.inwater > 2 and (not ply.onplanet and InSpace and InSpace == 1) and ply.suit.habitat == 1 then --= player is in an Art Env
				ply.HasAir = true
				if (ply.suit.air < 100) then
					ply.suit.air = 100
				end
			else	
				ply.HasAir = false
			end
		else 
			ply.HasAir = true
			if not ply.suit.air then ply.suit.air = 100 end
			if (ply.suit.air < 100) then
				ply.suit.air = 100
			end
		end
		if not ply.suit.temperature then ply.suit.temperature = FairTemp_Min end
		if ply.suit.temperature < FairTemp_Min or ply.suit.temperature > FairTemp_Max then
			ply.HasHeat = false
		else
			ply.HasHeat = true
			if not ply.suit.energy then ply.suit.energy = 100 end
			if (ply.suit.energy < 100) then
				ply.suit.energy = 100
			end
			if not ply.suit.coolant then ply.suit.coolant = 100 end
			if (ply.suit.coolant < 100) then
				ply.suit.coolant = 100
			end
		end
		if not ply.suit.atmosphere then ply.suit.atmosphere = 1 end
		if (ply.suit.atmosphere > 1) then
			ply.NoCrush = false
		else
			ply.NoCrush = true
		end
		local pod = ply:GetParent()
		if IsValid(pod) then
			ply.NoCrush = true
			if pod.environment then
				--air
				if not(ply.hasAir) then
					local air = RD_GetResourceAmount(pod, "air")
					if (ply.suit.air < 100) then
						if (air >= res_req) then
							RD_ConsumeResource(pod, "air", res_req)
							air = air - res_req
							local airneeded = 100 - ply.suit.air
								if (air >= airneeded) then
									RD_ConsumeResource(pod, "air", airneeded)
									ply.suit.air = 100
								end
							ply.HasAir = true
						else
							if (air > 0) then
								RD_ConsumeResource(pod, "air", air)
								ply.suit.air = ply.suit.air + air
							end
						end
					end
				end
				--heat
				if not ply.HasHeat then
					if pod.environment.temperature >= FairTemp_Min and pod.environment.temperature <= FairTemp_Max then 
						ply.HasHeat = true 
					else
						local r_needed = 0
						if pod.environment.temperature < FairTemp_Min then
							if (pod.environment.atmosphere > 0) then
								r_needed = math.ceil(res_req * (4 - (pod.environment.temperature / 72)))
							else
								r_needed = 2
							end
							if (RD_GetResourceAmount(pod, "energy") > r_needed) then
								RD_ConsumeResource(pod, "energy", r_needed)
								if ply.suit.energy < 98 then
									ply.suit.energy = ply.suit.energy + 2
								elseif ply.suit.energy < 100 then
									ply.suit.energy = 100
								end 
								ply.HasHeat = true
							end
						elseif pod.environment.temperature > FairTemp_Max then	
							r_needed = math.ceil(res_req * (pod.environment.temperature / 72))
							if (RD_GetResourceAmount(pod, "coolant") > r_needed) then
								RD_ConsumeResource(pod, "coolant", r_needed)
								if ply.suit.coolant < 98 then
									ply.suit.coolant = ply.suit.coolant + 2
								elseif ply.suit.coolant < 100 then
									ply.suit.coolant = 100
								end
								ply.HasHeat = true
							end	
						end
					end
				end
			end
		end
	end
	LSEntCheck()
	LSPlayerCheck()
end
timer.Create( "Life_Support_Update", 1, 0, Life_Support_Update)

function LSSpawnFunc( ply )
	if not ply.suit then 
		Player_Register( ply ) 
	else
		Player_Reset(ply)
	end
end
hook.Add( "PlayerSpawn", "LS_SpawnFunc", LSSpawnFunc )

function ColorDamage(ent, HP, Col)
	if (ent.health <= (ent.maxhealth / HP)) then
		ent:SetColor(Color(Col, Col, Col, 255))
	end
end

function DamageLS(ent, dam)
	if not (IsValid(ent) and dam) then return end
	if not ent.health then return end
	dam = math.floor(dam / 2)
	if (ent.health > 0) then
		local HP = ent.health - dam
		ent.health = HP
		if (ent.health <= (ent.maxhealth / 2)) then
			ent:Damage()
		end
		ColorDamage(ent, 2, 200)
		ColorDamage(ent, 3, 175)
		ColorDamage(ent, 4, 150)
		ColorDamage(ent, 5, 125)
		ColorDamage(ent, 6, 100)
		ColorDamage(ent, 7, 75)
		if (ent.health <= 0) then
			ent:SetColor(Color(50, 50, 50, 255))
			ent:Destruct()
		end
	end
end

local function RemoveEntity( ent )
	if (IsValid(ent)) then
		ent:Remove()
	end
end

local function Explode1( ent )
	if IsValid(ent) then
		local Effect = EffectData()
			Effect:SetOrigin(ent:GetPos() + Vector( math.random(-60, 60), math.random(-60, 60), math.random(-60, 60) ))
			Effect:SetScale(1)
			Effect:SetMagnitude(25)
		util.Effect("Explosion", Effect, true, true)
	end
end

local function Explode2( ent )
	if IsValid(ent) then
		local Effect = EffectData()
			Effect:SetOrigin(ent:GetPos())
			Effect:SetScale(3)
			Effect:SetMagnitude(100)
		util.Effect("Explosion", Effect, true, true)
		LS_RemoveEnt( ent )
	end
end

function LS_Destruct( ent, Simple )
	if (Simple) then
		Explode2( ent )
	else
		timer.Simple(1, Explode1, ent)
		timer.Simple(1.2, Explode1, ent)
		timer.Simple(2, Explode1, ent)
		timer.Simple(2, Explode2, ent)
	end
end

function LS_RemoveEnt( Entity )
	constraint.RemoveAll( Entity )
	timer.Simple( 1, RemoveEntity, Entity )
	Entity:SetNotSolid( true )
	Entity:SetMoveType( MOVETYPE_NONE )
	Entity:SetNoDraw( true )
end


function Wire_BuildDupeInfo( ent )
	if (not ent.Inputs) then return end
	
	local info = { Wires = {} }
	for k,input in pairs(ent.Inputs) do
		if (input.Src) and (input.Src:IsValid()) then
		    info.Wires[k] = {
				StartPos = input.StartPos,
				Material = input.Material,
				Color = input.Color,
				Width = input.Width,
				Src = input.Src:EntIndex(),
				SrcId = input.SrcId,
				SrcPos = Vector(0, 0, 0),
			}
			
			if (input.Path) then
				info.Wires[k].Path = {}
				
			    for _,v in ipairs(input.Path) do
			        if IsValid(v.Entity) then
			        	table.insert(info.Wires[k].Path, { Entity = v.Entity:EntIndex(), Pos = v.Pos })
					end
			    end
			    
			    local n = table.getn(info.Wires[k].Path)
			    if (n > 0) and (info.Wires[k].Path[n].Entity == info.Wires[k].Src) then
			        info.Wires[k].SrcPos = info.Wires[k].Path[n].Pos
			        table.remove(info.Wires[k].Path, n)
			    end
			end
		end
	end
	
	return info
end

function Wire_ApplyDupeInfo(ply, ent, info, GetEntByID)
	if (info.Wires) then
		for k,input in pairs(info.Wires) do
		    
			Wire_Link_Start(ply:UniqueID(), ent, input.StartPos, k, input.Material, input.Color, input.Width)
		    
			if (input.Path) then
		        for _,v in ipairs(input.Path) do
					
					local ent2 = GetEntByID(v.Entity)
					if IsValid(!ent2) then ent2 = ents.GetByIndex(v.Entity) end
					if IsValid(ent2)then
						Wire_Link_Node(ply:UniqueID(), ent2, v.Pos)
					else
						Msg("ApplyDupeInfo: Error, Could not find the entity for wire path\n")
					end
				end
		    end
			
			local ent2 = GetEntByID(input.Src)
		    if IsValid(!ent2) then ent2 = ents.GetByIndex(input.Src) end
			if IsValid(ent2) then
				Wire_Link_End(ply:UniqueID(), ent2, input.SrcPos, input.SrcId)
			else
				Msg("ApplyDupeInfo: Error, Could not find the output entity\n")
			end
		end
	end
end

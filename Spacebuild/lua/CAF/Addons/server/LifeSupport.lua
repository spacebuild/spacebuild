local LS = {}

local status = false

--Stuff that can't be disabled
CreateConVar( "LS_AllowNukeEffect", "1" ) --Update to something changeable later on
--end 

--Local Functions

local SB_AIR_O2 = 0
local SB_AIR_CO2 = 1

local function CheckRegulators()
	for k, v in pairs(LS.generators.air) do
		if not v then 
			table.remove(LS.generators.air, k)
		end
	end
	for k, v in pairs(LS.generators.temperature) do
		if not v then 
			table.remove(LS.generators.temperature, k)
		end
	end
end

LS.generators = {}
LS.generators.air = {}
LS.generators.temperature = {}

local function LS_Reg_Veh(ply, ent)
	local RD = CAF.GetAddon("Resource Distribution")
	RD.RegisterNonStorageDevice(ent)
end

local function LSSpawnFunc( ply )
	if not ply:Ls_Init() then
		ErrorNoHalt("Error initializing player\n")
	end
end

local function LSResetSpawnFunc( ply )
	ply:LsResetSuit()
end


local function RemoveEntity( ent )
	if (ent:IsValid()) then
		ent:Remove()
	end
end

local function Explode1( ent )
	if ent:IsValid() then
		local Effect = EffectData()
			Effect:SetOrigin(ent:GetPos() + Vector( math.random(-60, 60), math.random(-60, 60), math.random(-60, 60) ))
			Effect:SetScale(1)
			Effect:SetMagnitude(25)
		util.Effect("Explosion", Effect, true, true)
	end
end

local function Explode2( ent )
	if ent:IsValid() then
		local Effect = EffectData()
			Effect:SetOrigin(ent:GetPos())
			Effect:SetScale(3)
			Effect:SetMagnitude(100)
		util.Effect("Explosion", Effect, true, true)
		RemoveEntity( ent )
	end
end

local function PlayerLSThink()
	for k, ply in pairs(player.GetAll( )) do
		ply:LsCheck()
	end
end

local function AddonDisabled(addon)
	if not addon then return false end
	if addon == "Resource Distribution" then 
		CAF.Destruct("Life Support")
	end
end

-- End Local Functions


/**
	The Constructor for this Custom Addon Class
*/
function LS.__Construct()
	if status then return false , CAF.GetLangVar("This Addon is already Active!") end
	if not CAF.GetAddon("Resource Distribution") or not CAF.GetAddon("Resource Distribution").GetStatus() then return false, CAF.GetLangVar("Resource Distribution is Required and needs to be Active!") end
	util.PrecacheSound( "vehicles/v8/skid_lowfriction.wav" )
	util.PrecacheSound( "NPC_Stalker.BurnFlesh" )
	util.PrecacheModel("models/player/charple01.mdl")
	util.PrecacheSound( "streetwar.slimegurgle04" )
	util.PrecacheSound( "Player.FallGib" )
	LS.generators = {}
	LS.generators.air = {}
	LS.generators.temperature = {}
	local SB = CAF.GetAddon("Spacebuild")
	if SB then
		--Msg("Adding Player override to SB\n")
		SB.AddPlayerOverride()
		SB.AddOverride_PlayerHeatDestroy()
	end
	--SB_PlayerOverride = true
	--SB_Override_PlayerHeatDestroy = true
	hook.Add( "PlayerSpawnedVehicle", "LS_vehicle_spawn", LS_Reg_Veh )
	if (SunAngle == nil) then SunAngle = Vector(0,0,-1) end
	for k, ply in pairs(player.GetAll( )) do
		LSSpawnFunc( ply );
	end
	local RD = CAF.GetAddon("Resource Distribution")
	RD.AddProperResourceName("energy", CAF.GetLangVar("Energy"))
	RD.AddProperResourceName("water", CAF.GetLangVar("Water"))
	RD.AddProperResourceName("nitrogen", CAF.GetLangVar("Nitrogen"))
	RD.AddProperResourceName("hydrogen", CAF.GetLangVar("Hydrogen"))
	RD.AddProperResourceName("oxygen", CAF.GetLangVar("Oxygen"))
	RD.AddProperResourceName("carbon dioxide", CAF.GetLangVar("Carbon Dioxide"))
	RD.AddProperResourceName("steam", CAF.GetLangVar("Steam"))
	RD.AddProperResourceName("heavy water", CAF.GetLangVar("Heavy Water"))
	RD.AddProperResourceName("liquid nitrogen", CAF.GetLangVar("Liquid Nitrogen"))
	hook.Add( "PlayerInitialSpawn", "LS_Core_SpawnFunc", LSSpawnFunc )
	hook.Add( "PlayerSpawn", "LS_Core_ResetSpawnFunc", LSResetSpawnFunc )
	CAF.AddHook("think3", PlayerLSThink)
	CAF.AddHook("OnAddonDestruct", AddonDisabled)
	CAF.AddServerTag("LSC")
	status = true
	return true
end

/**
	The Destructor for this Custom Addon Class
*/
function LS.__Destruct()
	if not status then return false, CAF.GetLangVar("This addon wasn't on in the first place") end
	hook.Remove( "PlayerInitialSpawn", "LS_Core_SpawnFunc")
	hook.Remove( "PlayerSpawn", "LS_Core_ResetSpawnFunc")
	hook.Remove( "PlayerSpawnedVehicle", "LS_vehicle_spawn")
	CAF.RemoveHook("think3", PlayerLSThink)
	CAF.RemoveHook("OnAddonDestruct", AddonDisabled)
	local SB = CAF.GetAddon("Spacebuild")
	if SB then
		SB.RemovePlayerOverride()
		SB.RemoveOverride_PlayerHeatDestroy()
	end
	LS.generators = {}
	LS.generators.air = {}
	LS.generators.temperature = {}
	CAF.RemoveServerTag("LSC")
	status = false
	return true
end

/**
	Get the required Addons for this Addon Class
*/
function LS.GetRequiredAddons()
	return {"Resource Distribution"}
end

/**
	Get the Boolean Status from this Addon Class
*/
function LS.GetStatus()
	return status
end

/**
	Get the Version of this Custom Addon Class
*/
function LS.GetVersion()
	return 3.08, CAF.GetLangVar("Beta")
end

/**
	Get any custom options this Custom Addon Class might have
*/
function LS.GetExtraOptions()
	return {}
end

/**
	Get the Custom String Status from this Addon Class
*/
function LS.GetCustomStatus()
	return CAF.GetLangVar("Not Implemented Yet")
end

function LS.AddResourcesToSend()
	--[[local list = file.Find("models/props_phx/life_support/*.mdl")
	PrintTable(list)
	for k,v in pairs(list) do
		resource.AddFile("models/props_phx/life_support/"..v)
	end	
	list = file.Find("materials/props_phx/life_support/*.vtf")
	PrintTable(list) 
	for k,v in pairs(list) do
		resource.AddFile("materials/props_phx/life_support/"..v)
	end
	resource.AddFile("info.txt")]]
end

CAF.RegisterAddon("Life Support", LS, "2")

--Extra Methodes
function LS.AddAirRegulator(ent)
	if ent.GetLSClass and ent:GetLSClass() == "air exchanger" then
		if table.insert(LS.generators.air, ent) then
		--table.insert(LS.generators.air, ent)
		--	Msg("Added Air Exchanger\n");
			return true
		end
		--Msg("Not Added Air Exchanger\n");
	end
	--Msg("Not Added Air Exchanger\n");
	return false
end

function LS.AddTemperatureRegulator(ent)
	if ent.GetLSClass and ent:GetLSClass() == "temperature exchanger" then
		if table.insert(LS.generators.temperature, ent) then
		--table.insert(LS.generators.temperature, ent)
			--Msg("Added Temp Exchanger\n");
			return true
		end
		--Msg("Not Added temp Exchanger\n");
	end
	--Msg("Not Added temp Exchanger\n");
	return false
end

function LS.RemoveAirRegulator(ent)
	for k, v in pairs(LS.generators.air) do
		if v == ent then
			table.remove(LS.generators.air, k)
		end
	end
end

function LS.RemoveTemperatureRegulator(ent)
	for k, v in pairs(LS.generators.temperature) do
		if v == ent then
			table.remove(LS.generators.temperature, k)
		end
	end
end

function LS.GetAirRegulators()
	return LS.generators.air or {}
end

function LS.GetTemperatureRegulators()
	return LS.generators.temperature or {}
end

function LS.ZapMe(pos, magnitude)
	if not (pos and magnitude) then return end
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


function LS.Burn_Quiet(ent)
	if not ent then return end
	ent:StopSound( "NPC_Stalker.BurnFlesh" )
end


function LS.LS_Immolate(ent)
	if not ent then return end
	ent:EmitSound( "NPC_Stalker.BurnFlesh" )
	ent:SetModel("models/player/charple01.mdl")
	timer.Simple(3, function(self, ent) self.Burn_Quiet(ent) end, LS, ent)
end


function LS.LS_Frosty(ent)
	if not ent then return end
	ent:EmitSound( "vehicles/v8/skid_lowfriction.wav" )
end

function LS.LS_Crush(ent)
	if not ent then return end
	ent:EmitSound( "Player.FallGib" )
end

function LS.ColorDamage(ent, HP, Col)
	if not ent or not HP or not Col or not ValidEntity(ent) then return end
	if (ent:Health() <= (ent:GetMaxHealth( ) / HP)) then
		ent:SetColor(Col, Col, Col, 255)
	end
end

function LS.DamageLS(ent, dam)
	if not (ent and ent:IsValid() and dam) then return end
	if ent:GetMaxHealth( ) == 0 then return end
	dam = math.floor(dam / 2)
	if (ent:Health( ) > 0) then
		local HP = ent:Health( ) - dam
		ent:SetHealth( HP )
		if (ent:Health( ) <= (ent:GetMaxHealth( ) / 2)) then
			if ent.Damage then
				ent:Damage()
			end
		end
		LS.ColorDamage(ent, 2, 200)
		LS.ColorDamage(ent, 3, 175)
		LS.ColorDamage(ent, 4, 150)
		LS.ColorDamage(ent, 5, 125)
		LS.ColorDamage(ent, 6, 100)
		LS.ColorDamage(ent, 7, 75)
		if (ent:Health( ) <= 0) then
			ent:SetColor(50, 50, 50, 255)
			if ent.Destruct then
				ent:Destruct()
			else
				LS.Destruct( ent, true )
			end
		end
	end
end

function LS.Destruct( ent, Simple )
	if (Simple) then
		Explode2( ent )
	else
		timer.Simple(1, Explode1, ent)
		timer.Simple(1.2, Explode1, ent)
		timer.Simple(2, Explode1, ent)
		timer.Simple(2, Explode2, ent)
	end
end

function LS.RemoveEnt( ent )
	constraint.RemoveAll( ent )
	timer.Simple( 1, RemoveEntity, ent )
	ent:SetNotSolid( true )
	ent:SetMoveType( MOVETYPE_NONE )
	ent:SetNoDraw( true )
end

--End Extra Methodes

--Extensions on MetaTable

local Ply = FindMetaTable( "Player" )

function Ply:Ls_Init()
	if LS.GetVersion and LS.GetVersion() >= 0.1 then
		self.suit = self.suit or {}
		self.caf = self.caf or {}
		self.caf.custom = self.caf.custom or {}
		self.caf.custom.ls = {}
		self:LsResetSuit()
		return true
	end
	return false
end

function Ply:LsResetSuit()
	local hash = self.suit
	hash.env = {}
	hash.air = 200 --100
	hash.energy = 200 --100
	hash.coolant = 200 --100
	hash.recover = 0
	self.suit = hash
	hash = {}
	hash.temperature = 288
	hash.air = true
	hash.inspace = false
	self.airused = false
	self.highpressure = false
	self.caf.custom.ls = hash
end

function Ply:LsCheck()
	if self:IsValid() and self:Alive() and LS.GetStatus() then
		local pod = self:GetParent()
		local RD = CAF.GetAddon("Resource Distribution")
		local SB = CAF.GetAddon("Spacebuild")
		if SB and SB.GetStatus() then
			local space = SB.GetSpace()
			local environment = space --restore to default before doing the Environment checks
			local oldenvironment = self.environment
			for k, v in pairs(SB.GetPlanets()) do
				if v and v:IsValid() then
					--Msg("Checking planet\n")
					environment = v:OnEnvironment(self, environment, space) or environment
				else
					table.remove(Planets, k)
				end
			end
			if environment == space then
				for k, v in pairs(SB.GetStars()) do
					if v and v:IsValid() then
						environment = v:OnEnvironment(self, environment, space) or environment
					else
						table.remove(Stars, k)
					end
				end
			end
			for k, v in pairs(SB.GetEnvironments()) do
				if v and v:IsValid() then
					environment = v:OnEnvironment(self, environment, space) or environment
				else
					table.remove(Environments, k)
				end
			end
			if oldenvironment ~= environment then
				self.environment = environment
				SB.OnEnvironmentChanged(self)
			elseif oldenvironment ~= self.environment then
				self.environment = oldenvironment
			end
			self.environment:UpdateGravity(self)
			
			if self.environment:GetPressure() > 1.5 and not pod:IsValid() then
				local pressure = self.environment:GetPressure() - 1.5
				for k, v in pairs(LS.GetAirRegulators()) do
					if v and ValidEntity(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
						pressure = v:UsePersonPressure(pressure)
					end
				end
				if pressure > 0 then
					if self.suit.air <= 0 then
						self:TakeDamage( (pressure) * 50 , 0 )
						LS.LS_Crush( self )
						if self:Health() <= 0 then
							self:LsResetSuit()
							return
						end
					elseif self.suit.air < math.ceil(pressure/5) then
						self:TakeDamage(math.Round((self.suit.air/(pressure/5))* ((pressure +1) * 50)) , 0 )
						self.suit.air = 0
						if self:Health() <= 0 then
							self:LsResetSuit()
							return
						end
					else
						self.suit.air = math.Round(self.suit.air - (pressure/5))
					end
				end
			end
			self.caf.custom.ls.temperature = self.environment:GetTemperature(self)
			if self.caf.custom.ls.temperature < 283 or self.caf.custom.ls.temperature > 308 then
				if pod and pod:IsValid() then
					if self.caf.custom.ls.temperature < 283 then
						local needed = math.ceil((283 - self.caf.custom.ls.temperature)/8)
						if (RD.GetResourceAmount(pod, "energy") > needed) then
							RD.ConsumeResource(pod, "energy", needed)
							self.caf.custom.ls.temperature = 283
						else
							needed = RD.GetResourceAmount(pod, "energy")
							RD.ConsumeResource(pod, "energy", needed)
							self.caf.custom.ls.temperature = self.caf.custom.ls.temperature + math.ceil(needed * 8)
						end
					elseif self.caf.custom.ls.temperature > 308 then
						local needed = math.ceil((self.caf.custom.ls.temperature - 308)/16)
						if (RD.GetResourceAmount(pod, "nitrogen") > needed) then
							RD.ConsumeResource(pod, "nitorgen", needed)
							self.caf.custom.ls.temperature = 308
						else
							needed = RD.GetResourceAmount(pod, "nitrogen")
							RD.ConsumeResource(pod, "nitrogen", needed)
							self.caf.custom.ls.temperature = self.caf.custom.ls.temperature - math.ceil(needed * 16)
						end
						if self.caf.custom.ls.temperature > 308 then
							needed = math.ceil((self.caf.custom.ls.temperature - 308)/8)
							if (RD.GetResourceAmount(pod, "water") > needed) then
								RD.ConsumeResource(pod, "water", needed)
								self.caf.custom.ls.temperature = 308
							else
								needed = RD.GetResourceAmount(pod, "water")
								RD.ConsumeResource(pod, "water", needed)
								self.caf.custom.ls.temperature = self.caf.custom.ls.temperature - math.ceil(needed * 8)
							end
						end
					end
				end
				for k, v in pairs(LS.GetTemperatureRegulators()) do
					if v and ValidEntity(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
						self.caf.custom.ls.temperature = self.caf.custom.ls.temperature + v:CoolDown(self.caf.custom.ls.temperature)
					end
				end
				if not LS_Core_Override_Heat then
					local dec = 0
					if self.caf.custom.ls.temperature < 283 then
						dam = (283 - self.caf.custom.ls.temperature) / 5
						if (self.environment:GetPressure() > 0) then
							dec = math.ceil(5 * (4 - (self.caf.custom.ls.temperature / 72)))
						else
							dec = 5
						end
						if (self.suit.energy > dec) then
							self.suit.energy = self.suit.energy - dec
						else
							self.suit.energy = 0
							if (self.environment:GetPressure() > 0) then
								if (self:Health() <= dam) then
									if self:Health() > 0 then
										self:TakeDamage( dam, 0 )
										LS.LS_Frosty(self)
										self:LsResetSuit()
										return
									end
								else
									self:TakeDamage( dam, 0 )
									self.suit.recover = self.suit.recover + dam
								end
							else
								if (self:Health() <= 7) and (self:Health() > 0) then
									self:TakeDamage( 7, 0 )
									LS.LS_Frosty(self)
									self:LsResetSuit()
									return
								else
									self:TakeDamage( 7, 0 )
									self.suit.recover = self.suit.recover + 7
								end
							end
						end
					elseif self.caf.custom.ls.temperature > 308 then
						dam = (self.caf.custom.ls.temperature - 308) / 5
						dec = math.ceil(5 * ((self.caf.custom.ls.temperature - 308) / 72))
						if (self.suit.coolant > dec) then
							self.suit.coolant = self.suit.coolant - dec
						else
							self.suit.coolant = 0
							if (self:Health() <= dam) and (self:Health() > 0) then
								LS.LS_Immolate(self)
								self:TakeDamage( dam, 0 )
								self:LsResetSuit()
								return
							else
								self:TakeDamage( dam, 0 )
								self.suit.recover = self.suit.recover + dam
							end
						end
					end
				end
			end
			if self.environment:GetO2Percentage() * self.environment:GetAtmosphere() < 5 then
				self.caf.custom.ls.air = false
				self.caf.custom.ls.airused = false
				if pod and pod:IsValid() then
					local air = RD.GetResourceAmount(pod, "oxygen")
					if (air >= 5) then
						RD.ConsumeResource(pod, "oxygen", 5)
						self.caf.custom.ls.airused = true
					end
				end
				if not self.caf.custom.ls.airused then
					for k, v in pairs(LS.GetAirRegulators()) do
						if v and ValidEntity(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
							self.suit.air = self.suit.air + v:UsePerson()
							self.caf.custom.ls.airused = true
							break
						end
					end
				end
				if not self.caf.custom.ls.airused then
					if (self.suit.air <= 0 ) then
						if (self:Health() > 10) then
							self:TakeDamage( 10, 0 )
							self.suit.recover = self.suit.recover + 10
							self:EmitSound( "Player.DrownStart" )
						else
							if (self:Health() > 0) then
								self:TakeDamage( 10, 0 )
								self:LsResetSuit()
								self:EmitSound( "streetwar.slimegurgle04" )
								self:EmitSound( "streetwar.slimegurgle04" )
								self:EmitSound( "streetwar.slimegurgle04" )
								return
							end
						end
					else
						self.suit.air = self.suit.air - 5
						if self.suit.air < 0 then
							self.suit.air = 0
						end
					end
				end
			else
				self.caf.custom.ls.air = true
				if self:WaterLevel() <= 2 then
					if self.suit.air < 100  then
						self.suit.air = self.suit.air + self.environment:Convert(SB_AIR_O2, SB_AIR_CO2, 100-self.suit.air)
					end
					self.environment:Convert(SB_AIR_O2, SB_AIR_CO2, 5)
				end
			end
		end
		if not self.caf.custom.ls.airused then
			if self:WaterLevel() > 2 then
				if self.caf.custom.ls.air then
					self.caf.custom.ls.air = false
					self.caf.custom.ls.airused = false
					if pod and pod:IsValid() then
						local air = RD.GetResourceAmount(pod, "oxygen")
						if (air >= 5) then
							RD.ConsumeResource(pod, "oxygen", 5)
							self.caf.custom.ls.airused = true
						end
					end
					if not self.caf.custom.ls.airused then
						for k, v in pairs(LS.GetAirRegulators()) do
							if v and ValidEntity(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
								self.suit.air = self.suit.air + v:UsePerson()
								self.caf.custom.ls.airused = true
								break
							end
						end
					end
					if not self.caf.custom.ls.airused then
						if (self.suit.air <= 0 ) then
							if (self:Health() > 10) then
								self:TakeDamage( 10, 0 )
								self.suit.recover = self.suit.recover + 10
								self:EmitSound( "Player.DrownStart" )
							else
								if (self:Health() > 0) then
									self:TakeDamage( 10, 0 )
									self:LsResetSuit()
									self:EmitSound( "streetwar.slimegurgle04" )
									self:EmitSound( "streetwar.slimegurgle04" )
									self:EmitSound( "streetwar.slimegurgle04" )
									return
								end
							end
						else
							self.suit.air = self.suit.air - 5
							if self.suit.air < 0 then
								self.suit.air = 0
							end
						end
					end
				end
			elseif self.caf.custom.ls.air then
				if self.suit.air < 100 then
					self.suit.air = 100
				end
			end
		end
		if self.caf.custom.ls.temperature >= 283 and self.caf.custom.ls.temperature <= 308 and self.caf.custom.ls.air and self.suit.recover > 0 then
			if ((self:Health() + 5 )>= 100) then
				self:SetHealth(100)
				self.suit.recover = 0
			else
				self:SetHealth(self:Health() + 5)
				self.suit.recover = self.suit.recover - 5
			end
		end
		self.caf.custom.ls.airused = false
		self.caf.custom.ls.air = true
		self:UpdateLSClient()
	end
end

function Ply:UpdateLSClient()
	local SB = CAF.GetAddon("Spacebuild");
	if SB and SB.GetStatus() then
		umsg.Start("LS_umsg1", self)
			umsg.Float( self.environment:GetO2Percentage() or -1)
			umsg.Short( self.suit.air or -1 )
			umsg.Short( self.environment:GetTemperature(self) or -1)
			umsg.Short( self.suit.coolant or -1)
			umsg.Short( self.suit.energy  or -1)
		umsg.End() 
	else
		umsg.Start("LS_umsg2", self)
			umsg.Short( self.suit.air or -1 )
		umsg.End() 
	end
end


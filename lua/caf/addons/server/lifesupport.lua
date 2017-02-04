local SPACEBUILD = SPACEBUILD
local log = SPACEBUILD.log

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

-- End Local Functions


--[[
	The Constructor for this Custom Addon Class
]]
function LS.__Construct()
	if status then return false , CAF.GetLangVar("This Addon is already Active!") end
	if not CAF.GetAddon("Resource Distribution") or not CAF.GetAddon("Resource Distribution").GetStatus() then return false, CAF.GetLangVar("Resource Distribution is Required and needs to be Active!") end
	util.PrecacheSound( "vehicles/v8/skid_lowfriction.wav" )
	util.PrecacheSound( "NPC_Stalker.BurnFlesh" )
	util.PrecacheModel("models/player/charple.mdl")
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
	status = true
	return true
end

--[[
	The Destructor for this Custom Addon Class
]]
function LS.__Destruct()
	if not status then return false, CAF.GetLangVar("This addon wasn't on in the first place") end
	hook.Remove( "PlayerSpawnedVehicle", "LS_vehicle_spawn")
	LS.generators = {}
	LS.generators.air = {}
	LS.generators.temperature = {}
	status = false
	return true
end

--[[
	Get the required Addons for this Addon Class
]]
function LS.GetRequiredAddons()
	return {}
end

--[[
	Get the Boolean Status from this Addon Class
]]
function LS.GetStatus()
	return status
end

--[[
	Get the Version of this Custom Addon Class
]]
function LS.GetVersion()
	return SPACEBUILD.version:longVersion(), SPACEBUILD.version.tag
end

--[[
	Get any custom options this Custom Addon Class might have
]]
function LS.GetExtraOptions()
	return {}
end

--[[
	Get the Custom String Status from this Addon Class
]]
function LS.GetCustomStatus()
	return CAF.GetLangVar("Not Implemented Yet")
end

function LS.AddResourcesToSend()
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

--End Extra Methodes


local function LsCheck() --TODO compare to class ls/playersuit code
	if self:IsValid() and self:Alive() and LS.GetStatus() then
		local pod = self:GetParent()
		local RD = CAF.GetAddon("Resource Distribution")
		local SB = CAF.GetAddon("Spacebuild")
		if SB and SB.GetStatus() and self.environment ~= nil then
			local space = SB.GetSpace()
			if self.environment:getPressure() > 1.5 and not pod:IsValid() then
				local pressure = self.environment:getPressure() - 1.5
				for k, v in pairs(LS.GetAirRegulators()) do
					if v and IsValid(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
						pressure = v:UsePersonPressure(pressure)
					end
				end
				if pressure > 0 then
					if self.suit.air <= 0 then
						self:TakeDamage( (pressure) * 50 , 0 )
						SB.util.damage.performCrushEffects( self )
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
			self.caf.custom.ls.temperature = self.environment:getTemperature(self)
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
					if v and IsValid(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
						self.caf.custom.ls.temperature = self.caf.custom.ls.temperature + v:CoolDown(self.caf.custom.ls.temperature)
					end
				end
				if not LS_Core_Override_Heat then
					local dec = 0
					if self.caf.custom.ls.temperature < 283 then
						dam = (283 - self.caf.custom.ls.temperature) / 5
						if (self.environment:getPressure() > 0) then
							dec = math.ceil(5 * (4 - (self.caf.custom.ls.temperature / 72)))
						else
							dec = 5
						end
						if (self.suit.energy > dec) then
							self.suit.energy = self.suit.energy - dec
						else
							self.suit.energy = 0
							if (self.environment:getPressure() > 0) then
								if (self:Health() <= dam) then
									if self:Health() > 0 then
										self:TakeDamage( dam, 0 )
										SB.util.damage.performFrostyEffects(self)
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
									SB.util.damage.performFrostyEffects(self)
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
								SB.util.damage.performBurnedEffect(self)
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
			if self.environment:getResourceAmount("oxygen") * self.environment:getAtmosphere() < 5 then
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
						if v and IsValid(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
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
						self.suit.air = self.suit.air + self.environment:convertResource("oxygen", "carbon dioxide", 100-self.suit.air)
					end
					self.environment:convertResource("oxygen", "carbon dioxide", 5)
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
							if v and IsValid(v) and v:IsActive() and self:GetPos():Distance(v:GetPos()) < v:GetRange() then
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


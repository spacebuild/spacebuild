AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
util.PrecacheSound( "apc_engine_start" )
util.PrecacheSound( "apc_engine_stop" )
util.PrecacheSound( "common/warning.wav" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Air_Increment = 20
local Energy_Increment = 80
local Coolant_Increment = 20

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	self.maxradius = 1024
	self.hasatmosphere  = false
	SB_Add_Environment(self.Entity, 0, 0, 0, 0, 0)
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self.Entity, { "On", "Radius" })
		self.Outputs = Wire_CreateOutputs(self.Entity, { "On", "Air", "Heat" })
	end
end

function ENT:TurnOn()
	self.Entity:EmitSound( "apc_engine_start" )
	self.Active = 1
	self.HasAir = true
	self.HasHeat = true
	if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "On", self.Active) end
	self:SetOOO(1)
end

function ENT:TurnOff()
	self.Entity:StopSound( "apc_engine_start" )
	self.Entity:EmitSound( "apc_engine_stop" )
	self.Active = 0
	self.HasAir = false
	self.HasHeat = false
	if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "On", self.Active) end
	self:SetOOO(0)
end


function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive(value)
	elseif (iname == "Radius") then
		if value <= 1024 and value >= 0 then
			self.maxradius = value
		else
			self.maxradius = 1024
		end
	end
end

function ENT:Damage()
	if (self.damaged == 0) then
		self.damaged = 1
	end
	if ((self.Active == 1) and (math.random(1, 10) <= 3)) then
		self:TurnOff()
	end
end

function ENT:Repair()
	self.health = self.maxhealth
	self.damaged = 0
end

function ENT:Destruct()
	SB_Remove_Environment(self.num)
	LS_Destruct( self.Entity, true )
end

function ENT:OnRemove()
	SB_Remove_Environment(self.num)
	self.BaseClass.OnRemove(self)
	self.Entity:StopSound( "apc_engine_start" )
end

function ENT:Climate_Control()
	local temperature = self.environment.temperature
	local gravity = 0
	if self.planet then
		gravity = self.gravity or 0
	end
	local atmosphere = self.environment.atmosphere
	local habitat = self.environment.habitat
	if self.environment.inwater == 1 then
		habitat = 0
	end
	if habitat == 0 then
		self.needair = true
	else
		self.needair = false
	end
	if temperature > FairTemp_Max then
		self.needcoolant = true
	else
		self.needcoolant = false
	end
	if temperature < FairTemp_Min then
		self.needenergy = true
	else
		self.needenergy = false
	end
	local maxradius = 0
	if self.Active == 1 then
		self.air = RD_GetResourceAmount(self.Entity, "air")
		self.coolant = RD_GetResourceAmount(self.Entity, "coolant")
		self.energy = RD_GetResourceAmount(self.Entity, "energy")
		if ((self.coolant <= 0 and temperature > FairTemp_Max) or (self.energy <= 0 and temperature < FairTemp_Min)) or self.energy <= 0 then
			self.HasHeat = false
		else
			self.HasHeat = true
		end
		if (self.air <= 0) or (self.energy <= 0) then
			self.HasAir = false
		else
			self.HasAir = true
		end
		if self.HasAir or self.HasHeat then
			maxradius = self.maxradius
		end
		if (self.HasHeat or self.HasAir) and (self.needcoolant or self.needenergy or self.needair) then
			if self.HasHeat and self.HasAir and (self.needcoolant or self.needenergy) and self.needair  then
				local mul = 1
				if self.needenergy then
					mul = 2
				end
				local radrc = math.Round((self.coolant / Coolant_Increment)*256)
				local radre = math.Round((self.energy / (Energy_Increment + ((atmosphere - 1)/10)))* 256 * mul )
				local radar = math.Round((self.air / Air_Increment)*256)
				if radrc <= radre and radrc <= radar and self.needcoolant then
					maxradius = radrc
				elseif radre <= radrc and radre <= radar then
					maxradius = radre
				elseif self.needair then
					maxradius = radar
				else
					maxradius = self.maxradius
				end
			elseif self.HasHeat and (self.needcoolant or self.needenergy) then
				local mul = 1
				if self.needenergy then
					mul = 2
				end
				local radrc = math.Round((self.coolant / Coolant_Increment)*256)
				local radre = math.Round((self.energy / (Energy_Increment + ((atmosphere - 1)/10)))*256 * mul)
				if radrc <= radre and self.needcoolant then
					maxradius = radrc
				else
					maxradius = radre
				end
			elseif self.HasAir and self.needair then 
				local radre = math.Round((self.energy / (Energy_Increment + atmosphere - 1))*256)
				local radar = math.Round((self.air / Air_Increment)*256)
				if radre <= radar then
					maxradius = radre
				else
					maxradius = radar
				end
			else
				maxradius = 0
			end
			if maxradius > self.maxradius then
				maxradius = self.maxradius
			end
			if self.HasHeat then
				if temperature > FairTemp_Max then
					RD_ConsumeResource(self.Entity, "coolant", Coolant_Increment * self.maxradius/256)
				elseif temperature < FairTemp_Min then
					RD_ConsumeResource(self.Entity, "energy", Energy_Increment * self.maxradius/256)
				end
			end
			if self.HasAir then
				if habitat == 0 then
					RD_ConsumeResource(self.Entity, "air", Air_Increment * self.maxradius/256)
				end
			end
			RD_ConsumeResource(self.Entity, "energy", Energy_Increment * self.maxradius/256)
			if self.HasAir then
				habitat = 1	
			end
			if atmosphere > 1 then
				self.energy = RD_GetResourceAmount(self.Entity, "energy")
				if self.energy > 0 then
					RD_ConsumeResource(self.Entity, "energy", ((atmosphere - 1)/10) *  (self.maxradius/256))
					atmosphere = 1
				end
			end
			if self.HasHeat then
				temperature = 288
			end
			self.air = RD_GetResourceAmount(self.Entity, "air")
			self.coolant = RD_GetResourceAmount(self.Entity, "coolant")
			self.energy = RD_GetResourceAmount(self.Entity, "energy")
			if ((self.coolant <= 0 and temperature > FairTemp_Max) or (self.energy <= 0 and temperature < FairTemp_Min)) or self.energy <= 0 then
				self.HasHeat = false
			end
			if (self.air <= 0) or (self.energy <= 0) then
				self.HasAir = false
			end
			if not self.HasAir and not self.HasHeat then 
				self:TurnOff()
			end
		end
		if not (WireAddon == nil) then
			Wire_TriggerOutput(self.Entity, "Air", tonumber(self.HasAir))
			Wire_TriggerOutput(self.Entity, "Heat", tonumber(self.HasHeat))
		end
	end
	SB_Update_Environment(self.num, maxradius, gravity, habitat, atmosphere, temperature)
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	self:Climate_Control()
	
	self.Entity:NextThink(CurTime() + 1)
	return true
end


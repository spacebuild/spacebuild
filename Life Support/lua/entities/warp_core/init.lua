AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

util.PrecacheSound( "explode_9" )
util.PrecacheSound( "ambient/levels/labs/electric_explosion4.wav" )
util.PrecacheSound( "ambient/levels/labs/electric_explosion3.wav" )
util.PrecacheSound( "ambient/levels/labs/electric_explosion1.wav" )
util.PrecacheSound( "ambient/explosions/exp2.wav" )
util.PrecacheSound( "k_lab.ambient_powergenerators" )
util.PrecacheSound( "ambient/machines/thumper_startup1.wav" )
util.PrecacheSound( "coast.siren_citizen" )
util.PrecacheSound( "common/warning.wav" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32
local Energy_Increment = 2000
local Coolant_Increment = 85
local HW_Increment = 1

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.Active = 0
	self.damaged = 0
	self.critical = 0
	self.hwcount = 0
	self.time = 0
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self.Entity, { "On" })
		self.Outputs = Wire_CreateOutputs(self.Entity, { "On", "Output" })
	end
	self.Entity:SetColor( 10, 96, 255, 255 )
end

function ENT:TurnOn()
	if (self.Active == 0) then
		self.Active = 1
		self.Entity:EmitSound( "k_lab.ambient_powergenerators" )
		self.Entity:EmitSound( "ambient/machines/thumper_startup1.wav" )
		if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "On", 1) end
		self:SetOOO(1)
	end
end

function ENT:TurnOff()
	if (self.Active == 1) then
		self.Active = 0
		self.Entity:StopSound( "k_lab.ambient_powergenerators" )
		self.Entity:StopSound( "coast.siren_citizen" )
		if not (WireAddon == nil) then 
			Wire_TriggerOutput(self.Entity, "On", 0)
			Wire_TriggerOutput(self.Entity, "Output", 0)
		end
		self:SetOOO(0)
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "On") then
		self:SetActive(value)
	end
end

function ENT:Damage()
	if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:Repair()
	self.Entity:SetColor( 10, 96, 255, 255 )
	self.health = self.maxhealth
	self.damaged = 0
	self.critical = 0
	self.hwcount = 0
	self.Entity:StopSound( "coast.siren_citizen" )
end

function ENT:Destruct()
	self.Entity:StopSound( "coast.siren_citizen" )
	if (RD_GetResourceAmount(self, "energy") < 100000) or (GetConVarNumber("LS_AllowNukeEffect") == 0) then
		LS_Destruct( self.Entity )
	else -- !!oh shi-
		local effectdata = EffectData()
		effectdata:SetMagnitude( 1 )
		
		local Pos = self.Entity:GetPos()
	
		effectdata:SetOrigin( Pos )
		effectdata:SetScale( 23000 )
		util.Effect( "warpcore_breach", effectdata )
		local tAllPlayers = player.GetAll()
		for _, pPlayer in pairs( tAllPlayers ) do
			pPlayer.Entity:EmitSound( "explode_9" )
		end
		self:EmitSound( "explode_9" )
		
		local blastradius = 3000
		
		for _,Ent in pairs( constraint.GetAllConstrainedEntities( self.Entity ) ) do
			if Ent ~= self.Entity then
				if (string.find(Ent.Entity:GetClass(),"prop") ~= nil) then
					local delay = (math.random(300, 700) / 100)
					Ent.Entity:SetSolid( SOLID_NONE ) --we don't need to be crunching the phys collisions too
					Ent.Entity:DrawShadow( false )
					Ent.Entity:SetKeyValue("exploderadius","1")
					Ent.Entity:SetKeyValue("explodedamage","1")
					Ent.Entity:Fire("break","",tostring(delay))
					Ent.Entity:Fire("kill","",tostring(delay + 1))
					Ent.Entity:Fire("enablemotion","",0) --bye bye fort that took you 4 hours to make
					constraint.RemoveAll( Ent.Entity )
				else
					if (Ent.Entity:IsValid()) then
						Ent.Entity:Remove()
					end
				end
			
			end
		end
		
		for key,found in pairs(ents.FindInSphere(Pos,blastradius)) do
			movetype = 	found:GetMoveType()
			if (movetype == 2 or movetype == 3 or movetype == 5 or movetype == 6 or movetype == 8 or movetype == 9) then
				local entpos = found:LocalToWorld(found:OBBCenter()) --more accurate than getpos
				local vecang = entpos - Pos
				if vecang.z < 0 then vecang.z = 0 end
				vecang:Normalize()
			
				if found:IsNPC() then --ugh, messy
					util.BlastDamage(self.Entity, self:GetPlayer(), found:GetPos(), 256, 512)
				elseif found:IsPlayer() then
					found:SetModel("models/player/charple01.mdl")
					util.BlastDamage(self.Entity, self:GetPlayer(), found:GetPos(), 256, 512)
				elseif found:IsValid() then
					
					local physobj = found:GetPhysicsObject()
					local mass = 1
					if(physobj:IsValid()) then
						mass = physobj:GetMass();
					end
					
					if (found:GetMoveType() ~= 6) or not physobj:IsValid() then --if it's not a physics object...
						found:SetVelocity(vecang*(170*mass)) --push it away
					elseif (string.find(found:GetClass(),"ragdoll") ~= nil) then --if it's a ragdoll...
						physobj:ApplyForceCenter(vecang*(8e4*mass)) --push it away anyway :D
					else -- if it is a physics object...
						physobj:ApplyForceOffset(vecang*(8e4*mass),entpos + Vector(math.random(-20,20),math.random(-20,20),math.random(20,40))) --still push it away
					end
					
					util.BlastDamage(self.Entity, self:GetPlayer(), Pos - vecang*64, 384, 1000) --splode it
				end
			end
		end
		
		local shake = ents.Create("env_shake")
		shake:SetKeyValue("amplitude", "16")
		shake:SetKeyValue("duration", "6")
		shake:SetKeyValue("radius", 1) 
		shake:SetKeyValue("spawnflags", 5) 
		shake:SetKeyValue("frequency", "240")
		shake:SetPos(Pos)
		shake:Spawn()
		shake:Fire("StartShake","","0.6")
		shake:Fire("kill","","8")
		
		--shatter all glass
		for k,v in pairs(ents.FindByClass("func_breakable_surf")) do
			local dist = (v:GetPos() - Pos):Length()
			v:Fire("Shatter","",dist/19e3)
		end
		
		for k,v in pairs(ents.FindByClass("func_breakable")) do
			local dist = (v:GetPos() - Pos):Length()
			v:Fire("break","",dist/19e3)
		end
		self.Entity:Remove()
	end
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	self.Entity:StopSound( "k_lab.ambient_powergenerators" )
	self.Entity:StopSound( "coast.siren_citizen" )	
end

function ENT:Extract_Energy()
	local inc = Energy_Increment

	if (self.critical == 1) then
		local ang = self.Entity:GetAngles()
		local pos = (self.Entity:GetPos() + (ang:Up() * self.Entity:BoundingRadius()))
		local test = math.random(1, 10)
		if (test <= 2) then
			zapme((pos + (ang:Right() * 90)), 5)
			zapme((pos - (ang:Right() * 90)), 5)
			self.Entity:EmitSound( "ambient/levels/labs/electric_explosion3.wav" )
			inc = 0
		elseif (test <= 4) then
			zapme((pos + (ang:Right() * 90)), 3)
			zapme((pos - (ang:Right() * 90)), 3)
			self.Entity:EmitSound( "ambient/levels/labs/electric_explosion4.wav" )
			inc = math.ceil(inc / 4)
		elseif (test <= 6) then
			zapme((pos + (ang:Right() * 90)), 2)
			zapme((pos - (ang:Right() * 90)), 2)
			self.Entity:EmitSound( "ambient/levels/labs/electric_explosion1.wav" )
			inc = math.ceil(inc / 2)
		end
	end
	
	--coolant check (no coolant causes damage and greatly reduces output)
	if (RD_GetResourceAmount(self, "coolant") <= 0) then
		DamageLS(self.Entity, 15)
		local Smoke = ents.Create("env_smoketrail")
			Smoke:SetKeyValue("opacity", 1)
			Smoke:SetKeyValue("spawnrate", 10)
			Smoke:SetKeyValue("lifetime", 2)
			Smoke:SetKeyValue("startcolor", "180 180 180")
			Smoke:SetKeyValue("endcolor", "255 255 255")
			Smoke:SetKeyValue("minspeed", 15)
			Smoke:SetKeyValue("maxspeed", 30)
			Smoke:SetKeyValue("startsize", (self.Entity:BoundingRadius() / 2))
			Smoke:SetKeyValue("endsize", self.Entity:BoundingRadius())
			Smoke:SetKeyValue("spawnradius", 10)
			Smoke:SetKeyValue("emittime", 300)
			Smoke:SetKeyValue("firesprite", "sprites/firetrail.spr")
			Smoke:SetKeyValue("smokesprite", "sprites/whitepuff.spr")
			Smoke:SetPos(self.Entity:GetPos())
			Smoke:SetParent(self.Entity)
			Smoke:Spawn()
			Smoke:Activate()
			Smoke:Fire("kill","", 1)

		if (self.critical == 0) then
			if self.time > 3 then 
				self.Entity:EmitSound( "common/warning.wav" )
				self.time = 0
			else
				self.time = self.time + 1
			end
		else
			if self.time > 3 then 
				self.Entity:EmitSound( "coast.siren_citizen" )
				self.time = 0
			else
				self.time = self.time + 1
			end
		end

		--only supply 5-25% of the normal amount
		if (inc > 0) then inc = math.ceil(inc/math.random(4,20)) end
	else
		RD_ConsumeResource(self, "coolant", Coolant_Increment)
	end

	--heavy water check (water adds stability)
	if (RD_GetResourceAmount(self, "heavy water") <= 0) then
		if (inc > 0) then 
			--instability varying the output from 20-80% of normal
			local hwmult = math.random(20,80)/100
			inc = math.ceil(inc * hwmult)
		end
	else
		self.hwcount = self.hwcount + 1
		if (self.hwcount >= 5) then
			RD_ConsumeResource(self, "heavy water", HW_Increment)
			self.hwcount = 0
		end
	end

	--the money shot!
	if (inc > 0) then RD_SupplyResource(self, "energy", inc) end
	if not (WireAddon == nil) then Wire_TriggerOutput(self.Entity, "Output", inc) end

	--[[   	     Base: 2000

	       w/Critical: 0-1000

	       wo/Coolant: 100-500

	       wo/Heavy W: 500-2100

   	         --- Worst case---

	       w/Critical: 0-1000
	       wo/Coolant: 50-250
	       wo/Heavy W: 2.5-275 ]]--
end

function ENT:Leak() --leak cause this is like with storage, make be it could leak radation?
	if (RD_GetResourceAmount(self, "energy") >= 100000) then
		if (self.critical == 0) 
			then self.critical = 1 
		end
	else
		if (self.critical == 1) then
			self.Entity:StopSound( "coast.siren_citizen" )
			self.critical = 0
		end
	end
	--chance to leak additional heavy water
	if (math.random(1, 10) <= 2) then
		RD_ConsumeResource(self, "heavy water", HW_Increment)
	end
end

function ENT:Think()
	self.BaseClass.Think(self)
	
	if (self.Active == 1) then
		self:Extract_Energy()
	end
	
	if (self.damaged == 1) then
		self:Leak()
	end
	
	self.Entity:NextThink(CurTime() + 1)
	return true
end


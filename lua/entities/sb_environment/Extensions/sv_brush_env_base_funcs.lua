local SB_AIR_EMPTY = -1
local SB_AIR_O2 = 0
local SB_AIR_CO2 = 1
local SB_AIR_N = 2
local SB_AIR_H = 3

function SB_Brush_Environment_Load_Base_Func_Extensions1(ENT) -- HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ! HAKZ!

	function ENT:GetUnstable()
		return self.sbenvironment.unstable
	end

	function ENT:GetTemperature()
		return self.sbenvironment.temperature or 0
	end

	function ENT:Unstable()
		if self.Entity.sbenvironment.unstable then
			--Add some unstable planet shake thingy code here
		end
	end

	function ENT:IsPlanet()
		return false
	end

	function ENT:Think()
		self:Unstable()
		self.Entity:NextThink(CurTime() + 1)
		return true
	end

	function ENT:SendBloom()
		--We'll figure this shit out later
	end

	function ENT:SendColor()
		--We'll figure this shit out later
	end

	function ENT:GetEnvironmentID()
		return self.sbenvironment.id or 0
	end

	function ENT:PrintVars()
		Msg("Print Environment Data\n")
		PrintTable(self.sbenvironment)
		Msg("End Print Environment Data\n")
	end

	function ENT:GetEnvClass()
		return "SB ENVIRONMENT"
	end

	function ENT:GetSize()
		return 9000 + 1
	end

	function ENT:GetPriority()
		return 9000 + (self.PriorityOverride or 1)
	end

	function ENT:GetO2Percentage()
		if not self.sbenvironment.air.max then
			self:CalcAirMax()
		elseif self.sbenvironment.air.max == 0 then
			return
		end
		
		return ((self.sbenvironment.air.o2  / self.sbenvironment.air.max) * 100)
	end

	function ENT:GetCO2Percentage()
		if not self.sbenvironment.air.max then
			self:CalcAirMax()
		elseif self.sbenvironment.air.max == 0 then
			return
		end
		
		return ((self.sbenvironment.air.co2  / self.sbenvironment.air.max) * 100)
	end
	
	function ENT:GetNPercentage()
		if not self.sbenvironment.air.max then
			self:CalcAirMax()
		elseif self.sbenvironment.air.max == 0 then
			return
		end
		
		return ((self.sbenvironment.air.n  / self.sbenvironment.air.max) * 100)
	end

	function ENT:GetHPercentage()
		if not self.sbenvironment.air.max then
			self:CalcAirMax()
		elseif self.sbenvironment.air.max == 0 then
			return
		end
		
		return ((self.sbenvironment.air.h / self.sbenvironment.air.max) * 100)
	end
	
	function ENT:GetOtherGasPercentage()
		if not self.sbenvironment.air.max then
			self:CalcAirMax()
		elseif self.sbenvironment.air.max == 0 then
			return
		end
		
		return ((self.sbenvironment.air.other / self.sbenvironment.air.max) * 100)
	end
	
	function ENT:CalcAirMax()
		self.sbenvironment.air.max = self.sbenvironment.air.other +
									 self.sbenvironment.air.h +
									 self.sbenvironment.air.n +
									 self.sbenvironment.air.co2 +
									 self.sbenvironment.air.o2 
	end

	function ENT:SetSize(size)
		return Error("Cant set the size of a brush env!\n")
	end

	function ENT:ChangeAtmosphere(newatmosphere)
		if not newatmosphere or type(newatmosphere) ~= "number" then return Error("Invalid parameter\n") end
		if newatmosphere < 0 then
			newatmosphere = 0
		elseif newatmosphere > 1 then
			newatmosphere = 1
		end
		--Update the pressure since it's based on atmosphere and gravity
		if self.sbenvironment.atmosphere ~= 0 then
			self.sbenvironment.pressure = self.sbenvironment.pressure * (newatmosphere/self.sbenvironment.atmosphere)
		else
			self.sbenvironment.pressure = self.sbenvironment.pressure * newatmosphere
		end
		--Update air values so they are correct again (
		if newatmosphere > self.sbenvironment.atmosphere then
			self.sbenvironment.air.max = math.Round(100 * 5 * (self:GetVolume()/1000) * newatmosphere)
			local tmp = self.sbenvironment.air.max - (self.sbenvironment.air.o2 + self.sbenvironment.air.co2 + self.sbenvironment.air.n + self.sbenvironment.air.h)
			self.sbenvironment.air.other = tmp
			self.sbenvironment.air.otherper = self:GetOtherGasesPercentage()
		else
			self.sbenvironment.air.o2 = math.Round(GetO2Percentage() * 5 * (self:GetVolume()/1000) * newatmosphere)
			self.sbenvironment.air.co2 = math.Round(GetCO2Percentage() * 5 * (self:GetVolume()/1000) * newatmosphere)
			self.sbenvironment.air.n = math.Round(GetNPercentage() * 5 * (self:GetVolume()/1000) * newatmosphere)
			self.sbenvironment.air.h = math.Round(GetHPercentage() * 5 * (self:GetVolume()/1000) * newatmosphere)
			self.sbenvironment.air.other = math.Round(GetOtherGasesPercentage() * 5 * (self:GetVolume()/1000) * newatmosphere)
			self.sbenvironment.air.max = math.Round(100 * 5 * (self:GetVolume()/1000) * newatmosphere)
		end
		self.sbenvironment.atmosphere = newatmosphere
	end

	function ENT:ChangeGravity(newgravity)
		if not newgravity or type(newgravity) ~= "number" then return "Invalid parameter" end
		--Update the pressure since it's based on atmosphere and gravity
		if self.sbenvironment.gravity ~= 0 then
			self.sbenvironment.pressure = self.sbenvironment.pressure * (newgravity/self.sbenvironment.gravity)
		else
			self.sbenvironment.pressure = self.sbenvironment.pressure * newgravity
		end
		self.sbenvironment.gravity = newgravity
	end

	function ENT:GetEnvironmentName()
		return self.sbenvironment.name
	end

	function ENT:SetEnvironmentName(value)
		if not value then return end
		self.sbenvironment.name = value
	end

	function ENT:GetGravity()
		return self.sbenvironment.gravity or 0
	end

	function ENT:UpdatePressure(ent)
		if not ent or GAMEMODE.Override_PressureDamage > 0 then return end
		if ent:IsPlayer() and GAMEMODE.PlayerOverride > 0 then return end
		if self.sbenvironment.pressure and self.sbenvironment.pressure > 1.5 then
			ent:TakeDamage((self.sbenvironment.pressure - 1.5) * 10)
		end
	end

	function ENT:Convert(air1, air2, value)
		if not air1 or not air2 or not value then return end
		if type(air1) ~= "number" or type(air2) ~= "number" or type(value) ~= "number" then return end
		
		air1 = math.Round(air1)
		air2 = math.Round(air2)
		value = math.Round(value)
		
		if air1 < -1 or air1 > 3 then return 0 end
		if air2 < -1 or air2 > 3 then return 0 end
		
		if air1 == air2 then return 0 end
		if value < 1 then return 0 end
		
		if air1 == -1 then
			if self.sbenvironment.air.other < value then
				value = self.sbenvironment.air.other
			end
			
			self.sbenvironment.air.other = self.sbenvironment.air.other - value
			
			if air2 == SB_AIR_CO2 then
				self.sbenvironment.air.co2 = self.sbenvironment.air.co2 + value
			elseif air2 == SB_AIR_N then
				self.sbenvironment.air.n = self.sbenvironment.air.n + value
			elseif air2 == SB_AIR_H then
				self.sbenvironment.air.h = self.sbenvironment.air.h + value
			elseif air2 == SB_AIR_O2 then
				self.sbenvironment.air.o2 = self.sbenvironment.air.o2 + value
			end
		elseif air1 == SB_AIR_O2 then
			if self.sbenvironment.air.o2 < value then
				value = self.sbenvironment.air.o2
			end
			
			self.sbenvironment.air.o2 = self.sbenvironment.air.o2 - value
			
			if air2 == SB_AIR_CO2 then
				self.sbenvironment.air.co2 = self.sbenvironment.air.co2 + value
			elseif air2 == SB_AIR_N then
				self.sbenvironment.air.n = self.sbenvironment.air.n + value
			elseif air2 == SB_AIR_H then
				self.sbenvironment.air.h = self.sbenvironment.air.h + value
			elseif air2 == -1 then
				self.sbenvironment.air.other = self.sbenvironment.air.other + value
			end
		elseif air1 == SB_AIR_CO2 then
			if self.sbenvironment.air.co2 < value then
				value = self.sbenvironment.air.co2
			end
			
			self.sbenvironment.air.co2 = self.sbenvironment.air.co2 - value
			
			if air2 == SB_AIR_O2 then
				self.sbenvironment.air.o2 = self.sbenvironment.air.o2 + value
			elseif air2 == SB_AIR_N then
				self.sbenvironment.air.n = self.sbenvironment.air.n + value
			elseif air2 == SB_AIR_H then
				self.sbenvironment.air.h = self.sbenvironment.air.h + value
			elseif air2 == -1 then
				self.sbenvironment.air.other = self.sbenvironment.air.other + value
			end
		elseif air1 == SB_AIR_N then
			if self.sbenvironment.air.n < value then
				value = self.sbenvironment.air.n
			end
			
			self.sbenvironment.air.n = self.sbenvironment.air.n - value
			
			if air2 == SB_AIR_O2 then
				self.sbenvironment.air.o2 = self.sbenvironment.air.o2 + value
			elseif air2 == SB_AIR_CO2 then
				self.sbenvironment.air.co2 = self.sbenvironment.air.co2 + value
			elseif air2 == SB_AIR_H then
				self.sbenvironment.air.h = self.sbenvironment.air.h + value
			elseif air2 == -1 then
				self.sbenvironment.air.other = self.sbenvironment.air.other + value
			end
		else
			if self.sbenvironment.air.h < value then
				value = self.sbenvironment.air.h
			end
			
			self.sbenvironment.air.h = self.sbenvironment.air.h - value
			
			if air2 == SB_AIR_O2 then
				self.sbenvironment.air.o2 = self.sbenvironment.air.o2 + value
			elseif air2 == SB_AIR_CO2 then
				self.sbenvironment.air.co2 = self.sbenvironment.air.co2 + value
			elseif air2 == SB_AIR_N then
				self.sbenvironment.air.n = self.sbenvironment.air.n + value
			elseif air2 == -1 then
				self.sbenvironment.air.other = self.sbenvironment.air.other + value
			end
		end
		
		return value
	end

	function ENT:UpdateGravity(ent)
		if not ent then return end
		
		local phys = ent:GetPhysicsObject()
		if not phys:IsValid() then return end
		
		if self.sbenvironment.gravity == 0 then
			local trace = {}
			local pos = ent:GetPos()
			trace.start = pos
			trace.endpos = pos - Vector(0,0,512)
			trace.filter = { ent }
			local tr = util.TraceLine( trace )
			
			if (tr.Hit) and tr.Entity.grav_plate == 1 then
				ent:SetGravity(1)
				ent.gravity = 1
				phys:EnableGravity( true )
				phys:EnableDrag( true )
				return
			end
		elseif ent.gravity and  ent.gravity == self.sbenvironment.gravity then 
			return 
		end
		
		if not self.sbenvironment.gravity or self.sbenvironment.gravity  == 0 then
			phys:EnableGravity( false )
			phys:EnableDrag( false )
			ent:SetGravity(0.00001)
			ent.gravity = 0
		else
			ent:SetGravity(self.sbenvironment.gravity)
			ent.gravity = self.sbenvironment.gravity
			phys:EnableGravity( true )
			phys:EnableDrag( true )
		end	
	end

	function ENT:GetAtmosphere()
		return self.sbenvironment.atmosphere or 0
	end

	function ENT:GetPressure()
		return self.sbenvironment.pressure or 0
	end

	function ENT:GetTemperature()
		return self.sbenvironment.temperature or 0
	end

	function ENT:GetO2()
		return self.sbenvironment.air.o2 or 0
	end

	function ENT:GetOtherGases()
		return self.sbenvironment.air.other or 0
	end

	function ENT:GetCO2()
		return self.sbenvironment.air.co2 or 0
	end

	function ENT:GetN()
		return self.sbenvironment.air.n or 0
	end

	function ENT:GetH()
		return self.sbenvironment.air.h or 0
	end

	function ENT:CreateEnvironment(gravity, atmosphere, pressure, temperature, o2, co2, n, h, name)
		--Msg("CreateEnvironment: "..tostring(gravity).."\n")
		--set Gravity if one is given
		if gravity and type(gravity) == "number" then
			if gravity < 0 then
				gravity = 0
			end
			self.sbenvironment.gravity = gravity
		end
		--set atmosphere if given
		if atmosphere and type(atmosphere) == "number" then
			if atmosphere < 0 then
				atmosphere = 0
			elseif atmosphere > 1 then
				atmosphere = 1
			end
			self.sbenvironment.atmosphere = atmosphere
		end
		--set pressure if given
		if pressure and type(pressure) == "number" and pressure >= 0 then
			self.sbenvironment.pressure = pressure
		else 
			self.sbenvironment.pressure = math.Round(self.sbenvironment.atmosphere * self.sbenvironment.gravity)
		end
		--set temperature if given
		if temperature and type(temperature) == "number" then
			self.sbenvironment.temperature = temperature
		end
		--set o2 if given
		if o2 and type(o2) == "number" and o2 > 0 then
			if o2 < 0 then o2 = 0 end
			if o2 > 100 then o2 = 100 end
			self.sbenvironment.air.o2per = o2
			self.sbenvironment.air.o2 = math.Round(o2 * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
		else 
			o2 = 0
			self.sbenvironment.air.o2per = 0
			self.sbenvironment.air.o2 = 0
		end
		--set co2 if given
		if co2 and type(co2) == "number" and co2 > 0 then
			if co2 < 0 then co2 = 0 end
			if (100 - o2) < co2 then co2 = 100-o2 end
			self.sbenvironment.air.co2per = co2
			self.sbenvironment.air.co2 = math.Round(co2 * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
		else 
			co2 = 0
			self.sbenvironment.air.co2per = 0
			self.sbenvironment.air.co2 = 0
		end
		--set n if given
		if n and type(n) == "number" and n > 0 then
			if n < 0 then n = 0 end
			if ((100 - o2)-co2) < n then n = (100-o2)-co2 end
			self.sbenvironment.air.nper = n
			self.sbenvironment.air.n = math.Round(n * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
		else 
			n = 0
			self.sbenvironment.air.n = 0
			self.sbenvironment.air.n = 0
		end
		--set h if given
		if h and type(h) == "number" and h > 0 then
			if h < 0 then h = 0 end
			if (((100 - o2)-co2)-n) < h then h = ((100-o2)-co2)-n end
			self.sbenvironment.air.hper = h
			self.sbenvironment.air.h = math.Round(h * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
		else 
			h = 0
			self.sbenvironment.air.h = 0
			self.sbenvironment.air.h = 0
		end
		if o2 + co2 + n + h < 100 then
			local tmp = 100 - (o2 + co2 + n + h)
			self.sbenvironment.air.other = math.Round(tmp * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
			self.sbenvironment.air.otherper = tmp
		elseif o2 + co2 + n + h > 100 then
			local tmp = (o2 + co2 + n + h) - 100
			if co2 > tmp then
				self.sbenvironment.air.co2 = math.Round((co2 - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.co2per = co2 + tmp
			elseif n > tmp then
				self.sbenvironment.air.n = math.Round((n - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.nper = n + tmp
			elseif h > tmp then
				self.sbenvironment.air.h = math.Round((h - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.hper = h + tmp
			elseif o2 > tmp then
				self.sbenvironment.air.o2 = math.Round((o2 - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.o2per = o2 - tmp
			end
		end
		if name then
			self.sbenvironment.name = name
		end
		
		self.sbenvironment.air.max = math.Round(100 * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
		
		return self:PrintVars()
	end

	function ENT:UpdateEnvironment(gravity, atmosphere, pressure, temperature, o2, co2, n, h)
		self:ChangeGravity(gravity)
		if atmosphere then self:ChangeAtmosphere(atmosphere) end
		
		if pressure and type(pressure) == "number" then
			if pressure < 0 then
				pressure = 0
			end
			self.sbenvironment.pressure = pressure
		end
		--set temperature if given
		if temperature and type(temperature) == "number" then
			self.sbenvironment.temperature = temperature
		end
		self.sbenvironment.air.max = math.Round(100 * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
		--set o2 if given
		if o2 and type(o2) == "number" then
			if o2 < 0 then o2 = 0 end
			if o2 > 100 then o2 = 100 end
			self.sbenvironment.air.o2 = math.Round(o2 * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
			self.sbenvironment.air.o2per = o2
		else 
			o2 = self:GetO2Percentage()
		end
		--set co2 if given
		if co2 and type(co2) == "number" then
			if co2 < 0 then co2 = 0 end
			if (100 - o2) < co2 then co2 = 100-o2 end
			self.sbenvironment.air.co2 = math.Round(co2 * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
			self.sbenvironment.air.co2per = co2
		else 
			co2 = self:GetCO2Percentage()
		end
		--set n if given
		if n and type(n) == "number" then
			if n < 0 then n = 0 end
			if ((100 - o2)-co2) < n then n = (100-o2)-co2 end
			self.sbenvironment.air.n = math.Round(n * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
			self.sbenvironment.air.nper = n
		else 
			n = self:GetNPercentage()
		end
		if h and type(h) == "number" then
			if h < 0 then h = 0 end
			if (((100 - o2)-co2)-n) < h then h = (((100-o2)-co2)-n) end
			self.sbenvironment.air.h = math.Round(h * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
			self.sbenvironment.air.hper = h
		else 
			h = self:GetHPercentage()
		end
		if o2 + co2 + n + h < 100 then
			local tmp = 100 - (o2 + co2 + n + h)
			self.sbenvironment.air.other = math.Round(tmp * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
			self.sbenvironment.air.otherper = tmp
		elseif o2 + co2 + n + h > 100 then
			local tmp = (o2 + co2 + n + h) - 100
			if co2 >= tmp then
				self.sbenvironment.air.co2 = math.Round((co2 - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.co2per = co2 + tmp
			elseif n >= tmp then
				self.sbenvironment.air.n = math.Round((n - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.nper = n + tmp
			elseif h >= tmp then
				self.sbenvironment.air.h = math.Round((h - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.hper = h + tmp
			elseif o2 >= tmp then
				self.sbenvironment.air.o2 = math.Round((o2 - tmp) * 5 * (self:GetVolume()/1000) * self.sbenvironment.atmosphere)
				self.sbenvironment.air.o2per = o2 - tmp
			end
		end
		
		self:PrintVars()
	end

	function ENT:GetVolume()
		return 9001 -- You saw this coming.
	end

	function ENT:IsEnvironment()
		return true
	end

	function ENT:IsPlanet()
		return false
	end

	function ENT:IsStar()
		return false
	end

	function ENT:IsSpace()
		return false
	end
	 
	function ENT:OnEnvironment(ent)
		return (ent.BrushEnvStack and (ent.BrushEnvStack[#ent.BrushEnvStack] == self.ID))
	end

	function ENT:Remove()
		GAMEMODE:RemoveEnvironment(self)
	end
end
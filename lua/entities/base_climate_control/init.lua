--if not GAMEMODE.IsSpacebuildDerived then return end --Dont register the climate Control!
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
util.PrecacheSound("apc_engine_start")
util.PrecacheSound("apc_engine_stop")
util.PrecacheSound("common/warning.wav")

include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Active = 0
    self.damaged = 0
    self:CreateEnvironment(1, 1, 1, 0, 0, 0, 0, 0)
    self.currentsize = 1024
    self.maxsize = 4096
    self.maxO2Level = 100
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Inputs = Wire_CreateInputs(self, { "On", "Radius", "Gravity", "Max O2 level" })
        self.Outputs = Wire_CreateOutputs(self, { "On", "Oxygen-Level", "Temperature", "Gravity" })
    else
        self.Inputs = { { Name = "On" }, { Name = "Radius" }, { Name = "Gravity" }, { Name = "Max O2 level" } }
    end
end

function ENT:TurnOn()
    if (self.Active == 0) then
        self:EmitSound("apc_engine_start")
        self.Active = 1
        self:UpdateSize(self.sbenvironment.size, self.currentsize) --We turn the forcefield that contains the environment on
        --[[if self.environment and not self.environment:IsSpace() then --Fill the environment with air if the surounding environment has o2, replace with CO2
              self.sbenvironment.air.o2 = self.sbenvironment.air.o2 + self.environment:Convert(0, -1, math.Round(self.sbenvironment.air.max/18))
              self.sbenvironment.air.empty = self.sbenvironment.air.empty - self.sbenvironment.air.o2
          end*]]
        local oxygen = self:GetResourceAmount("oxygen")
        --[[if oxygen >= math.ceil(self.sbenvironment.air.max/ 18) then
              local left = RD.ConsumeResource(self, "oxygen", math.ceil(self.sbenvironment.air.max/ 18) )
              self.sbenvironment.air.o2 = math.ceil(self.sbenvironment.air.max/ 18) - left
              self.sbenvironment.air.empty = self.sbenvironment.air.empty - self.sbenvironment.air.o2
          elseif oxygen > 0 then
              local left = RD.ConsumeResource(self, "oxygen", oxygen )
              self.sbenvironment.air.o2 = oxygen - left
              self.sbenvironment.air.empty = self.sbenvironment.air.empty - self.sbenvironment.air.o2
          end]]
        self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 200 * math.ceil(self.maxsize / 1024))
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
        self:SetOOO(1)
    end
end

function ENT:TurnOff()
    if (self.Active == 1) then
        self:StopSound("apc_engine_start")
        self:EmitSound("apc_engine_stop")
        self.Active = 0
        if self.environment then --flush all resources into the environment if we are in one (used for the slownes of the SB updating process, we don't want errors do we?)
            if self.sbenvironment.air.o2 > 0 then
                local left = self:SupplyResource("oxygen", self.sbenvironment.air.o2)
                self.environment:Convert(-1, 0, left)
            end
            if self.sbenvironment.air.co2 > 0 then
                local left = self:SupplyResource("carbon dioxide", self.sbenvironment.air.co2)
                self.environment:Convert(-1, 1, left)
            end
            if self.sbenvironment.air.n > 0 then
                local left = self:SupplyResource("nitrogen", self.sbenvironment.air.n)
                self.environment:Convert(-1, 2, left)
            end
            if self.sbenvironment.air.h > 0 then
                local left = self:SupplyResource("hydrogen", self.sbenvironment.air.h)
                self.environment:Convert(-1, 3, left)
            end
        end
        self.sbenvironment.temperature = 0
        self:UpdateSize(self.sbenvironment.size, 0) --We turn the forcefield that contains the environment off!
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "On", self.Active) end
        self:SetOOO(0)
    end
end

function ENT:TriggerInput(iname, value)
    if (iname == "On") then
        self:SetActive(value)
    elseif (iname == "Radius") then
        if value >= 0 and value < self.maxsize then
            if self.Active == 1 then
                self:UpdateSize(self.sbenvironment.size, value)
            end
            self.currentsize = value
        else
            if self.Active == 1 then
                self:UpdateSize(self.sbenvironment.size, self.maxsize) --Default value
            end
            self.currentsize = self.maxsize
        end
    elseif (iname == "Gravity") then
        local gravity = value
        if value <= 0 then
            gravity = 0
        end
        self.sbenvironment.gravity = gravity
    elseif (iname == "Max O2 level") then
        local level = 100
        level = math.Clamp(math.Round(value), 0, 100)
        self.maxO2Level = level
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
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self.damaged = 0
end

function ENT:Destruct()
    GAMEMODE:RemoveEnvironment(self)
    CAF.GetAddon("Life Support").LS_Destruct(self, true)
end

function ENT:OnRemove()
    GAMEMODE:RemoveEnvironment(self)
    self.BaseClass.OnRemove(self)
    self:StopSound("apc_engine_start")
end

function ENT:UpdateSize(oldsize, newsize)
    if oldsize == newsize then return end
    if oldsize and newsize and type(oldsize) == "number" and type(newsize) == "number" and oldsize >= 0 and newsize >= 0 then
        if oldsize == 0 then
            self.sbenvironment.size = newsize
            self.sbenvironment.air.o2 = 0
            self.sbenvironment.air.co2 = 0
            self.sbenvironment.air.n = 0
            self.sbenvironment.air.h = 0
            self.sbenvironment.air.empty = math.Round(25 * (self:GetVolume() / 1000) * self.sbenvironment.atmosphere)
        elseif newsize == 0 then
            local tomuch = self.sbenvironment.air.o2
            if self.environment then
                tomuch = self.environment:Convert(-1, 0, tomuch)
            end
            tomuch = self.sbenvironment.air.co2
            if self.environment then
                tomuch = self.environment:Convert(-1, 1, tomuch)
            end
            tomuch = self.sbenvironment.air.n
            if self.environment then
                tomuch = self.environment:Convert(-1, 2, tomuch)
            end
            tomuch = self.sbenvironment.air.h
            if self.environment then
                tomuch = self.environment:Convert(-1, 3, tomuch)
            end
            self.sbenvironment.air.o2 = 0
            self.sbenvironment.air.co2 = 0
            self.sbenvironment.air.n = 0
            self.sbenvironment.air.h = 0
            self.sbenvironment.air.empty = 0
            self.sbenvironment.size = 0
        else
            self.sbenvironment.air.o2 = (newsize / oldsize) * self.sbenvironment.air.o2
            self.sbenvironment.air.co2 = (newsize / oldsize) * self.sbenvironment.air.co2
            self.sbenvironment.air.n = (newsize / oldsize) * self.sbenvironment.air.n
            self.sbenvironment.air.h = (newsize / oldsize) * self.sbenvironment.air.h
            self.sbenvironment.air.empty = (newsize / oldsize) * self.sbenvironment.air.empty
            self.sbenvironment.size = newsize
        end
        self.sbenvironment.air.max = math.Round(25 * (self:GetVolume() / 1000) * self.sbenvironment.atmosphere)
        if self.sbenvironment.air.o2 > self.sbenvironment.air.max then
            local tomuch = self.sbenvironment.air.o2 - self.sbenvironment.air.max
            tomuch = self:SupplyResource("oxygen", tomuch)
            if self.environment then
                tomuch = self.environment:Convert(-1, 0, tomuch)
            end
            self.sbenvironment.air.o2 = self.sbenvironment.air.max + tomuch
        end
        if self.sbenvironment.air.co2 > self.sbenvironment.air.max then
            local tomuch = self.sbenvironment.air.co2 - self.sbenvironment.air.max
            tomuch = self:SupplyResource("carbon dioxide", tomuch)
            if self.environment then
                tomuch = self.environment:Convert(-1, 1, tomuch)
            end
            self.sbenvironment.air.co2 = self.sbenvironment.air.max + tomuch
        end
        if self.sbenvironment.air.n > self.sbenvironment.air.max then
            local tomuch = self.sbenvironment.air.n - self.sbenvironment.air.max
            tomuch = self:SupplyResource("nitrogen", tomuch)
            if self.environment then
                tomuch = self.environment:Convert(-1, 2, tomuch)
            end
            self.sbenvironment.air.n = self.sbenvironment.air.max + tomuch
        end
        if self.sbenvironment.air.h > self.sbenvironment.air.max then
            local tomuch = self.sbenvironment.air.h - self.sbenvironment.air.max
            tomuch = self:SupplyResource("hydrogen", tomuch)
            if self.environment then
                tomuch = self.environment:Convert(-1, 3, tomuch)
            end
            self.sbenvironment.air.h = self.sbenvironment.air.max + tomuch
        end
    end
end

function ENT:Climate_Control()
    local temperature = 0
    local pressure = 0
    if self.environment then
        temperature = self.environment:GetTemperature(self)
        pressure = self.environment:GetPressure()
        --Msg("Found environment, updating\n")
    end
    --Msg("Temperature: "..tostring(temperature)..", pressure: " ..tostring(pressure).."\n")
    if self.Active == 1 then --Only do something if the device is on
        self.energy = self:GetResourceAmount("energy")
        if self.energy == 0 or self.energy < math.ceil(self.sbenvironment.size / self.maxsize) * 3 * math.ceil(self.maxsize / 1024) then --Don't have enough power to keep the controler\'s think process running, shut it all down
            self:TurnOff()
            return
            --Msg("Turning of\n")
        else
            self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 3 * math.ceil(self.maxsize / 1024))
            self.air = self:GetResourceAmount("oxygen")
            self.coolant = self:GetResourceAmount("water")
            self.coolant2 = self:GetResourceAmount("nitrogen")
            self.energy = self:GetResourceAmount("energy")
            --First let check our air supply and try to stabilize it if we got oxygen left in storage at a rate of 5 oxygen per second
            if self.sbenvironment.air.o2 < self.sbenvironment.air.max * (self.maxO2Level / 100) then
                --We need some energy to fire the pump!
                local energyneeded = math.ceil(self.sbenvironment.size / self.maxsize) * 5 * math.ceil(self.maxsize / 1024)
                local mul = 1
                if self.energy < energyneeded then
                    mul = self.energy / energyneeded
                    self:ConsumeResource("energy", self.energy)
                else
                    self:ConsumeResource("energy", energyneeded)
                end
                local air = math.ceil(5000 * mul)
                if self.air < air then air = self.air end
                if self.sbenvironment.air.empty > 0 then
                    local actual = self:Convert(-1, 0, air)
                    self:ConsumeResource("oxygen", actual)
                elseif self.sbenvironment.air.co2 > 0 then
                    local actual = self:Convert(1, 0, air)
                    self:ConsumeResource("oxygen", actual)
                    local left = self:SupplyResource("carbon dioxide", actual)
                    self.environment:Convert(-1, 1, left)
                elseif self.sbenvironment.air.n > 0 then
                    local actual = self:Convert(2, 0, air)
                    self:ConsumeResource("oxygen", actual)
                    local left = self:SupplyResource("nitrogen", actual)
                    self.environment:Convert(-1, 2, left)
                elseif self.sbenvironment.air.h > 0 then
                    local actual = self:Convert(3, 0, air)
                    self:ConsumeResource("oxygen", actual)
                    local left = self:SupplyResource("hydrogen", actual)
                    self.environment:Convert(-1, 1, left)
                end
            elseif self.sbenvironment.air.o2 > self.sbenvironment.air.max then
                local tmp = self.sbenvironment.air.o2 - self.sbenvironment.air.max
                local left = self:SupplyResource("oxygen", tmp)
                self.environment:Convert(-1, 0, left)
            end
            --Now let's check the pressure, if pressure is larger then 1 then we need some more power to keep the climate_controls environment stable. We don\' want any leaks do we?
            if pressure > 1 then
                self:ConsumeResource("energy", (pressure - 1) * math.ceil(self.sbenvironment.size / self.maxsize) * 2 * math.ceil(self.maxsize / 1024))
            end
            if temperature < self.sbenvironment.temperature then
                local dif = self.sbenvironment.temperature - temperature
                dif = math.ceil(dif / 100) --Change temperature depending on the outside temperature, 5� difference does a lot less then 10000� difference
                self.sbenvironment.temperature = self.sbenvironment.temperature - dif
            elseif temperature > self.sbenvironment.temperature then
                local dif = temperature - self.sbenvironment.temperature
                dif = math.ceil(dif / 100)
                self.sbenvironment.temperature = self.sbenvironment.temperature + dif
            end
            --Msg("Temperature: "..tostring(self.sbenvironment.temperature).."\n")
            if self.sbenvironment.temperature < 283 then
                --Msg("Heating up?\n")
                if self.sbenvironment.temperature + 60 <= 308 then
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 24 * math.ceil(self.maxsize / 1024))
                    self.energy = self:GetResourceAmount("energy")
                    if self.energy > math.ceil(self.sbenvironment.size / self.maxsize) * 60 * math.ceil(self.maxsize / 1024) then
                        --Msg("Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + 60
                        self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 60 * math.ceil(self.maxsize / 1024))
                    else
                        --Msg("not Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + math.ceil((self.energy / math.ceil(self.sbenvironment.size / self.maxsize) * 60 * math.ceil(self.maxsize / 1024)) * 60)
                        self:ConsumeResource("energy", self.energy)
                    end
                elseif self.sbenvironment.temperature + 30 <= 308 then
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 12 * math.ceil(self.maxsize / 1024))
                    self.energy = self:GetResourceAmount("energy")
                    if self.energy > math.ceil(self.sbenvironment.size / self.maxsize) * 30 * math.ceil(self.maxsize / 1024) then
                        --Msg("Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + 30
                        self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 30 * math.ceil(self.maxsize / 1024))
                    else
                        --Msg("not Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + math.ceil((self.energy / math.ceil(self.sbenvironment.size / self.maxsize) * 30 * math.ceil(self.maxsize / 1024)) * 30)
                        self:ConsumeResource("energy", self.energy)
                    end
                elseif self.sbenvironment.temperature + 15 <= 308 then
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 6 * math.ceil(self.maxsize / 1024))
                    self.energy = self:GetResourceAmount("energy")
                    if self.energy > math.ceil(self.sbenvironment.size / self.maxsize) * 15 * math.ceil(self.maxsize / 1024) then
                        --Msg("Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + 15
                        self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 15 * math.ceil(self.maxsize / 1024))
                    else
                        --Msg("not Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + math.ceil((self.energy / math.ceil(self.sbenvironment.size / self.maxsize) * 15 * math.ceil(self.maxsize / 1024)) * 15)
                        self:ConsumeResource("energy", self.energy)
                    end
                else
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 2 * math.ceil(self.maxsize / 1024))
                    self.energy = self:GetResourceAmount("energy")
                    if self.energy > math.ceil(self.sbenvironment.size / self.maxsize) * 5 * math.ceil(self.maxsize / 1024) then
                        --Msg("Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + 5
                        self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 5 * math.ceil(self.maxsize / 1024))
                    else
                        --Msg("not Enough energy\n")
                        self.sbenvironment.temperature = self.sbenvironment.temperature + math.ceil((self.energy / math.ceil(self.sbenvironment.size / self.maxsize) * 5 * math.ceil(self.maxsize / 1024)) * 5)
                        self:ConsumeResource("energy", self.energy)
                    end
                end
            elseif self.sbenvironment.temperature > 308 then
                if self.sbenvironment.temperature - 60 >= 283 then
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 24 * math.ceil(self.maxsize / 1024))
                    if self.coolant2 > math.ceil(self.sbenvironment.size / self.maxsize) * 12 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 60
                        self:ConsumeResource("nitrogen", math.ceil(self.sbenvironment.size / self.maxsize) * 12 * math.ceil(self.maxsize / 1024))
                    elseif self.coolant > math.ceil(self.sbenvironment.size / self.maxsize) * 60 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 60
                        self:ConsumeResource("water", math.ceil(self.sbenvironment.size / self.maxsize) * 60 * math.ceil(self.maxsize / 1024))
                    else
                        if self.coolant2 > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant2 / math.ceil(self.sbenvironment.size / self.maxsize) * 12 * math.ceil(self.maxsize / 1024)) * 60)
                            self:ConsumeResource("nitrogen", self.coolant2)
                        elseif self.coolant > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant / math.ceil(self.sbenvironment.size / self.maxsize) * 60 * math.ceil(self.maxsize / 1024)) * 60)
                            self:ConsumeResource("water", self.coolant)
                        end
                    end
                elseif self.sbenvironment.temperature - 30 >= 283 then
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 12 * math.ceil(self.maxsize / 1024))
                    if self.coolant2 > math.ceil(self.sbenvironment.size / self.maxsize) * 6 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 30
                        self:ConsumeResource("nitrogen", math.ceil(self.sbenvironment.size / self.maxsize) * 6 * math.ceil(self.maxsize / 1024))
                    elseif self.coolant > math.ceil(self.sbenvironment.size / self.maxsize) * 30 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 30
                        self:ConsumeResource("water", math.ceil(self.sbenvironment.size / self.maxsize) * 30 * math.ceil(self.maxsize / 1024))
                    else
                        if self.coolant2 > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant2 / math.ceil(self.sbenvironment.size / self.maxsize) * 6 * math.ceil(self.maxsize / 1024)) * 30)
                            self:ConsumeResource("nitrogen", self.coolant2)
                        elseif self.coolant > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant / math.ceil(self.sbenvironment.size / self.maxsize) * 30 * math.ceil(self.maxsize / 1024)) * 30)
                            self:ConsumeResource("water", self.coolant)
                        end
                    end
                elseif self.sbenvironment.temperature - 15 >= 283 then
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 6 * math.ceil(self.maxsize / 1024))
                    if self.coolant2 > math.ceil(self.sbenvironment.size / self.maxsize) * 3 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 15
                        self:ConsumeResource("nitrogen", math.ceil(self.sbenvironment.size / self.maxsize) * 3 * math.ceil(self.maxsize / 1024))
                    elseif self.coolant > math.ceil(self.sbenvironment.size / self.maxsize) * 15 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 15
                        self:ConsumeResource("water", math.ceil(self.sbenvironment.size / self.maxsize) * 15 * math.ceil(self.maxsize / 1024))
                    else
                        if self.coolant2 > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant2 / math.ceil(self.sbenvironment.size / self.maxsize) * 3 * math.ceil(self.maxsize / 1024)) * 15)
                            self:ConsumeResource("nitrogen", self.coolant2)
                        elseif self.coolant > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant / math.ceil(self.sbenvironment.size / self.maxsize) * 15 * math.ceil(self.maxsize / 1024)) * 15)
                            self:ConsumeResource("water", self.coolant)
                        end
                    end
                else
                    self:ConsumeResource("energy", math.ceil(self.sbenvironment.size / self.maxsize) * 2 * math.ceil(self.maxsize / 1024))
                    if self.coolant2 > math.ceil(self.sbenvironment.size / self.maxsize) * 1 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 5
                        self:ConsumeResource("nitrogen", math.ceil(self.sbenvironment.size / self.maxsize) * 1 * math.ceil(self.maxsize / 1024))
                    elseif self.coolant > math.ceil(self.sbenvironment.size / self.maxsize) * 5 * math.ceil(self.maxsize / 1024) then
                        self.sbenvironment.temperature = self.sbenvironment.temperature - 5
                        self:ConsumeResource("water", math.ceil(self.sbenvironment.size / self.maxsize) * 5 * math.ceil(self.maxsize / 1024))
                    else
                        if self.coolant2 > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant2 / math.ceil(self.sbenvironment.size / self.maxsize) * 1 * math.ceil(self.maxsize / 1024)) * 5)
                            self:ConsumeResource("nitrogen", self.coolant2)
                        elseif self.coolant > 0 then
                            self.sbenvironment.temperature = self.sbenvironment.temperature - math.ceil((self.coolant / math.ceil(self.sbenvironment.size / self.maxsize) * 5 * math.ceil(self.maxsize / 1024)) * 5)
                            self:ConsumeResource("water", self.coolant)
                        end
                    end
                end
            end
        end
    end
    if not (WireAddon == nil) then
        Wire_TriggerOutput(self, "Oxygen-Level", tonumber(self:GetO2Percentage()))
        Wire_TriggerOutput(self, "Temperature", tonumber(self.sbenvironment.temperature))
        Wire_TriggerOutput(self, "Gravity", tonumber(self.sbenvironment.gravity))
    end
end

function ENT:Think()
    self.BaseClass.Think(self)
    self:Climate_Control()
    self:NextThink(CurTime() + 1)
    return true
end


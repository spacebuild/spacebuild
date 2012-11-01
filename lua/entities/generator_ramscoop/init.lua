AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.Active = 0
    self.damaged = 0
    self.sequence = -1
    self.thinkcount = 0
    self.NscoopSpeed = 0
    if not (WireAddon == nil) then
        self.WireDebugName = self.PrintName
        self.Outputs = Wire_CreateOutputs(self, { "Out" })
    end
    self.caf.custom.resource = "hydrogen"
end

function ENT:TurnOn()
    if (self.Active == 0) then
        self.Active = 1
        self:SetOOO(1)
    end
end

function ENT:TurnOff()
    if (self.Active == 1) then
        self.Active = 0
        self:SetOOO(0)
        if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", 0) end
    end
end

function ENT:SetActive() --disable use, lol
end

function ENT:Damage()
    if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:Repair()
    self.BaseClass.Repair(self)
    self:SetColor(Color(255, 255, 255, 255))
    self.damaged = 0
end

function ENT:Destruct()
    if CAF and CAF.GetAddon("Life Support") then
        CAF.GetAddon("Life Support").Destruct(self, true)
    end
end

function ENT:Extract_Energy()
    local inc = 0
    if (self.damaged == 0) then
        if self.NscoopSpeed > 1 then
            inc = math.Round(math.Clamp(self.NscoopSpeed * 0.1, 1, 200))
        else
            inc = 1
        end
        self:SupplyResource(self.caf.custom.resource, inc)
    end
    if not (WireAddon == nil) then Wire_TriggerOutput(self, "Out", inc) end
end

function ENT:GenEnergy()
    local waterlevel = 0
    if CAF then
        waterlevel = self:WaterLevel2()
    else
        waterlevel = self:WaterLevel()
    end
    if (waterlevel > 1) then
        self:TurnOff()
        self:Destruct()
    else
        self:Extract_Energy()
    end
end

function ENT:Think()
    self.BaseClass.Think(self)
    self.thinkcount = self.thinkcount + 1
    if self.thinkcount == 10 then
        local SB = CAF.GetAddon("Spacebuild")
        if SB and SB.GetStatus() then
            if self.environment then
                local planet = self.environment:IsOnPlanet()
                if not (planet) then
                    self:TurnOn()
                else
                    self:TurnOff()
                end
            end
        else
            self:TurnOff()
        end
        if (self.Active == 1) then
            self:GenEnergy()
        end
        self.thinkcount = 0
    end
    if self:GetParent():IsValid() then --Determines whether to get local velocity from the Gyropod, or the entity it is parented to, if it exists
        local par = self:GetParent()
        local parpos = par:GetPos()
        local parvel = par:GetVelocity()
        local speed = par:WorldToLocal(parpos + parvel):Length()
        local phys = par:GetPhysicsObject()
        local angvel = phys:GetAngleVelocity()
        local angspeed = angvel:Length()
        if angspeed > speed then
            self.NscoopSpeed = angspeed
        else
            self.NscoopSpeed = speed
        end
    else
        local ent = self
        local entpos = ent:GetPos()
        local entvel = ent:GetVelocity()
        local speed = ent:WorldToLocal(entpos + entvel):Length()
        local phys = ent:GetPhysicsObject()
        local angvel = phys:GetAngleVelocity()
        local angspeed = angvel:Length()
        if angspeed > speed then
            self.NscoopSpeed = angspeed
        else
            self.NscoopSpeed = speed
        end
    end
    self:NextThink(CurTime() + 0.1)
    return true
end

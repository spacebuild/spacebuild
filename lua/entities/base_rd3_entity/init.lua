AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local SB = SPACEBUILD

function ENT:Initialize()
    --self.BaseClass.Initialize(self) --use this in all ents
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetNetworkedInt("overlaymode", 1)
    self:SetNetworkedInt("OOO", 0)
    self.Active = 0
    -- TODO remove this custom stuff
    self.caf = {}
    self.caf.custom = {}
end

--use this to set self.active
--put a self:TurnOn and self:TurnOff() in your ent
--give value as nil to toggle
--override to do overdrive
--AcceptInput (use action) calls this function with value = nil
function ENT:SetActive(value, caller)
    if ((not (value == nil) and value ~= 0) or (value == nil)) and self.Active == 0 then
        if self.TurnOn then self:TurnOn(nil, caller) end
    elseif ((not (value == nil) and value == 0) or (value == nil)) and self.Active == 1 then
        if self.TurnOff then self:TurnOff(nil, caller) end
    end
end

function ENT:SetOOO(value)
    self:SetNetworkedInt("OOO", value)
end

AccessorFunc(ENT, "LSMULTIPLIER", "Multiplier", FORCE_NUMBER)
function ENT:GetMultiplier()
    return self.LSMULTIPLIER or 1
end

function ENT:Repair()
    self:SetHealth(self:GetMaxHealth())
end

--[[
function ENT:AcceptInput(name,activator,caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		self:SetActive( nil, caller )
	end
end
]]
--Considering I don't want to break RD until it's working, I'll work inside commented code...for now.

function ENT:AcceptInput(name, activator, caller)
    if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
        if self.Inputs and caller.useaction and caller.useaction == true then
            local maxz = table.Count(self.Inputs)
            local last = false
            local num = 1
            for k, v in pairs(self.Inputs) do
                if num >= maxz then last = true end
                umsg.Start("RD_AddInputToMenu", caller)
                umsg.Bool(last)
                umsg.String(v.Name)
                umsg.Short(self:EntIndex())
                umsg.End()
                num = num + 1
            end
        else
            self:SetActive(nil, caller)
        end
    end
end



function ENT:OnTakeDamage(DmgInfo) --should make the damage go to the shield if the shield is installed(CDS)
    if CAF and CAF.GetAddon("Life Support") then
        CAF.GetAddon("Life Support").DamageLS(self, DmgInfo:GetDamage())
    end
end

function ENT:OnRemove()
    --self.BaseClass.OnRemove(self) --use this if you have to use OnRemove
    self.rdobject:unlink()
    SB:removeDevice(self)

    if WireLib then WireLib.Remove(self) end
    if self.InputsBeingTriggered then
        for k, v in pairs(self.InputsBeingTriggered) do
            hook.Remove("Think", "ButtonHoldThinkNumber" .. v.hooknum)
        end
    end
end


--NEW Functions 
function ENT:RegisterNonStorageDevice()
    SB:registerDevice(self, SB.RDTYPES.GENERATOR)
end

function ENT:AddResource(resource, maxamount, defaultvalue)
    self.rdobject:addResource(resource, maxamount, defaultvalue)
end

function ENT:ConsumeResource(resource, amount)
    self.rdobject:consumeResource(resource, amount)
end

function ENT:SupplyResource(resource, amount)
    self.rdobject:supplyResource(resource, amount)
end

function ENT:Link(netid)
    local network = SB:getDeviceInfo(netid)
    network:link(self)
end

function ENT:Unlink()
    self.rdobject:unlink()
end

--END NEW Functions

function ENT:OnRestore()
    --self.BaseClass.OnRestore(self) --use this if you have to use OnRestore
    if WireLib then WireLib.Restored(self) end
end

function ENT:PreEntityCopy()
    --self.BaseClass.PreEntityCopy(self) --use this if you have to use PreEntityCopy
    SB:buildDupeInfo(self)
    if WireLib then
        local DupeInfo = WireLib.BuildDupeInfo(self)
        if DupeInfo then
            duplicator.StoreEntityModifier(self, "WireDupeInfo", DupeInfo)
        end
    end
end

function ENT:PostEntityPaste(Player, Ent, CreatedEntities)
    --self.BaseClass.PostEntityPaste(self, Player, Ent, CreatedEntities ) --use this if you have to use PostEntityPaste
    SB:applyDupeInfo(Ent, CreatedEntities)
    if WireLib and (Ent.EntityMods) and (Ent.EntityMods.WireDupeInfo) then
        WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
    end
end

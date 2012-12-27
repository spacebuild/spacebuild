AddCSLuaFile( )

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "Base Resource Entity"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= false
ENT.AdminOnly 		= false

function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.STORAGE)
end


function ENT:OnRemove()
    sb.removeDevice(self)
end

if ( CLIENT ) then

    function ENT:BeingLookedAtByLocalPlayer()

        if ( LocalPlayer():GetEyeTrace().Entity ~= self ) then return false end
        if ( EyePos():Distance( self:GetPos() ) > 256 ) then return false end

        return true

    end

    function ENT:Draw()
        if self:BeingLookedAtByLocalPlayer() and self.rdobject then
            local resources = self.rdobject:getResources()
            local full_string = self.PrintName .. "\nResources:\n"
            for _, v in pairs(resources) do
                full_string = full_string ..v:getName().." = "..tostring(self.rdobject:getResourceAmount(v:getName())).."/"..tostring(self.rdobject:getMaxResourceAmount( v:getName())).."\n"
            end
            AddWorldTip(self:EntIndex(), full_string, 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end

end

function ENT:RegisterNonStorageDevice()
    return nil
end

function ENT:AddResource(resource, maxamount, defaultvalue)
    return self.rdobject:addResource(resource, maxamount, defaultvalue)
end

function ENT:ConsumeResource(resource, amount)
    return self.rdobject:consumeResource(resource, amount)
end

function ENT:SupplyResource(resource, amount)
    return self.rdobject:supplyResource(resource, amount)
end

function ENT:GetResourceAmount(resource)
    return self.rdobject:getResourceAmount(resource)
end

function ENT:GetUnitCapacity(resource)
    return self.rdobject:getUnitCapacity()
end

function ENT:GetNetworkCapacity(resource)
    return self.rdobject:getNetworkCapacity()
end

function ENT:GetEntityTable()
    return self.rdobject
end

if SERVER then

    function ENT:OnRestore()
        MsgN("Entity restore")
        self.rdobject:onRestore(self)
    end

    function ENT:PreEntityCopy()
        self.rdobject:buildDupeInfo(self)
    end

    function ENT:PostEntityPaste(Player, Ent, CreatedEntities)
        self.rdobject:applyDupeInfo(self, Ent, CreatedEntities)
    end

end



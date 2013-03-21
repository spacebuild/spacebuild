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
                full_string = full_string ..v:getDisplayName()..": "..tostring(self.rdobject:getResourceAmount(v:getName())).."/"..tostring(self.rdobject:getMaxResourceAmount( v:getName())).."\n"
            end
            AddWorldTip(self:EntIndex(), full_string, 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end

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


function ENT:GetMaxResourceAmount(resource)
   return self.rdobject:getMaxResourceAmount(resource)
end

function ENT:OnRestore()
    self.oldrdobject = self.rdobject
    self:Initialize()
    self.rdobject:onRestore(self)
end

if SERVER then

    local RD_TABLE = "SB4_RESOURCE_INFO"


    function ENT:PreEntityCopy()
        duplicator.StoreEntityModifier( self, RD_TABLE, self.rdobject:onSave())
    end

    function ENT:PostEntityPaste(Player, Ent, CreatedEntities)
        if self.EntityMods and self.EntityMods[RD_TABLE] then
            self.rdobject:applyDupeInfo(self.EntityMods[RD_TABLE], self, CreatedEntities)
            self.EntityMods[RD_TABLE] = nil -- Remove the data
        end
    end

end



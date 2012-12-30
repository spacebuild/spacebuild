AddCSLuaFile( )

DEFINE_BASECLASS( "base_resource_entity" )

ENT.PrintName		= "Base Resource Generator"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= false
ENT.AdminOnly 		= false


function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.GENERATOR)
end

if ( CLIENT ) then
    function ENT:Draw()
        if self:BeingLookedAtByLocalPlayer() and self.rdobject then
            local resources = self.rdobject:getResources()
            local full_string = self.PrintName .. "\nResources:\n"
            for _, v in pairs(resources) do
                full_string = full_string ..v:getDisplayName() --[[.." = "..tostring(self.rdobject:getResourceAmount(v:getName())).."/"..tostring(self.rdobject:getMaxResourceAmount( v:getName()))]].."\n"
            end
            AddWorldTip(self:EntIndex(), full_string, 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end
end

function ENT:turnOn(newself)
    self = newself or self
    if not self.active then
        self.active = true
    end
end

function ENT:turnOff(newself)
    self = newself or self
    if self.active then
        self.active = false
    end
end

function ENT:toggle(newself)
    newself = newself or self
    self.active = not self.active

    if self.active then
        self:turnOn()
    else
        self:turnOff()
    end

end

function ENT:OnRestore()
    self.oldrdobject = self.rdobject
    sb.registerDevice(self, sb.RDTYPES.GENERATOR)
    self.rdobject:onRestore(self)
end
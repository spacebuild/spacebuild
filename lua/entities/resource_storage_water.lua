AddCSLuaFile( )

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "Water Storage"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= true
ENT.AdminOnly 		= false

function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.GENERATOR)
    if SERVER then
        self:SetModel("models/hunter/blocks/cube1x1x1.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        -- Wake the physics object up. It's time to have fun!
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
        end
        self.rdobject:addResource("water", 500, 0)
        --self:PhysWake()
    end
end

function ENT:SpawnFunction(ply, tr)
    if (not tr.HitWorld) then return end

    local ent = ents.Create("resource_storage_water")
    ent:SetPos(tr.HitPos + Vector(0, 0, 50))
    ent:Spawn()

    return ent
end


function ENT:OnRemove()
    sb.removeDevice(self)
end


if SERVER then

    function ENT:Think()

    end

end

if ( CLIENT ) then

    function ENT:BeingLookedAtByLocalPlayer()

        if ( LocalPlayer():GetEyeTrace().Entity ~= self ) then return false end
        if ( EyePos():Distance( self:GetPos() ) > 256 ) then return false end

        return true

    end

    function ENT:Draw()
        if self:BeingLookedAtByLocalPlayer() and self.rdobject then
            AddWorldTip(self:EntIndex(), "Water storage "..tostring(self.rdobject:getResourceAmount("water")), 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end

end



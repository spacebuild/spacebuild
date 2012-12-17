AddCSLuaFile( )

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "Resource Network"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= true
ENT.AdminOnly 		= false

function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.NETWORK)
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
    end
end

function ENT:SpawnFunction(ply, tr)
    if (not tr.HitWorld) then return end

    local ent = ents.Create("resource_network")
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
            local resources = self.rdobject:getResources()
            local res = "";
            for _, v in pairs(resources) do
               res = res ..v:getName().." = "..tostring(v:getAmount()).." "
            end
            AddWorldTip(self:EntIndex(), "Resource network "..res, 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end

end



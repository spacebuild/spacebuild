AddCSLuaFile( )

ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.PrintName		= "Oxygen Generator"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= true
ENT.AdminOnly 		= false

function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.GENERATOR)
    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetModel("models/hunter/blocks/cube1x1x1.mdl")
        self.rdobject:addResource("oxygen", sb.core.net.TYPES_INT.INT.max - 1, 0)
        --self:PhysWake()
    end
end

function ENT:SpawnFunction(ply, tr)
    if (not tr.HitWorld) then return end

    local ent = ents.Create("resource_generator_oxygen")
    ent:SetPos(tr.HitPos + Vector(0, 0, 50))
    ent:Spawn()

    return ent
end


function ENT:OnRemove()
    sb.removeDevice(self)
end


if SERVER then

    function ENT:Think()
       self.rdobject:supplyResource("oxygen", 10);
    end

end

if ( CLIENT ) then

    function ENT:Draw()
        if self.rdobject and self.rdobject:getResource("oxygen") then
            AddWorldTip(self:EntIndex(), "Oxygen Generator "..tostring(self.rdobject:getResource("oxygen"):getAmount()), 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end

end



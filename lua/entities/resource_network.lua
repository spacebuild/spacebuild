AddCSLuaFile( )

DEFINE_BASECLASS( "base_resource_network" )

ENT.PrintName		= "Resource Network"
ENT.Author			= "SnakeSVx & Radon"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= true
ENT.AdminOnly 		= false

function ENT:Initialize()
    BaseClass.Initialize(self)
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

if SERVER then

    function ENT:updateConnections(c)

        local self = c or self
        self:EmitSound( Sound( "/common/warning.wav" ) )
        self._synctimestamp = CurTime()
        self.constraints = constraint.GetAllConstrainedEntities( self )

        for k, v in pairs(self.constraints or {}) do
            if v.rdobject and v.rdobject:canLink(self.rdobject) then
                v.rdobject:link(self.rdobject)
            end
        end

    end


    function ENT:Use()

        if self.active ~= 1 then
            self.active = 1
            MsgN("Activated Node")
            self:updateConnections()
        end

    end



    function ENT:Think()

        --Not using NextThink as some more resource processing may need to be done every Think
        if self.active and (CurTime() > self._synctimestamp + 3) then
            self:updateConnections()
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



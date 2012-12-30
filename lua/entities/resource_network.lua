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
        self:SetModel("models/blackfire/sb4test/screen.mdl")--"models/hunter/blocks/cube1x1x1.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self.Entity:SetUseType(SIMPLE_USE)

        -- Wake the physics object up. It's time to have fun!
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
        end
    end
    if CLIENT then
        local cam = cam
        local surface = surface
        local pos = self:GetPos()
        local angle = self:GetAngles()
        local textStartPos = -12
        cam.Start3D2D(pos,angle,0.05)
            surface.SetDrawColor(0,0,0,255)
            surface.DrawRect( textStartPos, 0, 1250, 675 )

            surface.SetDrawColor(155,155,155,255)
            surface.DrawRect( textStartPos, 0, -5, 675 )
            surface.DrawRect( textStartPos, 0, 1250, -5 )
            surface.DrawRect( textStartPos, 675, 1250, -5 )
            surface.DrawRect( textStartPos+1250, 0, 5, 675 )
        --Stop rendering
        cam.End3D2D()
    end
end

if SERVER then

    function ENT:updateConnections(c)

        local self = c or self
        self:EmitSound( Sound( "/common/warning.wav" ) )
        self._synctimestamp = CurTime()
        self.constraints = constraint.GetAllConstrainedEntities( self )

        for k, v in pairs(self.constraints or {}) do
            if v ~= self and sb.isValidRDEntity(v) and v.rdobject:canLink(self.rdobject) and v.rdobject.network ~= self.rdobject then
                v.rdobject:link(self.rdobject)
            end
        end

    end

    function ENT:Use()

        if not self.active then
            self.active = true
            self:updateConnections()
        end

    end



    function ENT:Think()

        --Not using NextThink as some more resource processing may need to be done every Think
        if self.active and (CurTime() > self._synctimestamp + 5) then  --sync every 5 seconds ish
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



AddCSLuaFile( )

DEFINE_BASECLASS( "base_resource_network" )

ENT.PrintName		= "Resource Network"
ENT.Author			= "SnakeSVx & Radon"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= true
ENT.AdminOnly 		= false

function ENT:Draw()

	self:DrawModel()
	local Vector = Vector
	local cam = cam
	local surface = surface
	local pos = self:LocalToWorld(Vector(-7.120728,4.200194,-1.212406))
	--DebugMessage(tostring(pos))
	local angle = self:GetAngles()
	cam.Start3D2D(pos,angle,0.05) -- Fiddle with 1 quite a bit
		--Draw the baseframe:
		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect( 0, 0, 285, 167 )  -- 167 seems to be the apprioximate height of the ipad at its current stage of dev


		--Sample Text
		surface.SetDrawColor(155,155,155,255)
		surface.SetFont("DermaDefault") --For custom fonts: http://wiki.garrysmod.com/page/Talk:Libraries/surface/SetFont and surface.CreateFont (see wikik or sb4_ls_spawner
		surface.SetTextPos( 100, 100 ) -- As the func name. Set's the pos for all DrawTexts coming up:
	    surface.SetTextColor( Color(255,0,0) )
		surface.DrawText( "IT\"S GERRY!" )    --For some reason this doesn't work. I think it's a size iissue and creating a custom font for a sample code seems pointless.

		--Enjoy the surface library Radon!

	      --[[
	    surface.DrawRect( textStartPos, 0, 1250, -5 )
		surface.DrawRect( textStartPos, 675, 1250, -5 )
		surface.DrawRect( textStartPos+1250, 0, 5, 675 )  ]]--
	--Stop rendering
	cam.End3D2D()



end


function ENT:Initialize()
    BaseClass.Initialize(self)
	if SERVER then
        self:SetModel("models/blackfire/sb4test/screen.mdl") --Only have to set it serverside
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



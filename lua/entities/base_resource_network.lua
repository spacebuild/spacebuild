AddCSLuaFile( )

DEFINE_BASECLASS( "base_resource_entity" )

ENT.PrintName		= "Base Resource Network"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= false
ENT.AdminOnly 		= false



function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.NETWORK)
    if SERVER then
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

function ENT:OnRestore()
    self.oldrdobject = self.rdobject
    sb.registerDevice(self, sb.RDTYPES.NETWORK)
    self.rdobject:onRestore(self)
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

if CLIENT then
    local pcall = pcall
    local tostring = tostring
    local surface = surface
    local cam = cam
    local Vector = Vector
    local colors = sb.core.const.colors
    local function drawText(text, x, y, color)
        if not color then color = colors.white end
        surface.SetTextPos( x, y ) -- As the func name. Set's the pos for all DrawTexts coming up:
        surface.SetTextColor( color )
        surface.DrawText( text )    --For some reason this doesn't work. I think it's a size iissue and creating a custom font for a sample code seems pointless.
    end


    function ENT:Draw()
        --[[
           Rectangle size: 650 * 350 (scale = 0.1)
           Screen (small) size: 65 * 35 (Vector(-32.5,17.5,5.16))
           Amount of columns (100 units width): 6
           Amount of rows (20 units height): 17 (7 for info, 10 for resources)
                               for c = 1, 6 do
                        surface.SetTextPos( 5 + ((c - 1) * 100), 5 + ((r - 1) * 20) ) -- As the func name. Set's the pos for all DrawTexts coming up:
                        surface.SetTextColor( Color(255,0,0) )
                        surface.DrawText( tostring(c)..","..tostring(r) )    --For some reason this doesn't work. I think it's a size iissue and creating a custom font for a sample code seems pointless.
                    end
         ]]

        self:DrawModel()
        if self.hud then
            local pos = self:LocalToWorld(self.hud.vector)
            local angle = self:GetAngles()
            cam.Start3D2D(pos,angle,self.hud.scale) -- Fiddle with 1 quite a bit
            pcall(function()
            --Draw the baseframe:
                surface.SetDrawColor(0,0,0,255)
                surface.DrawRect( 0, 0, 650, 350 )  -- 167 seems to be the apprioximate height of the ipad at its current stage of dev

                surface.SetDrawColor(155,155,155,255)
                surface.SetFont("DermaDefault") --For custom fonts: http://wiki.garrysmod.com/page/Talk:Libraries/surface/SetFont and surface.CreateFont (see wikik or sb4_ls_spawner

                -- Draw Title
                drawText("Resource Node "..tostring(self:EntIndex()), 5, 5)

                -- connected networks
                drawText("Connected to ", 5, 20)
                local str = "";
                for k, v in pairs(self.rdobject:getConnectedNetworks()) do
                    str  = str ..tostring(k).." "
                end
                drawText(str, 105, 20)

                -- resources
                drawText("Resource name", 5, 35)
                drawText("Amount", 205, 35)
                drawText("Max Amount", 330, 35)
                drawText("Note", 460, 35)
                local y, value, maxvalue = 35
                for k, v in pairs(self.rdobject:getResources()) do
                    y = y + 15
                    value = self.rdobject:getResourceAmount(k)
                    maxvalue = self.rdobject:getMaxResourceAmount(k)
                    drawText(k, 5, y)
                    drawText(tostring(value), 205, y)
                    drawText(tostring(maxvalue), 330, y)
                    if (value / maxvalue) > 0.3 then
                        drawText("safe", 460, y, colors.green)
                    elseif (value/maxvalue) > 0.1 then
                        drawText("warning", 460, y, colors.orange)
                    else
                        drawText("low on resource", 460, y, colors.red)
                    end

                end
                --Stop rendering
            end)
            cam.End3D2D()
        end


    end

end
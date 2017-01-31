--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 31/01/2017
-- Time: 19:37
-- To change this template use File | Settings | File Templates.
--


TOOL.Category = "Test"
TOOL.Tab = "Spacebuild"
TOOL.Name = "SB4 Test"

cleanup.Register( "sbmodels" )

local SB = SPACEBUILD

local MakeThruster
if ( SERVER ) then

    MakeThruster = function( pl,  ang, pos, device )

        if ( IsValid( pl ) and not pl:CheckLimit( "sbmodels" ) ) then return false end


        local thruster = ents.Create( device.class )
        if not IsValid( thruster ) then return false end

        thruster:SetModel( device.model )
        thruster:SetAngles( ang )
        thruster:SetPos(pos)
        if device.skin then
            thruster:SetSkin(device.skin)
        end
        thruster:Spawn()

        device.spawnFunction(thruster)

        if ( IsValid( pl ) ) then
            pl:AddCount( "sbmodels", thruster )
            pl:AddCleanup( "sbmodels", thruster )
        end

        return thruster

    end

    --duplicator.RegisterEntityClass( "gmod_thruster", MakeThruster, "Model", "Ang", "Pos", "key", "key_bck", "force", "toggle", "effect", "damageable", "soundname", "nocollide" )

end

function TOOL:LeftClick( trace )

    if ( trace.Entity and trace.Entity:IsPlayer() ) then return false end

    -- If there's no physics object then we can't constraint it!
    if ( SERVER and not util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

    if ( CLIENT ) then return true end

    local ply = self:GetOwner()
    local device = self:GetClientInfo( "device" ):Split(":")
    local category =  device[1]
    local name = device[2]

    local dev = SB:getCategories()[category].devices[name]

    if not dev or not util.IsValidModel( dev.model ) or not util.IsValidProp( dev.model ) then return false end
    if ( not self:GetSWEP():CheckLimit( "sbmodels" ) ) then return false end

    local Ang = trace.HitNormal:Angle()
    Ang.pitch = Ang.pitch + 90

    local thruster = MakeThruster( ply, Ang, trace.HitPos, dev )

    local min = thruster:OBBMins()
    thruster:SetPos( trace.HitPos - trace.HitNormal * min.z )

    undo.Create( "sbmodels" )
    undo.AddEntity( thruster )

    -- Don't weld to world
    if ( IsValid( trace.Entity ) ) then

        local const = constraint.Weld( thruster, trace.Entity, 0, trace.PhysicsBone, 0, collision, true )

        -- Don't disable collision if it's not attached to anything
        if ( collision ) then

            if ( IsValid( thruster:GetPhysicsObject() ) ) then thruster:GetPhysicsObject():EnableCollisions( false ) end
            thruster.nocollide = true

        end

        undo.AddEntity( const )
        ply:AddCleanup( "sbmodels", const )

    end

    undo.SetPlayer( ply )
    undo.Finish()

    return true

end


function TOOL:UpdateGhostThruster( ent, ply, skin )

    if ( not IsValid( ent ) ) then return end

    if skin then
        ent:SetSkin(skin)
    end

    local trace = ply:GetEyeTrace()
    if ( not trace.Hit or trace.Entity and trace.Entity:IsPlayer() ) then

        ent:SetNoDraw( true )
        return

    end

    local ang = trace.HitNormal:Angle()
    ang.pitch = ang.pitch + 90

    local min = ent:OBBMins()
    ent:SetPos( trace.HitPos - trace.HitNormal * min.z )
    ent:SetAngles( ang )

    ent:SetNoDraw( false )

end

function TOOL:Think()
    local device = self:GetClientInfo( "device" ):Split(":")
    local category =  device[1]
    local name = device[2]

    local dev = SB:getCategories()[category].devices[name]
    if ( not dev) then self:ReleaseGhostEntity() return end

    if ( not IsValid( self.GhostEntity ) or self.GhostEntity:GetModel() ~= dev.model ) then
        self:MakeGhostEntity( dev.model, Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) )
    end

    self:UpdateGhostThruster( self.GhostEntity, self:GetOwner(), dev.skin )

end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

    CPanel:AddControl( "Header", { Description = "#tool.sb4_test.desc" } )

    CPanel:AddControl( "PropSelect", { Label = "Select entity", ConVar = "sb4_test_device", Height = 0, modelstable = list.Get( "sbmodels" ) } )

end

for k, cat in pairs(SB:getCategories()) do
    for l, dev in pairs(cat.devices) do
       if not TOOL.ClientConVar[ "device" ] then
           TOOL.ClientConVar[ "device" ] = cat.name..":"..dev.name
       end
        list.Set( "sbmodels", cat.name..":"..dev.name, {
            model = dev.model,
            skin = dev.skin,
            sb4_test_category = cat.name,
            sb4_test_name = dev.name
        })
    end
end
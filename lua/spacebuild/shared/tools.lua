--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 30/01/2017
-- Time: 19:55
-- To change this template use File | Settings | File Templates.
--

local devices, SB, defaultIcon, lang = {}, SPACEBUILD, "", SPACEBUILD.lang

function SB:getCategories()
    return devices
end

function SB:registerCategory(name, icon)
    if not name then error("name is required") end
    if devices[name:lower()] then error("category is already registered") end
    if not icon then icon = defaultIcon end
    devices[name:lower()] = {
        name = name,
        icon = icon,
        devices = {}
    }
end

function SB:registerDeviceInfo(category, name, class, model, spawnFunction, material, icon, skin)
    if not category then error("category is required") end
    if not devices[category:lower()] then error("category is not registered yet") end
    if not name then error("name is required") end
    if devices[category:lower()].devices[name:lower()] then error("name is already registered") end
    if not class then error("class is required") end
    if not model then error("model is required") end
    if not spawnFunction then error("spawnfunction is required") end
    if not skin then skin = 0 end
    if not icon then icon = defaultIcon end
    devices[category:lower()].devices[name:lower()] = {
        name        = name,
        icon        = icon,
        class       = class,
        model       = model,
        material    = material,
        spawnFunction = spawnFunction,
        skin = skin
    }
end

SB:registerCategory("Network")
SB:registerCategory("Storage")
SB:registerCategory("Generators")
SB:registerCategory("Environmental")

SB:registerDeviceInfo(
    "Storage",
    "Battery",
    "base_resource_entity",
    "models/props_phx/life_support/battery_small.mdl",
    function(ent)
        ent:addResource("energy", 500)
    end
)
SB:registerDeviceInfo(
    "Storage",
    "Water tank",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("water", 500)
    end,
    nil,
    nil,
    4
)
SB:registerDeviceInfo(
    "Storage",
    "Oxygen tank",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("oxygen", 500)
    end
)
SB:registerDeviceInfo(
    "Network",
    "Network",
    "base_resource_network",
    "models/SnakeSVx/small_res_node.mdl",
    function(ent)
        ent.range = 512
    end
)

local makeDevice = function(tool, pl, ang, pos, device)
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
        pl:AddCount( tool.device_category, thruster )
        pl:AddCleanup( tool.device_category, thruster )
    end

    return thruster
end

local leftClick = function(tool, trace)

    if ( trace.Entity and trace.Entity:IsPlayer() ) then return false end

    -- If there's no physics object then we can't constraint it!
    if ( SERVER and not util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

    if ( CLIENT ) then return true end

    local ply = tool:GetOwner()
    local name = tool:GetClientInfo( "device" )
    local category =  tool.device_category

    local dev = SB:getCategories()[category].devices[name]

    if not dev or not util.IsValidModel( dev.model ) or not util.IsValidProp( dev.model ) then return false end
    if ( not tool:GetSWEP():CheckLimit( category ) ) then return false end

    local Ang = trace.HitNormal:Angle()
    Ang.pitch = Ang.pitch + 90

    local thruster = makeDevice(tool, ply, Ang, trace.HitPos, dev )

    local min = thruster:OBBMins()
    thruster:SetPos( trace.HitPos - trace.HitNormal * min.z )

    undo.Create( category )
    undo.AddEntity( thruster )

    -- Don't weld to world
    if ( IsValid( trace.Entity ) ) then

        local const = constraint.Weld( thruster, trace.Entity, 0, trace.PhysicsBone, 0, collision, true )

        undo.AddEntity( const )
        ply:AddCleanup( category, const )

    end

    undo.SetPlayer( ply )
    undo.Finish()

    return true
end

local updateGhost = function(tool, ent, ply, skin )

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

local think = function(tool)
    local name = tool:GetClientInfo( "device" )
    local category =  tool.device_category

    local dev = SB:getCategories()[category].devices[name]
    if ( not dev) then tool:ReleaseGhostEntity() return end

    if ( not IsValid( tool.GhostEntity ) or tool.GhostEntity:GetModel() ~= dev.model ) then
        tool:MakeGhostEntity( dev.model, Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) )
    end

    updateGhost(tool, tool.GhostEntity, tool:GetOwner(), dev.skin )

end

local function buildCPanel( tool )
    return function(CPanel)
        CPanel:AddControl( "Header", { Description = "#tool.sb4_test.desc" } )

        CPanel:AddControl( "PropSelect", { Label = "Select entity", ConVar = tool.device_category.."_device", Height = 0, modelstable = tool.models } )
    end
end

function SB:loadTools()
    for k, cat in pairs(SB:getCategories()) do
        local TOOL	= ToolObj:Create()
        TOOL.Category = lang.get("tool.category.sb")
        TOOL.Tab = "Spacebuild"
        TOOL.Name = cat.name
        TOOL.Mode = k
        TOOL.device_category = k

        cleanup.Register( k )

        TOOL.LeftClick		= leftClick
        TOOL.UpdateGhost	= updateGhost
        TOOL.Think			= think
        TOOL.BuildCPanel    = buildCPanel(TOOL)

        TOOL.models = {}
        for l, dev in pairs(cat.devices) do
            if not TOOL.ClientConVar[ "device" ] then
                TOOL.ClientConVar[ "device" ] = k
            end
            TOOL.models[dev.name] = {
                model = dev.model,
                skin = dev.skin
            }
        end

        TOOL:CreateConVars()
        SWEP.Tool[ k ] = TOOL
    end
end





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

    local allowWorldWeld = tool:GetClientNumber('AllowWorldWeld') == 1
    local dontWeld = tool:GetClientNumber('DontWeld') == 1
    local frozen			= tool:GetClientNumber('Frozen') == 1 or (not allowWorldWeld and trace.Entity:IsWorld())

    local dev = SB:getCategories()[category].devices[name]

    if not dev or not util.IsValidModel( dev.model ) or not util.IsValidProp( dev.model ) then return false end
    if ( not tool:GetSWEP():CheckLimit( category ) ) then return false end

    local Ang = trace.HitNormal:Angle()
    Ang.pitch = Ang.pitch + 90

    local ent = makeDevice(tool, ply, Ang, trace.HitPos, dev )

    local min = ent:OBBMins()
    ent:SetPos( trace.HitPos - trace.HitNormal * min.z )

    undo.Create( category )
    undo.AddEntity(ent)

    -- Don't weld to world
    if not dontWeld and (IsValid( trace.Entity ) or allowWorldWeld) then

        local const = constraint.Weld( ent, trace.Entity, 0, trace.PhysicsBone, 0, true )

        undo.AddEntity( const )
        ply:AddCleanup( category, const )

    end

    undo.SetPlayer( ply )
    undo.Finish()

    if frozen and IsValid(ent:GetPhysicsObject()) then
        local Phys = ent:GetPhysicsObject()
        Phys:EnableMotion(false)
        ply:AddFrozenPhysicsObject(ent, Phys)
    end

    ply:AddCleanup(category, ent)

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

        CPanel:CheckBox("Don't Weld", tool.device_category.."_DontWeld" )
        CPanel:CheckBox("Allow welding to world", tool.device_category.."_AllowWorldWeld" )
        CPanel:CheckBox("Make Frozen", tool.device_category.."_Frozen" )

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

        TOOL.ClientConVar[ "DontWeld" ] = 0
        TOOL.ClientConVar[ "AllowWorldWeld" ] = 0
        TOOL.ClientConVar[ "Frozen" ] = 0

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

--[[
    Start registering default devices
 ]]


-- Register network devices
local category = "Network"
SB:registerCategory(category)

SB:registerDeviceInfo(
    category,
    "Small resource node",
    "base_resource_network",
    "models/SnakeSVx/small_res_node.mdl",
    function(ent)
        ent.range = 512
    end
)

-- Register storage devices
category = "Storage"
SB:registerCategory(category)
-- Energy
SB:registerDeviceInfo(
    category,
    "Small Battery",
    "base_resource_entity",
    "models/props_phx/life_support/battery_small.mdl",
    function(ent)
        ent:addResource("energy", 1500)
    end
)
SB:registerDeviceInfo(
    category,
    "Medium Battery",
    "base_resource_entity",
    "models/props_phx/life_support/battery_medium.mdl",
    function(ent)
        ent:addResource("energy", 9000)
    end
)
SB:registerDeviceInfo(
    category,
    "Large Battery",
    "base_resource_entity",
    "models/props_phx/life_support/battery_large.mdl",
    function(ent)
        ent:addResource("energy", 72000)
    end
)
-- Water
SB:registerDeviceInfo(
    category,
    "Small water canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("water", 3000)
    end,
    nil,
    nil,
    4
)
SB:registerDeviceInfo(
    category,
    "Medium water canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_medium.mdl",
    function(ent)
        ent:addResource("water", 6000)
    end,
    nil,
    nil,
    4
)
SB:registerDeviceInfo(
    category,
    "Large water canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_large.mdl",
    function(ent)
        ent:addResource("water", 10000)
    end,
    nil,
    nil,
    4
)
SB:registerDeviceInfo(
    category,
    "Small water tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_small.mdl",
    function(ent)
        ent:addResource("water", 4500)
    end,
    nil,
    nil,
    4
)
SB:registerDeviceInfo(
    category,
    "Medium water tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_medium.mdl",
    function(ent)
        ent:addResource("water", 9000)
    end,
    nil,
    nil,
    4
)
SB:registerDeviceInfo(
    category,
    "Large water tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_large.mdl",
    function(ent)
        ent:addResource("water", 18000)
    end,
    nil,
    nil,
    4
)


-- Oxygen
SB:registerDeviceInfo(
    category,
    "Small oxygen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("oxygen", 3000)
    end
)
SB:registerDeviceInfo(
    category,
    "Medium oxygen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_medium.mdl",
    function(ent)
        ent:addResource("oxygen", 6000)
    end
)
SB:registerDeviceInfo(
    category,
    "Large oxygen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_large.mdl",
    function(ent)
        ent:addResource("oxygen", 10000)
    end
)
SB:registerDeviceInfo(
    category,
    "Small oxygen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_small.mdl",
    function(ent)
        ent:addResource("oxygen", 4500)
    end
)
SB:registerDeviceInfo(
    category,
    "Medium oxygen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_medium.mdl",
    function(ent)
        ent:addResource("oxygen", 9000)
    end
)
SB:registerDeviceInfo(
    category,
    "Large oxygen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_large.mdl",
    function(ent)
        ent:addResource("oxygen", 18000)
    end
)

-- Nitrogen
SB:registerDeviceInfo(
    category,
    "Small nitrogen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("nitrogen", 3000)
    end,
    nil,
    nil,
    1
)
SB:registerDeviceInfo(
    category,
    "Medium nitrogen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_medium.mdl",
    function(ent)
        ent:addResource("nitrogen", 6000)
    end,
    nil,
    nil,
    1
)
SB:registerDeviceInfo(
    category,
    "Large nitrogen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_large.mdl",
    function(ent)
        ent:addResource("nitrogen", 10000)
    end,
    nil,
    nil,
    1
)
SB:registerDeviceInfo(
    category,
    "Small nitrogen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_small.mdl",
    function(ent)
        ent:addResource("nitrogen", 4500)
    end,
    nil,
    nil,
    1
)
SB:registerDeviceInfo(
    category,
    "Medium nitrogen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_medium.mdl",
    function(ent)
        ent:addResource("nitrogen", 9000)
    end,
    nil,
    nil,
    1
)
SB:registerDeviceInfo(
    category,
    "Large nitrogen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_large.mdl",
    function(ent)
        ent:addResource("nitrogen", 18000)
    end,
    nil,
    nil,
    1
)

-- Hydrogen
SB:registerDeviceInfo(
    category,
    "Small hydrogen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("hydrogen", 3000)
    end,
    nil,
    nil,
    2
)
SB:registerDeviceInfo(
    category,
    "Medium hydrogen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_medium.mdl",
    function(ent)
        ent:addResource("hydrogen", 6000)
    end,
    nil,
    nil,
    2
)
SB:registerDeviceInfo(
    category,
    "Large hydrogen canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_large.mdl",
    function(ent)
        ent:addResource("hydrogen", 10000)
    end,
    nil,
    nil,
    2
)
SB:registerDeviceInfo(
    category,
    "Small hydrogen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_small.mdl",
    function(ent)
        ent:addResource("hydrogen", 4500)
    end,
    nil,
    nil,
    2
)
SB:registerDeviceInfo(
    category,
    "Medium hydrogen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_medium.mdl",
    function(ent)
        ent:addResource("hydrogen", 9000)
    end,
    nil,
    nil,
    2
)
SB:registerDeviceInfo(
    category,
    "Large hydrogen tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_large.mdl",
    function(ent)
        ent:addResource("hydrogen", 18000)
    end,
    nil,
    nil,
    2
)

-- Carbon dioxide
SB:registerDeviceInfo(
    category,
    "Small carbon dioxide canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("carbon dioxide", 3000)
    end,
    nil,
    nil,
    3
)
SB:registerDeviceInfo(
    category,
    "Medium carbon dioxide canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_medium.mdl",
    function(ent)
        ent:addResource("carbon dioxide", 6000)
    end,
    nil,
    nil,
    3
)
SB:registerDeviceInfo(
    category,
    "Large carbon dioxide canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_large.mdl",
    function(ent)
        ent:addResource("carbon dioxide", 10000)
    end,
    nil,
    nil,
    3
)
SB:registerDeviceInfo(
    category,
    "Small carbon dioxide tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_small.mdl",
    function(ent)
        ent:addResource("carbon dioxide", 4500)
    end,
    nil,
    nil,
    3
)
SB:registerDeviceInfo(
    category,
    "Medium carbon dioxide tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_medium.mdl",
    function(ent)
        ent:addResource("carbon dioxide", 9000)
    end,
    nil,
    nil,
    3
)
SB:registerDeviceInfo(
    category,
    "Large carbon dioxide tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_large.mdl",
    function(ent)
        ent:addResource("carbon dioxide", 18000)
    end,
    nil,
    nil,
    3
)

-- Steam
SB:registerDeviceInfo(
    category,
    "Small steam canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("steam", 3000)
    end,
    nil,
    nil,
    5
)
SB:registerDeviceInfo(
    category,
    "Medium steam canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_medium.mdl",
    function(ent)
        ent:addResource("steam", 6000)
    end,
    nil,
    nil,
    5
)
SB:registerDeviceInfo(
    category,
    "Large steam canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_large.mdl",
    function(ent)
        ent:addResource("steam", 10000)
    end,
    nil,
    nil,
    5
)
SB:registerDeviceInfo(
    category,
    "Small steam tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_small.mdl",
    function(ent)
        ent:addResource("steam", 4500)
    end,
    nil,
    nil,
    5
)
SB:registerDeviceInfo(
    category,
    "Medium steam tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_medium.mdl",
    function(ent)
        ent:addResource("steam", 9000)
    end,
    nil,
    nil,
    5
)
SB:registerDeviceInfo(
    category,
    "Large steam tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_large.mdl",
    function(ent)
        ent:addResource("steam", 18000)
    end,
    nil,
    nil,
    5
)

-- Heavy water
SB:registerDeviceInfo(
    category,
    "Small heavy water canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_small.mdl",
    function(ent)
        ent:addResource("heavy water", 3000)
    end,
    nil,
    nil,
    6
)
SB:registerDeviceInfo(
    category,
    "Medium heavy water canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_medium.mdl",
    function(ent)
        ent:addResource("heavy water", 6000)
    end,
    nil,
    nil,
    6
)
SB:registerDeviceInfo(
    category,
    "Large heavy water canister",
    "base_resource_entity",
    "models/props_phx/life_support/canister_large.mdl",
    function(ent)
        ent:addResource("heavy water", 10000)
    end,
    nil,
    nil,
    6
)
SB:registerDeviceInfo(
    category,
    "Small heavy water tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_small.mdl",
    function(ent)
        ent:addResource("heavy water", 4500)
    end,
    nil,
    nil,
    6
)
SB:registerDeviceInfo(
    category,
    "Medium heavy water tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_medium.mdl",
    function(ent)
        ent:addResource("heavy water", 9000)
    end,
    nil,
    nil,
    6
)
SB:registerDeviceInfo(
    category,
    "Large heavy water tank",
    "base_resource_entity",
    "models/props_phx/life_support/tank_large.mdl",
    function(ent)
        ent:addResource("heavy water", 18000)
    end,
    nil,
    nil,
    6
)

-- Register generatorsw
category = "Generators"
SB:registerCategory(category)

-- Register environmental devices
category = "Environmental"
SB:registerCategory(category)




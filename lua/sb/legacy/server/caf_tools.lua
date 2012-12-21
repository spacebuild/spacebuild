AddCSLuaFile( "vgui/caf_gui.lua" )
AddCSLuaFile( "vgui/caf_gui_button.lua"	)

-- Global list of callbacks
CAF_CallbackFuncs = {}


--DO NOT register this function with the duplication, you MUST wrap this function in another one as to add CheckLimit (ther is a generic function to generate these functions below)
function CAF_MakeCAFEnt( ply, Ang, Pos, system_type, system_class, model, frozen )

    local ent = ents.Create( system_class )
    if not ent:IsValid() then return false end
    ent:SetModel( model )
    ent:SetAngles(Ang)
    ent:SetPos(Pos)
    ent:SetPlayer(ply)
    ent:Spawn() --run ENT:Initialize()

    local rtable, maxhealth, mass = {}, 0, 0

    local SupFunction = list.Get( "CAF_MakeCAFEnt" )[system_class] --supplement function
    if (SupFunction) then
        --[[		== read me ==
              This part allow 3rd party ents to use this function too
              Just make a function that takes (ply, ent, system_type, system_class, model) and returns an ent merge table, maxhealth and mass
              maxheath is only needed for lsents, set it >1 to use the DamageLS hook on the ent
              Your function just needs to do what's done in these ifs (RD_AddResource and/or LS_RegisterEnt)
              Register this function like this: list.Set( "LS_MakeRDEnt", system_class, Function )
              Example: this would do the air_compressor
              local function air_comp(ply, ent, system_class, model)
                  local rtable = {}
                  local maxhealth = 600
                  local mass = 5500 -- return 0 to not set
                  RD_AddResource(ent, "air", 0)
                  RD_AddResource(ent, "energy", 0)
                  return rtable, maxhealth, mass
              end
              list.Set( "CAF_MakeCAFEnt", "air_compressor", air_comp )
              ]]--

        --Msg("found MakeCAFEntSupFunction for "..system_class.."\n")
        local noerror, rt, mh, ma = pcall( SupFunction, ply, ent, system_type, system_class, model )
        if (not noerror) then
        CAF.WriteToDebugFile("caf_tool_error", "MakeCAFEntSupFunction errored: '"..tostring(rt).."'. Removing.\n")
        list.Get( "CAF_MakeCAFEnt" )[system_class] = nil --nuke that shit, someone fucked up
        else --saftey
            rtable = rt or {}
            maxhealth = mh or 0
            mass = ma or 0
        end
    end

    if (maxhealth > 0) then
        rtable.health = maxhealth
        rtable.maxhealth = maxhealth
    end

    --rtable[system_type] = system_class --this is silly, we don't have to do this, just use "Class" for that arg with the duplicator.
    table.Merge(ent:GetTable(), rtable )

    if (mass > 0) or (frozen) then
        local phys = ent:GetPhysicsObject()
        if (phys:IsValid()) then
            if (mass > 0) then
                phys:SetMass(mass)
                phys:Wake()
            end
            if (frozen) then
                phys:EnableMotion( false )
                ply:AddFrozenPhysicsObject( ent, phys )
            end
        end
    end

    return ent
end

function CAF_GenerateMakeFunction( ToolName )
    -- Check to see if we already have a generic function for this tool
    if (CAF_CallbackFuncs[ToolName]) then
        --Msg('Stool CallBack [Existing] -> '..ToolName..'\n')
        return CAF_CallbackFuncs[ToolName]
    end

    local MakeFunction = function( ply, Ang, Pos, type, model, Frozen )
        if not ply:CheckLimit( ToolName ) then return nil end
        local ent = CAF_MakeCAFEnt( ply, Ang, Pos, ToolName, type, model, frozen )
        if not (ent and ent:IsValid()) then return nil end
        ply:AddCount( ToolName, ent )
        return ent
    end

    CAF_CallbackFuncs[ToolName] = MakeFunction
    --Msg('\nStool CallBack  [Created] -> '..ToolName..'\n')

    return MakeFunction
end

function CAF_SetToolMakeFunc( ToolName, EntClass, EntMakeFunct )
    if not (ToolName and EntClass) then return end
    if (not EntMakeFunct) then
    EntMakeFunct = CAF_GenerateMakeFunction( ToolName ) -- Thats checks to see if a function already exists for this tool or it will make a new one
    duplicator.RegisterEntityClass( EntClass, EntMakeFunct, "Ang", "Pos", "Class", "model", "frozen" )
    else
        --Msg('Stool CallBack [Argument] -- '..EntClass..' -> '..tostring(EntMakeFunct)..'\n')
    end
    list.Set( ToolName.."_Funcs", EntClass, EntMakeFunct )
end

function CAF_AddMakeCAFEntSupFunction( EntClass, MakeCAFEntSupFunction )
    if not (EntClass and MakeCAFEntSupFunction) then return end
    --Msg('MakeCAFEntSupFunction set for - '..EntClass..' -\n')
    list.Set( "CAF_MakeCAFEnt", EntClass, MakeCAFEntSupFunction ) --tell CAF_MakeCAFEnt how to set up this ent
end

function CAF_ToolLeftClick( tool, trace, ToolName )

    local FuncListName = ToolName.."_Funcs"
    local ply = tool:GetOwner()
    local Pos = trace.HitPos
    local Ang = trace.HitNormal:Angle()
    Ang.pitch = Ang.pitch + 90
    local type			= tool:GetClientInfo('type')
    local model			= tool:GetClientInfo('model')
    local AllowWorldWeld		= tool:GetClientNumber('AllowWorldWeld') == 1
    local DontWeld			= tool:GetClientNumber('DontWeld') == 1
    local Frozen			= (tool:GetClientNumber('Frozen') == 1) or (AllowWorldWeld and not trace.Entity:IsValid())
    if (not type or type == '') then
    CAF.WriteToDebugFile("caf_tool_error", "CAF: GetClientInfo('type') is nil!\n")
    return false
    end
    local func = list.Get( FuncListName )[type]
    if (func == nil) then Error("CAF: Unable to find make function for '"..type.."'\n") end
    local ent = func( ply, Ang, Pos, type, model, Frozen)
    if (not ent) then return false end
    ent:SetPos( trace.HitPos - trace.HitNormal * ent:OBBMins().z)
    --CAF.OnEntitySpawn(ent , "SENT" , ply) --Calls the CAF SentSpawn Hook
    local const
    if (not DontWeld) and ( trace.Entity:IsValid() or AllowWorldWeld ) then
    local const = constraint.Weld(ent, trace.Entity,0, trace.PhysicsBone, 0, true ) --add true to turn DOR on
    end

    undo.Create( ToolName )
    undo.AddEntity( ent )
    undo.AddEntity( const )
    undo.SetPlayer( ply )
    undo.Finish()
    ply:AddCleanup( ToolName, ent )

    return true
end
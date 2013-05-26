include("caf/core/shared/caf_tools.lua")
CAFEnts = {}

function CAFEnts.MakeEnt(tool, ply, Ang, Pos, class, type, sub_type, model, frozen, Extra_Data, Data)

    --Admin Check
    if tool.AdminOnly and not ply:IsAdmin() then
        CAF.POPUP(ply, CAF.GetLangVar("caf_stool_admin_required"), "right", CAF.colors.red, 0.5);
        return false
    end


    --Enable Check
    if tool.EnableFunc then
        if not tool.EnableFunc(ply) then
            CAF.POPUP(ply, CAF.GetLangVar("caf_stool_disabled"), "right", CAF.colors.red, 0.5);
            return
        end
    end

    --Core Stuff
    if tool.Renamed then
        if class and tool.Renamed.class and tool.Renamed.class[class] then
            class = tool.Renamed.class[class]
        end
        if type and tool.Renamed.type and tool.Renamed.type[type] then
            type = tool.Renamed.type[type]
        end
        if sub_type and tool.Renamed.sub_type and tool.Renamed.sub_type[sub_type] then
            sub_type = tool.Renamed.sub_type[sub_type]
        end
    end

    type = type or class
    if not type or not (sub_type or model) then return false end

    local devinfo
    if not sub_type and tool.Devices[type] and tool.Devices[type].models and tool.Devices[type].models[model] then
        devinfo = tool.Devices[type].models[model]
        sub_type = devinfo.sub_type
    elseif tool.Devices[type] and tool.Devices[type].devices[sub_type] then
        devinfo = tool.Devices[type].devices[sub_type]
        if model and string.lower(devinfo.model) ~= string.lower(model) then
            CAF.WriteToDebugFile("caf_tool_error", "CAF: model passed does not match what is defined for this device\n")
        end
    else
        CAF.WriteToDebugFile("caf_tool_error", "CAF: Invalid Device Info! class:" .. tostring(class) .. " type:" .. tostring(type) .. " sub_type:" .. tostring(sub_type))
        return false
    end
    --allow for overrides of old data
    type = devinfo.type
    sub_type = devinfo.sub_type
    class = devinfo.class
    model = devinfo.model

    if not util.IsValidModel(model) or not util.IsValidProp(model) then return false end


    local ent
    --Admin Checks
    if devinfo.group.AdminOnly and not ply:IsAdmin() then
        CAF.POPUP(ply, CAF.GetLangVar("caf_stool_entity_admin_required"), "right", CAF.colors.red, 0.5);
        return false;
    end
    if devinfo.AdminOnly and not ply:IsAdmin() then
        CAF.POPUP(ply, CAF.GetLangVar("caf_stool_entity_model_admin_required"), "right", CAF.colors.red, 0.5);
        return false
    end

    --Enabled Checks
    if devinfo.group.EnableFunc then
        if not devinfo.group.EnableFunc(ply) then
            CAF.POPUP(ply, CAF.GetLangVar("caf_stool_entity_disabled"), "right", CAF.colors.red, 0.5);
            return
        end
    end
    if devinfo.EnableFunc then
        if not devinfo.EnableFunc(ply) then
            CAF.POPUP(ply, CAF.GetLangVar("caf_stool_entity_model_disabled"), "right", CAF.colors.red, 0.5);
            return
        end
    end
    if not CAF.AllowSpawn(type, sub_type, class, model) then
        return
    end

    if devinfo.group.MakeFunc then
        ent = devinfo.group.MakeFunc(tool, ply, Ang, Pos, class, type, sub_type, model, frozen, Extra_Data, devinfo)
        if IsValid(ent) then return false end
        if devinfo.group.MakeFuncReturn then return ent end
    else
        ent = ents.Create(class)
        if not ent:IsValid() then return false end
        ent:SetModel(model)
        ent:SetAngles(Ang)
        ent:SetPos(Pos)
        ent:SetPlayer(ply)
        ent:Spawn() --run ENT:Initialize()
        ent:Activate()

        duplicator.DoGenericPhysics(ent, ply, Data)
    end

    local mass = devinfo.mass or 0
    local maxhealth = devinfo.maxhealth or 0
    local ent_extras = devinfo.ent_extras or {}
    ent_extras.type = type
    ent_extras.sub_type = sub_type
    ent_extras.Extra_Data = Extra_Data

    if devinfo.group.func then
        mass, maxhealth = devinfo.group.func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    end

    if devinfo.func then
        mass, maxhealth = devinfo.func(ent, type, sub_type, devinfo, Extra_Data, ent_extras)
    end

    if devinfo.group.func or devinfo.func then
        mass = mass or devinfo.mass or 0
        maxhealth = maxhealth or devinfo.maxhealth or 0
    end

    if devinfo.res then
        for res, amt in pairs(devinfo.res) do
            local RD = CAF.GetAddon("Resource Distribution")
            if RD then
                RD.AddResource(ent, res, amt)
            end
        end
    end

    if devinfo.skin then ent:SetSkin(devinfo.skin) end
    if devinfo.material then ent:SetMaterial(devinfo.material) end
    if ent.Setup then ent:Setup(Extra_Data) end


    if maxhealth > 0 then
        ent:SetHealth(maxhealth)
        ent:SetMaxHealth(maxhealth)
    else
        ent:SetHealth(1)
        ent:SetMaxHealth(0)
    end

    table.Merge(ent:GetTable(), ent_extras)

    if mass > 0 or frozen then
        local phys = ent:GetPhysicsObject()
        if phys:IsValid() then
            if mass > 0 then
                phys:SetMass(mass)
                phys:Wake()
            end
            if frozen then
                phys:EnableMotion(false)
                ply:AddFrozenPhysicsObject(ent, phys)
            end
        end
    end

    return ent
end


function CAFEnts.RegDupeFunction(class, MakeFunc)
    duplicator.RegisterEntityClass(class, MakeFunc, "Ang", "Pos", "Class", "type", "sub_type", "Model", "frozen", "Extra_Data", "Data")
end





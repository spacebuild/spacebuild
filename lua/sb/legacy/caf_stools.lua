--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 21/12/12
-- Time: 13:45
-- To change this template use File | Settings | File Templates.
--

--CAF_AddStoolItem('cdsweapons', "Heat Gun", 'models/props_junk/TrafficCone001a.mdl', 'gun_heat')
function CAF_AddStoolItem( ToolName, EntPrintName, EntModel, EntClass, EntMakeFunct, MakeCAFEntSupFunction )
    if not (ToolName and EntPrintName and EntModel and EntClass) then
        --Msg('Error when calling CAF_AddStoolItem -- ToolName: -'..tostring(ToolName)..'- EntPrintName: -'..tostring(EntPrintName)..'- Model: -'..tostring(Model)..'- EntClass: -'..tostring(EntClass)..'-\n')
        return
    end

    list.Set( ToolName.."_Models", EntPrintName, { name = EntPrintName, model = EntModel, type = EntClass } )
    util.PrecacheModel( EntModel )

    if (SERVER) then
        CAF_SetToolMakeFunc( ToolName, EntClass, EntMakeFunct ) --EntMakeFunct should not be in client scope, ever (sloppy)
        CAF_AddMakeCAFEntSupFunction( EntClass, MakeCAFEntSupFunction )
    end
end



--This fucntion saves your day by setting up 95% of your stool for you with a few vars
--TOOL: toolobj
--Models_List: list of ent info used to make the panel options and do ghosting, each member uses this template: { 'EntPrintName', 'EntModel', 'EntClass' } (only needed if you don't set this someother way)
--MakeFunc: function used to make ents in Models_List (not needed if you set Models_List someother way)
--ToolName: name of the tool (ie. filename) (needed
--ToolLimit: for simple tools that limit all ents it make by this number (ie. all ents made by this tool use the same MakeFunc)
--MakeCAFEntSupFunctionList: list of functions used by MakeCAFEnt to setup an EntClass, list is indexed with EntClass (only needed if you're using MakeCAFEnt to make your ents)
function CAF_ToolRegister( TOOL, Models_List, MakeFunc, ToolName, ToolLimit, MakeCAFEntSupFunctionList)

    if (ToolLimit ~= nil and type(ToolLimit) == "number" and ToolLimit >=0) then
        local sbox = 'sbox_max'..ToolName
        Msg(sbox..' -> '..ToolLimit..'\n')
        CreateConVar(sbox, ToolLimit)
    end

    cleanup.Register(ToolName)

    TOOL.ClientConVar['AllowWorldWeld'] = '0'
    TOOL.ClientConVar['DontWeld'] = '0'
    TOOL.ClientConVar['Frozen'] = '0'
    TOOL.ClientConVar['name'] = ''
    TOOL.ClientConVar['type'] = ''
    TOOL.ClientConVar['model'] = ''
    if not (Models_List == nil) then
        for k, v in pairs(Models_List) do
            CAF_AddStoolItem(ToolName, v[1], v[2], v[3], MakeFunc, v[4]) --v[4] can be a MakeCAFEntSupFunction or nil
        end
    end

    if (SERVER and MakeCAFEntSupFunctionList) then
        for EntClass, MakeCAFEntSupFunction in pairs(MakeCAFEntSupFunctionList) do
            CAF_AddMakeCAFEntSupFunction( EntClass, MakeCAFEntSupFunction )
        end
    end

    function TOOL:LeftClick( trace )
        if trace.Entity and (trace.Entity:IsPlayer() ) then return false end
        if(CLIENT) then return true end

        return CAF_ToolLeftClick( self, trace, ToolName )

    end

    function TOOL:RightClick( trace )
        if (not trace.Entity:IsValid()) then return false end
        if (CLIENT) then return true end
        if (not trace.Entity:GetTable().Repair) then
            self:GetOwner():SendLua("GAMEMODE:AddNotify('Object cannot be repaired!', NOTIFY_GENERIC, 7); surface.PlaySound(\"ambient/water/drip"..math.random(1, 4)..".wav\")")
            return
        end
        trace.Entity:Repair()
        return true
    end

    if (CLIENT) then

        function TOOL.BuildCPanel( cp )
            CAF_BuildCPanel( cp, ToolName, ToolName.."_Models", custom )
        end

    end

    function TOOL:Think()
        if (CAF_UpdateToolGhost) then CAF_UpdateToolGhost( self ) end
    end

    function TOOL:Deploy()
        if not CAF then
            self:GetOwner():PrintMessage( HUD_PRINTCENTER, "Please Install the Custom Addon Framework.\nThis mod requires it to function." )
        end
    end


end

if (game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT) then --server side in singleplayer, client side in multiplayer
function CAF_UpdateToolGhost( tool, model, min, GetOffset, offset )
local model = model or tool:GetClientInfo('model')
if (model == '') then return end

if (not tool.GhostEntity or not tool.GhostEntity:IsValid() or tool.GhostEntity:GetModel() ~= model) then
tool:MakeGhostEntity( model, Vector(0,0,0), Angle(0,0,0) )
end

if ( not tool.GhostEntity ) then return end
if ( not tool.GhostEntity:IsValid() ) then return end

local tr = util.GetPlayerTrace( tool:GetOwner(), tool:GetOwner():GetAimVector() )
local trace = util.TraceLine( tr )
if (not trace.Hit) then return end

if ( trace.Entity:IsPlayer() ) then
    tool.GhostEntity:SetNoDraw( true )
    return
end

local Ang = trace.HitNormal:Angle()
if (not min or min == "z") then
Ang.pitch = Ang.pitch + 90
end
tool.GhostEntity:SetAngles( Ang )

local Pos = trace.HitPos
if (offset) then
    Pos = Pos + GetOffset( trace.HitNormal:Angle(), offset )
else
    Pos = Pos - trace.HitNormal * tool.GhostEntity:OBBMins()[ min or "z" ]
end
tool.GhostEntity:SetPos( Pos )

tool.GhostEntity:SetNoDraw( false )
end
end
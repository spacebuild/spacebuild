
include(sb.core.extensions:getBasePath().."autorun/shared/functions.lua")

fluix = fluix or {}

PrintTable(fluix)

MsgN("USING DEBUG, STANDBY"..debug.getinfo(1).source)

fluix.Smooth, fluix.Smooth2, fluix.FrameDelay, fluix.Imported, fluix.Init = 0, 0, 0, false, false
local pi = 3.14159265--358979323863

function fluix.clr( color )
    return color.r, color.g, color.b, color.a
end

function fluix.ColorNegate( color )
    --Get negative of the color
    color.r = 255 - color.r
    color.g = 255 - color.g
    color.b = 255 - color.b
    --bg_color.a = 255
    return color
end

function fluix.Smoother( target, current, smooth )
    return current + ( target - current ) * fluix.FrameDelay / smooth
end

--========================================Setup Wrapper Functions===================================================
function fluix.wrappers:Find(typeof,...)

    local arg = {...}

    local typeof = typeof
    local files = {};	local dirs = {}

    files, dirs = file.Find(...)

    if typeof == "file" then
        return files
    else
        return dirs
    end

end


--========================================Draw text for an indicator================================================
function fluix.DrawText( PosX, PosY, Size, text, text_color, font_type )
    PosX, PosY = PosX * math.Clamp(fluix.Smooth+0.4,0,1), PosY --* fluix.Smooth
    Size = Size --* fluix.Smooth

    if not font_type then surface.SetFont( "HudHintTextSmall" )
    else surface.SetFont( font_type ) end

    local Width, _ = surface.GetTextSize( text or " " )
    local Height, _ = surface.GetTextSize( "W" )
    PosX = PosX + Size * 0.5 - ( Width or 8 ) * 0.5
    PosY = PosY - ( Height or 8 )

    text_color.a = text_color.a * math.Clamp(fluix.Smooth+0.4,0,1)

    surface.SetTextColor( fluix.clr( text_color ) )
    surface.SetTextPos( PosX, PosY )
    surface.DrawText( text )

end
--===========================================Display hud============================================================
fluix.SmoothB, fluix.SmoothB2, fluix.VelocityS = 0, 0, 0
fluix.Pos = Vector( )
fluix.LastPos = Vector()
fluix.MaxFPS, fluix.SmoothFPS = 0, 0
fluix.PingS, fluix.PacketsS = 0, 0
fluix.EntityCount, fluix.Stability = 0, 0
fluix.HUDToggle = true;

if not ConVarExists( "fluix_toggle" ) then
CreateConVar( "fluix_toggle", 0 )
end



--===========================================Run the functions=========================================================
function fluix.RenderLoop( )

    fluix.FrameDelay = math.Clamp( FrameTime(), 0.0001, 10 )



    if LocalPlayer():Alive() == false or not fluix.HUDToggle then
    if fluix.Smooth2 >= 0 then
        fluix.Smooth2 = math.Clamp( fluix.Smooth2 - fluix.FrameDelay, -0.001, 1 )
    elseif fluix.Smooth > 0.0001 then
        fluix.Smooth = fluix.Smoother( -0.002, fluix.Smooth, 0.25 )
        fluix.Smooth2 = 0
    elseif fluix.Smooth < -0.001 then
        fluix.Smooth = -0.001
    end

    if fluix.HUDToggle then
        fluix.Init = false
    end
    else
        if fluix.Smooth < 0.9999 then
            --fluix.Smooth = fluix.Smooth + 0.02
            fluix.Smooth = fluix.Smoother( 1, fluix.Smooth, 0.25 )
        elseif fluix.Smooth2 < 1 then
            fluix.Smooth2 = fluix.Smooth2 + fluix.FrameDelay
            fluix.Smooth = 1
        elseif fluix.Smooth2 > 1 then
            fluix.Smooth2 = 1
        end
    end


    if fluix.Smooth > 0 then
        --[[============================================Load Modules=========================================================]]--

        if fluix.Imported == false then
            include(fluix.basePath.."autorun/client/init.lua")
            fluix.Imported = true
        end

        for k, v in pairs( fluix.modules ) do
            if v.Enabled and v.Enabled == true then
            v:Run()
            end
        end


        if fluix.Init == false and LocalPlayer():Alive() then
        local function hidehud(name)
            for k, v in pairs { "CHudHealth",  "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
                if name == v then return false end;
            end
        end
        hook.Add( "HUDShouldDraw", "FluixDisableDefault", hidehud )
        fluix.Init = true
        end
    end


    --Toggle the HUD===============================
    if GetConVarNumber( "fluix_toggle" ) ~= 0 then

    if not fluix.HUDToggle then
    fluix.HUDToggle = true

    local function hidehud(name)
        for k, v in pairs { "CHudHealth",  "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
            if name == v then return false end;
        end
    end
    hook.Add( "HUDShouldDraw", "FluixDisableDefault", hidehud )
    else
        fluix.HUDToggle = false


        local function hidehud(name)
            for k, v in pairs { "CHudHealth",  "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
                if name == v then return true end;
            end
        end
        hook.Add( "HUDShouldDraw", "FluixDisableDefault", hidehud )
        fluix.Init = true

    end

    RunConsoleCommand( "fluix_toggle", 0 )
    end
    --=============================================

end

hook.Add( "HUDPaint", "fluix_hud", fluix.RenderLoop ) -- doesn't work?
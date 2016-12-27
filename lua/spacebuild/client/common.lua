-- Copyright 2016 SB Dev Team (http://github.com/spacebuild)
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.

--
-- Created by IntelliJ IDEA.
-- User: stijn
-- Date: 18/06/2016
-- Time: 21:14
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD

surface.CreateFont( "FABig", {
    font = "FontAwesome",
    size = 32,
    extended = true
})

surface.CreateFont( "FANormal", {
    font = "FontAwesome",
    size = 20,
    extended = true
})

local color_white  = { r = 255, g = 255, b = 255, a = 255}

hook.Add( "HUDPaint", "sb.ui.hud", function()
    local ply = LocalPlayer()
    if ( not IsValid( ply ) ) then return end

    -- Version
    draw.DrawText("Spacebuild "..SB.version:fullVersion(), "DebugFixed", 5, 5, color_white, TEXT_ALIGN_LEFT)

    if not ply:Alive() then return end

    draw.RoundedBox( 10, 20, ScrH() - 200, 240, 180, Color(112, 138, 144, 100) )

    draw.DrawText( "Player" , "FANormal", 28, ScrH() - 196, color_white, TEXT_ALIGN_LEFT )
    draw.DrawText( "Weapon" , "FANormal", 100, ScrH() - 196, color_white, TEXT_ALIGN_LEFT )

    -- Health
    draw.DrawText( utf8.char( 0xf21e ) , "FANormal", 28, ScrH() - 176, color_white, TEXT_ALIGN_LEFT )
    draw.DrawText( ply:Health() , "FANormal", 54, ScrH() - 176, color_white, TEXT_ALIGN_LEFT )

    -- Armor
    draw.DrawText( utf8.char( 0xf132 ) , "FANormal", 32, ScrH() - 156, color_white, TEXT_ALIGN_LEFT )
    draw.DrawText( ply:Armor() , "FANormal", 54, ScrH() - 156, color_white, TEXT_ALIGN_LEFT )

    local wep = ply:GetActiveWeapon()
    if IsValid( wep ) then
        local hasDrawn = false
        -- Ammo
        if wep:Clip1() > -1 then
            hasDrawn = true
            draw.DrawText( utf8.char( 0xf1b2 ) , "FANormal", 108, ScrH() - 176, color_white, TEXT_ALIGN_LEFT )
            draw.DrawText( wep:Clip1().."/"..ply:GetAmmoCount( wep:GetPrimaryAmmoType() ) , "FANormal", 136, ScrH() - 176, color_white, TEXT_ALIGN_LEFT )
        end
        -- Secondary Ammo
        if wep:Clip2() > -1 or ply:GetAmmoCount( wep:GetSecondaryAmmoType() ) > 0 then
            hasDrawn = true
            draw.DrawText( utf8.char( 0xf1e2 ) , "FANormal", 108, ScrH() - 156, color_white, TEXT_ALIGN_LEFT )
            draw.DrawText( wep:Clip2().."/"..ply:GetAmmoCount( wep:GetSecondaryAmmoType() )  , "FANormal", 136, ScrH() - 156, color_white, TEXT_ALIGN_LEFT )
        end
        if not hasDrawn then
            draw.DrawText( utf8.char( 0xf05e ) , "FABig", 108, ScrH() - 170, color_white, TEXT_ALIGN_LEFT )
        end
    else
        draw.DrawText( utf8.char( 0xf05e ) , "FABig", 108, ScrH() - 170, color_white, TEXT_ALIGN_LEFT )
    end

    draw.DrawText( "Suit" , "FANormal", 28, ScrH() - 136, color_white, TEXT_ALIGN_LEFT )
    draw.DrawText( "Environment" , "FANormal", 100, ScrH() - 136, color_white, TEXT_ALIGN_LEFT )

    if ply.suit then
        draw.DrawText( "TODO" , "FABig", 36, ScrH() - 110, color_white, TEXT_ALIGN_LEFT )
    else
        draw.DrawText( utf8.char( 0xf05e ) , "FABig", 36, ScrH() - 110, color_white, TEXT_ALIGN_LEFT )
    end

    if ply.environment then
        -- Temperature
        draw.DrawText( utf8.char( 0xf2c7 ) , "FANormal", 112, ScrH() - 116, color_white, TEXT_ALIGN_LEFT )
        local temperatureText = ""
        if ply.environment.getNightTemperature then
            temperatureText = ply.environment:getNightTemperature().."K - "
        end
        temperatureText = temperatureText..ply.environment:getTemperature().."K"
        draw.DrawText( temperatureText  , "FANormal", 136, ScrH() - 116, color_white, TEXT_ALIGN_LEFT )

        -- Gravity
        draw.DrawText( utf8.char( 0xf2d6 ) , "FANormal", 108, ScrH() - 92, color_white, TEXT_ALIGN_LEFT )
        draw.DrawText( ply.environment:getGravity().."g"  , "FANormal", 136, ScrH() - 92, color_white, TEXT_ALIGN_LEFT )
        -- Oxygen
        draw.DrawText( utf8.char( 0xf1bb ) , "FANormal", 108, ScrH() - 68, color_white, TEXT_ALIGN_LEFT )
        draw.DrawText( ply.environment:getResourcePercentage("oxygen").."%"  , "FANormal", 136, ScrH() - 68, color_white, TEXT_ALIGN_LEFT )

    else
        draw.DrawText( utf8.char( 0xf05e ) , "FABig", 108, ScrH() - 110, color_white, TEXT_ALIGN_LEFT )
    end

end )

local function hidehud(name)
    for k, v in pairs{ "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
        if name == v then return false end
    end
end
hook.Add("HUDShouldDraw", "SpacebuildDisableDefault", hidehud)
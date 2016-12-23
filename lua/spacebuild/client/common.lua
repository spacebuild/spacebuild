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
    size = 64,
    extended = true
})

surface.CreateFont( "FANormal", {
    font = "FontAwesome",
    size = 32,
    extended = true
})

local color_white  = { r = 255, g = 255, b = 255, a = 255}

hook.Add( "HUDPaint", "sb.ui.hud", function()
    local ply = LocalPlayer()
    if ( not IsValid( ply ) ) then return end

    -- Health
    draw.DrawText( utf8.char( 0xf21e ) , "FABig", 20, ScrH() - 200, color_white, TEXT_ALIGN_LEFT )
    draw.DrawText( ply:Health() , "FANormal", 100, ScrH() - 184, color_white, TEXT_ALIGN_LEFT )

    -- Armor
    draw.DrawText( utf8.char( 0xf132 ) , "FABig", 28, ScrH() - 120, color_white, TEXT_ALIGN_LEFT )
    draw.DrawText( ply:Armor() , "FANormal", 100, ScrH() - 104, color_white, TEXT_ALIGN_LEFT )

    local wep = ply:GetActiveWeapon()
    if ( not IsValid( wep ) ) then return end

    -- Ammo
    draw.DrawText( utf8.char( 0xf1ad ) , "FABig", ScrW() - 20, ScrH() - 200, color_white, TEXT_ALIGN_RIGHT )
    draw.DrawText( ply:GetAmmoCount( wep:GetPrimaryAmmoType() ) , "FANormal", ScrW() - 100, ScrH() - 184, color_white, TEXT_ALIGN_RIGHT )

    -- Secondary Ammo
    draw.DrawText( utf8.char( 0xf0f7 ) , "FABig", ScrW() - 28, ScrH() - 120, color_white, TEXT_ALIGN_RIGHT )
    draw.DrawText( ply:GetAmmoCount( wep:GetSecondaryAmmoType() ) , "FANormal", ScrW() - 100, ScrH() - 104, color_white, TEXT_ALIGN_RIGHT )

end )

local function hidehud(name)
    for k, v in pairs{ "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
        if name == v then return false end
    end
end
hook.Add("HUDShouldDraw", "SpacebuildDisableDefault", hidehud)
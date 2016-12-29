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
    size = 14,
    extended = true
})

local whiteColor = Color(255, 255, 255, 255)
local blackColor = Color(0, 0, 0, 255)
local redColor = Color(255,99,71, 255)
local orangeColor = Color(255,165,0, 255)
local greenColor = Color(50,205,50, 255)
local blueColor = Color(0,225,255,255)
local bgColor = Color(26, 26, 26, 150)
local bgColorLight = Color(153, 153, 102, 150)
local bgColorLight2 = Color(204, 204, 0, 150)

local function drawVersion(ply)
    if hook.Call( "HUDShouldDraw", GAMEMODE, "SBHudVersion" ) == false then return end
    draw.DrawText("Spacebuild "..SB.version:fullVersion(), "DebugFixed", 5, 5, whiteColor, TEXT_ALIGN_LEFT)
end

local function drawHealth(ply, width, height)
    if hook.Call( "HUDShouldDraw", GAMEMODE, "SBHudHealth" ) == false then return end
    -- Draw health
    surface.SetDrawColor( bgColor.r, bgColor.g, bgColor.b, bgColor.a )
    surface.DrawRect( 20, height - 50, 130, 20 )

    draw.DrawText( utf8.char( 0xf21e ) , "FANormal", 24, height - 48, whiteColor, TEXT_ALIGN_LEFT )

    local hp, maxHp, perc = ply:Health(), ply:GetMaxHealth(), 0
    perc = (hp/maxHp) * 105

    surface.SetDrawColor( whiteColor.r, whiteColor.g, whiteColor.b, whiteColor.a )
    surface.DrawRect( 40, height - 44, perc, 8 )

    -- Draw Armor
    surface.SetDrawColor( bgColor.r, bgColor.g, bgColor.b, bgColor.a )
    surface.DrawRect( 155, height - 50, 65, 20 )

    draw.DrawText( utf8.char( 0xf132 ) , "FANormal", 159, height - 48, whiteColor, TEXT_ALIGN_LEFT )

    hp, maxHp, perc = ply:Armor(), 100, 0
    perc = (hp/maxHp) * 40

    surface.SetDrawColor( whiteColor.r, whiteColor.g, whiteColor.b, whiteColor.a )
    surface.DrawRect( 175, height - 44, perc, 8 )
end

local function drawAmmo(ply, width, height)
    if hook.Call( "HUDShouldDraw", GAMEMODE, "SBHudAmmo" ) == false then return end
    surface.SetDrawColor( bgColor.r, bgColor.g, bgColor.b, bgColor.a )
    surface.DrawRect( 20, height - 72, 200, 20 )

    local wep = ply:GetActiveWeapon()
    local name = "No weapon"
    if IsValid( wep ) then
        name = wep:GetPrintName()

        if wep:Clip1() > -1 then
            surface.SetDrawColor( bgColorLight.r, bgColorLight.g, bgColorLight.b, bgColorLight.a )
            surface.DrawRect( 20, height - 72, 30, 20 )

            draw.DrawText( wep:Clip1(), "FANormal", 48, height - 70, blackColor, TEXT_ALIGN_RIGHT )
            draw.DrawText( ply:GetAmmoCount( wep:GetPrimaryAmmoType() ), "FANormal", 64, height - 70, whiteColor, TEXT_ALIGN_LEFT )
        elseif ply:GetAmmoCount( wep:GetPrimaryAmmoType() ) > 0 then
            draw.DrawText( ply:GetAmmoCount( wep:GetPrimaryAmmoType() ), "FANormal", 22, height - 70, whiteColor, TEXT_ALIGN_LEFT )
        end

        if ply:GetAmmoCount( wep:GetSecondaryAmmoType() ) > 0 then
            surface.SetDrawColor( bgColorLight2.r, bgColorLight2.g, bgColorLight2.b, bgColorLight2.a )
            surface.DrawRect( 50, height - 72, 12, 20 )

            draw.DrawText( ply:GetAmmoCount( wep:GetSecondaryAmmoType() ), "FANormal", 60, height - 70, blackColor, TEXT_ALIGN_RIGHT )
        end

    end
    draw.DrawText( name  , "FANormal", 215, height - 70, whiteColor, TEXT_ALIGN_RIGHT )

end

local function getTemperatureColor(temperature)
    if		temperature < 283 then return blueColor
    elseif	temperature > 308 then return redColor
    else return whiteColor end
end

local function convertTemperature(temperature, unit)
    if unit == "C" then
        return temperature - 273.15
    elseif unit == "F" then
        return (temperature * (9/5)) - 459.67
    else
       return temperature
    end
end

local function drawEnvironment(ply, width, height)
    if hook.Call( "HUDShouldDraw", GAMEMODE, "SBHudEnvironment" ) == false then return end
    if not ply.environment then return end

    surface.SetDrawColor( bgColor.r, bgColor.g, bgColor.b, bgColor.a )
    surface.DrawRect( 20, 28, 150, 20 )
    draw.DrawText( utf8.char( 0xf0ac) , "FANormal", 24, 30, whiteColor, TEXT_ALIGN_LEFT )

    local name = "Environment"
    if  ply.environment:hasName() then
        name = ply.environment:getName()
    end
    draw.DrawText( name, "FANormal", 158, 32, whiteColor, TEXT_ALIGN_RIGHT)

    --Temperature
    surface.SetDrawColor( bgColor.r, bgColor.g, bgColor.b, bgColor.a )
    surface.DrawRect( 20, 50, 150, 20 )

    local unit = "K"

    draw.DrawText( utf8.char( 0xf2c7 ) , "FANormal", 24, 52, whiteColor, TEXT_ALIGN_LEFT )

    if ply.environment.getNightTemperature and ply.environment:getNightTemperature() ~= ply.environment:getTemperature() then
        draw.DrawText( string.format("%6.2f", convertTemperature(ply.environment:getNightTemperature(), unit))..unit , "FANormal", 100, 54, getTemperatureColor(ply.environment:getNightTemperature()), TEXT_ALIGN_RIGHT )
        draw.DrawText( "-", "FANormal", 105, 54, whiteColor, TEXT_ALIGN_RIGHT)
    end
    draw.DrawText( string.format("%6.2f", convertTemperature(ply.environment:getTemperature(), unit))..unit , "FANormal", 158, 54, getTemperatureColor(ply.environment:getTemperature()), TEXT_ALIGN_RIGHT )

    -- Gravity
    surface.SetDrawColor( bgColor.r, bgColor.g, bgColor.b, bgColor.a )
    surface.DrawRect( 20, 72, 150, 20 )

    draw.DrawText( utf8.char( 0xf2d6 ) , "FANormal", 24, 74, whiteColor, TEXT_ALIGN_LEFT )
    draw.DrawText( string.format("%6.2f", ply.environment:getGravity()).."g"  , "FANormal", 158, 76, whiteColor, TEXT_ALIGN_RIGHT )
    -- Oxygen
    surface.SetDrawColor( bgColor.r, bgColor.g, bgColor.b, bgColor.a )
    surface.DrawRect( 20, 94, 150, 20 )

    draw.DrawText( utf8.char( 0xf1bb ) , "FANormal", 24, 96, whiteColor, TEXT_ALIGN_LEFT )
    draw.DrawText( string.format("%6.2f", ply.environment:getResourcePercentage("oxygen")).."%"  , "FANormal", 158, 98, whiteColor, TEXT_ALIGN_RIGHT )
end

local function drawSuit(ply, width, height)
    if hook.Call( "HUDShouldDraw", GAMEMODE, "SBHudSuit" ) == false then return end
    if not ply.suit then return end
end

local function drawRdInfo(ply, width, height)
    if hook.Call( "HUDShouldDraw", GAMEMODE, "SBHudRDent" ) == false then return end
end

hook.Add( "HUDPaint", "sb.ui.hud", function()
    local ply = LocalPlayer()
    if ( not IsValid( ply ) ) then return end
    if not ply:Alive() then return end

    local width = ScrW()
    local height = ScrH()

    drawVersion(ply, width, height)
    drawHealth(ply, width, height)
    drawAmmo(ply, width, height)
    drawEnvironment(ply, width, height)
    drawSuit(ply, width, height)
    drawRdInfo(ply, width, height)
end )

local function hidehud(name)
    for k, v in pairs{ "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
        if name == v then return false end
    end
end
hook.Add("HUDShouldDraw", "SpacebuildDisableDefault", hidehud)
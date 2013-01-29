--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 02/01/13
-- Time: 02:53
-- To change this template use File | Settings | File Templates.
--
require("class")
local class = class
local const = sb.core.const
local fluix = fluix
fluix.modules.playerSuit = { Enabled = true }

local scrW, scrH, width, height, suitPanel, environmentPanel, suit = ScrW(), ScrH()
if scrW > 1650 then
    width  = 200
elseif scrW > 1024 then
    width = 150
else
    width = 100
end

if scrH > 800 then
   height = 48
else
    height = 32
end


local white, orange, red, green, bg, percent = Color( 255, 255, 255, 240 ), Color( 255, 127, 36, 240 ), Color( 205, 51, 51, 240), Color(51, 205, 51, 240), Color( 50,50,50,220)
local function getColorBasedOnValue(component, value, maxvalue)
    percent = value/maxvalue
    if percent > 0.3 then
        return  white
    elseif percent > 0.15 then
        return orange
    end
    return red
end

local function getColorBasedOnTemperature(component, value, maxvalue)
    if value >= const.TEMPERATURE_SAFE_MIN and value <= const.TEMPERATURE_SAFE_MAX then
        return green
    elseif (value >= const.TEMPERATURE_SAFE_MIN - 50 and value < const.TEMPERATURE_SAFE_MIN) or (value > const.TEMPERATURE_SAFE_MAX  and value <= const.TEMPERATURE_SAFE_MAX + 50) then
        return orange
    end
    return red
end

suitPanel = class.new("HudPanel", 16, 16,0, 0, false);
--suitPanel:addChild(class.new("HudBarIndicator", 0, 0, width, height, "Oxygen: %i units", function() return suit:getOxygen() end, getColorBasedOnValue, function() return 2000 end))
--suitPanel:addChild(class.new("HudBarIndicator", 0, height, width, height, "Coolant: %i units", function() return suit:getCoolant() end, getColorBasedOnValue,  function() return 2000 end))
--suitPanel:addChild(class.new("HudBarIndicator", 0, height * 2, width, height, "Energy: %i units", function() return suit:getEnergy() end, getColorBasedOnValue,  function() return 2000 end))
--suitPanel:addChild(class.new("HudBarIndicator", 0, height * 3, width, height, "Temperature: %iK", function() return suit:getTemperature() end, getColorBasedOnTemperature,  function() return 1000 end))

environmentPanel = class.new("HudPanel", scrW - (width + 16) , 16, false);


function fluix.modules.playerSuit.Run()
    if not suit then
        suit = sb.getPlayerSuit()
        return
    end
    if suit:isActive() then
       suitPanel:render()
    end
    if suit:getEnvironment() then
       environmentPanel:render()
    end
    draw.RoundedBox( 1, 16, 16, 150, 100, bg )
    draw.SimpleText( "Suit information", "HudHintTextSmall",  32, 32, white)
    draw.SimpleText( string.format( "Oxygen: %i units", math.Round( suit:getOxygen() )), "HudHintTextSmall",  32, 48, white)
    draw.SimpleText( string.format( "Coolant: %i units", math.Round( suit:getCoolant() )), "HudHintTextSmall",  32, 64, white)
    draw.SimpleText( string.format( "Energy: %i units", math.Round( suit:getEnergy() )), "HudHintTextSmall",  32, 80, white)
    draw.SimpleText( string.format( "Temperature: %iK", math.Round( suit:getTemperature() )), "HudHintTextSmall",  32, 96, white)

    if suit:getEnvironment() then
        local x = scrW - (200 + 16)
        local env = suit:getEnvironment()
        PrintTable(env)
        draw.RoundedBox( 1, x, 16, 150, 100, bg )
        draw.SimpleText( "Environment information", "HudHintTextSmall",  x + 16, 32, white)
        draw.SimpleText( string.format( "Temperature: %i K", math.Round( env:getTemperature() )), "HudHintTextSmall",  x+16, 48, white)
        draw.SimpleText( string.format( "Gravity: %2f",  env:getGravity() ), "HudHintTextSmall",  x+16, 64, white)
        draw.SimpleText( string.format( "Atmosphere: %2f", env:getAtmosphere() ), "HudHintTextSmall",  x + 16, 80, white)
        --draw.SimpleText( string.format( "Oxygen: %iK",  suit:getTemperature() ), "HudHintTextSmall",  x + 16, 96, white)
    end

end
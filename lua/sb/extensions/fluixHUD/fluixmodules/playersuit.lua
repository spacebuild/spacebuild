--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 02/01/13
-- Time: 02:53
-- To change this template use File | Settings | File Templates.
--
local class = sb.core.class
local const = sb.core.const
local fluix = fluix
fluix.modules.playerSuit = { Enabled = true }

local suitPanel, environmentPanel, suit

local white, orange, red, green, percent = Color( 255, 255, 255, 240 ), Color( 255, 127, 36, 240 ), Color( 205, 51, 51, 240), Color(51, 205, 51, 240)
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

suitPanel = class.create("HudPanel", 16, 16, false);
suitPanel:addChild(class.create("HudBarIndicator", 0, 0, 200, 48, "Oxygen: %i units", function() return suit:getOxygen() end, getColorBasedOnValue, function() return 2000 end))
suitPanel:addChild(class.create("HudBarIndicator", 0, 48, 200, 48, "Coolant: %i units", function() return suit:getCoolant() end, getColorBasedOnValue,  function() return 2000 end))
suitPanel:addChild(class.create("HudBarIndicator", 0, 96, 200, 48, "Energy: %i units", function() return suit:getEnergy() end, getColorBasedOnValue,  function() return 2000 end))
suitPanel:addChild(class.create("HudBarIndicator", 0, 144, 200, 48, "Temperature: %iK", function() return suit:getTemperature() end, getColorBasedOnTemperature,  function() return 1000 end))

environmentPanel = class.create("HudPanel", ScrW() - 216, 16, false);


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
end
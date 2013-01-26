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

suitPanel = class.new("HudPanel", 16, 16,0, 0, false);
--suitPanel:addChild(class.new("HudBarIndicator", 0, 0, width, height, "Oxygen: %i units", function() return suit:getOxygen() end, getColorBasedOnValue, function() return 2000 end))
--suitPanel:addChild(class.new("HudBarIndicator", 0, height, width, height, "Coolant: %i units", function() return suit:getCoolant() end, getColorBasedOnValue,  function() return 2000 end))
--suitPanel:addChild(class.new("HudBarIndicator", 0, height * 2, width, height, "Energy: %i units", function() return suit:getEnergy() end, getColorBasedOnValue,  function() return 2000 end))
--suitPanel:addChild(class.new("HudBarIndicator", 0, height * 3, width, height, "Temperature: %iK", function() return suit:getTemperature() end, getColorBasedOnTemperature,  function() return 1000 end))

environmentPanel = class.new("HudPanel", scrW - (height + 16) , 16, false);


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
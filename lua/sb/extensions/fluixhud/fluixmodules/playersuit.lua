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

local scrW, scrH, width, height = ScrW(), ScrH()
if scrW > 1650 then
	width  = 200
elseif scrW > 1024 then
	width = 150
else
	width = 100
end

if scrH > 900 then
	height = 36
elseif scrH > 750 then
	height = 24
else
	height = 16
end

local white,orange,red, green, bg = const.colors.white, const.colors.orange, const.colors.red, const.colors.green, Color( 50,50,50,220)
local percent


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

local suitPanel, environmentPanel
local oxygen,coolant,energy,temperature
local envTemp,envGrav,envAtmos
local suit

function fluix.modules.playerSuit.Run()
	if not LocalPlayer():Alive() then return end

	if not suit then
		suit = sb.getPlayerSuit()
		return
	end

	if not suitPanel then
		local w,h = 0,0
		suitPanel = class.new("TopLeftPanel", 16, 20, 0, 0, bg, true)
		local label = class.new("TextElement", 0, 0, width, height, white, "Suit Information:    ")
		oxygen = class.new("TextElement", 0, 0, width, height, white, "Oxygen")
		coolant = class.new("TextElement", 0, 0, width, height, white, "Coolant")
		energy = class.new("TextElement", 0, 0, width, height, white, "Energy")
		temperature = class.new("TextElement", 0, 0, width, height, white, "Temperature")
		suitPanel:addChild(label):addChild(oxygen):addChild(coolant):addChild(energy):addChild(temperature)
	end

	if not environmentPanel then
		local w,h = 0,0
		environmentPanel = class.new("TopRightPanel",scrW-16, 20, 0, 0, bg, true)
		local label = class.new("TextElement", 0, 0, width, height, white, "Environment Information:    ")
		envTemp = class.new("TextElement", 0, 0, width, height, white, "Temperature")
		envGrav = class.new("TextElement", 0, 0, width, height, white, "Gravity")
		envAtmos = class.new("TextElement", 0, 0, width, height, white, "Atmosphere")
		environmentPanel:addChild(label):addChild(envTemp):addChild(envGrav):addChild(envAtmos)
	end

	--Set Values


	-- Suit Info
	oxygen:setText(string.format( "Oxygen: %i units", math.Round( suit:getOxygen() )))
	coolant:setText(string.format( "Coolant: %i units", math.Round( suit:getCoolant() )))
	energy:setText(string.format( "Energy: %i units", math.Round( suit:getEnergy() )))
	temperature:setText(string.format( "Temperature: %iK", math.Round( suit:getTemperature() )))

	-- Environment
	local env = suit:getEnvironment()
	if env then
		envTemp:setText(string.format( "Temperature: %i K", math.Round( env:getTemperature() )))
		envGrav:setText(string.format( "Gravity: %2g",  env:getGravity() ))
		envAtmos:setText(string.format( "Atmosphere: %2g", env:getAtmosphere() ))
	end

	if suit:isActive() then
		suitPanel:render()

		if suit:getEnvironment() then
			environmentPanel:render()
		end
	end

end
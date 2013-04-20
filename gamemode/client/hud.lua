local GM = GM
local class = GM.class
local const = GM.constants
local internal = GM.internal

internal.hud = {}

function GM:registerHUDComponent(name, component)
	internal.hud[name] = component
end

function GM:getHudComponentByName(name)
	return internal.hud[name]
end

function GM:getHudComponentByClass(classname)
	local ret = {}
	for k, v in pairs(internal.hud) do
	   	if v.isA and v:isA(classname) then
		   table.insert(ret, v)
		end
	end
	return ret
end

local surface, Color, Vector, LocalPlayer, math, ScrH, ScrW, string, FrameTime, pairs, os = surface, Color, Vector, LocalPlayer, math, ScrH, ScrW, string, FrameTime, pairs, os

local pi = 3.14159265
local Smooth, Smooth2, FrameDelay = 0, 0, 0
local SmoothB, SmoothB2, VelocityS = 0, 0, 0
local Pos, LastPos = Vector(), Vector()
local MaxFPS, SmoothFPS = 0, 0
local PingS, PacketsS = 0, 0
local EntityCount, Stability = 0, 0
local Ammo1, Ammo1S, Ammo1Total, Ammo1Max, Ammo2 = 0, 0, 0, 0, 0
local Weapon = LocalPlayer()
local WeaponTable = {}
local WeaponS = 0
local scrW, scrH
local health, armor
local percent
local suitPanel, environmentPanel
local oxygen, coolant, energy, temperature
local envTemp, envGrav, envAtmos
local white, orange, red, green, bg = const.colors.white, const.colors.orange, const.colors.red, const.colors.green, Color(50, 50, 50, 220)
local suit, healthPanel, ammoPanel, breathBar, healthBar, armorBar, ammoBar, altBar
local localplayer


local function getColorBasedOnValue(component, value, maxvalue)
	percent = value / maxvalue
	if percent > 0.3 then
		return white
	elseif percent > 0.15 then
		return orange
	end
	return red
end

local function getColorBasedOnTemperature(component, value, maxvalue)
	if value >= const.TEMPERATURE_SAFE_MIN and value <= const.TEMPERATURE_SAFE_MAX then
		return green
	elseif (value >= const.TEMPERATURE_SAFE_MIN - 50 and value < const.TEMPERATURE_SAFE_MIN) or (value > const.TEMPERATURE_SAFE_MAX and value <= const.TEMPERATURE_SAFE_MAX + 50) then
		return orange
	end
	return red
end

local function clr(color)
	return color.r, color.g, color.b, color.a
end

local function ColorNegate(color)
	--Get negative of the color
	color.r = 255 - color.r
	color.g = 255 - color.g
	color.b = 255 - color.b
	--bg_color.a = 255
	return color
end

local function Smoother(target, current, smooth)
	return current + (target - current) * FrameDelay / smooth
end

--========================================Draw text for an indicator================================================
local function DrawText(PosX, PosY, Size, text, text_color, font_type)
	PosX, PosY = PosX * math.Clamp(Smooth + 0.4, 0, 1), PosY

	if not font_type then surface.SetFont("HudHintTextSmall")
	else surface.SetFont(font_type)
	end

	local Width, _ = surface.GetTextSize(text or " ")
	local Height, _ = surface.GetTextSize("W")
	PosX = PosX + Size * 0.5 - (Width or 8) * 0.5
	PosY = PosY - (Height or 8)

	text_color.a = text_color.a * math.Clamp(Smooth + 0.4, 0, 1)

	surface.SetTextColor(clr(text_color))
	surface.SetTextPos(PosX, PosY)
	surface.DrawText(text)
end

local drawCircle = function(type, PosX, PosY, SizeX, SizeY, a, b, bg_color, value_color, gradient_toggle)

	local type = type
	local PosX, PosY = PosX, PosY
	local SizeX, SizeY = SizeX, SizeY
	local a, b = a, b
	local bg_color, value_color = bg_color, value_color
	local gradient_toggle = gradient_toggle or false

	--===Draw the big circle===
	local sin, cos, rad = math.sin, math.cos, math.rad
	local tmp = 0

	local radius = 1
	if SizeX < SizeY then
		radius = SizeX
	else
		radius = SizeY
	end
	radius = radius / 2

	local x = PosX + radius
	local y = PosY + radius
	local x2, y2 = x, y

	radius = radius / 1.25
	local radius2 = radius / 2

	local quality = math.ceil(radius * 1)
	local circle = {}
	local tmp = 0
	for i = 1, quality do
		tmp = rad(i * 360) / quality
		circle[i] = { x = x + cos(tmp) * radius, y = y + sin(tmp) * radius }
	end

	bg_color.a = bg_color.a * Smooth

	surface.SetTexture(0)
	surface.SetDrawColor(bg_color)
	surface.DrawPoly(circle)
	--===========================

	if type == "Direction" then
		local Direction = a * Smooth2
		local Width = b * Smooth2

		--Draw value circle first
		value_color.a = value_color.a * Smooth
		surface.SetDrawColor(value_color)

		Width = Width * 360
		local quality2, old_alpha, cosine, sine, Dir2, num_points = quality * 8, value_color.a, 1, 1, rad(Direction - Width * 0.5), (quality * 8 * Width / 360)
		local circle_1, circle_2 = {}, {}

		for i = 1, num_points * 0.5 + 3 do
			tmp = 0.5 * pi * (3 + 4 * i / quality2) + Dir2

			circle_1[i] = { x = x + cos(tmp) * radius, y = y + sin(tmp) * radius }
		end

		for i = 1, num_points * 0.5 do
			tmp = 0.5 * pi * (3 + 4 * (i + num_points * 0.5) / quality2) + Dir2

			circle_2[i] = { x = x + cos(tmp) * radius, y = y + sin(tmp) * radius }
		end

		circle_1[1] = { x = x2, y = y2 }
		circle_2[1] = { x = x2, y = y2 }

		surface.DrawPoly(circle_1)
		surface.DrawPoly(circle_2)


		--Then draw second circle last
		local circle1 = {}
		for i = 1, quality do
			tmp = rad(i * 360) / quality
			circle1[i] = { x = x + cos(tmp) * radius2, y = y + sin(tmp) * radius2 }
		end

		local bg_color = ColorNegate(bg_color)
		bg_color.a = 255 * Smooth


		surface.SetDrawColor(bg_color)
		surface.DrawPoly(circle1)



	elseif type == "Indicator" then
		local Value = a * Smooth2
		local Max = b

		--Draw value circle first
		value_color.a = value_color.a * Smooth
		surface.SetDrawColor(value_color)
		local quality2, old_alpha, num_points, circle_1, circle_2 = quality * 8, value_color.a, (quality * 8 * (Value / Max)), {}, {} --quality * 20

		for i = 1, num_points * 0.5 + 3 do
			tmp = 0.5 * pi * (3 + 4 * i / quality2)

			circle_1[i] = { x = x + cos(tmp) * radius, y = y + sin(tmp) * radius }
		end

		for i = 1, num_points * 0.5 do
			tmp = 0.5 * pi * (3 + 4 * (i + num_points * 0.5) / quality2)

			circle_2[i] = { x = x + cos(tmp) * radius, y = y + sin(tmp) * radius }
		end

		circle_1[1] = { x = x2, y = y2 }
		circle_2[1] = { x = x2, y = y2 }

		surface.DrawPoly(circle_1)
		surface.DrawPoly(circle_2)


		--Then draw second circle last -- COVER CIRCLE
		circle = {}
		for i = 1, quality do
			tmp = rad(i * 360) / quality
			circle[i] = { x = x + cos(tmp) * radius2, y = y + sin(tmp) * radius2 }
		end

		local bg_color = ColorNegate(bg_color)
		bg_color.a = 255 * Smooth

		surface.SetDrawColor(bg_color)
		surface.DrawPoly(circle)
	end
end

--================================ It's a clock, duh :P ======================================
local drawClock = function(PosX, PosY, SizeX, SizeY, bg_color, value_color)
	local seconds = os.date("%S")
	local minutes = os.date("%M") + (seconds / 60)
	local hours = (os.date("%H") % 12) + (minutes / 60)
	local PosY2 = PosY + SizeY + (SizeY / 8)

	--local value_color_orig = value_color or Color( 255, 255, 255, 240 )
	--local bg_color_orig = bg_color or Color( 50,50,50,255)

	--Hours
	local value_color = Color(255, 255, 255, 240)
	local bg_color = Color(50, 50, 50, 120)
	drawCircle("Direction", PosX, PosY, SizeX, SizeY + (SizeY / 4), hours * 30, 0.1, bg_color, value_color)

	DrawText(PosX, PosY2, SizeX, "Hours", value_color)

	--Minutes
	local value_color = Color(255, 255, 255, 240)
	local bg_color = Color(50, 50, 50, 120)
	PosX = PosX + SizeX
	drawCircle("Direction", PosX, PosY, SizeX, SizeY + (SizeY / 4), minutes * 6, 0.1, bg_color, value_color)

	DrawText(PosX, PosY2, SizeX, "Minutes", value_color)

	--Seconds
	local value_color = Color(255, 255, 255, 240)
	local bg_color = Color(50, 50, 50, 120)
	PosX = PosX + SizeX
	drawCircle("Direction", PosX, PosY, SizeX, SizeY + (SizeY / 4), seconds * 6, 0.1, bg_color, value_color)

	DrawText(PosX, PosY2, SizeX, "Seconds", value_color)
end

function GM:drawHealthAndArmor()
	if localplayer and localplayer:Alive() and hook.Call("HUDShouldDraw", self, "SBHudHealth") then
		suit = GM:getPlayerSuit()
		if suit then
			breathBar:setValue(Smoother(suit:getBreath(), breathBar:getValue(), 0.15))
			breathBar:setMaxValue(suit:getMaxBreath())
		end
	   	if localplayer:Health() < 0 then health = 0 else health = LocalPlayer():Health() end
	   	if localplayer:Armor() < 0 then armor = 0 else armor = LocalPlayer():Armor() end

	   	healthBar:setValue(Smoother(health, healthBar:getValue(), 0.15))

	   	--Calculate Armor.
	   	armorBar:setValue(Smoother(armor, armorBar:getValue(), 0.15))

		-- Render the panel
		healthPanel:render()
	end
end

function GM:drawAmmo()
	if localplayer and localplayer:Alive() and hook.Call("HUDShouldDraw", self, "SBHudAmmo") then
		--Check if the weapon is valid.
		Weapon = LocalPlayer():GetActiveWeapon()
		Ammo1Total = Weapon:IsValid() and LocalPlayer():GetAmmoCount(Weapon:GetPrimaryAmmoType()) or 0
		if Weapon:IsValid() and WeaponS >= 1 then

			Ammo1 = Weapon:Clip1() or 0
			--Check if weapon has ammo
			if Ammo1 > 0 then

				--Add weapon's maximum ammo to the table.
				if not WeaponTable[Weapon:GetClass()] then
					WeaponTable[Weapon:GetClass()] = Ammo1
				elseif Ammo1 > WeaponTable[Weapon:GetClass()] then
					WeaponTable[Weapon:GetClass()] = Ammo1
				end

				Ammo1Max = WeaponTable[Weapon:GetClass()]

				Ammo2 = Weapon:GetSecondaryAmmoType() and LocalPlayer():GetAmmoCount(Weapon:GetSecondaryAmmoType()) or 0
			elseif Ammo1Total > 0 then
				Ammo1 = 0
			end

			Ammo1S = Smoother(Ammo1, Ammo1S, 0.15)
		elseif Weapon:IsValid() and (Weapon:Clip1() > 0 or Ammo1Total > 0) then
			Ammo1S = 0.15
		end

		--Controller for showing the ammo bar.
		if (Ammo1Total > 0 or Ammo1S > 0.1) and WeaponS < 1 and Smooth >= 1 then
			WeaponS = Smoother(1.1, WeaponS, 0.15)
		elseif Ammo1Total <= 0 and Ammo1S <= 0.1 and WeaponS > 0 then
			WeaponS = Smoother(-0.1, WeaponS, 0.15)
		elseif WeaponS > 1 then
			WeaponS = 1
		elseif WeaponS < 0 then
			WeaponS = 0
		end

		ammoBar:setValue(Ammo1)
		ammoBar:setMaxValue(Ammo1Max)

		-- render the panel
		ammoPanel:render()
	end
end

function GM:drawSuitInfo()
	suit = GM:getPlayerSuit()
	if localplayer and localplayer:Alive() and suit and suit:isActive() and hook.Call("HUDShouldDraw", self, "SBHudSuitInfo") then
		-- Suit Info
		oxygen:setText(string.format("Oxygen: %i units", math.Round(suit:getOxygen())))
		coolant:setText(string.format("Coolant: %i units", math.Round(suit:getCoolant())))
		energy:setText(string.format("Energy: %i units", math.Round(suit:getEnergy())))
		temperature:setText(string.format("Temperature: %i K", math.Round(suit:getTemperature())))

		-- Render the panel
		suitPanel:render()
	end
end

function GM:drawEnvironmentInfo()
	suit = GM:getPlayerSuit()
	if localplayer and localplayer:Alive() and suit and suit:isActive() and hook.Call("HUDShouldDraw", self, "SBHudEnvironmentInfo") then
		local env = suit:getEnvironment()
		if env then
			envTemp:setText(string.format("Temperature: %i K", math.Round(env:getTemperature())))
			envGrav:setText(string.format("Gravity: %2g g", env:getGravity()))
			envAtmos:setText(string.format("Atmospheric Pressure: %2g kPa", env:getAtmosphere()*100))

			-- Render the panel
			environmentPanel:render()
		end
	end
end

function GM:drawMeters()
	if Smooth > 0 then
		local PosX = scrW / 2
		local PosY = 16
		local SizeX, SizeY = 64, 64
		local PosX, PosY = PosX * math.Clamp(Smooth + 0.4, 0, 1), PosY

		local value_color = Color(255, 255, 255, 240)
		local bg_color = Color(50, 50, 50, 120)

		drawClock(PosX - SizeX, PosY, SizeX, SizeY, bg_color, value_color) -- Don't add the 1/4 to this one, as it's done within the function

		--FPS meter
		PosX = PosX - SizeX * 2

		if MaxFPS == 0 then MaxFPS = GetConVarNumber("fps_max") end
		SmoothFPS = Smoother(1 / FrameDelay, SmoothFPS, 0.15)
		SmoothFPS = math.Clamp(SmoothFPS, 0, MaxFPS)

		local value_color = Color(255, 255, 255, 240)
		local bg_color = Color(50, 50, 50, 120)
		drawCircle("Indicator", PosX, PosY, SizeX, SizeY + (SizeY / 4), SmoothFPS, MaxFPS, bg_color, value_color, false)
		DrawText(PosX, PosY + SizeY + (SizeY / 8), SizeX, string.format("%i FPS", math.Round(SmoothFPS * Smooth2)), value_color)
	end
end

local function generateHudComponents()
	if not scrH or not scrW or scrH ~= ScrH() or scrW ~= ScrW() then
		local width, height
		scrW = ScrW()
		scrH = ScrH()
		if scrW > 1650 then
			width = 200
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
		healthPanel = class.new("BottomLeftPanel", 16, scrH - 20, 0, 0, false, true) -- Parent housing/stack, (ClassName,x,y,w,h,valColor,bgColor,string)
		breathBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, "Breath: %i%s")
		healthBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, "Health: %i%s")
		armorBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, "Armor: %i%s")
		healthPanel:addChild(breathBar):addChild(healthBar):addChild(armorBar)

		healthBar:setValue(LocalPlayer():Health())  -- Set initial value
		armorBar:setValue(LocalPlayer():Armor()) -- Set initial value

		ammoPanel = class.new("BottomRightPanel", scrW - 16, scrH - 20, 0, 0, false, true)
		ammoBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, false)
		altBar = class.new("TextElement", 0, 0, width, height, white, "Alt: %i")

		local oldRender = ammoBar.render
		function ammoBar:render()
			if WeaponS <= 0 then return end
			oldRender(self)
			self:DrawText(self:getX(), self:getY() + (self:getHeight() - self:getHeight() / 8), self.width, string.format("Ammo: %i Total: %i", self.value, Ammo1Total), self:getColor())
		end

		local oldRender = altBar.render
		function altBar:render()
			if WeaponS <= 0 then return end
			self:setY(self:getHeight() * 15 / 8)
			self:setText(string.Right(string.format("Alt: %i", Ammo2), self:getWidth() / 12))
			oldRender(self)
		end
		ammoPanel:addChild(ammoBar):addChild(altBar)

		local w, h = 0, 0
		suitPanel = class.new("TopLeftPanel", 16, 20, 0, 0, bg, true)
		local label = class.new("TextElement", 0, 0, width, height, white, "Suit Information:    ")
		oxygen = class.new("TextElement", 0, 0, width, height, white, "Oxygen")
		coolant = class.new("TextElement", 0, 0, width, height, white, "Coolant")
		energy = class.new("TextElement", 0, 0, width, height, white, "Energy")
		temperature = class.new("TextElement", 0, 0, width, height, white, "Temperature")
		suitPanel:addChild(label):addChild(oxygen):addChild(coolant):addChild(energy):addChild(temperature)

		w, h = 0, 0
		environmentPanel = class.new("TopRightPanel", scrW - 16, 20, 0, 0, bg, true)
		local label = class.new("TextElement", 0, 0, width, height, white, "Environment Information:    ")
		envTemp = class.new("TextElement", 0, 0, width, height, white, "Temperature")
		envGrav = class.new("TextElement", 0, 0, width, height, white, "Gravity")
		envAtmos = class.new("TextElement", 0, 0, width, height, white, "Atmosphere")
		environmentPanel:addChild(label):addChild(envTemp):addChild(envGrav):addChild(envAtmos)


		-- Register the panels so that other people can keep track of them outside hud.lua
		GM:registerHUDComponent( "suitPanel", suitPanel )
		GM:registerHUDComponent( "environmentPanel", environmentPanel )
		GM:registerHUDComponent( "ammoPanel", ammoPanel )
		GM:registerHUDComponent( "healthPanel", healthPanel )
	end
end

local BaseClass = GM:GetBaseClass()

function GM:HUDPaint()
	FrameDelay = math.Clamp(FrameTime(), 0.0001, 10)
	if LocalPlayer():Alive() == false then
		if Smooth2 >= 0 then
			Smooth2 = math.Clamp(Smooth2 - FrameDelay, -0.001, 1)
		elseif Smooth > 0.0001 then
			Smooth = Smoother(-0.002, Smooth, 0.25)
			Smooth2 = 0
		elseif Smooth < -0.001 then
			Smooth = -0.001
		end
	else
		if Smooth < 0.9999 then
			Smooth = Smoother(1, Smooth, 0.25)
		elseif Smooth2 < 1 then
			Smooth2 = Smooth2 + FrameDelay
			Smooth = 1
		elseif Smooth2 > 1 then
			Smooth2 = 1
		end
	end

	if not localplayer then
		localplayer = LocalPlayer()
		return
	end
	generateHudComponents()

	self:drawHealthAndArmor()
	self:drawAmmo()
	self:drawSuitInfo()
	self:drawEnvironmentInfo()
	self:drawMeters()

	self:PaintWorldTips()
	self:PaintHudTips()

	--BaseClass.HUDPaint( self ) -- Don't use HUDPaint from base, we don't need anything from there anyway, only breaks 3 things.
end

local function hidehud(name)
	for k, v in pairs{ "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "FluixDisableDefault", hidehud)


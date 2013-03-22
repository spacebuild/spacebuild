fluix.modules.TopPanel = { Enabled = true }

local surface = surface
local fluix = fluix
local Color = Color
local pi = 3.14159265

--======================================== OMNIFUNCTION ============================================================
local drawCircle = function(type, PosX, PosY, SizeX, SizeY, a, b, bg_color, value_color, gradient_toggle)

	local type = type
	local PosX, PosY = PosX, PosY
	local SizeX, SizeY = SizeX, SizeY
	local a, b = a, b
	local bg_color, value_color = bg_color, value_color
	local gradient_toggle = gradient_toggle or false

	--===Draw the big circle===
	local sin, cos, rad = math.sin, math.cos, math.rad
	local tmp = 0;

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
	local circle = {};
	local tmp = 0
	for i = 1, quality do
		tmp = rad(i * 360) / quality
		circle[i] = { x = x + cos(tmp) * radius, y = y + sin(tmp) * radius }
	end

	bg_color.a = bg_color.a * fluix.Smooth

	surface.SetTexture(0)
	surface.SetDrawColor(bg_color)
	surface.DrawPoly(circle)
	--===========================

	if type == "Direction" then
		local Direction = a * fluix.Smooth2
		local Width = b * fluix.Smooth2

		--Draw value circle first
		value_color.a = value_color.a * fluix.Smooth
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

		local bg_color = fluix.ColorNegate(bg_color)
		bg_color.a = 255 * fluix.Smooth


		surface.SetDrawColor(bg_color)
		surface.DrawPoly(circle1)



	elseif type == "Indicator" then
		local Value = a * fluix.Smooth2
		local Max = b

		--Draw value circle first
		value_color.a = value_color.a * fluix.Smooth
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
		circle = {};
		for i = 1, quality do
			tmp = rad(i * 360) / quality
			circle[i] = { x = x + cos(tmp) * radius2, y = y + sin(tmp) * radius2 }
		end

		local bg_color = fluix.ColorNegate(bg_color)
		bg_color.a = 255 * fluix.Smooth

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

	fluix.DrawText(PosX, PosY2, SizeX, "Hours", value_color)

	--Minutes
	local value_color = Color(255, 255, 255, 240)
	local bg_color = Color(50, 50, 50, 120)
	PosX = PosX + SizeX
	drawCircle("Direction", PosX, PosY, SizeX, SizeY + (SizeY / 4), minutes * 6, 0.1, bg_color, value_color)

	fluix.DrawText(PosX, PosY2, SizeX, "Minutes", value_color)

	--Seconds
	local value_color = Color(255, 255, 255, 240)
	local bg_color = Color(50, 50, 50, 120)
	PosX = PosX + SizeX
	drawCircle("Direction", PosX, PosY, SizeX, SizeY + (SizeY / 4), seconds * 6, 0.1, bg_color, value_color)

	fluix.DrawText(PosX, PosY2, SizeX, "Seconds", value_color)
end


function fluix.modules.TopPanel:Run()

	local PosX = ScrW() / 2
	local PosY = 16
	local SizeX, SizeY = 64, 64 --* math.Clamp(fluix.Smooth+0.4,0,1),64
	local PosX, PosY = PosX * math.Clamp(fluix.Smooth + 0.4, 0, 1), PosY

	local value_color = Color(255, 255, 255, 240)
	local bg_color = Color(50, 50, 50, 120)

	drawClock(PosX - SizeX, PosY, SizeX, SizeY, bg_color, value_color) -- Don't add the 1/4 to this one, as it's done within the function

	--FPS meter
	PosX = PosX - SizeX * 2

	if fluix.MaxFPS == 0 then fluix.MaxFPS = GetConVarNumber("fps_max") end
	fluix.SmoothFPS = fluix.Smoother(1 / fluix.FrameDelay, fluix.SmoothFPS, 0.15)
	fluix.SmoothFPS = math.Clamp(fluix.SmoothFPS, 0, fluix.MaxFPS)

	local value_color = Color(255, 255, 255, 240)
	local bg_color = Color(50, 50, 50, 120)
	drawCircle("Indicator", PosX, PosY, SizeX, SizeY + (SizeY / 4), fluix.SmoothFPS, fluix.MaxFPS, bg_color, value_color, false)
	fluix.DrawText(PosX, PosY + SizeY + (SizeY / 8), SizeX, string.format("%i FPS", math.Round(fluix.SmoothFPS * fluix.Smooth2)), value_color)
end

-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

AddCSLuaFile()
include("sb/extensions/base/init.lua")

require("class")
local class = class

local EXT = EXT
local oldinit = EXT.init
function EXT:init(config)
	oldinit(self, config)
	self.hidden = false
	self.active = true
	self.version = 1
	self.name = "Fluix HUD"
	self.description = "The default SB4 hud"
	self.clientside = true
end
EXT.wrappers = {}
EXT.modules = {}
EXT.basePath = sb.core.extensions:getBasePath()

class.registerClassPath(EXT.basePath .. "classes/")


--========================================Setup Wrapper Functions===================================================
function EXT.wrappers:Find(typeof, ...)

	local arg = { ... }

	local typeof = typeof
	local files, dirs

	files, dirs = file.Find(...)

	if typeof == "file" then
		return files
	else
		return dirs
	end
end

local mods = EXT.wrappers:Find("file", EXT.basePath .. "fluixmodules/*", "lsv")

if SERVER then
	for k, v in ipairs(mods) do
		if (string.sub(v, -4) == ".lua") then
			AddCSLuaFile(EXT.basePath .. "fluixmodules/" .. v)
		end
	end
	AddCSLuaFile(EXT.basePath .. "classes/HudComponent.lua")
	AddCSLuaFile(EXT.basePath .. "classes/HudBarIndicator.lua")
	AddCSLuaFile(EXT.basePath .. "classes/HudPanel.lua")
	AddCSLuaFile(EXT.basePath .. "classes/HudBarTextIndicator.lua")
	AddCSLuaFile(EXT.basePath .. "classes/BottomLeftPanel.lua")
	AddCSLuaFile(EXT.basePath .. "classes/BottomRightPanel.lua")
	AddCSLuaFile(EXT.basePath .. "classes/TopLeftPanel.lua")
	AddCSLuaFile(EXT.basePath .. "classes/TopRightPanel.lua")
	AddCSLuaFile(EXT.basePath .. "classes/TextElement.lua")
end

if CLIENT then
	include(EXT.basePath .. "fluixmodules/bottom_panel.lua")
	include(EXT.basePath .. "fluixmodules/top_panel.lua")
	include(EXT.basePath .. "fluixmodules/playersuit.lua")
	EXT.Smooth, EXT.Smooth2, EXT.FrameDelay, EXT.Imported, EXT.Init = 0, 0, 0, false, false
	local pi = 3.14159265 --358979323863

	function EXT.clr(color)
		return color.r, color.g, color.b, color.a
	end

	function EXT.ColorNegate(color)
		--Get negative of the color
		color.r = 255 - color.r
		color.g = 255 - color.g
		color.b = 255 - color.b
		--bg_color.a = 255
		return color
	end

	function EXT.Smoother(target, current, smooth)
		return current + (target - current) * EXT.FrameDelay / smooth
	end


	--========================================Draw text for an indicator================================================
	function EXT.DrawText(PosX, PosY, Size, text, text_color, font_type)
		PosX, PosY = PosX * math.Clamp(EXT.Smooth + 0.4, 0, 1), PosY --* fluix.Smooth
		--Size = Size * fluix.Smooth

		if not font_type then surface.SetFont("HudHintTextSmall")
		else surface.SetFont(font_type)
		end

		local Width, _ = surface.GetTextSize(text or " ")
		local Height, _ = surface.GetTextSize("W")
		PosX = PosX + Size * 0.5 - (Width or 8) * 0.5
		PosY = PosY - (Height or 8)

		text_color.a = text_color.a * math.Clamp(EXT.Smooth + 0.4, 0, 1)

		surface.SetTextColor(EXT.clr(text_color))
		surface.SetTextPos(PosX, PosY)
		surface.DrawText(text)
	end

	--===========================================Display hud============================================================
	EXT.SmoothB, EXT.SmoothB2, EXT.VelocityS = 0, 0, 0
	EXT.Pos = Vector()
	EXT.LastPos = Vector()
	EXT.MaxFPS, EXT.SmoothFPS = 0, 0
	EXT.PingS, EXT.PacketsS = 0, 0
	EXT.EntityCount, EXT.Stability = 0, 0
	EXT.HUDToggle = true

	if not ConVarExists("fluix_toggle") then
		CreateConVar("fluix_toggle", 0)
	end



	--===========================================Run the functions=========================================================
	function EXT.RenderLoop()
		EXT.FrameDelay = math.Clamp(FrameTime(), 0.0001, 10)
		if EXT:isActive() then




			if LocalPlayer():Alive() == false or not EXT.HUDToggle then
				if EXT.Smooth2 >= 0 then
					EXT.Smooth2 = math.Clamp(EXT.Smooth2 - EXT.FrameDelay, -0.001, 1)
				elseif EXT.Smooth > 0.0001 then
					EXT.Smooth = EXT.Smoother(-0.002, EXT.Smooth, 0.25)
					EXT.Smooth2 = 0
				elseif EXT.Smooth < -0.001 then
					EXT.Smooth = -0.001
				end

			else
				if EXT.Smooth < 0.9999 then
					--fluix.Smooth = fluix.Smooth + 0.02
					EXT.Smooth = EXT.Smoother(1, EXT.Smooth, 0.25)
				elseif EXT.Smooth2 < 1 then
					EXT.Smooth2 = EXT.Smooth2 + EXT.FrameDelay
					EXT.Smooth = 1
				elseif EXT.Smooth2 > 1 then
					EXT.Smooth2 = 1
				end
			end


			if EXT.Smooth > 0 then
				--[[============================================Load Modules=========================================================]] --

				for k, v in pairs(EXT.modules) do
					if v.Enabled and v.Enabled == true then
						v:Run()
					end
				end
			end
			--=============================================
		end
	end
	hook.Add("HUDPaint", "fluix_hud", EXT.RenderLoop) -- doesn't work?

	local function hidehud(name)
		for k, v in pairs{ "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo" } do
			if name == v then return GetConVarNumber("fluix_toggle") ~= 0 or not EXT:isActive() end
		end
	end
	hook.Add("HUDShouldDraw", "FluixDisableDefault", hidehud)
end


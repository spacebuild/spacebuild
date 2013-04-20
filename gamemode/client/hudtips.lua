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

local GM = GM
local class = GM.class
local const = GM.constants

local HudTip
local HudTipPanel

local label, content

local scrW, scrH, width, height

local bg = Color(50, 50, 50, 220)

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

	end


	local SuitPanel = GM:getHudComponentByName("suitPanel")
	if SuitPanel then

		HudTipPanel = class.new("TopLeftPanel", SuitPanel:getX(), SuitPanel:getY() + SuitPanel:getHeight() + 20, 0, 0, bg, true) -- This will left-align with SuitPanel and be 20 units under it.

		label = class.new("TextElement", 0, 0, width, height, const.colors.white, "Object Information:    ")

		HudTipPanel:addChild(label) -- Add labels in order

		for k,v in pairs( HudTip.text ) do
			HudTipPanel:addChild(v)  -- Go through the table of elements we should add
		end

		GM:registerHUDComponent( "hudTipPanel", HudTipPanel ) -- Finally register

	end

end

function GM:AddHudTip( unused1, textTable, unused2, pos, ent )
	--[[
		This is where you will register a tip for the hudTip.
	]]
	HudTip = {}

	HudTip.dietime 	= SysTime() + 0.05
	HudTip.text 	= textTable -- This will be a table of elements, so class.new etc.
	HudTip.pos 		= pos -- Position of the panel, possible remove this for a fixed panel underneath Suit Panel To Be Discussed
	HudTip.ent 		= ent

	generateHudComponents()

end

local function DrawHudTip( tip )
	--[[

	 	This is where actual drawing to the HUD will take place.
	 ]]

	if ( not IsValid( tip.ent ) ) then return end -- Ensure our ent is valid before we do anything
	if ( not tip.text ) then return end -- Check that we have text to draw

	HudTipPanel:render()

end

function GM:PaintHudTips()

	local suit = GM:getPlayerSuit()

	if suit and suit:isActive() then --Ensure we can access suit and that we have it active.
		if HudTip and HudTip.dietime > SysTime() then
			DrawHudTip( HudTip )
		end
	end

end


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

local sb = sb
local ExtsPnls = {}
local vgui = vgui
local hook = hook
local print = MsgN
local pairs = pairs
local type = type
local tostring = tostring
local table = table
local surface = surface
local spawnmenu = spawnmenu
local Color = Color


local function DrawExtensionsMenuOption(panel)
	local exts = 1
	for k, v in pairs(sb.core.extensions) do
		if (type(v) == "table") then

			local extmenu = {}
			ExtsPnls[v:getSyncKey()] = extmenu

			print((exts * 100) + (10 * (exts - 1)))
			--Create the base panel
			extmenu[1] = vgui.Create("DPanel", panel)
			extmenu[1]:SetPos(10, (exts * 100) + (10 * (exts - 1))) --TODO: Play around with the spacing (<10 perhaps)
			extmenu[1]:SetSize(300, 100) --TODO: Play around with value 100
			--Increments the amount of Extensions so we know where to place the next Panel
			exts = exts + 1

			--Create the Title Text in the panel
			extmenu[2] = vgui.Create("DLabel", extmenu[1])
			extmenu[2]:SetPos(5, 5)
			extmenu[2]:SetFont("ExtensionTitle")
			if v:isActive() then
				extmenu[2]:SetText(v:getName() .. " (Enabled)")
			else
				extmenu[2]:SetText(v:getName() .. " (Disabled)")
			end
			extmenu[2]:SetTextColor(Color(0, 0, 253))
			extmenu[2]:SizeToContents()


			--Create the description Text in the panel
			extmenu[3] = vgui.Create("DLabel", extmenu[1])
			extmenu[3]:SetPos(5, 10)
			extmenu[3]:SetText(v:getDescription())
			extmenu[3]:SetTextColor(Color(255, 0, 0))
			extmenu[3]:SetSize(300, 70)
			extmenu[3]:SetWrap(true)

			--Create the options button
			extmenu[4] = vgui.Create("DButton", extmenu[1])
			extmenu[4]:SetPos(65, 70)
			extmenu[4]:SetSize(50, 25)
			extmenu[4]:SetText("Options")
			extmenu[4].DoClick = function()
				v:MakeMenu()
			end
			if not v:hasOptions() then
				extmenu[4]:SetDisabled(true)
			end

			--Create the disable button
			extmenu[5] = vgui.Create("DButton", extmenu[1])
			extmenu[5]:SetPos(185, 70)
			extmenu[5]:SetSize(50, 25)
			extmenu[5]:SetText("Disable")

			if (not v:isActive()) then
				extmenu[5]:SetText("Enable")
			else
				extmenu[5]:SetText("Disable")
			end

			extmenu[5].DoClick = function()
			--If the extension is already disabled.
				if (not v:isActive()) then
					--The button should enable the addon and change the color to red and say Disable addon and change the title

					--TODO: Ashley ENABLING code goes here.

					--Set the color to green because the extension is Enabled
					extmenu[5]:ColorTo(Color(0, 100, 0, 255), 1, 0)
					-- Set the button to disable the extenison
					extmenu[5]:SetText("Disable")
					extmenu[2]:SetText(v:getName() .. " (Enabled)")
					extmenu[2]:SizeToContents()
				else

					--TODO: Ashley DISABLING code for extension "v" goes here.

					--Set the color to red because the extension is disabled
					extmenu[5]:ColorTo(Color(255, 0, 0, 255), 1, 0)
					-- Set the button to enable the extenison
					extmenu[5]:SetText("Enable")
					extmenu:SetText(v:getName() .. " (Disabled)")
					extmenu[2]:SizeToContents()
				end
			end

			--End of Disable Button
		end
	end
end



local function InitExtensionMenu()
	spawnmenu.AddToolMenuOption("Spacebuild", --Todo: Fucking make this add to the existing one.
		"Options", --Category
		"Extensions", --itemName
		"Extensions", --Text to display
		"", -- Command to run
		DrawExtensionsMenuOption,
		DrawExtensionsMenuOption)
end

hook.Add("PopulateToolMenu", "SB: Add Extension Menu Option", InitExtensionMenu)

local function CreateSBExtsFonts()
	surface.CreateFont("ExtensionTitle", {
		font = "Arial",
		size = 20,
		weight = 1000,
		underline = 100
	})
end

hook.Add("Initialize", "SB: Create Some Fonts", CreateSBExtsFonts)
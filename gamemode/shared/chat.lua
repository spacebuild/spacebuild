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

local chat = chat
local draw = draw
local surface = surface
local GM = GM

if SERVER then

	--[[
	-- This is for some chat server side stuff, perhaps for notifications of race change or team change or entering or leaving players.
	-- Perhaps some gamemode 'events'
	 ]]

elseif CLIENT then

	local chatBox
	local maxlines = 30
	local linespacing = 16

	local function toggle( bool, team )

		if chatBox.open == bool then return end -- Prevents spam of the function if we've already processed it once.

		chatBox.open = bool -- Give chatbox the current state of things

		chatBox:SetKeyboardInputEnabled( bool )
		chatBox:SetMouseInputEnabled( bool )

		if bool then

			chatBox:MakePopup()
			chatBox:SetFocusTopLevel( true )
			chatBox.input:RequestFocus()
		else
			chatBox.input:SetText( "" )
		end
	end

	function GM:OnPlayerChat( player, strText, bTeamOnly, bPlayerIsDead )
		local raceColor = player_manager.RunClass( player, "getRaceColor" )
		chat.AddText(raceColor, player:Name(),": ",Color(255,255,255),strText," LOL QUATS!" )
		return false
	end

	function GM:ChatText( playerindex, playername, text, filter )

		if filter == "joinleave" then
			chat.AddText(Color(255,255,255), text, Color(100,255,100), playername)
		end

		return true
	end

	function GM:StartChat()

		return false -- Return true to disable normal chat

	end

	function GM:PlayerBindPress( ply, bind, pressed ) -- This will disable the default chat registering our Y and U chat binds, and Toggle our system instead
		if string.find( bind, "messagemode" ) then
			toggle( true, bind == "messagemode2" ) -- Messagemode2 is team.
			return true
		elseif string.find( bind, "cancelselect" ) then
			toggle( false, false )
			return true
		end
	end


	function GM:HUDShouldDraw( name ) -- Let's stop the default chat from drawing
		if name == "CHudChat" then return false end
		return true
	end

	local PANEL = {} -- Let's just have a nice local to hold all our panel stuff prior to registering it as a vgui table

	function PANEL:Init()
		self.pos = { x = 35, y = ScrH() - 310 }
		self.size = { w = 480, h = 20 }

		self.input = vgui.Create( "DTextEntry", self ) -- Make an input element so we can get text from the user
		self.input:SetPos( 0, 0 ) -- Set it's position relative to the panel.
		self.input:SetSize( self.size.w, 20 ) -- Set it's size
		self.input:SetEnterAllowed(true) -- Allows enter to be used
		self.input:SetAllowNonAsciiCharacters( true ) -- And allow ascii chars

		self.input:SetDrawBackground( false )
		self.input:SetDrawBorder( false )

		self.input.Paint = function ( self )
			local w,h = self:GetSize()
			local x,y = self:GetPos();
		    draw.RoundedBox( 4, x, y, w, h, Color(255,100,100,150) )
		end

		self.input.OnEnter = function()
			local msg = self.input:GetValue() -- Get what the user typed
			chat.AddText(Color(255,255,255), msg) -- Print it to chat for now
		end

		self.input.OnKeyCodeTyped = function(self, key)
			if key == KEY_ESCAPE then
				chatBox.input:SetVisible(false)
				self:SetVisible(false)
				self:SetText("")
				RunConsoleCommand("cancelselect")
			end
		end


	end

	vgui.Register( "SB4ChatBox", PANEL, "EditablePanel" )

	chatBox = vgui.Create( "SB4ChatBox" )
	chatBox:SetSize(520, maxlines * linespacing)
	chatBox:SetPos(20, ScrH() * 0.75 - chatBox:GetTall())
	chatBox:SetVisible(true)



end


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
local color = GM.constants.colors
local surface = surface
local draw = draw

local MESSAGE = {}
function MESSAGE:new( o )
	-- Msg Format
	--o = {sender = ply, race = ply.race, raceColor = ply.raceColor, msg = msg, sendTime = CurTime(), teamMsg = isTeamMsg }
	o = o or {}   -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function MESSAGE:shouldFade( )
	return CurTime() > self.sendTime + 10
end

function MESSAGE:reindex( i )
	-- Reindex the message, essentially change its ID.
	self.id = i or self.id
end

function MESSAGE:Paint()
	-- Paint the message, this should be called to display the message
end

function MESSAGE:IsTeam()
	return self.teamMsg
end

local PANEL = {}

surface.SetFont("ChatFont")
local _, h = surface.GetTextSize("W")



function PANEL:Init()
	-- Here we want to initialise our panel, get our lovely dimensions and orientation in the world set.
	-- We also want to make children, isn't that the goal of every VGUI element?

	--[[
	-- The structure of the chat is to have 1 absolute chat Panel. This will be our anchor into the screen world
	-- THE ABSOLUTE CHAT PANEL IS SELF!!!! ALL Members will be children of this
	 - Next comes the fakePanel/invisiblePanel This will essentially be a viewport into our messageBox and input field
	   Inside of this viewport we play our Message box and input field spaced out.
	   The messagebox is a DScrollPanel in which we place panels, these little unit panels will be our messages
	   Messages will contain data:
	   	: self.sender will be for who the message belongs to, usually localPlayer otherwise console
	   	: self.race if sender is player then get their race
	   	: likewise self.raceColor will be there as well
	   	: self.message this will be the message string
	   	: self.sendTime will be the CurTime() when the msg was sent, allows for cool fading effects later :D
	   	: self.teamMsg will be for whether it should be team or not, allows for our playerClass to act as a team-
	   Messages will be constructed and added to the messageBox by calling a constructor
	   After this there will be a spacing
	   Then a standard input text field.
	   MessageBox and input will be outline rects, in draw or surface.
	 ]]

	local superparent = self -- So we can access the superparent of any child from within it's functions
	self.maxLines = 10 -- This refer to max amount shown at any given time.
	self.lineSpacing = h + 3 -- Space by max height and then 3
	self.lineMemory = 100 -- Amount of lines to keep stored, too many and it will seriously lag on draw.
	self.color =  Color(50, 50, 50, 70)
	self.outlineColor = color.white

	self:SetSize(520, (self.maxLines+2) * self.lineSpacing) -- Define our size and position
	self:SetPos( 20, ScrH() * 0.75 - self:GetTall() )
	self:SetVisible( false ) -- Make sure people can't see us initially

	self.width,self.height = self:GetSize()

	self.viewport = self:Add( "EditablePanel" )
	self.viewport:SetSize( self:GetSize() ) -- Same size as parent
	self.viewport:SetPos( 0, 0 )

	self.msgBox = self.viewport:Add( "DScrollPanel" )
	self.msgBox:SetSize( self.width, self.maxLines * self.lineSpacing )
	self.msgBox:SetPos( 0, 0 ) -- Place at top of viewport
	self.msgBox.color = superparent.color
	self.msgBox.Paint = function( self )
		local input = superparent.input
		if input and input:HasFocus() then
			-- In box
			draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), self.color )

			-- Outline
			surface.SetDrawColor(superparent.outlineColor)
			surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
		end
	end

	self.msgBox.addMsg = function ( self, msgData )
		-- Check for wrapping / wrap the string

		-- Check if addition of this line will exceed the boundary condition, scroll to compensate

		-- Check if addition of this line will exceed memory limit, remove to compensate
	end

	self.input = self.viewport:Add( "DTextEntry" )
	self.input.color = superparent.color
	self.input:SetHistoryEnabled( true )
	self.input:SetSize( self.width, 20)
	local x, y = self:GetPos()
	self.input:SetPos( 0, self.viewport:GetTall() - self.input:GetTall() ) -- Place at bottom of viewport
	self.input:SetAllowNonAsciiCharacters(true)
	self.input:SetTextInset(0, 0)

	self.input.Paint = function ( self )
		-- input body
		surface.SetDrawColor(superparent.color)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

		-- input outline
		surface.SetDrawColor(superparent.outlineColor)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())

		-- Txt Color, Highlight Color, Cursor color
		self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
	end

	self.input.SetTeam = function ( self, bool )
		self.team = bool
	end
	self.input.IsTeam = function( self )
		return self.team
	end

	self.input.turnOffTyping = function ( self )
		self:SetText("")
		self:SetEditable( false )
		self:SetVisible( false )
		self:GetParent():SetVisible( false )
		self:SetTeam( false ) -- Ensure when we close we're back to default or bad things.
	end


	local oldOnKey = self.input.OnKeyCodeTyped
	self.input.OnKeyCodeTyped = function( self, key)
		if key == KEY_ESCAPE then
			self:SetText("")
			self:KillFocus()
		end
		oldOnKey( self, key) -- Run the old stuff
	end

	self.input.OnValueChange = function( self, strValue)
		self:AddHistory( strValue )
		local msg = MESSAGE:new( {
			sender = LocalPlayer(),
			race = player_manager.RunClass( LocalPlayer(), "getRace" ),
			raceColor = player_manager.RunClass( LocalPlayer(), "getRaceColor" ),
			msg = strValue,
			sendTime = CurTime(),
			teamMsg = self:IsTeam()
		} )
		PrintTable( msg )
		print(msg:shouldFade())
		self:turnOffTyping()
	end

	self.input.OnLoseFocus = function ( self ) -- Also fixes our amazing console problem :D
	    self:turnOffTyping()
	end

	self.viewport:SizeToChildren( false, true) -- Nice and snug
	self:SizeToChildren(false, true)
end

function PANEL:PerformLayout()
	-- Called when things are invalidated
	-- When this happens all the things go to 0,0

	self:SetSize(520, (self.maxLines+2) * self.lineSpacing) -- Define our size and position
	self:SetPos( 20, ScrH() * 0.75 - self:GetTall() )

	self.viewport:SetParent( self )
	self.viewport:SetSize( self:GetSize() ) -- Same size as parent
	self.viewport:SetPos( self:GetPos() )

	self.msgBox:SetParent( self.viewport )
	self.msgBox:SetSize( self.width, self.maxLines * self.lineSpacing )
	self.msgBox:SetPos( self:GetParent():GetPos() ) -- Place at top of viewport

	self.input:SetParent( self.viewport )
	self.input:SetSize( self.width, 20)
	local x, y = self:GetParent():GetPos()
	self.input:SetPos( 0, self.viewport:GetTall() - self.input:GetTall() ) -- Place at bottom of viewport

	self.viewport:SizeToChildren( false, true) -- Nice and snug
	self:SizeToChildren(false, true)
end

vgui.Register('DChatPanel', PANEL, 'EditablePanel')

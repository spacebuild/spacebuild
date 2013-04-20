
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
local g_Scoreboard

--
-- This is just a linear colour interpolation function
-- it will be used to create smooth colour transitions based
-- upon health values
--

local function clrInterpolation( startClr, endClr, fraction )

	local dr		= ( endClr.r and not 0 or math.log(endClr.r) )-( startClr.r and not 0 or math.log(startClr.r) )
	local dg		= ( endClr.g and not 0 or math.log(endClr.g) )-( startClr.g and not 0 or math.log(startClr.g) )
	local db		= ( endClr.b and not 0 or math.log(endClr.b) )-( startClr.b and not 0 or math.log(startClr.b) )
	local da		= ( endClr.a and not 0 or math.log(endClr.a) )-( startClr.a and not 0 or math.log(startClr.a) )

	dr,dg,db,da = dr * fraction, dg * fraction, db * fraction, da * fraction

	local r,g,b,a = startClr.r + math.exp(dr), startClr.g + math.exp(dg), startClr.b + math.exp(db), startClr.a + math.exp(da)

	return Color( r, g, b, a )

end

local ply

--
-- This defines a new panel type for the player row. The player row is given a player
-- and then from that point on it pretty much looks after itself. It updates player info
-- in the think function, and removes itself when the player leaves the server.
--
local PLAYER_LINE = 
{
	Init = function( self )

		self.AvatarButton = self:Add( "DButton" )
		self.AvatarButton:Dock( LEFT )
		self.AvatarButton:SetSize( 32, 32 )
		self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

		self.Avatar		= vgui.Create( "AvatarImage", self.AvatarButton )
		self.Avatar:SetSize( 32, 32 )
		self.Avatar:SetMouseInputEnabled( false )		

		self.Name		= self:Add( "DLabel" )
		self.Name:Dock( FILL )
		self.Name:SetFont( "ScoreboardDefault" )
		self.Name:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )
		self.Name:DockMargin( 8, 0, 0, 0 )

		self.Mute		= self:Add( "DImageButton" )
		self.Mute:SetSize( 32, 32 )
		self.Mute:Dock( RIGHT )

		self.Ping		= self:Add( "DLabel" )
		self.Ping:Dock( RIGHT )
		self.Ping:SetWidth( 50 )
		self.Ping:SetFont( "ScoreboardDefault" )
		self.Ping:SetContentAlignment( 5 )

		self.Deaths		= self:Add( "DLabel" )
		self.Deaths:Dock( RIGHT )
		self.Deaths:SetWidth( 50 )
		self.Deaths:SetFont( "ScoreboardDefault" )
		self.Deaths:SetContentAlignment( 5 )

		self.Kills		= self:Add( "DLabel" )
		self.Kills:Dock( RIGHT )
		self.Kills:SetWidth( 50 )
		self.Kills:SetFont( "ScoreboardDefault" )
		self.Kills:SetContentAlignment( 5 )

		self:Dock( TOP )
		self:DockPadding( 3, 3, 3, 3 )
		self:SetHeight( 32 + 3*2 )
		self:DockMargin( 2, 0, 2, 2 )

	end,

	Setup = function( self, pl )

		self.Player = pl

		self.Avatar:SetPlayer( pl )
		self.Name:SetText( pl:Nick() )

		self:Think( self )

	end,

	Think = function( self )

		if ( not IsValid( self.Player ) ) then
			self:Remove()
			return
		end

		if ( self.NumKills == nil or self.NumKills ~= self.Player:Frags() ) then
			self.NumKills	=	self.Player:Frags()
			self.Kills:SetText( self.NumKills )
		end

		if ( self.NumDeaths == nil or self.NumDeaths ~= self.Player:Deaths() ) then
			self.NumDeaths	=	self.Player:Deaths()
			self.Deaths:SetText( self.NumDeaths )
		end

		if ( self.NumPing == nil or self.NumPing ~= self.Player:Ping() ) then
			self.NumPing	=	self.Player:Ping()
			self.Ping:SetText( self.NumPing )
		end

		--
		-- Change the icon of the mute button based on state
		--
		if ( self.Muted == nil or self.Muted ~= self.Player:IsMuted() ) then

			self.Muted = self.Player:IsMuted()
			if ( self.Muted ) then
				self.Mute:SetImage( "icon32/muted.png" )
			else
				self.Mute:SetImage( "icon32/unmuted.png" )
			end

			self.Mute.DoClick = function() self.Player:SetMuted( not self.Muted ) end

		end

		--
		-- Connecting players go at the very bottom
		--
		if ( self.Player:Team() == TEAM_CONNECTING ) then
			self:SetZPos( 32700 )
		end

		--
		-- This is what sorts the list. The panels are docked in the z order, 
		-- so if we set the z order according to kills they'll be ordered that way!
		-- Careful though, it's a signed short internally, so needs to range between -32,768k and +32,767
		--

		local race = player_manager.RunClass( self.Player, "getRace" )

		local mult
		if race == "Terran" then
			mult = 1000
		elseif race == "Radijn" then
			mult = 0
		elseif race == "Pendrouge" then
			mult = -1000
		end



		self:SetZPos( (mult * -30 ) - (self.NumKills * 10) + self.NumDeaths ) --- TODO Change this to money for each.

	end,

	Paint = function( self, w, h )

		if ( not IsValid( self.Player ) ) then
			return
		end

		--
		-- We draw our background a different colour based on the status of the player
		--

		local Race = player_manager.RunClass( self.Player, "getRace" )

			local Racecolor = player_manager.RunClass( self.Player, "getRaceColor" )
			draw.RoundedBox( 4, 0, 0, w, h, Racecolor )         -- Draw the player row

			local localRace = player_manager.RunClass( ply, "getRace" )

			if localRace == Race then          -- Only the same race as the local Player will draw health Bars. Useful :D

				local health = self.Player:Health()
				local xoff, yoff = w/100,h/10 -- We'll indent 10% all the way around :D
				local w, h = w-xoff*2, h-yoff*2 -- Shave off the same from the other end

				--
				-- Width should be a minimum of 32-xoff this will put the bar's min just a the end of the avatar
				-- Then it should have a max length of (orig_w-xoff*2)*(2/5)
				-- Split that up into 100 increments, and use the health fraction to set width to curr health value
				-- Use 1-fraction *255 to set the alpha. This will make it more visible the closer to 0 health you get.
				-- This will give the effect of the health bar emerging from the row
				--

				local w_min = 32-xoff
				local w_max = w*(4/5)
				local w_length = w_max - w_min

				local fraction
				if health >= 100 then fraction = 1
				else
					fraction = health / 100       -- Fraction of health between 0 and 1. 1 is full health
				end
				local startClr = Color(255,50,50,200) -- Red
				local endClr = Racecolor   -- Green / Race Colour
				-- Since 1 represents full health, start ---- fraction --------------- end
				-- End must be our health when on full colour, and our start must be red :D

				local clr = clrInterpolation(startClr, endClr, fraction)
				clr.a = 255*(1 - fraction)

				w = w_min+(w_length*fraction)

				if self.Player:Alive() == false or fraction == 0 then
					w = w_max- (w_length*0.1)
					clr = Color(255,0,0,255)
				end


				draw.RoundedBox( 4, xoff, yoff, w, h, clr )
			end
	end,
}

--
-- Convert it from a normal table into a Panel Table based on DPanel
--
PLAYER_LINE = vgui.RegisterTable( PLAYER_LINE, "DPanel" );

--
-- Here we define a new panel table for the scoreboard. It basically consists 
-- of a header and a scrollpanel - into which the player lines are placed.
--
local SCORE_BOARD = 
{
	Init = function( self )

		ply = LocalPlayer()

		self.Header = self:Add( "Panel" )
		self.Header:Dock( TOP )
		self.Header:SetHeight( 100 )

		self.Name = self.Header:Add( "DLabel" )
		self.Name:SetFont( "ScoreboardDefaultTitle" )
		self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Name:Dock( TOP )
		self.Name:SetHeight( 40 )
		self.Name:SetContentAlignment( 5 )
		self.Name:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		--self.NumPlayers = self.Header:Add( "DLabel" )
		--self.NumPlayers:SetFont( "ScoreboardDefault" )
		--self.NumPlayers:SetTextColor( Color( 255, 255, 255, 255 ) )
		--self.NumPlayers:SetPos( 0, 100 - 30 )
		--self.NumPlayers:SetSize( 300, 30 )
		--self.NumPlayers:SetContentAlignment( 4 )

		self.Scores = self:Add( "DScrollPanel" )
		self.Scores:Dock( FILL )

	end,

	PerformLayout = function( self )

		self:SetSize( 700, ScrH() - 200 )
		self:SetPos( ScrW() / 2 - 350, 100 )

	end,

	Paint = function( self, w, h )

		--draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

	end,

	Think = function( self, w, h )

		self.Name:SetText( GetHostName() )

		--
		-- Loop through each player, and if one doesn't have a score entry - create it.
		--
		local plyrs = player.GetAll()
		for id, pl in pairs( plyrs ) do

			if ( not IsValid( pl.ScoreEntry ) ) then

				pl.ScoreEntry = vgui.CreateFromTable( PLAYER_LINE, pl.ScoreEntry )
				pl.ScoreEntry:Setup( pl )

				self.Scores:AddItem( pl.ScoreEntry )

			end

		end		

	end,
}

SCORE_BOARD = vgui.RegisterTable( SCORE_BOARD, "EditablePanel" )

--[[---------------------------------------------------------
   Name: gamemode:ScoreboardShow( )
   Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()

	if ( not IsValid( g_Scoreboard ) ) then
		g_Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
	end

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Show()
		g_Scoreboard:MakePopup()
		g_Scoreboard:SetKeyboardInputEnabled( false )
	end

end

--[[---------------------------------------------------------
   Name: gamemode:ScoreboardHide( )
   Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Hide()
	end

end


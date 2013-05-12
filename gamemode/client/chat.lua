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


JChat = {} --Let's prevent any breaking.
--Various data

if CLIENT then
	--[[
	JChat.ScrollSpeed = 3.52
	JChat.ChatFont = "ChatFont"
	JChat.UseIcons = false

	surface.SetFont(JChat.ChatFont)
	local w, h = surface.GetTextSize("0")
	JChat.LineSpacing = h + 2

	JChat.SentChatPrintLine = false
	JChat.MaxLines = 10
	JChat.FadeTime = 1.5
	JChat.fadeDelay = 5

	JChat.lineMemory = 100

	JChat.SentChatPrintLine = false

	if not JChat.OldChatAddText then JChat.OldChatAddText = chat.AddText end

	JChat.ChatboxPanel = {} --Initialize our panel data

	function JChat.GetLastColor(linedata)
		local color = color_white
		for k, v in pairs(linedata.textdata) do
			if type(v) == "table" and v.r and v.g and v.b then
				color = v
			end
		end
		return color
	end

	function JChat.WrapString(linedata, maxwidth)
		surface.SetFont(JChat.ChatFont)
		local linewidth = 0
		local packedlines = {}
		local linenumber = 1
		table.insert(packedlines, {icon = linedata.icon, textdata = {}})
		for k, v in pairs(linedata.textdata) do
			if type(v) == "string" then
				local w, h = surface.GetTextSize(v)
				linewidth = linewidth + w
				if linewidth + ((linedata.icon and #packedlines == 1) and 22 or 0) >= maxwidth then
					local w, h = surface.GetTextSize(v)
					linewidth = w
					linenumber = linenumber + 1
					table.insert(packedlines, {textdata = {JChat.GetLastColor(packedlines[linenumber-1])}})
				end
			end
			if type(v) == "table" and v.r and v.g and v.b then
				table.insert(packedlines[linenumber].textdata, v)
			end
			if type(v) == "string" then
				table.insert(packedlines[linenumber].textdata, v)
			end
		end
		return packedlines
	end

	function JChat.ChatboxPanel:Init()
		self.ChatLines = {}
		self.ScrollY = 0
	end

	local a = 255

	function JChat.ChatboxPanel:DrawLine(num, data)
		surface.SetFont(JChat.ChatFont)
		local linewidth = 0
		local num = num - 1
		if (num < ((self.ScrollY) / JChat.LineSpacing) - 1 or num > (self.ScrollY / JChat.LineSpacing)+JChat.MaxLines + 1) then return end

		local w, h = 0, 0
		h = h + JChat.LineSpacing * num
		timer.Simple(JChat.fadeDelay, function()

			data.alpha = math.Approach(data.alpha, 0, (self.TextEntry:IsVisible() and 0 or JChat.FadeTime)) --- TODO FIX THE SHITTY FADING

		end)

		for _, elem in pairs(data.textdata) do
			local r,g,b,a
			if type(elem) == "table" and elem.r and elem.g and elem.b then
				surface.SetTextColor(Color(elem.r, elem.g, elem.b, (self.TextEntry:IsVisible() and 255 or data.alpha)))
			end
			if type(elem) == "string" then
				w, _ = surface.GetTextSize(elem)
				surface.SetTextPos(2 + linewidth, h + self.ScrollY * -1)
				surface.DrawText(elem)
				linewidth = linewidth + w
			end
		end --But our team of scientific trained ninja monkeys is working on this aspect
	end

	function JChat.ChatboxPanel:AddLine(linedata)
		--linedata struct = {icon(optional), textdata(same format as chat.AddText), printedon = RealTime()}
		local wrapped = JChat.WrapString(linedata, self:GetWide())
		for k,v in pairs(wrapped) do
			v.alpha = 255
			table.insert(self.ChatLines, v)
		end
		if #self.ChatLines >= math.ceil(self:GetTall() / JChat.LineSpacing) then
			self.ScrollY = (#self.ChatLines - math.ceil(self:GetTall() / JChat.LineSpacing)) * JChat.LineSpacing
		end
		for k, v in pairs(self.ChatLines) do
			if k ~= #self.ChatLines then
				v.shouldfade = true
			end
		end


		-- Check to see if we need to remove the first item of the table
		-- We don't want the table getting too big that it begins to lag.
		while #self.ChatLines > JChat.lineMemory do
			table.remove(self.ChatLines,1)
		end
	end

	function JChat.ChatboxPanel:Paint()
		if self.TextEntry then -- If the player has the text entry field open
			surface.SetDrawColor(Color(50, 50, 50, (self.TextEntry:IsVisible() and 150 or 0))) --Darkish transparent grey
			local xoff, yoff = 15,15
			surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
			for k, v in ipairs(self.ChatLines) do
				self:DrawLine(k, v)
			end
		end
	end

	vgui.Register("JChat.ChatBoxPanel", JChat.ChatboxPanel, "EditablePanel")

	--timer.Simple(0, function()


		JChat.ChatBox = vgui.Create("JChat.ChatBoxPanel")
		JChat.ChatBox:SetSize(520, JChat.MaxLines * JChat.LineSpacing)
		JChat.ChatBox:SetPos(20, ScrH() * 0.75 - JChat.ChatBox:GetTall())
		JChat.ChatBox:SetVisible(true)

		JChat.FakePanel = vgui.Create("EditablePanel")
		JChat.FakePanel:SetPos(10, ScrH() * 0.75 - JChat.ChatBox:GetTall())
		JChat.FakePanel:SetSize(800, ScrH())
		JChat.FakePanel:SetVisible(true)
		JChat.FakePanel.Paint = function() end
		JChat.FakePanel.OnMouseWheeled = function(self, dir)
			if JChat.ChatBox then
				local maxlines = math.ceil(JChat.ChatBox:GetTall() / JChat.LineSpacing)
				if #JChat.ChatBox.ChatLines >= maxlines then
					JChat.ChatBox.ScrollY = math.Clamp(JChat.ChatBox.ScrollY + (dir * -1) * JChat.LineSpacing, 0, (#JChat.ChatBox.ChatLines - maxlines) * JChat.LineSpacing)
					--print(JChat.ChatBox.ScrollY)
				end
			end
		end


		local chatx, chaty = JChat.ChatBox:GetPos()
		JChat.ChatBox.TextEntry = vgui.Create("DTextEntry", JChat.FakePanel)
		JChat.ChatBox.TextEntry:SetParent(JChat.FakePanel)
		JChat.ChatBox.TextEntry:SetPos(10, JChat.MaxLines * JChat.LineSpacing + 15)
		JChat.ChatBox.TextEntry:SetSize(JChat.ChatBox:GetWide(), 20)
		JChat.ChatBox.TextEntry:SetAllowNonAsciiCharacters(true)
		JChat.ChatBox.TextEntry:SetTextInset(0, 0)
		JChat.ChatBox.TextEntry:SetVisible(false)
		JChat.ChatBox.TextEntry.IsTeamChat = false
		JChat.ChatBox.TextEntry.OnMouseWheeled = function(self, dir)
			local maxlines = math.ceil(JChat.ChatBox:GetTall() / JChat.LineSpacing)
			if #JChat.ChatBox.ChatLines >= maxlines then
				JChat.ChatBox.ScrollY = math.Clamp(JChat.ChatBox.ScrollY + (dir * -1) * JChat.LineSpacing, 0, (#JChat.ChatBox.ChatLines - maxlines) * JChat.LineSpacing)
				--print(JChat.ChatBox.ScrollY)
			end
		end
		JChat.ChatBox.TextEntry.OnKeyCodeTyped = function(self, key)
			if key == KEY_ESCAPE then
				JChat.ChatBox.TextEntry:SetVisible(false)
				JChat.FakePanel:SetVisible(false)
				self:SetText("")
				--timer.Simple(0, function()
					RunConsoleCommand("cancelselect")
				--end)
			end
			if key == KEY_ENTER then
				if self:GetText():Trim() ~= "" then
					RunConsoleCommand((self.IsTeamChat and "say_team" or "say"), self:GetText():Trim())
					JChat.ChatBox.TextEntry.IsTeamChat = false
				end
				self:SetText("")
				--timer.Simple(0.001, function()
					JChat.ChatBox.TextEntry:SetVisible(false)
					JChat.FakePanel:SetVisible(false)
					JChat.ChatBox.TextEntry:KillFocus()
				--end)
			end
		end
		JChat.ChatBox.TextEntry.Paint = function(self)
			surface.SetDrawColor(Color(50, 50, 50, (self:IsVisible() and 150 or 0)))
			surface.DrawOutlinedRect( 0, 0, self:GetWide(), self:GetTall() )
			--surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
			--surface.SetDrawColor(color_white)
			--surface.DrawRect(1, 1, self:GetWide() - 2, self:GetTall() - 2)
			self:DrawTextEntryText(Color(0, 0, 0), Color(255, 255, 255), Color(0, 0, 0))
		end

		JChat.ChatBox.TextEntry.OnLoseFocus = function( self )
			self:RequestFocus()  -- When it's meant to be visible keep focusing it, otherwise we run into crappy bind issues.
		end

		JChat.ChatBox.TextEntry.OnEnter = function(self)
			if self:GetText():Trim() ~= "" then
				RunConsoleCommand((self.IsTeamChat and "say_team" or "say"), self:GetText():Trim())
				JChat.ChatBox.TextEntry.IsTeamChat = false
			end
			self:SetText("")
			--timer.Simple(0.001, function()
				JChat.ChatBox.TextEntry:SetVisible(false)
				JChat.FakePanel:SetVisible(false)
				JChat.ChatBox.TextEntry:KillFocus()
			--end)
		end
		JChat.ChatBox.TextEntry.OnTextChanged = function(self)
			hook.Call("ChatTextChanged", GAMEMODE, self:GetText():Trim())
		end
	--end)

	JChat.isplayerchat = false

	function chat.AddText(...)
		local pargs = {...}
		local colorsparsed = false
		--timer.Simple(0, function()
			local ind = 1
			local args = {}
			for k, v in pairs(pargs) do
				if type(v) == "table" and v.r and v.g and v.b then -- It's a colour
					local fixedcolor = Color(v.r, v.g, v.b, 255)
					table.insert(args, fixedcolor)
				end
				if type(v) == "Player" then
					JChat.isplayerchat = true
					table.insert(args, player_manager.RunClass( v, "getRaceColor" )) --- TODO Change to race colour
					table.insert(args, v:Nick())
				end
				if type(v) == "string" then
					for s in string.gmatch(v, "%s?[(%S)]+[^.]?" ) do --[%S]+[^.]?") do -- This will match any non-whitespace to the largest substring, then ignore any whitespace inbetween
						surface.SetFont(JChat.ChatFont)
						local w, _ = surface.GetTextSize(s)
						local singlew, _ = surface.GetTextSize("O")
						if w >= JChat.ChatBox:GetWide() then --- TODO Sort this fucking mess, cut lines to nearest word not char, and actually use #str becuase it's an array of chars ... or something
							local lastchar = 0
							local maxchars = JChat.ChatBox:GetWide() / singlew
							for i = 0, math.ceil(w / JChat.ChatBox:GetWide()) do
								local cutstr = string.sub(s, lastchar + 1, lastchar + maxchars)
								table.insert(args, cutstr)
								lastchar = lastchar + string.len(cutstr)
							end
						else
							table.insert(args, s)
						end
					end
				end
			end
			JChat.ChatBox:AddLine({icon = JChat.PlayerChatIcon, textdata = args})
			JChat.OldChatAddText(unpack(pargs))
			JChat.PlayerChatIcon = nil
		--end)
	end

	usermessage.Hook("JChat.SendChatPrint", function(um) --- TODO Eliminate these shitty umsgs
		JChat.SentChatPrintLine = um:ReadBool()
	end)

	hook.Add("OnPlayerChat", "JCAHR", function(ply)  --- TODO Remove all icon support
		if ply:IsSuperAdmin() then
			JChat.PlayerChatIcon = "gui/silkicons/star"
			return
		end
		if ply:IsAdmin() then
			JChat.PlayerChatIcon = "gui/silkicons/shield"
			return
		end
		JChat.PlayerChatIcon = "gui/silkicons/user"
	end)

	hook.Add("ChatText","mein_chat", function(index, nick, text, messagetype)
	--:?[^(:.-:)]+:?
		timer.Simple(0, function()  --- TODO SHITTY TIMER'S WHY THE FUCK ARE YOU THERE
			if JChat.ChatBox and nick ~= text then
				local args = {}
				if JChat.SentChatPrintLine then --- TODO What even is this SentChatPrintLine?
					args = {}
					table.insert(args, Color(151, 211, 255))
					for s in string.gmatch(text, "%s?[(%S)]+[^.]?") do --HEIL PATTERN
						table.insert(args, s)
					end
					JChat.ChatBox:AddLine({textdata = args})
					JChat.SentChatPrintLine = false
					return
				end
				if messagetype == "joinleave" then -- For ply join or leave msgs
					args = {}
					local color = color_white
					for leavestr in string.gmatch(text, "%S+") do -- WHY DO WE NEED GMATCH HERE? Find would do...
						if leavestr == "joined" then
							color = Color(161, 255, 161)
						end
						if leavestr == "left" then
							color = Color(200, 0, 10)
						end
					end
					table.insert(args, color)
					for s in string.gmatch(text, "%s?[(%S)]+[^.]?") do --- TODO Replace this pattern with the more optimised one from before.
						table.insert(args, s) -- This just now makes the message available to print after selecting colours
					end
					JChat.ChatBox:AddLine({textdata = args})
					return
				end
				if messagetype == "none" then -- Then it's a normal message
					args = {}
					for s in string.gmatch(text, "%S+") do --- TODO AGAIN WHAT'S WITH ALL THE GMATCHING
						if s == "cvar" then
							table.insert(args, Color(255, 225, 0))
						end
					end
					for s in string.gmatch(text, "%s?[(%S)]+[^.]?") do --- TODO Replace this pattern with the more optimised one from before.
						table.insert(args, s)
					end
					JChat.ChatBox:AddLine({textdata = args})
				end
			end
		end)
	end)

	hook.Add("StartChat", "JChat.HideChat", function() return true end)

	local OpenChat = function(pl, bind, pressed) --- TODO Make text entry disappear if you go to press anything other than TAB as textentry will be over the ESC menu

		if(pressed and string.find(bind, "messagemode")) then
			if string.find(bind, "messagemode2") then
				JChat.ChatBox.TextEntry.IsTeamChat = true
			end
			JChat.ChatBox:SetVisible(true)
			JChat.ChatBox:SetFocusTopLevel( true )
			JChat.ChatBox.TextEntry:SetVisible(true)
			JChat.FakePanel:SetVisible(true)
			JChat.FakePanel:MakePopup()
			JChat.ChatBox.TextEntry:RequestFocus()
			return true
		end
	end
	hook.Add("PlayerBindPress", "JChat.PlayerBindPress", OpenChat)


	hook.Add("HUDShouldDraw", "JChat.HUDShouldDraw", function(elem)
		if elem == "CHudChat" then
			return false
		end
	end)      ]]

	-- TESTING
	local oldChatAddText = chat.AddText

	local test = vgui.Create('DChatPanel')
	--test:MoveToBack()

	function GM:StartChat()
		return true
	end

	function GM:HUDShouldDraw(name)
		if(name == "CHudChat") then  -- Stop default HUD behaviour ALL OF IT
			return false
		end
		return true -- Otherwise all the hud elements go bye bye :C
	end

	function GM:PlayerBindPress(ply, bind, pressed)
		if pressed and string.find(bind, "messagemode") then

			if string.find(bind, "messagemode2") then  -- Is Team Chat?
				test.input:SetTeam( true )
			else
				test.input:SetTeam( false )
			end

			test:SetVisible( true )
			test.viewport:SetVisible( true )
			test.msgBox:SetVisible( true )
			test.input:SetVisible( true )
			test.viewport:SetPopupStayAtBack()
			test.input:SetPopupStayAtBack()
			test.viewport:MakePopup()
			test:PerformLayout() -- Now, not next frame. I've got to fix all the shit makepopup did :/

			if test.input:IsTeam() then --- TODO Make this use some off side prefix / label system & use race color
				test.input:SetText("( "..player_manager.RunClass( ply, "getRace" ).." ) ")
				test.input:SetCaretPos( self:GetValue():len() )
			end

			--test:InvalidateLayout( true )
			test.input:RequestFocus()  -- Essentially adds to focus queue

			return true
		end
	end

	function GM:OnPlayerChat(  ply, msg, msgIsTeam, plyIsDead  )
		local data = {}

		--- TODO ConVar for if dead should be able to talk, at the moment default is accepted.
		if ply then
			data.sender = ply
			data.race = player_manager.RunClass( ply, "getRace" )
			data.raceColor = player_manager.RunClass( ply, "getRaceColor" )
			data.msg = msg:Trim() -- Trim any whitespace from either end just in case
			--- TODO Make a function to track delay in send and receive time, using net lib
			data.sendTime = CurTime()
			data.teamMsg = msgIsTeam
		end -- We should have all our msg data now.

		-- Pass this data to msgBox to construct itself an object and store it.
		test.msgBox.addMsg( data ) --- TODO Make this function use MESSAGE:new in VGUI element file





	end


	function GM:ChatText( ply,  name, msg, type )

		--- TODO filter this out, use OnPlayerChat instead as it catches teamChat
		--- TODO Just use ChatText for join/leave events? or console events?

		if type == "joinleave" then -- This is if a client leaves or joins
			-- Set colour, filter for leave or join
			-- Print Msg
		end
		--[[
		elseif type == "none" then -- Standard message
			-- Parse it accordingly,
			-- Add it to chat
		end  ]]-- Because we parsed above in OnPlayerChat for standard messages anyay?

	end

	function chat.AddText(...)
		local args = {... }

		local data = {} -- We'll construct our message into here :D

		for k, v in pairs( args ) do -- For each argument it will be either a color, string, or player

			if type(v) == "table" and v.r and v.g and v.b then
				local clr = Color( v.r, v.g, v.b, 255 )
				table.insert( data, clr )
			elseif type(v) == "Player" then
				-- Get it's nick
				local plyNick = v:Nick()
				table.insert( data, plyNick)
			elseif type(v) == "string" then
				surface.SetFont( "ChatText" )
				if #v < test.msgBox:GetWide() then
					for str in string.gmatch( v, "%s?[(%S)]+[^.]?" ) do
						table.insert( data, str)
					end
				else
					local len = 0
					for str in string.gmatch( v, "%s?[(%S)]+[^.]?" ) do
						local w, h = surface.GetTextSize(str)
						local sw, sh = surface.GetTextSize("W")

						if #str + len > test.msgBox:GetWide() then
							MsgN("WTF IS GOING ON :C")
						end
					end
				end
			end
		end

		test.msgBox:addMsg( {sender = "CONSOLE", race = nil, raceColor = nil, msg = data, sendTime = CurTime(), teamMsg = false  } )
        --test:AddMessage( {sender = "CONSOLE", race = nil, raceColor = nil, msg = data, sendTime = CurTime(), teamMsg = false  } )
		oldChatAddText(unpack(data))
	end
end


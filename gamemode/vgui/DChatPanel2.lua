
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

local PANEL = {}

surface.SetFont("ChatFont")
local textWidth, textHeight = surface.GetTextSize("W")

function PANEL:Init()
    local parent = self
    self.messages = {}
    self.maxLines = 10 -- This refer to max amount shown at any given time.
    self.lineHeight = textHeight + 3 -- Space by max height and then 3

    local color =  Color(50, 50, 50, 70)
    local outlineColor = Color(255, 255, 255)

    self:SetSize(520, (self.maxLines+2) * self.lineHeight) -- Define our size and position
    self:SetPos( 20, ScrH() * 0.75 - self:GetTall() )

    local closeButton = vgui.Create('DButton', self)
    closeButton:SetFont('marlett')
    closeButton:SetText('r')
    closeButton:SetColor(Color(255, 255, 255))
    closeButton:SetSize(15, 15)
    closeButton:SetDrawBackground(false)
    closeButton:SetPos(self:GetWide() - 25, 10)
    closeButton.DoClick = function()
        parent:close()
    end
    local oldPaint = closeButton.Paint
    function closeButton:Paint()
        if parent:isVisible() then
           oldPaint(self)
        end
    end

    self.input = self:Add( "DTextEntry" )
    self.input:SetHistoryEnabled( true )
    self.input:SetSize( self:GetWide(), 20)
    local x, y = self:GetPos()
    self.input:SetPos( 0, (self.maxLines + 1) * self.lineHeight ) -- Place at bottom of viewport
    self.input:SetAllowNonAsciiCharacters(true)
    self.input:SetTextInset(0, 0)

    self.input.Paint = function ( self )
        if parent:isVisible() then -- Somebody is typing
            -- input body
            surface.SetDrawColor(color)
            surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

            -- input outline
            surface.SetDrawColor(outlineColor)
            surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())

            -- Txt Color, Highlight Color, Cursor color
            self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
        end
    end

    self.msgBox = self:Add( "DScrollPanel" )
    self.msgBox:SetSize( self:GetWide(), self.maxLines * self.lineHeight )
    self.msgBox:SetPos( 0, 0 ) -- Place at top of viewport

    self.msgBox.Paint = function ( self )
        -- In box
        if parent:isVisible() then -- Somebody is typing
            draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), color )

            -- Outline
            surface.SetDrawColor(outlineColor)
            surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())

            for k, v in pairs(self:GetChildren()[1]:GetChildren()) do
               v:Paint()
            end
        end
    end
end

function PANEL:isVisible()
    return (self.input and self.input:HasFocus()) or self:hasActiveMessages()
end

local lastExpireTime = 0
local timeToExpire = 20
function PANEL:hasActiveMessages()
    return lastExpireTime > CurTime()
end

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
local lineOfText, items, parent
function PANEL:AddMessage(message)
    parent = self
    local color = Color(255, 255, 255, 255)
    items =  self.msgBox:GetChildren()[1]:GetChildren()

    local isNew = true
    for k, v in pairs(message.msg) do
        if type(v) == "table" then
            color = Color(v.r, v.g, v.b, v.a)
        else
            lineOfText = vgui.Create("DPanel")
            lineOfText.color = color
            lineOfText.text = v
            lineOfText.isNew = isNew
            isNew = false
            surface.SetFont("ChatFont")
            textWidth, textHeight = surface.GetTextSize(v)
            lineOfText:SetSize(textWidth, textHeight + 3)
            function lineOfText:Paint()
                if parent:isVisible() then
                    surface.SetTextColor( self.color)
                    surface.SetTextPos( self:GetPos() )
                    surface.DrawText( self.text )
                end
            end
            self.msgBox:AddItem(lineOfText)
            lastExpireTime = CurTime() + timeToExpire
        end
        --print("Adding message")
    end
    items =  self.msgBox:GetChildren()[1]:GetChildren()
    if #items > 100 then
        self:RemoveItem(items[1])
        --table.remove(self.msgBox:GetChildren(), 1)
    end
    items =  self.msgBox:GetChildren()[1]:GetChildren()
    local x, y = 0, 0
    for k, v in pairs(items) do
        v:SetPos(x, y)
        if v.isNew or x + v:GetWide() > self.msgBox:GetWide() then
           x, y = 0, y + v:GetTall()
        else
            x = x + v:GetWide() + 3
        end
    end
    PrintTable(items)
end

function PANEL:Paint()

    --draw.RoundedBox(10, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 150))

end

vgui.Register('DChatPanel2', PANEL, 'EditablePanel')


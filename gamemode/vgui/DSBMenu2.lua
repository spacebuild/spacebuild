
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


local COLORS = {
    bg = Color(0, 0, 0, 150),
    buttonBg = Color(240, 240, 240, 255),
    white = Color(255, 255, 255, 255),
    blue = Color(29, 116, 184, 255),
    black = Color(0, 0, 0, 255),
    darkGray = Color(100, 100, 100, 255)
}

local PANEL = {}

function PANEL:Init()
    self.text = ""
    self.color = COLORS.bg
    self:SetTextColor(COLORS.white)
    self:SetFont("SB_Menu_Heading2")
end

function PANEL:SetColor(color)
    self.color = color or COLORS.bg
end

function PANEL:GetColor()
    return self.color
end

function PANEL:Paint()
    surface.SetDrawColor(self.color)
    surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
end

vgui.Register('DSBMenuTitle', PANEL, "DButton")

PANEL = {}

function PANEL:Init()
    self.text = ""
    self.color = COLORS.bg
    self:SetTextColor(COLORS.white)
    self:SetFont("SB_Menu_Heading2")
    self.drawOutline = true
    self.Icon = vgui.Create( "DImage", self )
    self.Icon:SetImage( "icon16/folder.png" )
    self.Icon:SetSize(24, 24)
    self.Icon:SetPos(10, 2)
end

function PANEL:RemoveIcon()
    self.Icon:Remove()
end

function PANEL:SetImage(image)
    self.Icon:SetImage( image )
end

function PANEL:SetColor(color)
    self.color = color or COLORS.bg
end

function PANEL:SetDrawOutline(draw)
    self.drawOutline = draw
end

function PANEL:GetColor()
    return self.color
end

function PANEL:Paint()
    surface.SetDrawColor(self.color)
    surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
    surface.SetDrawColor(COLORS.darkGray)
    if self.drawOutline then
        surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
    end
end
vgui.Register('DSBMenuItem', PANEL, "DButton")


PANEL = {}

function PANEL:Init()
    self:SetSize( 224, 738 )
    self:SetPos(0, 0)
    self.maxy = 0

    -- Title Element
    self.title = vgui.Create("DSBMenuTitle", self)
    self.title:SetFont('SB_Menu_Heading')
    self.title:SetPos(0, 0)
    self.title:SetSize(self:GetWide(), 70)
    self.title:SetText("Spacebuild")
    self.title:SetColor(COLORS.blue)

    self.maxy = self.maxy + self.title:GetTall()

end

function PANEL:setTitle(title)
    self.title:SetText(title or "Invalid String")
end

function PANEL:getTitle()
    return self.title:GetText()
end

function PANEL:AddItem(text, callback)
    local element = vgui.Create("DSBMenuItem", self)
    element:SetText(text)
    element:SetPos(0, self.maxy)
    element:SetFont('SB_Menu_Heading2')
    element:SetSize(self:GetWide(), 30)
    element:SetColor(COLORS.buttonBg)
    element:SetTextColor(COLORS.darkGray)
    element.DoClick = callback
    self.maxy = self.maxy + element:GetTall()
    return element
end

function PANEL:AddEmptyItem()
    local element = vgui.Create("DSBMenuItem", self)
    element:SetText("")
    element:SetPos(0, self.maxy)
    element:SetSize(self:GetWide(), 30)
    element:SetDrawOutline(false)
    element:RemoveIcon()
    self.maxy = self.maxy + element:GetTall()
end

function PANEL:Paint()
    --surface.SetDrawColor(COLORS.bg)
    --surface.DrawRect( 0,0, self:GetWide(), self:GetTall() )

    surface.SetDrawColor(COLORS.white)
    surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
end

vgui.Register('DSBMenuSideBar', PANEL)

PANEL = {}

function PANEL:Init()
    local parent = self
    self:SetSize( 1024, 768 )
    self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))

    self.sideBar = vgui.Create("DSBMenuSideBar", self)

    self.content = vgui.Create("DScrollPanel", self)
    function self.content:Paint()

    end
    self.content:SetPos(224, 0)
    self.content:SetSize(800, 768)

    self.sideBar:AddEmptyItem()
    local button = self.sideBar:AddItem("Shop", function(button)
        parent:SetContent(vgui.Create("DShopPanel"))
    end)
    button:SetImage("icons/48/shop.png")
    button = self.sideBar:AddItem("Inventory", function(button) print("clicked") end)
    button:SetImage("icons/48/inventory.png")
    button = self.sideBar:AddItem("Races", function(button)
        parent:SetContent(vgui.Create("DRacePickPanel"))
    end)
    button:SetImage("icons/48/races.png")
    button = self.sideBar:AddItem("Chat log", function(button) print("clicked") end)
    button:SetImage("icons/48/chat.png")
    button = self.sideBar:AddItem("Settings", function(button) print("clicked") end)
    button:SetImage("icons/48/settings.png")

    self.credits = vgui.Create("DSBMenuItem", self)
    self.credits:SetFont('SB_Menu_Heading2')
    self.credits:SetColor(COLORS.buttonBg)
    self.credits:SetTextColor(COLORS.darkGray)
    self.credits:SetPos(0, 738)
    self.credits:SetSize(224, 30)
    self.credits:SetImage("icons/48/credits.png")
end

function PANEL:GetCredits()
    return player_manager.RunClass( LocalPlayer(), "getCredits" ) or 0
end

function PANEL:close()
    gui.EnableScreenClicker(false)
    self:onClose()
    self:Remove()
end

function PANEL:onClose()
    -- fill this in with custom stuff
end

function PANEL:onShow()
    -- fill this in with custom stuff
end

function PANEL:Show()
    gui.EnableScreenClicker(true)
    self:onShow()
end

function PANEL:SetContent(content)
    self.content:Clear()
    self.content:AddItem(content)
end

function PANEL:Paint()
    Derma_DrawBackgroundBlur(self)

    surface.SetDrawColor(COLORS.bg)
    surface.DrawRect( 0,0, self:GetWide(), self:GetTall() )

    self.credits:SetText(tostring(self:GetCredits()))

end

vgui.Register('DSBMenu2', PANEL)

-- Shop Stuff

PANEL = {}

function PANEL:Init()
    local parent = self
    self:SetMouseInputEnabled( true )
    self:SetKeyboardInputEnabled( true )

    self:SetCursor( "hand" )
    self:SetSize(72, 72)
    self.Icon = vgui.Create( "DImage", self )
    self.Icon:SetImage( "icon16/folder.png" )
    self.Icon:SetSize(48, 48)
    self.Icon:SetPos(12, 4)
    --[[function self.Icon:DoClick()
       parent:DoClick()
    end ]]

    self.Text = vgui.Create( "DLabel", self )
    self.Text:SetPos(0, 52)
    self.Text:SetSize(72, 12)
    self.Text:SetContentAlignment( 2 )

    self.color = COLORS.bg
    self.Text:SetTextColor(COLORS.white)
    self.Text:SetFont("StoreMenuFont")
    self.drawOutline = true

end

function PANEL:DoClick()

end

function PANEL:DoRightClick()
end

function PANEL:DoMiddleClick()
end

--[[---------------------------------------------------------
	OnMouseReleased
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )

    self:MouseCapture( false )

    if ( mousecode == MOUSE_RIGHT ) then
        self:DoRightClick()
    end

    if ( mousecode == MOUSE_LEFT ) then
        self:DoClick()
    end

    if ( mousecode == MOUSE_MIDDLE ) then
        self:DoMiddleClick()
    end

end

function PANEL:SetText(text)
    self.Text:SetText(text)
end

function PANEL:SetImage(image)
    self.Icon:SetImage( image )
end

function PANEL:SetColor(color)
    self.color = color or COLORS.bg
end

function PANEL:SetDrawOutline(draw)
    self.drawOutline = draw
end

function PANEL:GetColor()
    return self.color
end

function PANEL:Paint()
    surface.SetDrawColor(self.color)
    surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
    surface.SetDrawColor(COLORS.darkGray)
    if self.drawOutline then
        surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
    end
end
vgui.Register('DSBShopMenuItem', PANEL)


PANEL = {}

function PANEL:Init()
    self:SetSize( 72, 698 )
    self:SetPos(5, 0)
    self.maxy = 0
end

function PANEL:AddItem(text, callback)
    local element = vgui.Create("DSBShopMenuItem", self)
    element:SetText(text)
    element:SetPos(0, self.maxy)
    element.DoClick = callback
    self.maxy = self.maxy + element:GetTall()
    return element
end

function PANEL:Paint()
    --surface.SetDrawColor(COLORS.bg)
    --surface.DrawRect( 0,0, self:GetWide(), self:GetTall() )

    surface.SetDrawColor(COLORS.white)
    surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
end

vgui.Register('DSBShopMenuSideBar', PANEL)



local item, credits
local function createItem(cat_name, item_name, v)
    credits = player_manager.RunClass( LocalPlayer(), "getCredits" ) or 0
    item = vgui.Create( "DModelPanel" ) --SpawnIcon
    item:SetSize( 80, 80 )
    item:SetModel( v.model )
    item:SetToolTip(v.name)
    local ent = item.Entity
    if v.material then
        ent:SetMaterial(v.material)
    end
    if v.skin then
        ent:SetSkin(v.skin)
    end


    item.item = {cat = cat_name, name = item_name}


    local PrevMins, PrevMaxs = ent:GetRenderBounds()
    item:SetCamPos(PrevMins:Distance(PrevMaxs)*Vector(0.75, 0.75, 0.5))
    item:SetLookAt((PrevMaxs + PrevMins)/2)

    local Label = vgui.Create( "DLabel", item )
    Label:Dock( BOTTOM )
    Label:SetContentAlignment( 2 )
    Label:DockMargin( 4, 0, 4, 4 )
    if v.price == 0 or v.price <= credits then --Player has enough money
        Label:SetTextColor( Color( 42, 255, 9, 255 ) )
    else -- Player doesn't have enough money
        Label:SetTextColor( Color( 255, 9, 9, 255 ) )
    end
    Label:SetFont( "StorePriceFont" )
    Label:SetExpensiveShadow( 1, Color( 0, 0, 0, 200 ) )
    if v.price == 0 then
        Label:SetText("Free")
    else
        Label:SetText(v.price)
    end
    return item
end


local PANEL = {}

function PANEL:Init()
    local this = self
    self:SetSize(800, 768)
    self:SetPos(0, 0)

    local label = vgui.Create("DLabel", self)
    label:SetFont('SB_Menu_Heading')
    label:SetPos(0, 0)
    label:SetSize(800, 70)
    label:SetContentAlignment( 2 )
    label:SetText("Shop")

    local x, y = 0, 70;

    --[[
        Shop Panel
     ]]

    local items = GAMEMODE:getItems()

    local tree_ui = vgui.Create("DSBShopMenuSideBar", self)
    tree_ui:SetPos(x, y)

    x = x + 80
    local DLabel = vgui.Create( "DLabel", self )
    DLabel:SetPos( x, y )
    DLabel:SetSize(200, 25)
    DLabel:SetFont("SB_Menu_Heading2")
    DLabel:SetText( "Shop Items" )

    local outer_icon_panel = vgui.Create("DScrollPanel", self)
    outer_icon_panel:SetPos(x, y + 30)
    outer_icon_panel:SetSize(805, 400)
    local icon_panel = vgui.Create("DGrid")
    icon_panel:SetCols( 8 )
    icon_panel:SetColWide( 85 )
    icon_panel:SetRowHeight( 85 )
    outer_icon_panel:AddItem(icon_panel)

    local DLabel = vgui.Create( "DLabel", self )
    DLabel:SetPos( x, y + 425 )
    DLabel:SetSize(200, 25)
    DLabel:SetFont("SB_Menu_Heading2")
    DLabel:SetText( "Selected items" )

    local outer_icon_buy_panel = vgui.Create("DScrollPanel", self)
    outer_icon_buy_panel:SetPos(x, y + 450)
    outer_icon_buy_panel:SetSize(805, 150)
    local icon_buy_panel = vgui.Create("DGrid")
    icon_buy_panel:SetCols( 8 )
    icon_buy_panel:SetColWide( 85 )
    icon_buy_panel:SetRowHeight( 85 )
    outer_icon_buy_panel:AddItem(icon_buy_panel)

    local buyButton = vgui.Create( "DButton", self )
    buyButton:SetPos( x + 200, y + 425 )
    buyButton:SetText( "Buy selected items" )
    buyButton:SetSize( 100, 25 )
    buyButton.DoClick = function()
        for _, v in pairs(icon_buy_panel:GetItems()) do
            net.Start( "SPAWNITEM" )
            net.WriteString( v.item.cat )
            net.WriteString( v.item.name )
            net.SendToServer()
            icon_buy_panel:RemoveItem(v)
        end

    end

    local clearButton = vgui.Create( "DButton", self )
    clearButton:SetPos( x + 310, y + 425 )
    clearButton:SetText( "Clear selected items" )
    clearButton:SetSize( 120, 25 )
    clearButton.DoClick = function()
        for _, v in pairs(icon_buy_panel:GetItems()) do
            icon_buy_panel:RemoveItem(v)
        end

    end

    local node
    for cat_name, cat in pairs(items) do
        node = tree_ui:AddItem( cat.name, function()
            for _, v in pairs(icon_panel:GetItems()) do
                icon_panel:RemoveItem(v)
            end
            for item_name, v in pairs(cat.items) do
                item = createItem(cat_name, item_name, v, credits)

                function item:DoClick()
                    item = createItem(cat_name, item_name, v, credits)
                    function item:DoClick()
                        icon_buy_panel:RemoveItem(self)
                    end
                    icon_buy_panel:AddItem(item)
                    item = nil
                end
                icon_panel:AddItem( item )
            end
        end )
        if cat.icon then
            node:SetImage(cat.icon)
        end
    end
    node, item = nil, nil
end
vgui.Register('DShopPanel', PANEL)

-- Races

local PANEL = {}

function PANEL:Init()

    self:SetSize(800, 768)
    self:SetPos(0, 0)

    local label = vgui.Create("DLabel", self)
    label:SetFont('SB_Menu_Heading')
    label:SetPos(0, 0)
    label:SetSize(800, 70)
    label:SetContentAlignment( 2 )
    label:SetText("Race picker")

    local x, y = 5, 70;
    local panel = self

    local races =  GAMEMODE:getRaces()
    local DermaButton, modelPanel, selectedRace, raceSelectButton, descriptionText
    for k, v in pairs(races) do
        DermaButton = vgui.Create( "DButton", self )
        DermaButton:SetText( v.RaceName )
        DermaButton:SetPos( x, y )
        x = x + 200
        DermaButton:SetSize( 192, 48 )
        DermaButton.DoClick = function()
            selectedRace = k
            raceSelectButton:SetDisabled(false)
            descriptionText:SetText( v.RaceName )
            raceSelectButton:SetText( "Select "..tostring(v.RaceName) )
            function modelPanel.Entity:GetPlayerColor() return v.PlayerColor end --we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.
        end
    end

    -- Reset
    x = 25
    y = y + 60

    modelPanel = vgui.Create("DModelPanel", self)
    modelPanel:SetSize(192, 192)
    modelPanel:SetModel( "models/player/alyx.mdl" ) -- you can only change colors on playermodels
    --function modelPanel:LayoutEntity( Entity ) return end -- disables default rotation
    --function modelPanel.Entity:GetPlayerColor() return v.PlayerColor end --we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.

    modelPanel:SetPos( x, y )

    x = x + 200

    descriptionText = vgui.Create( "DLabel", self )
    descriptionText:SetPos( x, y )
    descriptionText:SetText( "" )

    -- Text and stuff here

    x, y = 25, y + 200

    raceSelectButton = vgui.Create( "DButton", self )
    raceSelectButton:SetText( "No Race Selected" )
    raceSelectButton:SetPos( x, y )
    raceSelectButton:SetSize( 192, 48 )
    raceSelectButton:SetDisabled(true)
    raceSelectButton.DoClick = function()
        if(selectedRace) then
            net.Start( "RACECHANGE" )
            net.WriteString( selectedRace )
            net.SendToServer()
        end
    end
end
vgui.Register('DRacePickPanel', PANEL)




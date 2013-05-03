
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

local item
local function createItem(cat_name, item_name, v, credits)
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
    self:setTitle("Shop Menu")
    self:setSlogan("Pick your items")
    local credits = player_manager.RunClass( LocalPlayer(), "getCredits" ) or 0
    self:setByLine(tostring(credits).." credits")

    local x, y = 25, 95;

    local PropertySheet = vgui.Create( "DPropertySheet", self )
    PropertySheet:SetPos( x, y )
    PropertySheet:SetSize( self:GetWide() -(x * 2), self:GetTall() - (y + 25) )

    function PropertySheet:Paint()

    end

    local shopPanel = vgui.Create("DPanel")
    function shopPanel:Paint()

    end
    local inventoryPanel = vgui.Create("DPanel")
    function inventoryPanel:Paint()

    end
    local tab = PropertySheet:AddSheet("Shop", shopPanel, "icons/48/shop.png", false, false, "Shop menu")
    function tab.Tab:DoClick()
        self:GetPropertySheet():SetActiveTab( self )
        this:setTitle("Shop Menu")
        this:setSlogan("Pick your items")
    end
    function tab.Tab:Paint()
    end
    tab.Tab.Image:SetSize(16, 16)
    tab = PropertySheet:AddSheet("Inventory", inventoryPanel, "icons/48/inventory.png", false, false, "Inventory menu")
    function tab.Tab:DoClick()
        self:GetPropertySheet():SetActiveTab( self )
        this:setTitle("Inventory")
        this:setSlogan("View your items")
    end
    function tab.Tab:Paint()
    end
    tab.Tab.Image:SetSize(16, 16)

    --[[
        Shop Panel
     ]]
    x, y = 0, 5;

    local items = GAMEMODE:getItems()

    local tree_ui = vgui.Create("DTree", shopPanel)
    tree_ui:SetPos(x, y)
    tree_ui:SetSize(150, 600)  -- 974 - 170 = 807
    tree_ui:SetLineHeight(25)
    --tree_ui:SetIndentSize( 14 )
    --tree_ui:SetPadding( 2 )

    x = x + 170
    local DLabel = vgui.Create( "DLabel", shopPanel )
    DLabel:SetPos( x, y )
    DLabel:SetSize(200, 25)
    DLabel:SetFont("SB_Menu_Heading2")
    DLabel:SetText( "Shop Items" )

    local outer_icon_panel = vgui.Create("DScrollPanel", shopPanel)
    outer_icon_panel:SetPos(x, y + 30)
    outer_icon_panel:SetSize(805, 400)
    local icon_panel = vgui.Create("DGrid")
    icon_panel:SetCols( 9 )
    icon_panel:SetColWide( 85 )
    icon_panel:SetRowHeight( 85 )
    outer_icon_panel:AddItem(icon_panel)

    local DLabel = vgui.Create( "DLabel", shopPanel )
    DLabel:SetPos( x, y + 425 )
    DLabel:SetSize(200, 25)
    DLabel:SetFont("SB_Menu_Heading2")
    DLabel:SetText( "Selected items" )

    local outer_icon_buy_panel = vgui.Create("DScrollPanel", shopPanel)
    outer_icon_buy_panel:SetPos(x, y + 450)
    outer_icon_buy_panel:SetSize(805, 150)
    local icon_buy_panel = vgui.Create("DGrid")
    icon_buy_panel:SetCols( 9 )
    icon_buy_panel:SetColWide( 85 )
    icon_buy_panel:SetRowHeight( 85 )
    outer_icon_buy_panel:AddItem(icon_buy_panel)

    local buyButton = vgui.Create( "DButton", shopPanel )
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

    local clearButton = vgui.Create( "DButton", shopPanel )
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
        node = tree_ui:AddNode( cat.name )
        node.Icon:SetSize(24, 24)
        if cat.icon then
            node.Icon:SetImage(cat.icon)
        end
        function node:DoClick()
           for _, v in pairs(icon_panel:GetItems()) do
              icon_panel:RemoveItem(v)
           end
           for item_name, v in pairs(cat.items) do
               item = createItem(cat_name, item_name, v, credits)

               function item:DoClick()
                   item = createItem(cat_name, item_name, v, credits)
                   function item:DoClick()
                       icon_buy_panel:AddItem(self)
                   end
                   icon_buy_panel:AddItem(item)
                   item = nil
               end
               icon_panel:AddItem( item )
           end
        end
    end
    node, item = nil, nil
end
vgui.Register('DItemMenu', PANEL, 'DSBMenu')


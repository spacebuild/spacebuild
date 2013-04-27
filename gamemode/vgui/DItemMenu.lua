
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

function PANEL:Init()
    self:setTitle("Item Menu")
    self:setSlogan("Pick your items")
    self:setByLine("Test")


    local x, y = 25, 100;

    local items = GAMEMODE:getItems()

    local tree_ui = vgui.Create("DTree", self)
    tree_ui:SetPos(x, y)
    tree_ui:SetSize(150, 550)  -- 974 - 170 = 807

    x = x + 170
    local icon_panel = vgui.Create("DGrid", self)
    icon_panel:SetPos(x, y)
    icon_panel:SetSize(805, 550)
    icon_panel:SetCols( 9 )
    icon_panel:SetColWide( 85 )
    icon_panel:SetRowHeight( 85 )

    local node, item
    for cat_name, cat in pairs(items) do
        node = tree_ui:AddNode( cat.name )
        function node:DoClick()
           for _, v in pairs(icon_panel:GetItems()) do
              icon_panel:RemoveItem(v)
           end
           for item_name, v in pairs(cat.items) do
               item = vgui.Create( "SpawnIcon" ) --DModelPanel
               item:SetSize( 80, 80 )
               item:SetModel( v.model )
               item:SetToolTip(v.name)
               function item:DoClick()
                   net.Start( "SPAWNITEM" )
                       net.WriteString( cat_name )
                       net.WriteString( item_name )
                   net.SendToServer()
               end
               icon_panel:AddItem( item )
           end
        end
    end
end

vgui.Register('DItemMenu', PANEL, 'DSBMenu')


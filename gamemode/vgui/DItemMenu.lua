
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

    local CatList = vgui.Create( "DCategoryList", self )
    CatList:SetPos( x, y )
    CatList:SetSize( 974, 643 );

    local items = GAMEMODE:getItems()

    local cat_ui, cat_content_ui
    for cat_name, cat in pairs(items) do
        cat_ui = CatList:Add( cat.name )
        cat_content_ui = vgui.Create( "DPanel")
        cat_content_ui:SetSize(974, 643)
        --cat_ui:SetSize(974, 643)


        --[[---------------------------------------------------------
           Name: PerformLayout
        -----------------------------------------------------------]]
        function cat_ui:SizeToChildren()
            self:SetSize(self.Contents:GetTall(), self.Contents:GetWide())
        end

        -- Test
        local DLabel = vgui.Create( "DLabel", cat_content_ui )
        DLabel:SetPos( 10, 10 ) -- Set the position of the label
        DLabel:SetText( cat.name ) --  Set the text of the label
        DLabel:SizeToContents() -- Size the label to fit the text in it
        DLabel:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one

        cat_ui:SetContents(cat_content_ui)
        -- End test
    end
end

vgui.Register('DItemMenu', PANEL, 'DSBMenu')


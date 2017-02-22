--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
---------------------------------------------------------]]
function PANEL:Init()

    self.SpawnButton = vgui.Create("Button", self)
end

--[[---------------------------------------------------------
   Name: ApplySchemeSettings
---------------------------------------------------------]]
function PANEL:ApplySchemeSettings()
end

--[[---------------------------------------------------------
   Name: Setup
---------------------------------------------------------]]
function PANEL:Setup(in_table)
end

--[[---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------]]
function PANEL:PerformLayout()

    local Border = 3

    self.SpawnButton:SizeToContents()
    self.SpawnButton:SetSize(self:GetWide() - Border * 2, self.SpawnButton:GetTall() - Border + 6)
    --self.SpawnButton:SetSize( self:GetWide() - Border * 2, 24 - Border )
    self.SpawnButton:SetPos(Border, Border)

    self:SetSize(self:GetWide(), self.SpawnButton:GetTall() + Border * 2)
end

--[[---------------------------------------------------------
   Name: SetID
---------------------------------------------------------]]
function PANEL:SetCommands(toolname, name, model, type, num)

    self.toolname = toolname
    self.name = name
    self.num = tostring(num)
    self.SpawnButton:SetText(name)
    self.SpawnButton.DoClick = function() LocalPlayer():ConCommand(toolname .. "_name " .. num .. "\n" .. toolname .. "_model " .. model .. "\n" .. toolname .. "_type " .. type .. "\n") end

    self:InvalidateLayout()
end

--[[---------------------------------------------------------
   Name: Paint
---------------------------------------------------------]]
function PANEL:Paint()

    if (LocalPlayer():GetInfo(self.toolname .. "_name") == self.num) then
        local bgColor = Color(50, 50, 255, 250)
        draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), bgColor)
    end

    return false
end

vgui.Register("CAFButton", PANEL, "Panel")


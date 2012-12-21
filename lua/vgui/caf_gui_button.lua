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


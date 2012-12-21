local PANEL = {}


--[[---------------------------------------------------------
   Name: 
---------------------------------------------------------]]
function PANEL:Init()

    self.List = vgui.Create("DPanelList", self)
    self.List:SetSpacing(1)
    self.List:EnableVerticalScrollbar()

    self.EntList = {}

    self:ApplySchemeSettings()
end

--[[---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------]]
function PANEL:ApplySchemeSettings()
end

--[[---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------]]
function PANEL:PerformLayout()

    local Border = 10
    local Tall = 402
    local iTop = Tall - Border

    self.List:SetPos(Border, Border)
    self.List:SetSize(self:GetWide() - Border * 2, iTop - Border * 2)
    self.List:InvalidateLayout(true)

    self:SetSize(self:GetWide(), Tall)
end

--[[---------------------------------------------------------
   Name: Paint
---------------------------------------------------------]]
function PANEL:Paint()

    local bgColor = Color(130, 130, 130, 255)
    draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), bgColor)

    return true
end

--[[---------------------------------------------------------
   Name: Clear
---------------------------------------------------------]]
function PANEL:Clear()

    for k, panel in pairs(self.List.Items) do
        panel:Remove()
    end

    self.List.Items = {}
end

--[[---------------------------------------------------------
   Name: SortByName
---------------------------------------------------------]]
function PANEL:SortByName()

    table.sort(self.List.Items, function(a, b)
        if (b.name == nil) then return false end
        if (a.name == nil) then return true end
        return b.name > a.name
    end)
end

--[[---------------------------------------------------------
   Name: Populate
---------------------------------------------------------]]
function PANEL:Populate()

    self:Clear()

    local n = 0
    for k, v in pairs(list.Get(self.ListName)) do
        local Button = vgui.Create("CAFButton", self)
        n = n + 1
        Button:SetCommands(self.ToolName, v.name, v.model, v.type, n)
        self.List:AddItem(Button)
    end

    self:SortByName()
end

--[[---------------------------------------------------------
   Name: SetList
---------------------------------------------------------]]
function PANEL:SetList(ToolName, ListName)

    self.ToolName = ToolName
    self.ListName = ListName

    self:Populate()
end


vgui.Register("CAFControl", PANEL, "Panel")


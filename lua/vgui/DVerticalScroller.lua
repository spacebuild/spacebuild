--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DVerticalScroller
	
	Made to scroll the tabson PropertySheet, but may have other uses.
	
]]

PANEL = {}

AccessorFunc(PANEL, "m_iOverlap", "Overlap")

--[[---------------------------------------------------------

---------------------------------------------------------]]
function PANEL:Init()

    self.Panels = {}
    self.OffsetX = 0
    self.FrameTime = 0

    self.pnlCanvas = vgui.Create("Panel", self)

    self:SetOverlap(2)

    self.btnLeft = vgui.Create("DSysButton", self)
    self.btnLeft:SetType("up")

    self.btnRight = vgui.Create("DSysButton", self)
    self.btnRight:SetType("down")
end

--[[---------------------------------------------------------

---------------------------------------------------------]]
function PANEL:AddPanel(pnl)

    table.insert(self.Panels, pnl)

    pnl:SetParent(self.pnlCanvas)
end

--[[---------------------------------------------------------
   Name: OnMouseWheeled
---------------------------------------------------------]]
function PANEL:OnMouseWheeled(dlta)

    self.OffsetX = self.OffsetX + dlta * -30
    self:InvalidateLayout(true)

    return true
end

--[[---------------------------------------------------------

---------------------------------------------------------]]
function PANEL:Think()

    -- Hmm.. This needs to really just be done in one place
    -- and made available to everyone.
    local FrameRate = VGUIFrameTime() - self.FrameTime
    self.FrameTime = VGUIFrameTime()

    if (self.btnRight:IsDown()) then
        self.OffsetX = self.OffsetX + (500 * FrameRate)
        self:InvalidateLayout(true)
    end

    if (self.btnLeft:IsDown()) then
        self.OffsetX = self.OffsetX - (500 * FrameRate)
        self:InvalidateLayout(true)
    end
end

--[[---------------------------------------------------------
    PerformLayout
---------------------------------------------------------]]
function PANEL:PerformLayout()

    local w, h = self:GetSize()

    self.pnlCanvas:SetTall(h)

    local x = 0

    for k, v in pairs(self.Panels) do

        v:SetPos(0, x) -- x, 0
        v:SetTall(20)
        v:SetWide(100) --SetTall(h)
        v:ApplySchemeSettings()

        x = x + 20 - self.m_iOverlap --GetTall
    end

    self.pnlCanvas:SetTall(x + self.m_iOverlap) --SetWide

    if (w < self.pnlCanvas:GetWide()) then
        self.OffsetX = math.Clamp(self.OffsetX, 0, self.pnlCanvas:GetTall() - self:GetTall()) --GetWide, GetWide
    else
        self.OffsetX = 0
    end

    self.pnlCanvas.y = self.OffsetX * -1 --x

    self.btnLeft:SetSize(16, 16)
    self.btnLeft:AlignLeft(4)
    self.btnLeft:CenterVertical()

    self.btnRight:SetSize(16, 16)
    self.btnRight:AlignRight(4)
    self.btnRight:CenterVertical()

    self.btnLeft:SetVisible(self.pnlCanvas.y < 0) --x
    self.btnRight:SetVisible(self.pnlCanvas.y + self.pnlCanvas:GetTall() > self:GetTall()) --x, GetWide, GetWide
end

derma.DefineControl("DVerticalScroller", "", PANEL, "Panel")

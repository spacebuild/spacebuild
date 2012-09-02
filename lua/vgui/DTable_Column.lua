--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DListView
	
	Columned list view

--]]

local PANEL = {}

AccessorFunc(PANEL, "m_fSort", "Sort")
AccessorFunc(PANEL, "m_bCanSort", "CanSort", FORCE_BOOL)

function PANEL:DoClick()
    if self:GetCanSort() then --We won't sort if there is no sort function
        self:GetParent():SortByColumn(self:GetColumnID(), self:GetDescending())
        self:SetDescending(not self:GetDescending())
    end
end

function PANEL:SetViewFunction(func)
    self.view_func = func
end

function PANEL:GenerateViewForData(data, panel)
    local ret = nil;
    if not self.view_func then
        ret = vgui.Create("DListViewLabel", panel)
        ret:SetMouseInputEnabled(false)
        ret.Value = data
        ret:SetText(tostring(data))
    else
        ret = self.view_func(data)
    end
    return ret
end

derma.DefineControl("DTable_Column", "", PANEL, "DListView_Column")
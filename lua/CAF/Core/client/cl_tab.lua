--
--	Custom Addon Framework Tab Module and Tool Helper
--

include("CAF/Core/shared/CAF_Tools.lua")

local usetab = CreateClientConVar("CAF_UseTab", "1", true, false)

local function CAFTab()
    if usetab:GetBool() then
        spawnmenu.AddToolTab("Custom Addon Framework", "CAF")
    end
end

hook.Add("AddToolMenuTabs", "CAFTab", CAFTab)

function CAF_BuildCPanel(cp, toolname, listname, custom)
    cp:AddControl("CheckBox", { Label = "Don't Weld", Command = toolname .. "_DontWeld" })
    cp:AddControl("CheckBox", { Label = "Allow welding to world", Command = toolname .. "_AllowWorldWeld" })
    cp:AddControl("CheckBox", { Label = "Make Frozen", Command = toolname .. "_Frozen" })
    local ListControl = vgui.Create("CAFControl")
    cp:AddPanel(ListControl)
    ListControl:SetList(toolname, listname)
end


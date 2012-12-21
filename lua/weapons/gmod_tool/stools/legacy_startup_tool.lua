include("sb/legacy/tool_manifest.lua")

TOOL = ToolObj:Create()
TOOL.Category = "SB"
TOOL.Mode = "legacy_startup_tool"
TOOL.Name = "Legacy Tools Startup"
TOOL.Command = nil
TOOL.ConfigName = nil
TOOL.AddToMenu = false
TOOL.Tab = "Spacebuild"


function TOOL:LeftClick(trace)
    if (not trace.Entity:IsValid()) then return false end
    if (CLIENT) then return true end

    --for something else

    return true
end

function TOOL:RightClick(trace)
    if (not trace.Entity:IsValid()) then return false end
    if (CLIENT) then return true end

    --for something else

    return true
end

function TOOL:Reload(trace)
    if (not trace.Entity:IsValid()) then return false end
    if (CLIENT) then return true end

    --for something else

    return true
end
--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 28/12/12
-- Time: 21:01
-- To change this template use File | Settings | File Templates.
--

include(sb.core.extensions:getBasePath().."autorun/shared/functions.lua")

fluix = fluix or {}

--========================================Send files to client===================================================

local function import(send)
    local mods = fluix.wrappers:Find("file",fluix.basePath.."fluixmodules/*", "lsv")

    for k, v in ipairs( mods ) do
        if(string.sub(v,-4) == ".lua") then
                AddCSLuaFile(fluix.basePath.."fluixmodules/"..v)
        end
    end
    AddCSLuaFile(fluix.basePath.."classes/HudComponent.lua")
    AddCSLuaFile(fluix.basePath.."classes/HudBarIndicator.lua")
    AddCSLuaFile(fluix.basePath.."classes/HudPanel.lua")

end

if SERVER then
    import(true)
end
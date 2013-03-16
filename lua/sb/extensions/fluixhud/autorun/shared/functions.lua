--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 28/12/12
-- Time: 21:28
-- To change this template use File | Settings | File Templates.
--

sb.core.extensions:register("fluixHUD",{})

fluix = sb.core.extensions:get("fluixHUD")
fluix:construct()
fluix.name = "Fluix HUD"
fluix.wrappers = {}
fluix.modules = {}

--========================================Setup Wrapper Functions===================================================
function fluix.wrappers:Find(typeof,...)

    local arg = {...}

    local typeof = typeof
    local files = {};	local dirs = {}

    files, dirs = file.Find(...)

    if typeof == "file" then
        return files
    else
        return dirs
    end

end

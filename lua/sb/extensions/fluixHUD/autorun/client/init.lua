--
-- Created by IntelliJ IDEA.
-- User: Ash
-- Date: 29/12/12
-- Time: 00:54
-- To change this template use File | Settings | File Templates.
--

local sb = sb

require("class")
local class = class

class.registerClassPath(fluix.basePath.."classes/")

include(fluix.basePath.."fluixmodules/bottom_panel.lua")
include(fluix.basePath.."fluixmodules/top_panel.lua")
include(fluix.basePath.."fluixmodules/playersuit.lua")
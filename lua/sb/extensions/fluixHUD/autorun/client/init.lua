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

class.registerClassPath(sb.core.extensions:getBasePath().."classes/")

include(sb.core.extensions:getBasePath().."fluixmodules/bottom_panel.lua")
include(sb.core.extensions:getBasePath().."fluixmodules/top_panel.lua")
include(sb.core.extensions:getBasePath().."fluixmodules/playersuit.lua")
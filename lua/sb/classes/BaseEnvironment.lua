--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 27/12/12
-- Time: 23:29
-- To change this template use File | Settings | File Templates.
--

--Lua specific
local error = error
local tostring = tostring
local type = type

-- Gmod specific
local CurTime = CurTime
local net = net
-- Class specific
local C = CLASS
local sb = sb;
local core = sb.core

function C:isA(className)
    return className == "BaseEnvironment"
end

function C:init(ent, data)
    self.ent = ent
    self.data = data
    self.resources = {}
    self.modified = CurTime()
    self.start_sync_after = CurTime() + 1
end
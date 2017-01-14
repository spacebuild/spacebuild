--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 14/01/2017
-- Time: 22:48
-- To change this template use File | Settings | File Templates.
--

local SB = SPACEBUILD
local log = SB.log
local internal = SB.internal

local util = SB.util;
util.damage = {}
util.wire = {}

util.wire.render = function(ent)
    if Wire_Render then
        Wire_Render(ent)
    end
end





util.damage =  internal.readOnlyTable(util.damage)
util.wire =  internal.readOnlyTable(util.wire)













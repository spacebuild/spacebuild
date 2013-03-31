--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 27/12/12
-- Time: 23:30
-- To change this template use File | Settings | File Templates.
--

include("sb/classes/BaseEnvironment.lua")

-- Lua Specific
local type = type

-- Gmod specific
local Entity = Entity
local CurTime = CurTime
require("sbnet")
local net = sbnet

-- Class Specific
local C = CLASS
local sb = sb
local core = sb.core

-- Function Refs
local funcRef = {
	isA = C.isA,
	init = C.init,
	sendContent = C._sendContent,
	receiveSignal = C.receive,
	onSave = C.onSave,
	onLoad = C.onLoad
}

--local DEFAULT_SUN_ANGLE = Vector(0,0,-1)
local DEFAULT_SUN_POSITION = Vector(0, 0, 0)

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "SunEnvironment"
end

function C:getPos()
	return (self:getEntity() and self:getEntity():GetPos()) or DEFAULT_SUN_POSITION
end


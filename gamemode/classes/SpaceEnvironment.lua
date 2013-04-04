--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 27/12/12
-- Time: 23:30
-- To change this template use File | Settings | File Templates.
--

include("BaseEnvironment.lua")

-- Class Specific
local C = CLASS

-- Function Refs
local funcRef = {
	isA = C.isA,
	init = C.init,
	sendContent = C._sendContent,
	receiveSignal = C.receive,
	onSave = C.onSave,
	onLoad = C.onLoad
}

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "SpaceEnvironment"
end

function C:init()
	funcRef.init(self, -1)
	self.temperature = 14 -- in K
end

function C:getEntity()
	return nil
end

function C:hasName()
	return true
end

function C:getName()
	return "Space"
end


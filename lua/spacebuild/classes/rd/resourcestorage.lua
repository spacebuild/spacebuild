-- Copyright 2016 SB Dev Team (http://github.com/spacebuild)
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.


include("resourceentity.lua")

local SB = SPACEBUILD
local log = SB.log

-- Lua Specific
local type = type

-- Class Specific
local C = CLASS

-- Function Refs
local funcRef = {
	isA = C.isA,
	init = C.init,
	onSave = C.onSave,
	onLoad = C.onLoad
}

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "ResourceStorage"
end

--- Constructor for this container class
-- @param entID The entity id we will be using for linking and syncing
-- @param resourceRegistry The resource registry which contains all resource data.
--
function C:init(entID, resourceRegistry)
	if entID and type(entID) ~= "number" then error("You have to supply the entity id or nil to create a ResourceEntity") end
	funcRef.init(self, entID, SB.RDTYPES.STORAGE, resourceRegistry)
	self.network = nil
end

-- Duplicator methods
if SERVER then
	local function buildInfo(ent, data)
		return {}
	end
	local function applyInfo(ent, createdEntities, data)

	end
	local function restoreInfo(ent, data)

	end
	timer.Simple(0.1, function() SB:registerDupeFunctions("rd/ResourceStorage", buildInfo, applyInfo, restoreInfo) end)
end

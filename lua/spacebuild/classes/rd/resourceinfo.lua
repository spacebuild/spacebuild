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

-- Lua Specific
local error = error
local pairs = pairs

--Class specific
local C = CLASS

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return className == "ResourceInfo"
end

function C:init(id, name, displayName, unit, attributes, attributeMultipliers)
	if not id then error(self:getClass() + " requires an id") end
	if not name then error(self:getClass() + " requires a name") end
	self.id = id
	self.name = name
	self.displayName = displayName or self.name
	self.unit = unit or ""
	self.attributes = attributes or {}
	self.attributeMultipliers = attributeMultipliers or {}
end

function C:getID()
	return self.id
end

function C:getName()
	return self.name
end

function C:getDisplayName()
	return self.displayName
end

function C:setDisplayName(name)
	self.displayName = name or self.displayName
end

function C:getAttributes()
	return self.attributes
end

function C:hasAttribute(attribute)
	for _, v in pairs(self.attributes) do
		if v == attribute then
			return true
		end
	end
	return false
end

function C:getAttributeMultiplier(attribute)
	for _, v in pairs(self.attributes) do
		if v == attribute then
			return self.attributeMultipliers[_] or 1
		end
	end
	return 1
end








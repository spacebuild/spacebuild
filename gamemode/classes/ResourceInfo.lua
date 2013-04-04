--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ]]

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

function C:init(id, name, displayName, attributes)
	if not id then error(self:getClass() + " requires an id") end
	if not name then error(self:getClass() + " requires a name") end
	self.id = id
	self.name = name
	self.displayName = displayName or self.name
	self.attributes = attributes or {}
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








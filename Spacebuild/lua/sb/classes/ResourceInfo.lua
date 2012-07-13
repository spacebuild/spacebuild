--[[
		Addon: SB core
		Filename: classes/ResourceInfo.lua
		Author(s): SnakeSVx
		Website: http://www.snakesvx.net
		
		Description:
			Resource Info

		License: http://creativecommons.org/licenses/by-sa/3.0/
]]

-- Lua Specific
local error = error
local pairs = pairs

--Class specific
local C = CLASS
local sb = sb;

function C:init(name, displayName, attributes)
	if not name then error(self:getClass() + " requires a name") end
	self.name = name
	self.displayName = displayName or self.name
	self.attributes = attributes or {}
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








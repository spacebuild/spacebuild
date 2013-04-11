
-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

local C = CLASS

local GM = GM
local class = GM.class

function C:isA(className)
	return className == "WireComponent"
end

function C:init()
	self.name = ""
	self.inputs = {}
	self.outputs = {}
	self.parent = nil
end

function C:setParent(parent)
   self.parent = parent
end

function C:getParent()
	return self.parent
end

function C:setName(name)
	self.name = name
end

function C:getName()
	return self.name
end

function C:addInput(name)
	local input = class.new("WireInput", self, name)
	self.inputs[name] = input
	return input
end

function C:getInput(name)
	return self.inputs[name]
end

function C:addOutput(name)
	local output = class.new("WireOutput", self, name)
	self.outputs[name] = output
	return output
end

function C:getOutput(name)
	return self.outputs[name]
end

function C:fireOutput(name, value)
	local output = self:getOutput(name)
	if output then output:setValue(value) end
end

function C:fireInput()
   -- Do nothing
end


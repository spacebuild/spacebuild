
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

include("WireComponent.lua")

local C = CLASS

local GM = GM
local class = GM.class

local oldInit = C.init
local oldIsA = C.isA

function C:isA(className)
	return oldIsA(self, className) or className == "WireNode"
end

function C:init(method)
	oldInit(self)
	self.method = method
	for k, v in pairs(method.inputs) do
		self:addInput(k)
	end
	for k, v in pairs(method.outputs) do
		self.addOutput(k)
	end
end

function C:fireInput()
	local values = {}
	for k, v in pairs(self.inputs) do
		values[k] = v:getValue()
	end
	local retTable = self.method.func(values)
	for k, v in pairs(self.outputs) do
	   v:setValue(retTable[k])
	end
end
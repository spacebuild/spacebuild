
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
	return oldIsA(self, className) or className == "WireBoard"
end

function C:init()
	oldInit(self)
	self.nodes = {}
end

function C:addNode(node)
	table.insert(self.nodes, node)
	node:setParent(self)
end

function C:removeNode(node)
	for k, v in pairs(self.nodes)  do
		if v == node then
			table.remove(self.nodes, k)
			node:setParent(nil)
			break
		end
	end
end
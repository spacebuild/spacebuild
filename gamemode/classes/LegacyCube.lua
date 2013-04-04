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

--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 27/12/12
-- Time: 23:30
-- To change this template use File | Settings | File Templates.
--

include("LegacyPlanet.lua")

-- Class Specific
local C = CLASS
local GM = GM

-- Function Refs
local funcRef = {
	isA = C.isA
}

--- General class function to check is this class is of a certain type
-- @param className the classname to check against
--
function C:isA(className)
	return funcRef.isA(self, className) or className == "LegacyCube"
end

function C:updateEntities()
	for k, ent in pairs(self.entities) do
		if GM:isValidSBEntity(ent) then
			if ent.environment ~= self then
				self:setEnvironmentOnEntity(ent, self)
			end
		else
			self.entities[k] = nil
			ent.environment = nil
		end
	end
end

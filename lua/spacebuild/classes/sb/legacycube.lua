--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

include("legacyplanet.lua")

-- Class Specific
local C = CLASS
local GM = SPACEBUILD

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

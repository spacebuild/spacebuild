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



local pairs = pairs
local table = table
-- Class specific
local C = CLASS
local SB = SPACEBUILD


function C:isA(className)
    return className == "ResourceRegistry"
end

function C:init()
    self.resources_names_table = {}
    self.resources_ids_table = {}
end

function C:registerResourceInfo(id, name, displayName, unit, attributes, attributeMultipliers)
    local resourceinfo = self.classLoader.new("rd/ResourceInfo", id, name, displayName, unit, attributes, attributeMultipliers)
    self.resources_names_table[name] = resourceinfo
    self.resources_ids_table[id] = resourceinfo
end

function C:getResourceInfoFromID(id)
    return self.resources_ids_table[id] or error("Resource with id="..id.."not found in the registry, please call ResourceRegistry:registerResourceInfo(unique_id, name, displayname, attributes)")
end

function C:getResourceInfoFromName(name)
    return self.resources_names_table[name] or error("Resource with name="..name.."not found in the registry, please call ResourceRegistry:registerResourceInfo(unique_id, name, displayname, attributes)")
end

function C:getRegisteredResources()
    return self.resources_names_table
end

local coolant_resources
function C:getRegisteredCoolants()
    if self.coolant_resources == nil then
        self.coolant_resources = {}
        for k, v in pairs(self.resources_names_table) do
            if v:hasAttribute(SB.RESTYPES.COOLANT) then
                table.insert(self.coolant_resources, v:getName())
            end
        end
    end
    return self.coolant_resources
end



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

local lang = SPACEBUILD.lang

TOOL.Category = lang.get("tool.category.ls")
TOOL.Name = '#Suit control'
TOOL.Command = nil
TOOL.ConfigName = ''
TOOL.Tab = "Spacebuild"

local SB = SPACEBUILD

-- Add Default Language translation (saves adding it to the txt files)
if ( CLIENT ) then
	lang.register( "tool.grav_plate.name" )
	lang.register( "tool.grav_plate.desc" )
	lang.register( "tool.grav_plate.0" )
end

function TOOL:LeftClick( trace )
	if CLIENT then return true end
	self:GetOwner().suit:setActive(true)
	SB.util.messages.notify(self:GetOwner(), "helmet put on" )
	return true
end

function TOOL:RightClick( trace )
	if CLIENT then return true end
	self:GetOwner().suit:setActive(false)
	SB.util.messages.notify(self:GetOwner(), "helmet put off" )
	return true
end

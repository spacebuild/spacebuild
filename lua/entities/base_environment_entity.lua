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

AddCSLuaFile()

DEFINE_BASECLASS("base_anim")

ENT.PrintName = "Base Environment Entity"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD

function ENT:Initialize()
	--sb.addEnvironment(self)
end


function ENT:OnRemove()
	SB:removeEnvironmentFromEntity(self)
end

function ENT:OnRestore()
	self.oldenvobject = self.envobject
	self:Initialize()
	self.envobject:onRestore(self)
end



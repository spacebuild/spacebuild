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

local baseClass = baseclass.Get("base_resource_entity")

ENT.PrintName = "Base Resource Generator"

local SB = SPACEBUILD

function ENT:Initialize()
	baseClass.Initialize(self)
	self.active = false
end

function ENT:registerDevice()
	SB:registerDevice(self, SB.RDTYPES.GENERATOR)
end

function ENT:AcceptInput(name, activator, caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		self:toggle(caller)
	end
end

function ENT:turnOn(caller)
	if not self.active then
		self.active = true
	end
end

function ENT:turnOff(caller)
	if self.active then
		self.active = false
	end
end

function ENT:toggle(caller)
	if not self.active then
		self:turnOn(caller)
	else
		self:turnOff(caller)
	end
end
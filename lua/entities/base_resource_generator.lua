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
local lang = SB.lang

function ENT:Initialize()
	baseClass.Initialize(self)
	self.active = false
end

function ENT:registerDevice()
	SB:registerDevice(self, SB.RDTYPES.GENERATOR)
end

--- Use button support
-- @param name
-- @param activator
-- @param caller
--
function ENT:AcceptInput(name, activator, caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		self:toggle(caller)
	end
end

--- Wire input support
-- @param name
-- @param value
--
function ENT:TriggerInput(name, value)
	if name == "active" then
		if value ~= 0 then
			self:turnOn()
		else
			self:turnOff()
		end
	end
end

function ENT:canTurnOn()
	return true
end

function ENT:turnOn(caller)
	if self.active then
		SB.util.messages.notify(caller, lang.get("device.already.on"))
		return
	end
	if not self:canTurnOn() then
		SB.util.messages.notify(caller, lang.get("device.can.not.turn.on"))
		return
	end
	self.active = true
	SB.util.messages.notify(caller, lang.get("device.turned.on") )
end

function ENT:turnOff(caller)
	if not self.active then
		SB.util.messages.notify(caller, lang.get("device.already.off"))
		return
	end
	self.active = false
	SB.util.messages.notify(caller, lang.get("device.turned.off") )
end

function ENT:toggle(caller)
	if not self.active then
		self:turnOn(caller)
	else
		self:turnOff(caller)
	end
end
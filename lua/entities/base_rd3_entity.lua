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

local baseClass = baseclass.Get("base_resource_generator")

ENT.PrintName = "Base RD3 Entity"

local SB = SPACEBUILD

function ENT:Initialize()
	baseClass.Initialize(self)
end

function ENT:RegisterNonStorageDevice() end

function ENT:AddResource(resource, maxamount, defaultvalue)
	self:addResource(resource, maxamount, defaultvalue)
end

function ENT:ConsumeResource(resource, amount)
	return self:consumeResource(resource, amount)
end

function ENT:SupplyResource(resource, amount)
	return self:supplyResource(resource, amount)
end

function ENT:Link(netid)
	local network = SB:getDeviceInfo(netid)
	network:link(self)
end

function ENT:Unlink()
	self.rdobject:unlink()
end

function ENT:GetResourceAmount(resource)
	return self.rdobject and self.rdobject:getResourceAmount(resource) or 0
end

---
-- @param resource [string] Resource name
-- @return [number] the max network capacity this resources has
-- @deprecated use ENT:GetCapacity(resource)
--
function ENT:GetUnitCapacity(resource)
	return self:GetCapacity(resource)
end

---
-- @param resource [string] Resource name
-- @return [number] the max network capacity this resources has
-- @deprecated use ENT:GetCapacity(resource)
--
function ENT:GetNetworkCapacity(resource)
	return self:GetCapacity(resource)
end

---
-- @param resource [string] Resource name
-- @return [number] the max (network) capacity this resources has
--
function ENT:GetCapacity(resource)
	return self.rdobject and self.rdobject:getResourceAmount(resource) or 0
end
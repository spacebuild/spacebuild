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

DEFINE_BASECLASS("base_environment_entity")

ENT.PrintName = "Sun"
ENT.Author = "SnakeSVx"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD
local DEFAULT_SPAWN_SIZE = 1

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/props_lab/huladoll.mdl")
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		self:PhysicsInitSphere(DEFAULT_SPAWN_SIZE)
		self:SetCollisionBounds(Vector(-DEFAULT_SPAWN_SIZE, -DEFAULT_SPAWN_SIZE, -DEFAULT_SPAWN_SIZE), Vector(DEFAULT_SPAWN_SIZE, DEFAULT_SPAWN_SIZE, DEFAULT_SPAWN_SIZE))
		self:SetTrigger(true)
		self:GetPhysicsObject():EnableMotion(false)
		self:DrawShadow(false)

		local phys = self:GetPhysicsObject() --reset physics
		if (phys:IsValid()) then
			phys:Wake()
		end
		self:SetNotSolid(true)
	end
end

if SERVER then

	function ENT:InitEnvironment()
		if not self.envobject then error("Environment Object not found!") end
		local env = self.envobject
		self:PhysicsInitSphere(env:getRadius())
		self:SetCollisionBounds(Vector(-env:getRadius(), -env:getRadius(), -env:getRadius()), Vector(env:getRadius(), env:getRadius(), env:getRadius()))
		self:SetTrigger(true)
		self:GetPhysicsObject():EnableMotion(false)
		self:SetMoveType(MOVETYPE_NONE)

		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
		self:SetNotSolid(true)
	end

	function ENT:StartTouch(ent)
		if not SB:isValidSBEntity(ent) then return end -- SB can't handle this
		--self.envobject:addEntity(ent)
	end

	function ENT:EndTouch(ent)
		--self.envobject:removeEntity(ent)
	end

	function ENT:Think()
		--self.envobject:updateEntities()
		self:NextThink(CurTime() + 0.2)
		return true
	end
end

if CLIENT then
	function ENT:Draw()
		-- Don't draw anything
	end
end

-- Start don't allow tools and stuff
function ENT:CanTool()
	return false
end

function ENT:GravGunPunt()
	return false
end

function ENT:GravGunPickupAllowed()
	return false
end

-- End don't allow tools and stuff
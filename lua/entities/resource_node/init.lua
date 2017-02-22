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

local SB = SPACEBUILD

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	--self.BaseClass.Initialize(self) --use this in all ents
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	SB:registerDevice(self, SPACEBUILD.RDTYPES.NETWORK)
	self:SetNetworkedInt( "overlaymode", 2 )
	self.range = self.range or 512
	self:SetNetworkedInt( "range", self.range )
	-- Will add the ability to the node to store 1000 units of energy
	--CAF.GetAddon("Resource Distribution").AddNetResource(self.netid, "energy", 1000)
	-- Will Add the ability to the node to store 1000 units of water, with the startup amount at 500 units
	--CAF.GetAddon("Resource Distribution").AddNetResource(self.netid, "water", 1000, 500)
end

function ENT:SetCustomNodeName(name)
	self:SetNetworkedString("rd_node_name", name)
end

function ENT:SetActive( value, caller )
end

function ENT:Repair()
	self:SetHealth( self:GetMaxHealth( ))
end

function ENT:SetRange(range)
	self.range = range
	self:SetNetworkedInt( "range", self.range )
end

function ENT:AcceptInput(name,activator,caller)
end

function ENT:OnTakeDamage(DmgInfo)--should make the damage go to the shield if the shield is installed(CDS)
	SB.util.damage.doDamage(self, DmgInfo:GetDamage())
end

function ENT:Think()
	if self.rdobject then
		local entities = self.rdobject:getConnectedEntities()
		if table.Count(entities) > 0 then
			for k, container in pairs(entities) do
				local ent = container:getEntity()
				if ent and IsValid(ent) then
					local pos = ent:GetPos()
					if pos:Distance(self:GetPos()) > self.range then
						self.rdobject:unlink(container)
						self:EmitSound("physics/metal/metal_computer_impact_bullet"..math.random(1,3)..".wav", 500)
						ent:EmitSound("physics/metal/metal_computer_impact_bullet"..math.random(1,3)..".wav", 500)
					end
				end
			end
		end
		local cons = self.rdobject:getConnectedNetworks()
		if table.Count(cons) > 0 then
			for k, v in pairs(cons) do
				local ent = v:getEntity()
				if ent and IsValid(ent) then
					local pos = ent:GetPos()
					local range = pos:Distance(self:GetPos())
					if range > self.range and range > ent.range then
						self.rdobject:unlink(v)
						self:EmitSound("physics/metal/metal_computer_impact_bullet"..math.random(1,3)..".wav", 500)
						ent:EmitSound("physics/metal/metal_computer_impact_bullet"..math.random(1,3)..".wav", 500)
					end
				end
			end
		end
	end
	self:NextThink(CurTime() + 1)
	return true
end


function ENT:OnRemove()
	SB:removeDevice(self)
	if not (WireAddon == nil) then Wire_Remove(self) end
end

function ENT:OnRestore()
	--self.BaseClass.OnRestore(self) --use this if you have to use OnRestore
	if not (WireAddon == nil) then Wire_Restored(self) end
end

function ENT:PreEntityCopy()
	--self.BaseClass.PreEntityCopy(self) --use this if you have to use PreEntityCopy
	local RD = CAF.GetAddon("Resource Distribution")
	RD.BuildDupeInfo(self)
	if not (WireAddon == nil) then
		local DupeInfo = WireLib.BuildDupeInfo(self)
		if DupeInfo then
			duplicator.StoreEntityModifier( self, "WireDupeInfo", DupeInfo )
		end
	end
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	--self.BaseClass.PostEntityPaste(self, Player, Ent, CreatedEntities ) --use this if you have to use PostEntityPaste
	local RD = CAF.GetAddon("Resource Distribution")
	RD.ApplyDupeInfo(Ent, CreatedEntities)
	if not (WireAddon == nil) and (Ent.EntityMods) and (Ent.EntityMods.WireDupeInfo) then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end
end

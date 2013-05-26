
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	--self.BaseClass.Initialize(self) --use this in all ents
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNetworkedInt( "overlaymode", 1 )
	self:SetNetworkedInt( "OOO", 0 )
	self.range = 512
	self:SetNetworkedInt( "range", 512 )
	self.Active = 0
	self.connected = {}
	self.connected.ent = nil
	self.connected.node = nil
	if not (WireAddon == nil) then
		self.WireDebugName = self.PrintName
		self.Inputs = Wire_CreateInputs(self, { "Open"} )
		self.Outputs = Wire_CreateOutputs(self, {"Open"} )
	else
		self.Inputs = {{Name="Open"}}
	end
end

function ENT:SetRDEntity(ent)
	if self.connected.ent and self.Active == 1 then
		self:TurnOff()
	end
	self.connected.ent = ent
	if ent then
		self:SetNetworkedInt("entid", ent:EntIndex( ))
	else
		self:SetNetworkedInt("entid", nil)
	end
end

function ENT:GetRDEntity()
	return self.connected.ent
end

function ENT:GetNode()
	return self.connected.node
end

function ENT:SetNode(node)
	self.connected.node = node
	if self.connected.ent and self.Active == 1 then
		self:TurnOff()
	end
	if node then
		self:SetNetworkedInt("netid", node.netid)
	else
		self:SetNetworkedInt("netid", nil)
	end
end

function ENT:TurnOn()
	if self.Active == 0 then
		if self.connected.ent and self.connected.node then
			CAF.GetAddon("Resource Distribution").Unlink(self.connected.ent)
			CAF.GetAddon("Resource Distribution").Link(self.connected.ent, self.connected.node.netid)
			self.Active = 1 
			self:SetOOO(1)
			if not (WireAddon == nil) then Wire_TriggerOutput(self, "Open", self.Active) end
		end
	end
end

function ENT:TurnOff()
	if self.Active == 1 then
		if self.connected.ent and self.connected.node then
			CAF.GetAddon("Resource Distribution").Unlink(self.connected.ent)
			self.Active = 0 
			self:SetOOO(0)
			if not (WireAddon == nil) then Wire_TriggerOutput(self, "Open", self.Active) end
		end
	end
end

function ENT:TriggerInput(iname, value)
	if (iname == "Open") then
		if value == 0 then
			self:TurnOff()
		elseif value == 1 then
			self:TurnOn()
		end
	end
end

--use this to set self.active
--put a self:TurnOn and self:TurnOff() in your ent
--give value as nil to toggle
--override to do overdrive
--AcceptInput (use action) calls this function with value = nil
function ENT:SetActive( value, caller )
	if ((not(value == nil) and value ~= 0) or (value == nil)) and self.Active == 0 then
		if self.TurnOn then self:TurnOn( nil, caller ) end
	elseif ((not(value == nil) and value == 0) or (value == nil)) and self.Active == 1 then
		if self.TurnOff then self:TurnOff( nil, caller ) end
	end
end

function ENT:SetOOO(value)
	self:SetNetworkedInt( "OOO", value )
end

function ENT:Repair()
	self:SetHealth( self:GetMaxHealth( ))
end

function ENT:AcceptInput(name,activator,caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		self:SetActive( nil, caller )
	end
end

function ENT:OnTakeDamage(DmgInfo)--should make the damage go to the shield if the shield is installed(CDS)
	if self.Shield then
		self.Shield:ShieldDamage(DmgInfo:GetDamage())
		CDS_ShieldImpact(self:GetPos())
		return
	end
	if CAF and CAF.GetAddon("Life Support") then
		CAF.GetAddon("Life Support").DamageLS(self, DmgInfo:GetDamage())
	end
end

function ENT:Think()
	-- Check if all ents are still valid!
	if self.connected.ent and not IsValid(self.connected.ent) then 
		self.connected.ent = nil 
		self:SetNetworkedInt("entid", nil)
	end
	if self.connected.node and not IsValid(self.connected.node) then 
		self:TurnOff()
		self.connected.node = nil 
		self:SetNetworkedInt("netid", nil)
	end
	-- Check if they are still in range!
	if self.connected.ent then
		if self.connected.ent:GetPos():Distance(self:GetPos()) > self.range then
			self:TurnOff()
			self.connected.ent = nil
			self:SetNetworkedInt("entid", nil)
		end
	end
	if self.connected.node then
		if self:GetPos():Distance(self.connected.node:GetPos()) > self.connected.node.range then
			self:TurnOff()
			self.connected.node = nil 
			self:SetNetworkedInt("netid", nil)
		end
	end
	self:NextThink( CurTime() + 1 )
	return true
end

function ENT:OnRemove()
	--self.BaseClass.OnRemove(self) --use this if you have to use OnRemove
	self:TurnOff()
	--CAF.GetAddon("Resource Distribution").RemoveRDEntity(self)
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

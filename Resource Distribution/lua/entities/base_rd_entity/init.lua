
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	--self.BaseClass.Initialize(self) --use this in all ents
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
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

function ENT:AcceptInput(name,activator,caller)
	if name == "Use" and caller:IsPlayer() and caller:KeyDownLast(IN_USE) == false then
		self:SetActive( nil, caller )
	end
end

function ENT:OnTakeDamage(DmgInfo)--should make the damage go to the shield if the shield is installed(CDS)
	if self.Shield then
		self.Shield:ShieldDamage(DmgInfo:GetDamage())
		CDS_ShieldImpact(self.Entity:GetPos())
		return
	end
	if DamageLS then
		DamageLS(self.Entity, DmgInfo:GetDamage())
	end
end

function ENT:Think()
	--self.BaseClass.Think(self) --use this in all ents that use standard setoverlaytext
	if (self.NextOverlayTextTime) and (CurTime() >= self.NextOverlayTextTime) then
		if (self.NextOverlayText) then
			self.Entity:SetNetworkedString( "GModOverlayText", self.NextOverlayText )
			self.NextOverlayText = nil
		end
		self.NextOverlayTextTime = CurTime() + 0.2 + math.random() * 0.2
	end
end

function ENT:OldMethodSetOverlayText(txt) --called from shared
	if (not self.OverlayDelay) or (self.OverlayDelay == 0) then
		self.Entity:SetNetworkedString( "GModOverlayText", txt )
	elseif (self.NextOverlayTextTime) then
		self.NextOverlayText = txt
	else
		self.Entity:SetNetworkedString( "GModOverlayText", txt )
		self.NextOverlayText = nil
		self.NextOverlayTextTime = 0
	end
end

function ENT:OnRemove()
	--self.BaseClass.OnRemove(self) --use this if you have to use OnRemove
	Dev_Unlink_All(self.Entity)
	if not (WireAddon == nil) then Wire_Remove(self.Entity) end
end

function ENT:OnRestore()
	--self.BaseClass.OnRestore(self) --use this if you have to use OnRestore
	if not (WireAddon == nil) then Wire_Restored(self.Entity) end
end

function ENT:PreEntityCopy()
	--self.BaseClass.PreEntityCopy(self) --use this if you have to use PreEntityCopy
	RD_BuildDupeInfo(self.Entity)
	if not (WireAddon == nil) then
		local DupeInfo = WireLib.BuildDupeInfo(self.Entity)
		if DupeInfo then
			duplicator.StoreEntityModifier( self.Entity, "WireDupeInfo", DupeInfo )
		end
	end
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	--self.BaseClass.PostEntityPaste(self, Player, Ent, CreatedEntities ) --use this if you have to use PostEntityPaste
	RD_ApplyDupeInfo(Ent, CreatedEntities)
	if not (WireAddon == nil) and (Ent.EntityMods) and (Ent.EntityMods.WireDupeInfo) then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end
end

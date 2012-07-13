AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local Ground = 1 + 0 + 2 + 8 + 32

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.damaged = 0
	self.time = 0
	self.water = 100
	self:SetOOO(1)
	self:ShowOutput()
end

function ENT:Repair()
	self:SetColor(Color( 255, 255, 255, 255 ))
	self.health = self.maxhealth
	self.damaged = 0
	self.time = 0
	self.water = 100
	self:SetOOO(1)
	self:ShowOutput()
end

function ENT:SetActive()
	self:Repair()
end

function ENT:Destruct()
	LS_Destruct( self, true )
end

function ENT:ShowOutput()
	self:SetNetworkedInt( 1, self.water )
end

function ENT:Damage()
	if (self.damaged == 0) then self.damaged = 1 end
end

function ENT:OnRemove()
 --nothing
end

function ENT:Think()
	self.BaseClass.Think(self)
	if self.environment.inwater == 1 then
		if self.water < 100 then
			self.water = self.water + 1
			self:ShowOutput()
		end
	elseif self.water > 0 then
		self.water = self.water - 1
		self:ShowOutput()
	else
		if self.Active == 1 then
			self:SetOOO(0)
			self:SetColor(Color(75, 75, 75, 255))
			self:ShowOutput()
		end		
	end
	self:NextThink( CurTime() +  1 )
	return true
end

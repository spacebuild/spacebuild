function EFFECT:Init(data)
	self.ent = data:GetEntity()
	self.Entity:SetParent(self.ent)
	self.Entity:PhysicsInitSphere(4)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetPos(data:GetOrigin())
	self.Life = 10+CurTime()
	self.emit = ParticleEmitter(data:GetOrigin())
	self.size = data:GetMagnitude()
	self.nrm = data:GetNormal()
end

local function ParticleThink(particle) --we love you Jinto
	local green = (255)*particle:GetLifeTime()
	particle:SetColor(255,math.Clamp(green,0,255),0)
	particle:SetNextThink(CurTime()+0.1)
end

local function slide(p, hit, nrm)--why the hell do we have to do this? it should be automatic
	p:SetBounce(.3)
	local v = p:GetVelocity()
	v.z = 0
	p:SetVelocity(v)
	p:SetPos(hit+nrm)
end

function EFFECT:Emit()
	local X = self.ent:GetRight()
	local Y = self.ent:GetUp()
	local Z = self.ent:GetForward()
	local ang = math.random()*math.pi*2
	local offset = (math.cos(ang)*X*180)+(math.sin(ang)*Y*180)+100*Z
	local particle = self.emit:Add("particle/smokestack", self.Entity:GetPos())
	if particle then
		particle:SetThinkFunction(ParticleThink)
		particle:SetNextThink(CurTime()+0.1)
		particle:SetVelocity(Vector(0,0,0))
		particle:SetDieTime(2)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(self.size)
		particle:SetEndSize(0)
		particle:SetRoll(180)
		particle:SetRollDelta(math.random(-1,1))
		particle:SetColor(255, math.random(0,255),0)
		particle:SetGravity(offset*5)
		particle:SetCollide(true)
		particle:SetCollideCallback(slide)
	end
end

function EFFECT:Think()
	if (not (self.Life > CurTime())) then
		self.emit:Finish()
	else
		for i=1,20 do
			self:Emit()
		end
	end
	return (self.Life > CurTime())
end

function EFFECT:Render()	
end



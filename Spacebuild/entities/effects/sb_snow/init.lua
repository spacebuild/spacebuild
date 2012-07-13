local ply = LocalPlayer()

function EFFECT:Init(data)
	self.time = CurTime()+data:GetMagnitude()
	self.ori = data:GetOrigin()
	self.rad = data:GetScale()
	self.emitter = ParticleEmitter(self.ori)
end

function EFFECT:Emit()
	local a = math.random(9999)
	local b = math.random(1,180)
	local dist = math.random(128,1024)
	local X = math.sin(b)*math.sin(a)*dist
	local Y = math.sin(b)*math.cos(a)*dist
	local offset = Vector(X,Y,0)
	local spawnpos = ply:GetPos()+Vector(0,0,300)+offset
	local particle = self.emitter:Add("particle/snow", spawnpos)
	if (particle) then
		particle:SetLifeTime(0)
		particle:SetDieTime(5)
		particle:SetStartAlpha(0)
		particle:SetEndAlpha(254)
		particle:SetStartSize(2)
		particle:SetEndSize(2)
		particle:SetAirResistance(1)
		particle:SetGravity(Vector(0,0,math.random(-125,-50)))
		particle:SetCollide(false)
		particle:SetBounce(.01)
		particle:SetColor(255,255,255,255)
	end
end

function EFFECT:Think()
	if self.time > CurTime() then
		if ply:GetPos():Distance(self.ori)-self.rad <= 0 then
			for i=1,60 do
				self:Emit()
			end
		end
		return true
	else
		self.emitter:Finish()
		return false
	end
end

function EFFECT:Render()
end
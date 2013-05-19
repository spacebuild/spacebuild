local matRefraction	= Material( "refract_ring" )

local tMats = {}

tMats.Glow1 = Material("sprites/light_glow02")
--tMats.Glow1 = Material("models/roller/rollermine_glow")
tMats.Glow2 = Material("sprites/yellowflare")
tMats.Glow3 = Material("sprites/redglow2")

for _,mat in pairs(tMats) do

	mat:SetInt("$spriterendermode",9)
	mat:SetInt("$ignorez",1)
	mat:SetInt("$illumfactor",8)
	
end

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )

	self.Position = data:GetOrigin()
	self.Position.z = self.Position.z + 4
	self.TimeLeft = CurTime() + 7.6
	self.GAlpha = 254
	self.GSize = 100
	self.CloudHeight = data:GetScale()
	
	self.Refract = 0
	self.Size = 24
	if render.GetDXLevel() <= 81 then
		matRefraction = Material( "effects/strider_pinch_dudv" )
	end
	
	self.SplodeDist = 700
	self.BlastSpeed = 3500
	self.lastThink = 0
	self.MinSplodeTime = CurTime() + self.CloudHeight/self.BlastSpeed
	self.MaxSplodeTime = CurTime() + 6
	self.GroundPos = self.Position - Vector(0,0,self.CloudHeight)
	
	local Pos = self.Position
	
	
	self.smokeparticles = {}
	self.Emitter = ParticleEmitter( Pos )

	--moving fire plumes
	for i=1, math.ceil(26) do
		
		local vecang = VectorRand()*8
		local spawnpos = Pos + 64*vecang
		
			for k=5,26 do
			local particle = self.Emitter:Add( "particles/flamelet"..math.random(1,5), spawnpos - vecang*9*k)
			particle:SetVelocity(vecang*math.Rand(-80,-100))
			particle:SetDieTime( math.Rand( 8, 16 ) )
			particle:SetStartAlpha( math.Rand(230, 250) )
			particle:SetStartSize( k*math.Rand( 13, 15 ) )
			particle:SetEndSize( k*math.Rand( 17, 19 ) )
			particle:SetRoll( math.Rand( 20, 80 ) )
			particle:SetRollDelta( math.random( -1, 1 ) )
			particle:SetColor(20, math.random(20,60), math.random(100,255))
			particle:VelocityDecay( true )
			end
	
	end
	
	--central fire plumes
	for i=1, math.ceil(26) do
		
		local vecang = VectorRand()*8
		local spawnpos = Pos + 256*vecang
		
			for k=5,26 do
			local particle = self.Emitter:Add( "particles/flamelet"..math.random(1,5), spawnpos - vecang*9*k)
			particle:SetVelocity(vecang*math.Rand(2,3))
			particle:SetDieTime( math.Rand( 4, 12 ) )
			particle:SetStartAlpha( math.Rand(230, 250) )
			particle:SetStartSize( k*math.Rand( 13, 15 ) )
			particle:SetEndSize( k*math.Rand( 17, 19 ) )
			particle:SetRoll( math.Rand( 20, 80 ) )
			particle:SetRollDelta( math.random( -1, 1 ) )
			particle:SetColor(100, math.random(100,128), math.random(230,255))
			particle:VelocityDecay( true )
			end
	
	end
	self.vecang = VectorRand()


	
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )

	
	

	local Pos = self.Position
	local timeleft = self.TimeLeft - CurTime()
	if timeleft > 0 then 
		local ftime = FrameTime()
		
		self.GAlpha = self.GAlpha - 10.5*ftime
		self.GSize = self.GSize - 0.12*timeleft*ftime
		
		self.Size = self.Size + 1200*ftime
		self.Refract = self.Refract + 1.3*ftime
		
		--shock ring
		if (self.Size < 8000) then
			local spawndist = self.Size
			local NumPuffs = spawndist / 80
			
				
			local ang = self.vecang:Angle()
			for i=1, NumPuffs do
					
		
					ang:RotateAroundAxis(ang:Up(), (360/NumPuffs))
					local newang = ang:Forward()
					local spawnpos = (Pos + (newang * spawndist))
					local particle = self.Emitter:Add( "particles/flamelet"..math.random(1,5), spawnpos)
		--			particle:SetVelocity(vecang*math.Rand(2,3))
					particle:SetVelocity(Vector(0, 0, 0))
					particle:SetDieTime( 2 )
					particle:SetStartAlpha( math.Rand(230, 250) )
					particle:SetStartSize( 20*math.Rand( 13, 15 ) )
					particle:SetEndSize( math.Rand( 17, 19 ) )
					particle:SetRoll( math.Rand( 20, 80 ) )
					particle:SetRollDelta( math.random( -1, 1 ) )
					particle:SetColor(20, math.random(20,60), math.random(100,255))
					particle:VelocityDecay( true )
			
			end
		end
		
		
		return true
	else
		self.Emitter:Finish()
		return false	
	end

end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )

local startpos = self.Position

	--Base glow
	render.SetMaterial(tMats.Glow1)
	render.DrawSprite(startpos, 400*self.GSize,90*self.GSize,Color(80, math.random(80,90), math.random(230,255),self.GAlpha))
	render.DrawSprite(startpos, 70*self.GSize,280*self.GSize,Color(80, math.random(80,90), math.random(240,255),0.7*self.GAlpha))
	--shockwave
	if self.Size < 32768 then

		local Distance = EyePos():Distance( self:GetPos() )
		local Pos = self:GetPos() + (EyePos() - self:GetPos()):GetNormal() * Distance * (self.Refract^(0.3)) * 0.8

		matRefraction:SetMaterialFloat( "$refractamount", math.sin( self.Refract * math.pi ) * 0.1 )
		render.SetMaterial( matRefraction )
		render.UpdateRefractTexture()
		render.DrawSprite( Pos, self.Size, self.Size )

	end


end

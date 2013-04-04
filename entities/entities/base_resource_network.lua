AddCSLuaFile()

DEFINE_BASECLASS("base_resource_entity")

ENT.PrintName = "Base Resource Network"
ENT.Author = "SnakeSVx & Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminOnly = false



function ENT:Initialize()
	GAMEMODE:registerDevice(self, GAMEMODE.RDTYPES.NETWORK)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self.Entity:SetUseType(SIMPLE_USE)

		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end

	if CLIENT then
		self.oldResourceValues = {}
		self.ResourceValues = {}
		self._synctimestamp2 = CurTime()
	end
end

function ENT:OnRestore()
	self.oldrdobject = self.rdobject
	GAMEMODE:registerDevice(self, GAMEMODE.RDTYPES.NETWORK)
	self.rdobject:onRestore(self)
end

if SERVER then

	function ENT:updateConnections(c)

		local self = c or self
		self:EmitSound(Sound("/common/warning.wav"), 90)
		self._synctimestamp = CurTime()
		self.constraints = constraint.GetAllConstrainedEntities(self)

		for k, v in pairs(self.constraints or {}) do
			if v ~= self and GAMEMODE:isValidRDEntity(v) and v.rdobject:canLink(self.rdobject) and v.rdobject.network ~= self.rdobject then
				v.rdobject:link(self.rdobject)
			end
		end
	end

	function ENT:Use()

		if not self.active then -- One time only trigger to begin device syncing
			self.active = true
			self:updateConnections()
		end
	end

	function ENT:Think()

		--Not using NextThink as some more resource processing may need to be done every Think
		if self.active and (CurTime() > self._synctimestamp + 5) then --sync every 5 seconds ish
			self:updateConnections()
		end
	end
end

if CLIENT then
	local pcall = pcall
	local tostring = tostring
	local surface = surface
	local cam = cam
	local Vector = Vector
	local colors = GAMEMODE.constants.colors
	local function drawText(text, x, y, color)
		if not color then color = colors.white end
		surface.SetTextPos(x, y) -- As the func name. Set's the pos for all DrawTexts coming up:
		surface.SetTextColor(color)
		surface.DrawText(text) --For some reason this doesn't work. I think it's a size iissue and creating a custom font for a sample code seems pointless.
	end

	function ENT:updateOldValues()
		for k, v in pairs(self:getResources()) do
			self.oldResourceValues[k] = v.value --Populate the old values
		end
	end

	function ENT:getOldValues()
		return self.oldResourceValues
	end

	function ENT:getResources()
		return self.ResourceValues
	end

	function ENT:updateResources()
		local old = self:getOldValues()
		for k, v in pairs(self.rdobject:getResources()) do
			self.ResourceValues[k] = { value = self.rdobject:getResourceAmount(k), maxvalue = self.rdobject:getMaxResourceAmount(k) }
			self.ResourceValues[k].delta = self.ResourceValues[k].value - (old[k] or 0)
		end
	end


	function ENT:Think() -- Clientside think

		if (CurTime() > self._synctimestamp2 + 2) then
			self.ResourceValues = {}
			self:updateResources()

			self.oldResourceValues = {}
			self:updateOldValues()

			self._synctimestamp2 = CurTime()
		end
	end



	function ENT:Draw()
		--[[
  Rectangle size: 650 * 350 (scale = 0.1)
  Screen (small) size: 65 * 35 (Vector(-32.5,17.5,5.16))
  Amount of columns (100 units width): 6
  Amount of rows (20 units height): 17 (7 for info, 10 for resources)
					  for c = 1, 6 do
			   surface.SetTextPos( 5 + ((c - 1) * 100), 5 + ((r - 1) * 20) ) -- As the func name. Set's the pos for all DrawTexts coming up:
			   surface.SetTextColor( Color(255,0,0) )
			   surface.DrawText( tostring(c)..","..tostring(r) )    --For some reason this doesn't work. I think it's a size iissue and creating a custom font for a sample code seems pointless.
		   end
]]

		self:DrawModel()

		if self.hud then
			local pos = self:LocalToWorld(self.hud.vector)
			local angle = self:GetAngles()
			cam.Start3D2D(pos, angle, self.hud.scale) -- Fiddle with 1 quite a bit
			pcall(function()
			--Draw the baseframe:
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawRect(0, 0, 650, 350) -- 167 seems to be the apprioximate height of the ipad at its current stage of dev

				surface.SetDrawColor(155, 155, 155, 255)
				surface.SetFont("DermaDefault") --For custom fonts: http://wiki.garrysmod.com/page/Talk:Libraries/surface/SetFont and surface.CreateFont (see wikik or sb4_ls_spawner

				-- Draw Title
				drawText("Resource Node " .. tostring(self:EntIndex()), 5, 5)

				-- connected networks
				drawText("Connected to ", 5, 20)
				local str = ""
				for k, v in pairs(self.rdobject:getConnectedNetworks()) do
					str = str .. tostring(k) .. " "
				end
				drawText(str, 105, 20)

				-- resources
				drawText("Resource name", 5, 35)
				drawText("Amount", 205, 35)
				drawText("Max Amount", 330, 35)
				drawText("Delta", 430, 35)
				drawText("Note", 530, 35)
				local y, value, maxvalue = 35, 35, 35 -- One to One please

				for k, v in pairs(self:getResources()) do

					y = y + 15

					value = v.value
					maxvalue = v.maxvalue

					drawText(k:gsub("^%l", string.upper), 5, y)
					drawText(tostring(value), 205, y)
					drawText(tostring(maxvalue), 330, y)

					--  Delta
					drawText(tostring(v.delta), 430, y) --some reason the self:getDelta call isn't working and it's halting

					-- Cleaned up note column

					local str, color = "Low on resource", colors.red
					local pcnt = value / maxvalue

					if (v.delta > 0) then

						str, color = "Safe", colors.green

					elseif (v.delta == 0) then
						if pcnt > 0.8 then
							str, color = "Safe", colors.green
						elseif pcnt > 0.3 then
							str, color = "Caution", colors.yellow
						elseif pcnt > 0.1 then
							str, color = "Warning", colors.orange
						end

					elseif (v.delta < 0) then
						if pcnt > 0.3 then
							str, color = "Warning", colors.red
						elseif pcnt > 0.1 then
							str, color = "DANGER", colors.red
						end
					end

					drawText(tostring(str), 530, y, color)
				end
			--Stop rendering
			end)
			cam.End3D2D()
			self:updateOldValues() -- Update the values to the curr ones
		end
	end
end
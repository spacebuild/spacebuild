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

local baseClass = baseclass.Get("base_resource_entity")

ENT.PrintName = "Base Resource Network"
ENT.Category        = "Spacebuild"
ENT.Spawnable = false
ENT.AdminOnly = false

local SB = SPACEBUILD

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("base_resource_network")
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:SetModel("models/SnakeSVx/small_res_node.mdl")
	ent.range = 512 --TODO make this better
	ent:Spawn()

	return ent
end

function ENT:Initialize()
	baseClass.Initialize(self)
	self.active = false
end

function ENT:registerDevice()
	SB:registerDevice(self, SB.RDTYPES.NETWORK)
end

if SERVER then

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

end

function ENT:drawScreen()
	baseClass.drawScreen(self)
	local ply = LocalPlayer()
	local trace = ply:GetEyeTrace();
	-- TODO what range?
	if (EyePos():Distance( self:GetPos() ) < 256) then
		if not bDontDrawModel  then self:DrawModel() end
		local obj = self.rdobject
		if not obj then return end
		local playername = self:GetPlayerName()
		if playername == "" then
			playername = "World"
		end
		local TempY = 0
		local mul_up = 10
		local mul_ri = -16.5
		local mul_fr = -12.5
		if string.find(self:GetModel(),"small_res") then
			mul_up = 5.2
		elseif string.find(self:GetModel(),"medium_res") then
			mul_up = 10.2
		elseif string.find(self:GetModel(),"large_res") then
			mul_up = 15.2
		end
		local screenOffset = (self:GetUp() * mul_up) + (self:GetRight() * mul_ri) + (self:GetForward() * mul_fr)
		local pos = self:GetPos() + screenOffset

		local angle = self:GetAngles()

		local textStartPos = -375

		local factor = 20

		cam.Start3D2D(pos,angle,1/factor)

		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect( textStartPos, 0, 1250, 675 )

		surface.SetDrawColor(155,155,155,255)
		surface.DrawRect( textStartPos, 0, -5, 675 )
		surface.DrawRect( textStartPos, 0, 1250, -5 )
		surface.DrawRect( textStartPos, 675, 1250, -5 )
		surface.DrawRect( textStartPos+1250, 0, 5, 675 )

		TempY = TempY + 10
		surface.SetFont("ConflictText")
		surface.SetTextColor(255,255,255,255)
		surface.SetTextPos(textStartPos+15,TempY)

		if not obj then
			surface.DrawText("Loading network data...")
		else

			surface.DrawText("Network " .. obj:getID())
			TempY = TempY + 70
			local extra = 70
			if mode == 3 then
				extra = 50
			end
			surface.SetFont("Flavour")
			surface.SetTextColor(200,200,255,255)
			surface.SetTextPos(textStartPos+15,TempY)
			surface.DrawText("Owner: "..playername)
			TempY = TempY + extra

			if nodename and nodename ~= "" then
				surface.SetFont("Flavour")
				surface.SetTextColor(200,200,255,255)
				surface.SetTextPos(textStartPos+15,TempY)
				surface.DrawText("Nodename: "..nodename)
				TempY = TempY + extra
			end
			surface.SetFont("Flavour")
			surface.SetTextColor(200,200,255,255)
			surface.SetTextPos(textStartPos+15,TempY)
			surface.DrawText("Range: "..(self.range or 512))
			TempY = TempY + extra

			-- Print the used resources
			local stringUsage = ""
			local cons = obj:getConnectedNetworks()
			if ( table.Count(cons) > 0 ) then
				local i = 0
				surface.SetFont("Flavour")
				surface.SetTextColor(200,200,255,255)
				for k, v in pairs(cons) do
					stringUsage = stringUsage..tostring(v:getID()).. " "
				end
				surface.SetTextPos(textStartPos+15,TempY)
				surface.DrawText("Connected to networks: "..stringUsage)
				TempY = TempY + extra
			end
			stringUsage = ""
			local resources = obj:getResources()
			if ( table.Count(resources) > 0 ) then
				local amt, value, h, amount
				local i = 0
				surface.SetFont("Flavour")
				surface.SetTextColor(200,200,255,255)
				surface.SetTextPos(textStartPos+15,TempY)
				surface.DrawText("Resources: ")
				TempY = TempY + extra
				for k, v in pairs(resources) do
					if mode == 3 then
						surface.SetTextColor(200,200,255,255)
						amt = v.value/v.maxvalue
						surface.SetTextPos(textStartPos+15, TempY)
						surface.DrawText("   "..v:getDisplayName())
						surface.DrawOutlinedRect(-20, TempY-5, -2*(textStartPos)+20, 40)
						surface.DrawRect(-20, TempY-5, ((-2*textStartPos)+20)*amt, 40)
						TempY = TempY + 50
						amount = obj:getResourceAmount(v:getName())
						value,h = surface.GetTextSize(tostring(amount))
						if amt < 0.5 then
							surface.SetTextColor(200,200,255,255)
							surface.SetTextPos(-2*(textStartPos)*amt-5,TempY-15-h)
							surface.DrawText(amount)
						else
							surface.SetTextColor(0,0,0,255)
							surface.SetTextPos(-2*(textStartPos)*amt-15-value,TempY-15-h)
							surface.DrawText(amount)
						end
					else
						stringUsage = stringUsage.."["..v:getDisplayName()..": " .. obj:getResourceAmount(v:getName()) .. "/" .. obj:getMaxResourceAmount(v:getName()) .. "] "
						i = i + 1
						if i == 3 then
							surface.SetTextPos(textStartPos+15,TempY)
							surface.DrawText("   "..stringUsage)
							TempY = TempY + 70
							stringUsage = ""
							i = 0
						end
					end
				end
				if mode ~= 3 then
					surface.SetTextPos(textStartPos+15,TempY)
					surface.DrawText("   "..stringUsage)
					TempY = TempY + 70
				end
			else
				surface.SetFont("Flavour")
				surface.SetTextColor(200,200,255,255)
				surface.SetTextPos(textStartPos+15,TempY)
				surface.DrawText("No resources connected")
				TempY = TempY + 70
			end
		end
		--Stop rendering
		-- Test Screen clicking for button behaviour

		if trace.Entity == self then
			local pos = self:WorldToLocal(trace.HitPos)
			if pos.y > -16 and pos.y < 16 and pos.x > -32 and pos.x < 32 then
				surface.DrawCircle(250+(pos.x  * factor), 330 -(pos.y * factor), 4, 255, 0, 0, 255 )
			end
			surface.SetTextPos(textStartPos+15,TempY + 70)
			surface.DrawText("Pos: "..pos.x ..", "..pos.y)
		end

		--end test screen clicking
		cam.End3D2D()
	end
end

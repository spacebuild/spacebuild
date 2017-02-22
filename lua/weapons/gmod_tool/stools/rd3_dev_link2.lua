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

--load our other stools first
--include( "RD2/tool_manifest.lua" )

--dev link stool
--TOOL			= ToolObj:Create()
local lang = SPACEBUILD.lang

TOOL.Category = lang.get("tool.category.rd")
TOOL.Mode		= "rd3_dev_link2"
TOOL.Name		= '#Smart Link Tool'
TOOL.Command	= nil
TOOL.ConfigName	= ''
TOOL.Tab = "Spacebuild"

local SB = SPACEBUILD

if ( CLIENT ) then
	lang.register( "tool.rd3_dev_link2.name" )
	lang.register( "tool.rd3_dev_link2.desc" )
	lang.register( "tool.rd3_dev_link2.0" )
	lang.register( "tool.rd3_dev_link2.1" )
	lang.register( "rd3_dev_link2_addlength" )
	lang.register( "rd3_dev_link2_width" )
	lang.register( "rd3_dev_link2_material" )
	lang.register( "rd3_dev_link2_colour" )
end

TOOL.ClientConVar[ "width" ] = "2"
TOOL.ClientConVar[ "material" ] = "cable/cable2"
TOOL.ClientConVar[ "color_r" ] = "255"
TOOL.ClientConVar[ "color_g" ] = "255"
TOOL.ClientConVar[ "color_b" ] = "255"
TOOL.ClientConVar[ "color_a" ] = "255"

function TOOL:LeftClick( trace )
	if (not trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	if (CLIENT) then return true end
	if trace.Entity.rdobject then
		local iNum = self:NumObjects()
		local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
		self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )
		trace.Entity:SetColor(Color(0, 0, 255, 200))
	end
	return true
end

function TOOL:RightClick( trace )
	if (not trace.Entity:IsValid()) or (trace.Entity:IsPlayer()) then return end
	
	if (CLIENT) then return true end
	local iNum = self:NumObjects()
	--local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	--self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if iNum > 0 and trace.Entity.rdobject and trace.Entity.rdobject:isA("ResourceNetwork") then
		-- Get information we're about to use
		for k, v in pairs(self.Objects) do
			local Ent1, nodeEntity = self:GetEnt(k), trace.Entity
			--local Bone1, Bone2 = self:GetBone(k),	trace.PhysicsBone
			local WPos1, WPos2 = self:GetPos(k),		trace.Entity:GetPos()
			--local LPos1, LPos2 = self:GetLocalPos(k),	self:GetLocalPos(2)
			local length = ( WPos1 - WPos2):Length()
			Ent1:SetColor(Color(255, 255, 255, 255))
			local inRange1 = not Ent1.range or Ent1.range >= length
			local inRange2 = not nodeEntity.range or nodeEntity.range >= length

			if not nodeEntity.rdobject:canLink(Ent1.rdobject) then
				SB.util.messages.notify(self:GetOwner(), "Invalid Combination!" )
			elseif not inRange1 or not inRange2 then
				SB.util.messages.notify(self:GetOwner(), "These 2 entities are too far apart!'" )
			else
				nodeEntity.rdobject:link(Ent1.rdobject)
				local material = self:GetClientInfo("material")
				local width = tonumber(self:GetClientInfo("width"))
				local color =  Color(self:GetClientInfo("color_r"), self:GetClientInfo("color_g"), self:GetClientInfo("color_b"), self:GetClientInfo("color_a"))

				Ent1.rdobject:addBeam(nodeEntity.rdobject:getID(), material, width, color);
				nodeEntity.rdobject:addBeam(Ent1.rdobject:getID(), material, width, color);
			end
		end
		self:Reload(trace) --Reset colors and clear objects
	else
		SB.util.messages.notify(self:GetOwner(), "You didn't click on a Resource node to link to!" )
	end
	return true
end

function TOOL:Reload(trace)
	local iNum = self:NumObjects()
	if iNum > 0 then
		for k, v in pairs(self.Objects) do
			local Ent1  = self:GetEnt(k)
			Ent1:SetColor(Color(255, 255, 255, 255))
		end
	end
	self:ClearObjects()
	return true
end

function TOOL.BuildCPanel( panel )
	panel:AddControl( "Header", { Text = "#tool.rd3_dev_link.name", Description	= "#tool.rd3_dev_link.desc" }  )

	panel:AddControl("Slider", {
		Label = "#rd3_dev_link2_width",
		Type = "Float",
		Min = ".1",
		Max = "20",
		Command = "rd3_dev_link2_width"
	})

	panel:AddControl( "MatSelect", {
		Height = "1",
		Label = "#rd3_dev_link2_material",
		ItemWidth = 24,
		ItemHeight = 64,
		ConVar = "rd3_dev_link2_material",
		Options = list.Get( "BeamMaterials" )
	})

	panel:AddControl("Color", {
		Label = "#rd3_dev_link2_colour",
		Red = "rd3_dev_link2_color_r",
		Green = "rd3_dev_link2_color_g",
		Blue = "rd3_dev_link2_color_b",
		ShowAlpha = "1",
		ShowHSV = "1",
		ShowRGB = "1",
		Multiplier = "255"
	})
end


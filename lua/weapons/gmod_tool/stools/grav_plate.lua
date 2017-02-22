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

local lang = SPACEBUILD.lang

TOOL.Category = lang.get("tool.category.ls")
TOOL.Name = '#Gravity Plating'
TOOL.Command = nil
TOOL.ConfigName = ''
TOOL.Tab = "Spacebuild"

local SB = SPACEBUILD

-- Add Default Language translation (saves adding it to the txt files)
if ( CLIENT ) then
	lang.register( "tool.grav_plate.name" )
	lang.register( "tool.grav_plate.desc" )
	lang.register( "tool.grav_plate.0" )
end

local function SaveGravPlating( Player, Entity, Data )
	if not SERVER then return end
	if Data.GravPlating then
		Entity.grav_plate = 1
		if ( SERVER ) then
			Entity.EntityMods = Entity.EntityMods or {}
			Entity.EntityMods.GravPlating = Data
		end
	else
		Entity.grav_plate = nil
		if ( SERVER ) then
			if Entity.EntityMods then Entity.EntityMods.GravPlating = nil end
		end	
	end
	duplicator.StoreEntityModifier( Entity, "gravplating", Data )
end
duplicator.RegisterEntityModifier( "gravplating", SaveGravPlating )

function TOOL:LeftClick( trace )
	if trace.Entity then
		if not trace.Entity:IsValid() or trace.Entity:IsPlayer() or trace.HitWorld or trace.Entity:IsNPC() then
			return false
		end
	end
	if CLIENT then return true end
	local gravplating = 1
	SaveGravPlating(self:GetOwner(),trace.Entity,{ GravPlating = gravplating })
	SB.util.messages.notify(self:GetOwner(), lang.get("tool.grav_plate.added") )
	return true
end

function TOOL:RightClick( trace )
	if trace.Entity then
		if not trace.Entity:IsValid() or trace.Entity:IsPlayer() or trace.HitWorld or trace.Entity:IsNPC() then
			return false
		end
	end
	if CLIENT then return true end
	local gravplating = 0
	SaveGravPlating(self:GetOwner(),trace.Entity,{ GravPlating = gravplating })
	SB.util.messages.notify(self:GetOwner(), lang.get("tool.grav_plate.removed"))
	return true
end

function TOOL.BuildCPanel( CPanel )
	-- HEADER
	CPanel:AddControl( "Header", { Text = "#tool.grav_plate.name", Description	= "#tool.grav_plate.desc" }  )
end

local function overrideGravity(ent, gravity, pressure, environment)
	if gravity == 0 then
		local trace = {}
		local pos = ent:GetPos()
		trace.start = pos
		trace.endpos = pos - Vector(0,0,512)
		trace.filter = { ent }
		local tr = util.TraceLine( trace )
		if tr.Hit and tr.sb and tr.sb.grav_plate == 1 then
			return 1, pressure
		end
	end
	-- Else no return, let other hooks handle this
end
hook.Add( "SBOverrideEnvironmentGravity", "spacebuild.override.gravity_plating", overrideGravity );

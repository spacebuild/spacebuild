--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]] --
-- Created by IntelliJ IDEA.
-- User: Sam
-- Date: 31/12/12
-- Time: 10:11 AM
-- To change this template use File | Settings | File Templates.
--


TOOL.Category = "Debuggers" --TODO: Change for Sb4
TOOL.Name = "#Debugger"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.Tab = "Spacebuild"

TOOL.ClientConVar["ent"] = "models/SmallBridge/Hulls_SW/sbhulle1.mdl"
TOOL.ClientConVar[""] = ""

local pos
local ent


function TOOL:LeftClick(trace)
	--Spawn in the selected Generator
	DebugMessage(tostring(trace.HitPos))
	pos = trace.HitPos
	if IsValid(ent) then
		DebugMessage("local " .. tostring(ent:WorldToLocal(pos)))
	else
	end
end


function TOOL:RightClick(trace)
	--Select Model
	--[[
if (  not trace.Entity:IsValid() or trace.Entity:IsPlayer() ) then return false end

RunConsoleCommand( "sb4_ls_spawner_model", trace.Entity:GetModel());
]] --

	ent = trace.Entity
end
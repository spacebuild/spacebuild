-- Copyright (C) 2012-2013 Spacebuild Development Team
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

AddCSLuaFile()

DEFINE_BASECLASS("base_resource_network")

ENT.PrintName = "Large Resource Network"
ENT.Author = "SnakeSVx & Radon"
ENT.Contact = ""
ENT.Purpose = "Testing"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminOnly = false

ENT.hud = {
	vector = Vector(-130, 70, 5.28),
	scale = 0.4
}

function ENT:SpawnFunction(ply, tr)
	if (not tr.HitWorld) then return end

	local ent = ents.Create("resource_network_large")
	ent:SetModel("models/ce_ls3additional/screens/large_screen.mdl") --Only have to set it serverside
	ent:SetPos(tr.HitPos + Vector(0, 0, 50))
	ent:Spawn()

	return ent
end



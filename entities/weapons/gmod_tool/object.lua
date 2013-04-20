	
	
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

--[[---------------------------------------------------------
   Sets which stage a tool is at
-----------------------------------------------------------]]
function ToolObj:UpdateData()
	
	self:SetStage( self:NumObjects() )
	
end
	
--[[---------------------------------------------------------
   Sets which stage a tool is at
-----------------------------------------------------------]]
function ToolObj:SetStage( i )
	
	if ( SERVER ) then
		self:GetWeapon():SetNWInt( "Stage", i, true )
	end
	
end

--[[---------------------------------------------------------
   Gets which stage a tool is at
-----------------------------------------------------------]]
function ToolObj:GetStage()
	return self:GetWeapon():GetNWInt( "Stage", 0 )
end

--[[---------------------------------------------------------
-----------------------------------------------------------]]
function ToolObj:GetOperation()
	return self:GetWeapon():GetNWInt( "Op", 0 )
end

--[[---------------------------------------------------------
-----------------------------------------------------------]]
function ToolObj:SetOperation( i )
	
	if ( SERVER ) then
		self:GetWeapon():SetNWInt( "Op", i, true )
	end
	
end

--[[---------------------------------------------------------
   ClearObjects - clear the selected objects
-----------------------------------------------------------]]
function ToolObj:ClearObjects()

	self:ReleaseGhostEntity()
	self.Objects = {}
	self:SetStage( 0 )
	self:SetOperation( 0 )
	
end


--[[---------------------------------------------------------
	Since we're going to be expanding this a lot I've tried
	to add accessors for all of this crap to make it harder
	for us to mess everything up.
-----------------------------------------------------------]]
function ToolObj:GetEnt( i )

	if (not self.Objects[i]) then return NULL end
	
	return self.Objects[i].Ent
end


--[[---------------------------------------------------------
	Returns the world position of the numbered object hit
	We store it as a local vector then convert it to world
	That way even if the object moves it's still valid
-----------------------------------------------------------]]
function ToolObj:GetPos( i )

	if (self.Objects[i].Ent:EntIndex() == 0) then
		return self.Objects[i].Pos
	else
		if (self.Objects[i].Phys ~= nil and self.Objects[i].Phys:IsValid()) then
			return self.Objects[i].Phys:LocalToWorld(self.Objects[i].Pos)
		else
			return self.Objects[i].Ent:LocalToWorld(self.Objects[i].Pos)
		end
	end
	
end

--[[---------------------------------------------------------
	Returns the local position of the numbered hit
-----------------------------------------------------------]]
function ToolObj:GetLocalPos( i )
	return self.Objects[i].Pos
end


--[[---------------------------------------------------------
	Returns the physics bone number of the hit (ragdolls)
-----------------------------------------------------------]]
function ToolObj:GetBone( i )
	return self.Objects[i].Bone
end

function ToolObj:GetNormal( i )
	if (self.Objects[i].Ent:EntIndex() == 0) then
		return self.Objects[i].Normal
	else
		local norm
		if (self.Objects[i].Phys ~= nil and self.Objects[i].Phys:IsValid()) then
			norm = self.Objects[i].Phys:LocalToWorld(self.Objects[i].Normal)
		else
			norm = self.Objects[i].Ent:LocalToWorld(self.Objects[i].Normal)
		end
		
		return norm - self:GetPos(i)
	end
end


--[[---------------------------------------------------------
	Returns the physics object for the numbered hit
-----------------------------------------------------------]]
function ToolObj:GetPhys( i )

	if (self.Objects[i].Phys == nil) then
		return self:GetEnt(i):GetPhysicsObject()
	end

	return self.Objects[i].Phys
end


--[[---------------------------------------------------------
	Sets a selected object
-----------------------------------------------------------]]
function ToolObj:SetObject( i, ent, pos, phys, bone, norm )

	self.Objects[i] = {}
	self.Objects[i].Ent = ent
	self.Objects[i].Phys = phys
	self.Objects[i].Bone = bone
	self.Objects[i].Normal = norm

	-- Worldspawn is a special case
	if (ent:EntIndex() == 0) then

		self.Objects[i].Phys = nil
		self.Objects[i].Pos = pos
		
	else
		
		norm = norm + pos
	
		-- Convert the position to a local position - so it's still valid when the object moves
		if (phys ~= nil and phys:IsValid()) then
			self.Objects[i].Normal = self.Objects[i].Phys:WorldToLocal(norm)
			self.Objects[i].Pos = self.Objects[i].Phys:WorldToLocal(pos)
		else
			self.Objects[i].Normal = self.Objects[i].Ent:WorldToLocal(norm)
			self.Objects[i].Pos = self.Objects[i].Ent:WorldToLocal(pos)
		end
		
	end
	
	if (SERVER) then
		-- Todo: Make sure the client got the same info
	end
	
end


--[[---------------------------------------------------------
	Returns the number of objects in the list
-----------------------------------------------------------]]
function ToolObj:NumObjects()

	if ( CLIENT ) then
	
		return self:GetStage()
	
	end

	return #self.Objects
	
end


--[[---------------------------------------------------------
	Returns the number of objects in the list
-----------------------------------------------------------]]
function ToolObj:GetHelpText()

	return "#tool."..gmod_toolmode:GetString().."."..self:GetStage()
	
end



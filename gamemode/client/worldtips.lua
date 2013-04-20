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

local surface = surface
local GM = GM
local draw = draw
local const = GM.constants

local WorldTip = nil
local tipTable = {}

local TipColor = Color(50, 50, 50, 220)

local FrameDelay = 0

--
-- Adds a hint to the queue
--
function GM:AddWorldTip( unused1, unused2, unused3, pos, ent )

	WorldTip = {}

	WorldTip.dietime 	= SysTime() + 0.05
	--WorldTip.text 		= text
	WorldTip.pos 		= pos
	WorldTip.ent 		= ent

	table.insert( tipTable, WorldTip )

end

local function rotatePoint( pt, center, angleDeg)

	local angleRad = angleDeg * math.pi/180
	local angleRad = angleDeg
	local cosAngle = math.cos( angleRad )
	local sinAngle = math.sin( angleRad )
	local dx = (pt.x - center.x)
	local dy = (pt.y - center.y)

	pt.x = center.x + (dx*cosAngle-dy*sinAngle)
	pt.y = center.y + (dx*sinAngle+dy*cosAngle)

	return pt

end

local dx = 0

local function DrawWorldTip( tip )

	if ( IsValid( tip.ent ) ) then
		tip.pos = tip.ent:GetPos()
	end

	local pos = tip.pos:ToScreen()  -- Gets the screen x,y for that position vector
	local r = 50 -- "RADIUS" of our square, or diagonal distance, whatever :P
	local verts = {}             -- 1: left, 2: up, 3: right, 4: down
	local poly = {}

	-- R counts as our initial offset from a center location of pos.x and pos.y
	-- Counter-clockwise rotation

	verts[1] = { x=pos.x-r, y=pos.y } -- Set up a simple square first. (Or Diamond if you prefer)
	verts[2] = { x=pos.x, y=pos.y-r}
	verts[3] = { x=pos.x+r, y=pos.y}
	verts[4] = { x=pos.x, y=pos.y+r }

	verts[1] = rotatePoint( verts[1], pos, dx) -- Rotate each point around the center position by dx amount.
	verts[2] = rotatePoint( verts[2], pos, dx)
	verts[3] = rotatePoint( verts[3], pos, dx)
	verts[4] = rotatePoint( verts[4], pos, dx)

	local r2 = 15

	local dr = math.abs( (r2/5)*math.sin(dx)*1/4 + (r2/5) )

	-- Triangle, up, bottom left, bottom right.
	poly[1] = { x=pos.x, y=pos.y-(r2) }
	poly[2] = { x=pos.x- r2*math.cos(30 * math.pi/180), y=pos.y+ r2*math.sin(30 *math.pi/180) }
	poly[3] = { x=pos.x+ r2*math.cos(30 * math.pi/180), y=pos.y+ r2*math.sin(30 *math.pi/180) }

	poly[1] = rotatePoint( poly[1], pos, dx*-0.5 )
	poly[2] = rotatePoint( poly[2], pos, dx*-0.5 )
	poly[3] = rotatePoint( poly[3], pos, dx*-0.5 )



	local raceColour = player_manager.RunClass( LocalPlayer(), "getRaceColor" )
	raceColour.a = 255

	surface.SetDrawColor( raceColour ) -- Set colour for poly
	surface.DrawPoly( poly ) -- Create our poly in the center

	for i=1, #verts do
		surface.SetDrawColor( raceColour ) -- Set the line colour to be the player's race colour.

	    if i ~= #verts then
			surface.DrawLine( verts[i].x, verts[i].y, verts[i+1].x, verts[i+1].y)  -- For 1,2,3 verts connect to next.
		elseif i == #verts then
			surface.DrawLine( verts[i].x, verts[i].y, verts[1].x, verts[1].y) -- But on the final vert, loop it back to the first making a connected "poly"
		end

	end

	dx = RealTime() * -1

	if math.abs( math.abs(dx) % 90) < 0.01 and math.abs(dx) >= 90 then --Ensure that even -90 will work :D Also make sure we reset because otherwise huge floats are bad :C
		dx = 0
	end



end


function GM:PaintWorldTips()

	local suit = GM:getPlayerSuit()

	for k, WorldTip in pairs(tipTable) do

		if suit and suit:isActive() then
			if WorldTip and WorldTip.dietime > SysTime() then
				DrawWorldTip( WorldTip )
			end
		end

	end

	tipTable = {}  -- Clear the table once we've drawn the contents, otherwise push pop till your shoulder stops


end

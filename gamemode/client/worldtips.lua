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

surface.CreateFont( "GModWorldtip",
	{
		font		= "HudHintTextSmall",
		size		= 16,
		weight		= 250
	})

local WorldTip = nil

local TipColor = Color(50, 50, 50, 220)

--
-- Adds a hint to the queue
--
function GM:AddWorldTip( unused1, text, unused2, pos, ent )

	WorldTip = {}

	WorldTip.dietime 	= SysTime() + 0.05
	WorldTip.text 		= text
	WorldTip.pos 		= pos
	WorldTip.ent 		= ent

end


local function DrawWorldTip( tip )

	if ( IsValid( tip.ent ) ) then
		tip.pos = tip.ent:GetPos()
	end

	local pos = tip.pos:ToScreen()
	local tipcol = Color( TipColor.r, TipColor.g, TipColor.b, 255 )

	local x = 0
	local y = 0
	local padding = 10
	local offset = 50

	surface.SetFont( "GModWorldtip" )
	local w, h = surface.GetTextSize( tip.text )

	x = pos.x - w
	y = pos.y - h

	x = x - offset
	y = y - offset

	draw.RoundedBox( 8, x-padding-2, y-padding-2, w+padding*2+4, h+padding*2+4, const.colors.orange )


	local verts = {}
	verts[1] = { x=x+w/1.5-2, y=y+h+2 }
	verts[2] = { x=x+w+2, y=y+h/2-1 }
	verts[3] = { x=pos.x-offset/1.5+2, y=pos.y-offset/1.5+2 }

	draw.NoTexture()
	surface.SetDrawColor( const.colors.orange.r, const.colors.orange.g, const.colors.orange.b, tipcol.a )
	surface.DrawPoly( verts )


	draw.RoundedBox( 8, x-padding, y-padding, w+padding*2, h+padding*2, tipcol )

	local verts = {}
	verts[1] = { x=x+w/1.5, y=y+h }
	verts[2] = { x=x+w, y=y+h/2 }
	verts[3] = { x=pos.x-offset/1.5, y=pos.y-offset/1.5 }

	draw.NoTexture()
	surface.SetDrawColor( tipcol.r, tipcol.g, tipcol.b, tipcol.a )
	surface.DrawPoly( verts )


	draw.DrawText( tip.text, "GModWorldtip", x + w/2, y, const.colors.orange, TEXT_ALIGN_CENTER )

end


function GM:PaintWorldTips()

	if GM:getPlayerSuit():isActive() and WorldTip and WorldTip.dietime > SysTime() then
		DrawWorldTip( WorldTip )
	end

end



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

local matScreen 	= Material( "models/weapons/v_toolgun/screen" )
local txidScreen	= surface.GetTextureID( "models/weapons/v_toolgun/screen" )
local txRotating	= surface.GetTextureID( "pp/fb" )

local txBackground	= surface.GetTextureID( "models/weapons/v_toolgun/screen_bg" )


-- GetRenderTarget returns the texture if it exists, or creates it if it doesn't
local RTTexture 	= GetRenderTarget( "GModToolgunScreen", 256, 256 )

local function DrawScrollingText( text, y, texwide )

		local w, h = surface.GetTextSize( text  )
		w = w + 64
		
		local x = math.fmod( CurTime() * 400, w ) * -1;
		
		while ( x < texwide ) do
		
			surface.SetTextColor( 0, 0, 0, 255 )
			surface.SetTextPos( x + 3, y + 3 )
			surface.DrawText( text )
				
			surface.SetTextColor( 255, 255, 255, 255 )
			surface.SetTextPos( x, y )
			surface.DrawText( text )
			
			x = x + w
			
		end

end

--[[---------------------------------------------------------
	We use this opportunity to draw to the toolmode 
		screen's rendertarget texture.
-----------------------------------------------------------]]
function SWEP:RenderScreen() --Default RenderScreen to fall back on
	
	local TEX_SIZE = 256
	local mode 	= gmod_toolmode:GetString()
	local NewRT = RTTexture
	local oldW = ScrW()
	local oldH = ScrH()
	
	-- Set the material of the screen to our render target
	matScreen:SetTexture( "$basetexture", NewRT )
	
	local OldRT = render.GetRenderTarget();
	
	-- Set up our view for drawing to the texture
	render.SetRenderTarget( NewRT )
	render.SetViewPort( 0, 0, TEX_SIZE, TEX_SIZE )
	cam.Start2D()
	
		-- Background
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetTexture( txBackground )
		surface.DrawTexturedRect( 0, 0, TEX_SIZE, TEX_SIZE )
		
		-- Give our toolmode the opportunity to override the drawing
		if ( self:GetToolObject() and self:GetToolObject().DrawToolScreen ) then
		
			self:GetToolObject():DrawToolScreen( TEX_SIZE, TEX_SIZE )
		
		else
			
			surface.SetFont( "ToolGunDefault" )
			DrawScrollingText( "#tool."..mode..".name", 64, TEX_SIZE )
				
		end

	cam.End2D()
	render.SetRenderTarget( OldRT )
	render.SetViewPort( 0, 0, oldW, oldH )
	
end
local class = sb.core.class
local fluix = fluix
fluix.modules.BottomPanel = { Enabled = true }
fluix.PlayerHealth, fluix.HealthS, fluix.PlayerArmor, fluix.ArmorS = 0, 0, 0, 0
fluix.BreathS, fluix.MaxBreathS = 0, 100
fluix.Ammo1, fluix.Ammo1S, fluix.Ammo1Total, fluix.Ammo1Max, fluix.Ammo2 = 0, 0, 0, 0, 0
fluix.Weapon = LocalPlayer()
fluix.WeaponTable = { }
fluix.WeaponS = 0


--========================================Draw a bar indicator======================================================
local drawBarIndicator = function ( PosX, PosY, SizeX, SizeY, Value, Max, bg_color, value_color )
    value_color = Color(value_color.r, value_color.g, value_color.b, value_color.a)
    bg_color = Color(bg_color.r, bg_color.g, bg_color.b, bg_color.a)
    PosX, PosY = PosX * math.Clamp(fluix.Smooth+0.4,0,1), PosY --* fluix.Smooth
    SizeX, SizeY = SizeX * math.Clamp(fluix.Smooth+0.4,0,1), SizeY --* fluix.Smooth
    Value = Value * fluix.Smooth2

    --[[bg_color.a = bg_color.a * fluix.Smooth
    surface.SetDrawColor( bg_color )
    surface.DrawRect( PosX, PosY, SizeX, SizeY )  ]]

    --[[bg_color = fluix.ColorNegate( bg_color )
    local old_alpha = bg_color.a
    bg_color.a = 255 * fluix.Smooth ]]
    bg_color.a = bg_color.a * fluix.Smooth
    value_color.a = value_color.a * fluix.Smooth

    --bg_color.a = old_alpha
    surface.SetDrawColor( value_color )           -- Outline of Background of the bar
    surface.DrawOutlinedRect( PosX + SizeX * 0.05, PosY + SizeY * 0.2, SizeX * 0.9, SizeY * 0.4 )

    surface.SetDrawColor( bg_color )        -- Background of Bar
    surface.DrawRect( PosX + SizeX * 0.05, PosY + SizeY * 0.2, SizeX * 0.9, SizeY * 0.4 )

    --value_color.a = value_color.a * fluix.Smooth
    surface.SetDrawColor( value_color )          --Value of Bar
    surface.DrawRect( PosX + SizeX * 0.05, PosY + SizeY * 0.2, SizeX * ( Value / Max ) * 0.9, SizeY * 0.4 )


end


--======================================== Display Ammo ======================================================


local drawAmmo = function (PosX,PosY,SizeX,SizeY, bg_color, value_color)


    drawBarIndicator( PosX, PosY, SizeX, SizeY, math.Clamp( fluix.Ammo1S * fluix.WeaponS, 0, fluix.Ammo1Max ), fluix.Ammo1Max, bg_color, value_color )


    fluix.DrawText( PosX, PosY + SizeY * 0.85, SizeX, string.Right(
        string.format( "Ammo: %i Total: %i", math.Round( fluix.Ammo1S ) * fluix.Smooth2, fluix.Ammo1Total * fluix.Smooth2 ), SizeX / 8 ), value_color )

    PosY = PosY + SizeY                 --ALT AMMO?
    fluix.DrawText( PosX, PosY + SizeY * 0.5, SizeX, string.Right( string.format( "Alt: %i", fluix.Ammo2 ), SizeX / 12 ), value_color, "Default" )


end

local function CopyColor(color)
   return Color(color.r, color.g, color.b, color.a)
end


--=================================================================================================================

local function getBreath(component)
    return fluix.BreathS
end

local function getMaxBreath(component)
    return fluix.MaxBreathS
end

local white, orange, red, bg = Color( 255, 255, 255, 240 ), Color( 255, 127, 36, 240 ), Color( 205, 51, 51, 240 ), Color( 50,50,50,220)
local function getColorBasedOnValue(component, value)
    if value > 30 then
        return  white
    elseif value > 15 then
        return orange
    end
    return red
end

local function getColorWhite()
   return white
end

local function getHealth()
   return fluix.HealthS
end

local function getMaxHealth()
   return 100
end

local function getArmor()
   return fluix.ArmorS
end

local function getMaxArmor()
   return 100
end

local suit, hudPanel
function fluix.modules.BottomPanel.Run( )
    --Check if player is alive.
    if LocalPlayer():Alive() then
        fluix.PlayerHealth = LocalPlayer():Health()
        fluix.PlayerArmor = LocalPlayer():Armor()
    end
    suit = sb.getPlayerSuit()

    -- Calculate breath

    if suit then
        fluix.BreathS = fluix.Smoother( suit:getBreath(), fluix.BreathS, 0.15 )
        fluix.MaxBreathS = suit:getMaxBreath()
    end

    --Calculate Health.
    fluix.HealthS = fluix.Smoother( fluix.PlayerHealth, fluix.HealthS, 0.15 )

    --Calculate Armor.
    fluix.ArmorS = fluix.Smoother( fluix.PlayerArmor, fluix.ArmorS, 0.15 )

    if not hudPanel then
       hudPanel = class.create("HudPanel", 16, (ScrH() - 72*3) - 20, false);
       hudPanel:addChild(class.create("HudBarIndicator", 0, 0, hudPanel, 200, 72, "Breath: %i%s", getBreath, getColorBasedOnValue, getMaxBreath))
       hudPanel:addChild(class.create("HudBarIndicator", 0, 72, hudPanel, 200, 72, "Health: %i%s", getHealth, getColorWhite, getMaxHealth ))
       hudPanel:addChild(class.create("HudBarIndicator", 0, 72 * 2, hudPanel, 200, 72, "Armor: %i%s", getArmor, getColorWhite, getMaxArmor ))
    end
    hudPanel:render()


	local SizeX, SizeY = 200, 48
    local SizeY2 = SizeY + SizeY/4 -- Height of 1 section.
    local PosX, PosY = 16, (ScrH() - SizeY2*3) - 20


	
	

	--Draw primary ammo bar.
	PosX, PosY = ScrW() - 216, ScrH() - 144 --Absolute values as SizeX varies with ammo, and can't be calculated previously.
	
	--Check if the weapon is valid.
	fluix.Weapon = LocalPlayer():GetActiveWeapon()
	fluix.Ammo1Total = fluix.Weapon:IsValid() and LocalPlayer():GetAmmoCount( fluix.Weapon:GetPrimaryAmmoType() ) or 0
	if fluix.Weapon:IsValid() and fluix.WeaponS >= 1 then
		
		fluix.Ammo1 = fluix.Weapon:Clip1() or 0
		--Check if weapon has ammo
		if fluix.Ammo1 > 0 then
			
			--Add weapon's maximum ammo to the table.
			if not fluix.WeaponTable[ fluix.Weapon:GetClass() ] then
				fluix.WeaponTable[ fluix.Weapon:GetClass() ] = 1
			elseif fluix.Ammo1 > fluix.WeaponTable[ fluix.Weapon:GetClass() ] then
				fluix.WeaponTable[ fluix.Weapon:GetClass() ] = fluix.Ammo1
			end
			
			fluix.Ammo1Max = fluix.WeaponTable[ fluix.Weapon:GetClass() ]
			
			fluix.Ammo2 = fluix.Weapon:GetSecondaryAmmoType() and LocalPlayer():GetAmmoCount( fluix.Weapon:GetSecondaryAmmoType() ) or 0
		elseif fluix.Ammo1Total > 0 then
			fluix.Ammo1 = 0
		end
		
		fluix.Ammo1S = fluix.Smoother( fluix.Ammo1, fluix.Ammo1S, 0.15 )
	elseif fluix.Weapon:IsValid() and ( fluix.Weapon:Clip1() > 0 or fluix.Ammo1Total > 0 ) then
		fluix.Ammo1S = 0.15
	end
	
	
	
	--Controller for showing the ammo bar.
	if ( fluix.Ammo1Total > 0 or fluix.Ammo1S > 0.1 ) and fluix.WeaponS < 1 and fluix.Smooth >= 1 then
		fluix.WeaponS = fluix.Smoother( 1.1, fluix.WeaponS, 0.15 )
	elseif fluix.Ammo1Total <= 0 and fluix.Ammo1S <= 0.1 and fluix.WeaponS > 0 then
		fluix.WeaponS = fluix.Smoother( -0.1, fluix.WeaponS, 0.15 )
	elseif fluix.WeaponS > 1 then
		fluix.WeaponS = 1
	elseif fluix.WeaponS < 0 then
		fluix.WeaponS = 0
	end
	
	--Shows the ammo bar.
	if fluix.WeaponS > 0 then
		SizeX = SizeX * fluix.WeaponS --THIS IS A BLOODY SMOOTHER

        drawAmmo(PosX,PosY,SizeX,SizeY,CopyColor(bg),CopyColor(white))

	end
	
end
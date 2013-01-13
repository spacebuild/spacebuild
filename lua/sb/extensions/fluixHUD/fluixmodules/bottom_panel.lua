local class = sb.core.class
local fluix = fluix
fluix.modules.BottomPanel = { Enabled = true }
fluix.PlayerHealth, fluix.HealthS, fluix.PlayerArmor, fluix.ArmorS = 0, 0, 0, 0
fluix.BreathS, fluix.MaxBreathS = 0, 100
fluix.Ammo1, fluix.Ammo1S, fluix.Ammo1Total, fluix.Ammo1Max, fluix.Ammo2 = 0, 0, 0, 0, 0
fluix.Weapon = LocalPlayer()
fluix.WeaponTable = { }
fluix.WeaponS = 0

--=================================================================================================================

local function getBreath(component)
    return fluix.BreathS
end

local function getMaxBreath(component)
    return fluix.MaxBreathS
end

local white, orange, red, bg = Color( 255, 255, 255, 240 ), Color( 255, 127, 36, 240 ), Color( 205, 51, 51, 240 ), Color( 50,50,50,220)
local function getColorBasedOnValue(component, value, maxvalue)
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

local function getAmmo()
    return fluix.Ammo1
end

local function getMaxAmmo()
    return fluix.Ammo1Max
end

local suit, hudLeftBottomPanel, hudBottomRightPanel
function fluix.modules.BottomPanel.Run( )
    -- Define Hud Components
    if not hudLeftBottomPanel then
        hudLeftBottomPanel = class.create("HudPanel", 16, (ScrH() - 72*3) - 20, false);
        hudLeftBottomPanel:addChild(class.create("HudBarIndicator", 0, 0, 200, 72, "Breath: %i%s", getBreath, getColorBasedOnValue, getMaxBreath))
        hudLeftBottomPanel:addChild(class.create("HudBarIndicator", 0, 72, 200, 72, "Health: %i%s", getHealth, getColorWhite, getMaxHealth ))
        hudLeftBottomPanel:addChild(class.create("HudBarIndicator", 0, 72 * 2, 200, 72, "Armor: %i%s", getArmor, getColorWhite, getMaxArmor ))
    end
    if not hudBottomRightPanel then
        hudBottomRightPanel = class.create("HudPanel", ScrW() - 216, ScrH() - 144, false)
        local indicator = class.create("HudBarIndicator", 0, 0, 200, 48, nil, getAmmo, getColorWhite, getMaxAmmo)
        local oldRender = indicator.render
        function indicator:render()
            if fluix.WeaponS <= 0 then return end
            oldRender(self)
            self:DrawText( self:getX(), self:getY() + (self.height - self.height/8), self.width, string.format( "Ammo: %i Total: %i", self.value , fluix.Ammo1Total ), self:getColor() )
            fluix.DrawText( self:getX(), self:getY() + self.height + self.height * 0.5, self.width, string.Right( string.format( "Alt: %i", fluix.Ammo2 ), self.width / 12 ), self:getColor(), "Default" )
        end
        hudBottomRightPanel:addChild(indicator)
    end

    -- Calculate values


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

	--Check if the weapon is valid.
	fluix.Weapon = LocalPlayer():GetActiveWeapon()
	fluix.Ammo1Total = fluix.Weapon:IsValid() and LocalPlayer():GetAmmoCount( fluix.Weapon:GetPrimaryAmmoType() ) or 0
	if fluix.Weapon:IsValid() and fluix.WeaponS >= 1 then
		
		fluix.Ammo1 = fluix.Weapon:Clip1() or 0
		--Check if weapon has ammo
		if fluix.Ammo1 > 0 then
			
			--Add weapon's maximum ammo to the table.
			if not fluix.WeaponTable[ fluix.Weapon:GetClass() ] then
				fluix.WeaponTable[ fluix.Weapon:GetClass() ] = fluix.Ammo1
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

    -- Render Hud Components
    hudLeftBottomPanel:render()
    hudBottomRightPanel:render()
	
end
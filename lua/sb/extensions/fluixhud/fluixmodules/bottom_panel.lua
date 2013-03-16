require("class")
local class = class
local fluix = fluix
fluix.modules.BottomPanel = { Enabled = true }
fluix.Ammo1, fluix.Ammo1S, fluix.Ammo1Total, fluix.Ammo1Max, fluix.Ammo2 = 0, 0, 0, 0, 0
fluix.Weapon = LocalPlayer()
fluix.WeaponTable = { }
fluix.WeaponS = 0

--=================================================================================================================

local scrW, scrH, width, height = ScrW(), ScrH()
if scrW > 1650 then
    width  = 200
elseif scrW > 1024 then
    width = 150
else
    width = 100
end

if scrH > 900 then
    height = 36
elseif scrH > 750 then
    height = 24
else
    height = 16
end

local white, orange, red, bg = Color( 255, 255, 255, 240 ), Color( 255, 127, 36, 240 ), Color( 205, 51, 51, 240 ), Color( 50,50,50,220)
local suit, hudLeftBottomPanel, hudBottomRightPanel, breathBar, healthBar, armorBar, ammoBar, altBar
function fluix.modules.BottomPanel.Run( )
    -- Define Hud Components
    if not hudLeftBottomPanel then
        hudLeftBottomPanel = class.new("BottomLeftPanel", 16, scrH - 20, 0, 0, false, true) -- Parent housing/stack, (ClassName,x,y,w,h,valColor,bgColor,string)
        breathBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, "Breath: %i%s")
        healthBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, "Health: %i%s")
        armorBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, "Armor: %i%s")
        hudLeftBottomPanel:addChild(breathBar):addChild(healthBar):addChild(armorBar)
    end
    if not hudBottomRightPanel then
        hudBottomRightPanel = class.new("BottomRightPanel", scrW -  16, scrH - 20, 0, 0, false, true)
        ammoBar = class.new("HudBarTextIndicator", 0, 0, width, height, 0, 100, white, bg, false)
        altBar = class.new("TextElement", 0, 0, width, height, white, "Alt: %i")

        local oldRender = ammoBar.render
        function ammoBar:render()
            if fluix.WeaponS <= 0 then return end
            oldRender(self)
            self:DrawText( self:getX(), self:getY() + (self:getHeight() - self:getHeight()/8), self.width, string.format( "Ammo: %i Total: %i", self.value , fluix.Ammo1Total ), self:getColor() )
            --fluix.DrawText( self:getX(), self:getY() + self:getHeight() + (self:getHeight() - self:getHeight()/8), self.width, string.Right( string.format( "Alt: %i", fluix.Ammo2 ), self.width / 12 ), self:getColor(), "Default" )
        end

        local oldRender = altBar.render
        function altBar:render()
            if fluix.WeaponS <= 0 then return end
            self:setY( self:getHeight() * 15/8 )
            self:setText( string.Right( string.format( "Alt: %i", fluix.Ammo2 ), self:getWidth() / 12 ) )
            oldRender(self)
        end


        hudBottomRightPanel:addChild(ammoBar):addChild(altBar)
    end

    -- Calculate values


    --Check if player is alive.
    if LocalPlayer():Alive() then
        healthBar:setValue(LocalPlayer():Health())
        armorBar:setValue(LocalPlayer():Armor())
    end
    suit = sb.getPlayerSuit()

    -- Calculate breath

    if suit then
        breathBar:setValue(fluix.Smoother( suit:getBreath(), breathBar:getValue(), 0.15 ))
        breathBar:setMaxValue( suit:getMaxBreath())
    end

    --Calculate Health.
    healthBar:setValue(fluix.Smoother( LocalPlayer():Health(), healthBar:getValue(), 0.15 ))

    --Calculate Armor.
    armorBar:setValue(fluix.Smoother( LocalPlayer():Armor(), armorBar:getValue(), 0.15 ))

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

    ammoBar:setValue(fluix.Ammo1)
    ammoBar:setMaxValue(fluix.Ammo1Max)

    -- Render Hud Components
    hudLeftBottomPanel:render()
    hudBottomRightPanel:render()
	
end
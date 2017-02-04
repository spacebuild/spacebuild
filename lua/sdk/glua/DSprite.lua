---
-- @description Library DSprite
 module("DSprite")

--- DSprite:GetColor
-- @usage client
-- Gets the color the sprite is using as a modifier.
--
-- @return table The Color being used.
function GetColor() end

--- DSprite:GetMaterial
-- @usage client
-- Gets the material the sprite is using.
--
-- @return IMaterial The material in use.
function GetMaterial() end

--- DSprite:GetRotation
-- @usage client
-- Gets the 2D rotation angle of the sprite, in the plane of the screen.
--
-- @return number The anti-clockwise rotation in degrees.
function GetRotation() end

--- DSprite:SetColor
-- @usage client
-- Sets the color modifier for the sprite.
--
-- @param  color table  The Color to use.
function SetColor( color) end

--- DSprite:SetMaterial
-- @usage client
-- Sets the source material for the sprite.
--
-- @param  material IMaterial  The material to use. This will ideally be an UnlitGeneric.
function SetMaterial( material) end

--- DSprite:SetRotation
-- @usage client
-- Sets the 2D rotation angle of the sprite, in the plane of the screen.
--
-- @param  ang number  The anti-clockwise rotation in degrees.
function SetRotation( ang) end

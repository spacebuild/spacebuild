---
-- @description Library CEffectData
 module("CEffectData")

--- CEffectData:GetAngles
-- @usage shared
-- Returns the angles of the effect.
--
-- @return Angle The angles of the effect
function GetAngles() end

--- CEffectData:GetAttachment
-- @usage shared
-- Returns the attachment ID for the effect.
--
-- @return number The attachment ID of the effect.
function GetAttachment() end

--- CEffectData:GetColor
-- @usage shared
-- Returns byte which represents the color of the effect.
--
-- @return number The color of the effect
function GetColor() end

--- CEffectData:GetDamageType
-- @usage shared
-- Returns the damage type of the effect
--
-- @return number Damage type of the effect, see DMG_ Enums
function GetDamageType() end

--- CEffectData:GetEntIndex
-- @usage server
-- Returns the entity index of the entity set for the effect.
--
-- @return number The entity index of the entity set for the effect.
function GetEntIndex() end

--- CEffectData:GetEntity
-- @usage shared
-- Returns the entity assigned to the effect.
--
-- @return Entity The entity assigned to the effect
function GetEntity() end

--- CEffectData:GetFlags
-- @usage shared
-- Returns the flags of the effect.
--
-- @return number The flags of the effect.
function GetFlags() end

--- CEffectData:GetHitBox
-- @usage shared
-- Returns the hit box ID of the effect.
--
-- @return number The hit box ID of the effect.
function GetHitBox() end

--- CEffectData:GetMagnitude
-- @usage shared
-- Returns the magnitude of the effect.
--
-- @return number The magnitude of the effect.
function GetMagnitude() end

--- CEffectData:GetMaterialIndex
-- @usage shared
-- Returns the material ID of the effect.
--
-- @return number The material ID of the effect.
function GetMaterialIndex() end

--- CEffectData:GetNormal
-- @usage shared
-- Returns the normalized direction vector of the effect.
--
-- @return Vector The normalized direction vector of the effect.
function GetNormal() end

--- CEffectData:GetOrigin
-- @usage shared
-- Returns the origin position of the effect.
--
-- @return Vector The origin position of the effect.
function GetOrigin() end

--- CEffectData:GetRadius
-- @usage shared
-- Returns the radius of the effect.
--
-- @return number The radius of the effect.
function GetRadius() end

--- CEffectData:GetScale
-- @usage shared
-- Returns the scale of the effect.
--
-- @return number The scale of the effect
function GetScale() end

--- CEffectData:GetStart
-- @usage shared
-- Returns the start position of the effect.
--
-- @return Vector The start position of the effect
function GetStart() end

--- CEffectData:GetSurfaceProp
-- @usage shared
-- Returns the surface property index of the effect.
--
-- @return number The surface property index of the effect
function GetSurfaceProp() end

--- CEffectData:SetAngles
-- @usage shared
-- Sets the angles of the effect.
--
-- @param  ang Angle  The new angles to be set.
function SetAngles( ang) end

--- CEffectData:SetAttachment
-- @usage shared
-- Sets the attachment id of the effect to be created with this effect data.
--
-- @param  attachment number  New attachment ID of the effect.
function SetAttachment( attachment) end

--- CEffectData:SetColor
-- @usage shared
-- Sets the color of the effect.
--
-- @param  color number  Color represented by a byte.
function SetColor( color) end

--- CEffectData:SetDamageType
-- @usage shared
-- Sets the damage type of the effect to be created with this effect data.
--
-- @param  damageType number  Damage type, see DMG_ Enums.
function SetDamageType( damageType) end

--- CEffectData:SetEntIndex
-- @usage server
-- Sets the entity of the effect via its index.
--
-- @param  entIndex number  The entity index to be set.
function SetEntIndex( entIndex) end

--- CEffectData:SetEntity
-- @usage shared
-- Sets the entity of the effect to be created with this effect data.
--
-- @param  entity Entity  Entity of the effect, mostly used for parenting.
function SetEntity( entity) end

--- CEffectData:SetFlags
-- @usage shared
-- Sets the flags of the effect.
--
-- @param  flags number  The flags of the effect. Engine flags:   PARTICLE_DISPATCH_FROM_ENTITY = 1  PARTICLE_DISPATCH_RESET_PARTICLES = 2
function SetFlags( flags) end

--- CEffectData:SetHitBox
-- @usage shared
-- Sets the hit box index of the effect.
--
-- @param  hitBoxIndex number  The hit box index of the effect.
function SetHitBox( hitBoxIndex) end

--- CEffectData:SetMagnitude
-- @usage shared
-- Sets the magnitude of the effect.
--
-- @param  magnitude number  The magnitude of the effect.
function SetMagnitude( magnitude) end

--- CEffectData:SetMaterialIndex
-- @usage shared
-- Sets the material index of the effect.
--
-- @param  materialIndex number  The material index of the effect.
function SetMaterialIndex( materialIndex) end

--- CEffectData:SetNormal
-- @usage shared
-- Sets the normalized direction vector of the effect to be created with this effect data.
--
-- @param  normal Vector  The normalized direction vector of the effect.
function SetNormal( normal) end

--- CEffectData:SetOrigin
-- @usage shared
-- Sets the origin of the effect to be created with this effect data.
--
-- @param  origin Vector  Origin of the effect.
function SetOrigin( origin) end

--- CEffectData:SetRadius
-- @usage shared
-- Sets the radius of the effect to be created with this effect data.
--
-- @param  radius number  Radius of the effect.
function SetRadius( radius) end

--- CEffectData:SetScale
-- @usage shared
-- Sets the scale of the effect to be created with this effect data.
--
-- @param  scale number  Scale of the effect.
function SetScale( scale) end

--- CEffectData:SetStart
-- @usage shared
-- Sets the start of the effect to be created with this effect data.
--
-- @param  start Vector  Start of the effect.
function SetStart( start) end

--- CEffectData:SetSurfaceProp
-- @usage shared
-- Sets the surface property index of the effect.
--
-- @param  surfaceProperties number  The surface property index of the effect.
function SetSurfaceProp( surfaceProperties) end

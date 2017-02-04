---
-- @description Library CTakeDamageInfo
 module("CTakeDamageInfo")

--- CTakeDamageInfo:AddDamage
-- @usage shared
-- Increases the damage by damageIncrease.
--
-- @param  damageIncrease number  The damage to add.
function AddDamage( damageIncrease) end

--- CTakeDamageInfo:GetAmmoType
-- @usage shared
-- Returns the ammo type used by the weapon that inflicted the damage.
--
-- @return number Ammo type ID
function GetAmmoType() end

--- CTakeDamageInfo:GetAttacker
-- @usage shared
-- Returns the attacker ( character who originated the attack ), for example a player or an NPC that shot the weapon.
--
-- @return Entity The attacker
function GetAttacker() end

--- CTakeDamageInfo:GetBaseDamage
-- @usage shared
-- Returns the initial unmodified by skill level ( game.GetSkillLevel ) damage.
--
-- @return number baseDamage
function GetBaseDamage() end

--- CTakeDamageInfo:GetDamage
-- @usage shared
-- Returns the total damage.
--
-- @return number damage
function GetDamage() end

--- CTakeDamageInfo:GetDamageBonus
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return number 
function GetDamageBonus() end

--- CTakeDamageInfo:GetDamageCustom
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return number 
function GetDamageCustom() end

--- CTakeDamageInfo:GetDamageForce
-- @usage shared
-- Returns a vector representing the damage force.
--
-- @return Vector The damage force
function GetDamageForce() end

--- CTakeDamageInfo:GetDamagePosition
-- @usage shared
-- Returns the position where the damage was or is going to be applied to.
--
-- @return Vector The damage position
function GetDamagePosition() end

--- CTakeDamageInfo:GetDamageType
-- @usage shared
-- Returns a bitflag which indicates the damage type(s) of the damage.
--
-- @return number Damage type(s), a combination of DMG_ Enums
function GetDamageType() end

--- CTakeDamageInfo:GetInflictor
-- @usage shared
-- Returns the inflictor of the damage. This is not necessarily a weapon.
--
-- @return Entity The inflictor
function GetInflictor() end

--- CTakeDamageInfo:GetMaxDamage
-- @usage shared
-- Returns the maximum damage.
--
-- @return number maxDmg
function GetMaxDamage() end

--- CTakeDamageInfo:GetReportedPosition
-- @usage shared
-- Returns the initial, unmodified position where the damage occured.
--
-- @return Vector position
function GetReportedPosition() end

--- CTakeDamageInfo:IsBulletDamage
-- @usage shared
-- Returns true if the damage was caused by a bullet.
--
-- @return boolean isBulletDmg
function IsBulletDamage() end

--- CTakeDamageInfo:IsDamageType
-- @usage shared
-- Returns whenever the damageinfo contains the damage type specified.
--
-- @param  dmgType number  Damage type to test. See DMG_ Enums.
-- @return boolean Whether this damage contains specified damage type or not
function IsDamageType( dmgType) end

--- CTakeDamageInfo:IsExplosionDamage
-- @usage shared
-- Returns whenever the damageinfo contains explosion damage.
--
-- @return boolean isExplDamage
function IsExplosionDamage() end

--- CTakeDamageInfo:IsFallDamage
-- @usage shared
-- Returns whenever the damageinfo contains fall damage.
--
-- @return boolean isFallDmg
function IsFallDamage() end

--- CTakeDamageInfo:ScaleDamage
-- @usage shared
-- Scales the damage by the given value.
--
-- @param  scale number  Value to scale the damage with.
function ScaleDamage( scale) end

--- CTakeDamageInfo:SetAmmoType
-- @usage shared
-- Changes the ammo type used by the weapon that inflicted the damage.
--
-- @param  ammoType number  Ammo type ID
function SetAmmoType( ammoType) end

--- CTakeDamageInfo:SetAttacker
-- @usage shared
-- Sets the attacker ( character who originated the attack ) of the damage, for example a player or an NPC.
--
-- @param  ent Entity  The entity to be set as the attacker.
function SetAttacker( ent) end

--- CTakeDamageInfo:SetDamage
-- @usage shared
-- Sets the amount of damage.
--
-- @param  damage number  The value to set the absolute damage to.
function SetDamage( damage) end

--- CTakeDamageInfo:SetDamageBonus
-- @usage shared
-- Adds bonus damage, like CTakeDamageInfo:AddDamage does.
--
-- @param  damage number  The extra damage to be added
function SetDamageBonus( damage) end

--- CTakeDamageInfo:SetDamageCustom
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param Uy number 
function SetDamageCustom(Uy) end

--- CTakeDamageInfo:SetDamageForce
-- @usage shared
-- Sets the directional force of the damage.
--
-- @param  force Vector  The vector to set the force to.
function SetDamageForce( force) end

--- CTakeDamageInfo:SetDamagePosition
-- @usage shared
-- Sets the position of where the damage gets applied to.
--
-- @param  pos Vector  The position where the damage will be applied.
function SetDamagePosition( pos) end

--- CTakeDamageInfo:SetDamageType
-- @usage shared
-- Sets the damage type.
--
-- @param  type number  The damage type, see DMG_ Enums.
function SetDamageType( type) end

--- CTakeDamageInfo:SetInflictor
-- @usage shared
-- Sets the inflictor of the damage for example a weapon.
--
-- @param  inflictor Entity  The new inflictor.
function SetInflictor( inflictor) end

--- CTakeDamageInfo:SetMaxDamage
-- @usage shared
-- Sets the maximum damage the object can cause.
--
-- @param  maxDamage number  Maximum damage value.
function SetMaxDamage( maxDamage) end

--- CTakeDamageInfo:SetReportedPosition
-- @usage shared
-- Sets the origin of the damage.
--
-- @param  pos Vector  The location of where the damage is originating
function SetReportedPosition( pos) end

--- CTakeDamageInfo:SubtractDamage
-- @usage shared
-- Subtracts the specified amount from the damage.
--
-- @param  damage number  Value to subtract.
function SubtractDamage( damage) end

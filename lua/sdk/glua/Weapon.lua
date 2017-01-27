---
-- @description Library Weapon
 module("Weapon")

--- Weapon:AllowsAutoSwitchFrom
-- @usage shared
-- Returns whether the weapon allows to being switched from when a better ( Weapon:GetWeight ) weapon is being picked up.
--
-- @return boolean Whether the weapon allows to being switched from.
function AllowsAutoSwitchFrom() end

--- Weapon:AllowsAutoSwitchTo
-- @usage shared
-- Returns whether the weapon allows to being switched to when a better ( Weapon:GetWeight ) weapon is being picked up.
--
-- @return boolean Whether the weapon allows to being switched to.
function AllowsAutoSwitchTo() end

--- Weapon:CallOnClient
-- @usage shared
-- Calls a SWEP function on client.
--
-- @param  func string  Name of function to call. If you want to call SWEP:MyFunc() on client, you type in "MyFunc"
-- @param  arguments="" string  Arguments for the function, separated by spaces.  Note: Only the second argument is passed as argument and must be a string
function CallOnClient( func,  arguments) end

--- Weapon:Clip1
-- @usage shared
-- Returns how much primary ammo is in the magazine.
--
-- @return number The amount of primary ammo in the magazine.
function Clip1() end

--- Weapon:Clip2
-- @usage shared
-- Returns how much secondary ammo is in magazine.
--
-- @return number The amount of secondary ammo in the magazine.
function Clip2() end

--- Weapon:DefaultReload
-- @usage shared
-- Forces the weapon to reload while playing given animation.
--
-- @param  act number  Sequence to use as reload animation. Uses the ACT_ Enums.
-- @return boolean Did reloading actually take place
function DefaultReload( act) end

--- Weapon:GetActivity
-- @usage shared
-- Returns the sequence enumeration number that the weapon is playing.
--
-- @return number Current activity, see ACT_ Enums. Returns 0 if the weapon doesn't have active sequence.
function GetActivity() end

--- Weapon:GetHoldType
-- @usage shared
-- Returns the hold type of the weapon.
--
-- @return string The hold type of the weapon. You can find a list of default hold types here.
function GetHoldType() end

--- Weapon:GetMaxClip1
-- @usage shared
-- Returns maximum primary clip size
--
-- @return number Maximum primary clip size
function GetMaxClip1() end

--- Weapon:GetMaxClip2
-- @usage shared
-- Returns maximum secondary clip size
--
-- @return number Maximum secondary clip size
function GetMaxClip2() end

--- Weapon:GetNextPrimaryFire
-- @usage shared
-- Gets the next time the weapon can primary fire. ( Can call WEAPON:PrimaryAttack )
--
-- @return number The time, relative to CurTime
function GetNextPrimaryFire() end

--- Weapon:GetNextSecondaryFire
-- @usage shared
-- Gets the next time the weapon can secondary fire. ( Can call WEAPON:SecondaryAttack )
--
-- @return number The time, relative to CurTime
function GetNextSecondaryFire() end

--- Weapon:GetPrimaryAmmoType
-- @usage shared
-- Gets the primary ammo type of the given weapon.
--
-- @return number The ammo type ID.
function GetPrimaryAmmoType() end

--- Weapon:GetPrintName
-- @usage shared
-- Returns the non-internal name of the weapon, that should be for displaying.
--
-- @return string The "nice" name of the weapon.
function GetPrintName() end

--- Weapon:GetSecondaryAmmoType
-- @usage shared
-- Gets the ammo type of the given weapons secondary fire.
--
-- @return number The secondary ammo type ID.
function GetSecondaryAmmoType() end

--- Weapon:GetSlot
-- @usage shared
-- Returns the slot of the weapon (slot numbers start from 0)
--
-- @return number The slot of the weapon
function GetSlot() end

--- Weapon:GetSlotPos
-- @usage shared
-- Returns slot position of the weapon
--
-- @return number The slot position of the weapon
function GetSlotPos() end

--- Weapon:GetWeaponViewModel
-- @usage shared
-- Returns the view model of the weapon.
--
-- @return string The view model of the weapon.
function GetWeaponViewModel() end

--- Weapon:GetWeaponWorldModel
-- @usage shared
-- Returns the world model of the weapon.
--
-- @return string The world model of the weapon.
function GetWeaponWorldModel() end

--- Weapon:GetWeight
-- @usage shared
-- Returns the "weight" of the weapon, which is used when deciding which Weapon is better by the engine.
--
-- @return number The weapon "weight".
function GetWeight() end

--- Weapon:HasAmmo
-- @usage shared
-- Returns whether the weapon has ammo left or not. It will return false when there's no ammo left in the magazine and when there's no reserve ammo left.
--
-- @return boolean Whether the weapon has ammo or not.
function HasAmmo() end

--- Weapon:IsCarriedByLocalPlayer
-- @usage client
-- Returns whenever the weapon is carried by the local player.
--
-- @return boolean Is the weapon is carried by the local player or not
function IsCarriedByLocalPlayer() end

--- Weapon:IsScripted
-- @usage shared
-- Checks if the weapon is a SWEP or a built-in weapon.
--
-- @return boolean Returns true if weapon is scripted ( SWEP ), false if not ( A built-in HL2 weapon )
function IsScripted() end

--- Weapon:IsWeaponVisible
-- @usage shared
-- Returns whether the weapon is visible. The term visibility is not exactly what gets checked here, first it checks if the owner is a player, then checks if the active view model has EF_NODRAW flag NOT set.
--
-- @return boolean Is visible or not
function IsWeaponVisible() end

--- Weapon:LastShootTime
-- @usage shared
-- Returns the time since this weapon last fired a bullet with Entity:FireBullets in seconds.
--
-- @return number The time in seconds when the last bullet was fired.
function LastShootTime() end

--- Weapon:SendWeaponAnim
-- @usage shared
-- Forces weapon to play activity/animation.
--
-- @param  act number  Activity to play. See the ACT_ Enums (specifically ACT_VM_).
function SendWeaponAnim( act) end

--- Weapon:SetClip1
-- @usage shared
-- Lets you change the number of bullets in the given weapons primary clip.
--
-- @param  ammo number  The amount of bullets the clip should contain
function SetClip1( ammo) end

--- Weapon:SetClip2
-- @usage shared
-- Lets you change the number of bullets in the given weapons secondary clip.
--
-- @param  ammo number  The amount of bullets the clip should contain
function SetClip2( ammo) end

--- Weapon:SetHoldType
-- @usage shared
-- Sets the hold type of the weapon. This function also calls WEAPON:SetWeaponHoldType and properly networks it to all clients.
--
-- @param  name string  Name of the hold type. You can find all default hold types here
function SetHoldType( name) end

--- Weapon:SetNextPrimaryFire
-- @usage shared
-- Sets when the weapon can fire again. Time should be based on CurTime.
--
-- @param  time number  Time when player should be able to use primary fire again
function SetNextPrimaryFire( time) end

--- Weapon:SetNextSecondaryFire
-- @usage shared
-- Sets when the weapon can alt-fire again. Time should be based on CurTime.
--
-- @param  time number  Time when player should be able to use secondary fire again
function SetNextSecondaryFire( time) end

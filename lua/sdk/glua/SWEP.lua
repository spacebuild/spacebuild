---
-- @description Library SWEP
 module("SWEP")

--- SWEP:AcceptInput
-- @usage server
-- Called when another entity fires an event to this entity.
--
-- @param  inputName string  The name of the input that was triggered.
-- @param  activator Entity  The initial cause for the input getting triggered.
-- @param  called Entity  The entity that directly trigger the input.
-- @param  data string  The data passed.
-- @return boolean Should we suppress the default action for this input?
function AcceptInput( inputName,  activator,  called,  data) end

--- SWEP:AdjustMouseSensitivity
-- @usage client
-- Allows you to adjust the mouse sensitivity. This hook only works if you haven't overridden GM:AdjustMouseSensitivity.
--
-- @return number Sensitivity scale
function AdjustMouseSensitivity() end

--- SWEP:Ammo1
-- @usage shared
-- Returns how much of primary ammo the player has.
--
-- @return number The amount of primary ammo player has
function Ammo1() end

--- SWEP:Ammo2
-- @usage shared
-- Returns how much of secondary ammo the player has.
--
-- @return number The amount of secondary ammo player has
function Ammo2() end

--- SWEP:CalcView
-- @usage client
-- Allows you to adjust player view while this weapon in use.
--
-- @param  ply Player  The owner of weapon
-- @param  pos Vector  Current position of players view
-- @param  ang Angle  Current angles of players view
-- @param  fov number  Current FOV of players view
-- @return Vector New position of players view
-- @return Angle New angle of players view
-- @return number New FOV of players view
function CalcView( ply,  pos,  ang,  fov) end

--- SWEP:CalcViewModelView
-- @usage client
-- Allows overriding the position and angle of the viewmodel. This hook only works if you haven't overridden GM:CalcViewModelView.
--
-- @param  vm Entity  The viewmodel entity
-- @param  oldPos Vector  Original position (before viewmodel bobbing and swaying)
-- @param  oldAng Angle  Original angle (before viewmodel bobbing and swaying)
-- @param  pos Vector  Current position
-- @param  ang Angle  Current angle
-- @return Vector New position
-- @return Angle New angle
function CalcViewModelView( vm,  oldPos,  oldAng,  pos,  ang) end

--- SWEP:CanPrimaryAttack
-- @usage shared
-- Helper function for checking for no ammo.
--
-- @return boolean Can use primary attack
function CanPrimaryAttack() end

--- SWEP:CanSecondaryAttack
-- @usage shared
-- Helper function for checking for no ammo.
--
-- @return boolean Can use secondary attack
function CanSecondaryAttack() end

--- SWEP:ContextScreenClick
-- @usage shared
-- Called when the Context Menu ( Default key C ) is open and the player has clicked the screen.
--
-- @param  aimvec Vector  Players aim direction. Notice that this is not the aim position.
-- @param  mouseCode number  The mouse button that the player clicked. See the MOUSE_ Enums.
-- @param  pressed boolean  Was the button pressed or released
-- @param  ply Player  Player who clicked
function ContextScreenClick( aimvec,  mouseCode,  pressed,  ply) end

--- SWEP:CustomAmmoDisplay
-- @usage client
-- Allows you to use any numbers you want for the ammo display on the HUD.
--
-- @return table The new ammo display settings.
function CustomAmmoDisplay() end

--- SWEP:Deploy
-- @usage shared
-- Called when player has just switched to this weapon.
--
-- @return boolean Return true to allow switching away from this weapon using lastinv command
function Deploy() end

--- SWEP:DoDrawCrosshair
-- @usage client
-- Called when the crosshair is about to get drawn, and allows you to override it.
--
-- @param  x number  X coordinate of the crosshair.
-- @param  y number  Y coordinate of the crosshair.
-- @return boolean Return true to override the default crosshair.
function DoDrawCrosshair( x,  y) end

--- SWEP:DoImpactEffect
-- @usage shared
-- Called so the weapon can override the impact effects it makes.
--
-- @param  tr table  A TraceResult structure from player's eyes to the impact point
-- @param  damageType number  The damage type of bullet
-- @return boolean Return true to not do the default thing - which is to call UTIL_ImpactTrace in C++
function DoImpactEffect( tr,  damageType) end

--- SWEP:DrawHUD
-- @usage client
-- This hook allows you to draw on screen while this weapon is in use.
--
function DrawHUD() end

--- SWEP:DrawHUDBackground
-- @usage client
-- This hook allows you to draw on screen while this weapon is in use. This hook is called before WEAPON:DrawHUD and is equivalent of GM:HUDPaintBackground.
--
function DrawHUDBackground() end

--- SWEP:DrawWeaponSelection
-- @usage client
-- This hook draws the selection icon in the weapon selection menu.
--
-- @param  x number  X coordinate of the selection panel
-- @param  y number  Y coordinate of the selection panel
-- @param  width number  Width of the selection panel
-- @param  height number  Height of the selection panel
-- @param  alpha number  Alpha value of the selection panel
function DrawWeaponSelection( x,  y,  width,  height,  alpha) end

--- SWEP:DrawWorldModel
-- @usage client
-- Called when we are about to draw the world model.
--
function DrawWorldModel() end

--- SWEP:DrawWorldModelTranslucent
-- @usage client
-- Called when we are about to draw the translucent world model.
--
function DrawWorldModelTranslucent() end

--- SWEP:Equip
-- @usage server
-- Called when a player or NPC has picked the weapon up.
--
-- @param  NewOwner Entity  The one who picked the weapon up. Can be Player or NPC.
function Equip( NewOwner) end

--- SWEP:EquipAmmo
-- @usage server
-- The player has picked up the weapon and has taken the ammo from it.
--The weapon will be removed immidiately after this call.
--
-- @param  ply Player  The player who picked up the weapon
function EquipAmmo( ply) end

--- SWEP:FireAnimationEvent
-- @usage client
-- Called before firing animation events, such as muzzle flashes or shell ejections.
--
-- @param  pos Vector  Position of the effect
-- @param  ang Angle  Angle of the effect
-- @param  event number  The event ID of happened even. See this page.
-- @param  name string  Name of the event
-- @return boolean Return true to disable the effect
function FireAnimationEvent( pos,  ang,  event,  name) end

--- SWEP:FreezeMovement
-- @usage client
-- This hook allows you to freeze players screen.
--
-- @return boolean Return true to freeze moving the view
function FreezeMovement() end

--- SWEP:GetCapabilities
-- @usage server
-- This hook is for NPCs, you return what they should try to do with it.
--
-- @return number A number defining what NPC should do with the weapon. Use the CAP_ Enums.
function GetCapabilities() end

--- SWEP:GetTracerOrigin
-- @usage client
-- Allows you to override where the tracer effect comes from. ( Visual bullets )
--
-- @return Vector The new position to start tracer effect from
function GetTracerOrigin() end

--- SWEP:GetViewModelPosition
-- @usage client
-- This hook allows you to adjust view model position and angles.
--
-- @param  pos Vector  Current position
-- @param  ang Angle  Current angle
-- @return Vector New position
-- @return Angle New angle
function GetViewModelPosition( pos,  ang) end

--- SWEP:Holster
-- @usage shared
-- Called when weapon tries to holster.
--
-- @param  weapon Entity  The weapon we are trying switch to.
-- @return boolean Return true to allow weapon to holster
function Holster( weapon) end

--- SWEP:HUDShouldDraw
-- @usage client
-- This hook determines which parts of the HUD to draw.
--
-- @param  element string  The HUD element in question
-- @return boolean Return false to hide this HUD element
function HUDShouldDraw( element) end

--- SWEP:Initialize
-- @usage shared
-- Called when the weapon entity is created.
--
function Initialize() end

--- SWEP:KeyValue
-- @usage server
-- Called when the engine sets a value for this swep.
--
-- @param  key string  The key that was affected.
-- @param  value string  The new value.
-- @return boolean Return true to suppress this KeyValue or return false or nothing to apply this key value.
function KeyValue( key,  value) end

--- SWEP:OnDrop
-- @usage server
-- Called when weapon is dropped by Player:DropWeapon.
--
function OnDrop() end

--- SWEP:OnReloaded
-- @usage shared
-- Called whenever the weapons Lua script is reloaded.
--
function OnReloaded() end

--- SWEP:OnRemove
-- @usage shared
-- Called when the swep is about to be removed.
--
function OnRemove() end

--- SWEP:OnRestore
-- @usage shared
-- Called when the swep was reloaded from a save game.
--
function OnRestore() end

--- SWEP:OwnerChanged
-- @usage shared
-- Called when weapon is dropped or picked up by a new player.
--
function OwnerChanged() end

--- SWEP:PostDrawViewModel
-- @usage client
-- Allows you to modify viewmodel while the weapon in use after the view model has been drawn. This hook only works if you haven't overridden GM:PostDrawViewModel.
--
-- @param  vm Entity  This is the view model entity after it is drawn
-- @param  weapon Weapon  This is the weapon that is from the view model
-- @param  ply Player  The the owner of the view model
function PostDrawViewModel( vm,  weapon,  ply) end

--- SWEP:PreDrawViewModel
-- @usage client
-- Allows you to modify viewmodel while the weapon in use before it is drawn. This hook only works if you haven't overridden GM:PreDrawViewModel.
--
-- @param  vm Entity  This is the view model entity before it is drawn.
-- @param  weapon Weapon  This is the weapon that is from the view model.
-- @param  ply Player  The the owner of the view model.
function PreDrawViewModel( vm,  weapon,  ply) end

--- SWEP:PrimaryAttack
-- @usage shared
-- Called when primary attack button ( +attack ) is pressed.
--
function PrimaryAttack() end

--- SWEP:PrintWeaponInfo
-- @usage client
-- A convenience function that draws the weapon info box, used in WEAPON:DrawWeaponSelection.
--
-- @param  x number  The x co-ordinate of box position
-- @param  y number  The y co-ordinate of box position
-- @param  alpha number  Alpha value for the box
function PrintWeaponInfo( x,  y,  alpha) end

--- SWEP:Reload
-- @usage shared
-- Called when the reload key ( +reload ) is pressed.
--
function Reload() end

--- SWEP:RenderScreen
-- @usage client
-- Called every frame to render screens.
--
function RenderScreen() end

--- SWEP:SecondaryAttack
-- @usage shared
-- Called when secondary attack button ( +attack2 ) is pressed.
--
function SecondaryAttack() end

--- SWEP:SetDeploySpeed
-- @usage shared
-- Sets the weapon deploy speed. This value needs to match on client and server.
--
-- @param  speed number  The value to set deploy speed to. Negative will slow down playback.
function SetDeploySpeed( speed) end

--- SWEP:SetupDataTables
-- @usage shared
-- Called when the SWEP should set up its  Data Tables.
--
function SetupDataTables() end

--- SWEP:SetWeaponHoldType
-- @usage shared
-- Sets the hold type of the weapon. This must be called on both the server and the client to work properly.
--
-- @param  name string  Name of the hold type. You can find all default hold types here
function SetWeaponHoldType( name) end

--- SWEP:ShootBullet
-- @usage shared
-- A convenience function to shoot bullets.
--
-- @param  damage number  The damage of the bullet
-- @param  num_bullets number  Amount of bullets to shoot
-- @param  aimcone number  Spread of bullets
function ShootBullet( damage,  num_bullets,  aimcone) end

--- SWEP:ShootEffects
-- @usage shared
-- A convenience function to create shoot effects.
--
function ShootEffects() end

--- SWEP:ShouldDropOnDie
-- @usage server
-- Should this weapon be dropped when its owner dies?
--
-- @return boolean Return true to drop the weapon, false otherwise. Default ( if you don't return anything ) is false.
function ShouldDropOnDie() end

--- SWEP:TakePrimaryAmmo
-- @usage shared
-- A convenience function to remove primary ammo from clip.
--
-- @param  amount number  Amount of primary ammo to remove
function TakePrimaryAmmo( amount) end

--- SWEP:TakeSecondaryAmmo
-- @usage shared
-- A convenience function to remove secondary ammo from clip.
--
-- @param  amount number  How much of secondary ammo to remove
function TakeSecondaryAmmo( amount) end

--- SWEP:Think
-- @usage shared
-- Called when the swep thinks.
--
-- @return boolean Return true if you used Entity:NextThink to make it work.
function Think() end

--- SWEP:TranslateActivity
-- @usage shared
-- Translate a player's Activity into a weapon's activity, depending on how you want the player to be holding the weapon.
--
-- @param  act number  The activity to translate
-- @return number The translated activity
function TranslateActivity( act) end

--- SWEP:TranslateFOV
-- @usage client
-- Allows to change players Field Of View while player holds the weapon.
--
-- @param  fov number  The current/default FOV.
-- @return number The target FOV.
function TranslateFOV( fov) end

--- SWEP:ViewModelDrawn
-- @usage client
-- Called straight after the view model has been drawn.
--
-- @param  ViewModel Entity  Players view model
function ViewModelDrawn( ViewModel) end

--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

---
-- @description Library GM
 module("GM")

--- GM:AcceptInput
-- @usage server
-- Called when a map I/O event occurs.
--
-- @param  ent Entity  Entity that receives the input
-- @param  input string  The input name
-- @param  activator Entity  Activator of the input
-- @param  caller Entity  Caller of the input
-- @param  value any  Data provided with the input
-- @return boolean Return true to prevent this input from being processed.
function AcceptInput( ent,  input,  activator,  caller,  value) end

--- GM:AddDeathNotice
-- @usage client
-- Adds a death notice entry.
--
-- @param  attacker string  The name of the attacker
-- @param  attackerTeam number  The team of the attacker
-- @param  inflictor string  Class name of the entity inflicting the damage
-- @param  victim string  Name of the victim
-- @param  victimTeam number  Team of the victim
function AddDeathNotice( attacker,  attackerTeam,  inflictor,  victim,  victimTeam) end

--- GM:AdjustMouseSensitivity
-- @usage client
-- Allows you to adjust the mouse sensitivity.
--
-- @param  defaultSensitivity number  The old sensitivity  In general it will be 0, which is equivalent to a sensitivity of 1.
-- @return number A fraction of the normal sensitivity (0.5 would be half as sensitive), return -1 to not override.
function AdjustMouseSensitivity( defaultSensitivity) end

--- GM:AllowPlayerPickup
-- @usage server
-- Called when a player tries to pick up something using the "use" key, return to override.
--
-- @param  ply Player  The player trying to pick up something.
-- @param  ent Entity  The Entity the player attempted to pick up.
-- @return boolean Allow the player to pick up the entity or not.
function AllowPlayerPickup( ply,  ent) end

--- GM:CalcMainActivity
-- @usage shared
-- This hook is used to calculate animations for a player.
--
-- @param  ply Player  The player to apply the animation.
-- @param  vel Vector  The velocity of the player.
function CalcMainActivity( ply,  vel) end

--- GM:CalcVehicleView
-- @usage client
-- Called from GM:CalcView when player is in driving a vehicle.
--
-- @param  veh Vehicle  The vehicle the player is driving
-- @param  ply Player  The vehicle driver
-- @param  view table  The view data containing players FOV, view position and angles, see CamData structure
-- @return table The modified view table containing new values, see CamData structure
function CalcVehicleView( veh,  ply,  view) end

--- GM:CalcView
-- @usage client
-- Allows override of the default view.
--
-- @param  ply Player  The local player.
-- @param  origin Vector  The player's view position.
-- @param  angles Angle  The player's view angles.
-- @param  fov number  Field of view.
-- @param  znear number  Distance to near clipping plane.
-- @param  zfar number  Distance to far clipping plane.
-- @return table View data table. See CamData structure
function CalcView( ply,  origin,  angles,  fov,  znear,  zfar) end

--- GM:CalcViewModelView
-- @usage client
-- Allows overriding the position and angle of the viewmodel.
--
-- @param  wep Weapon  The weapon entity
-- @param  vm Entity  The viewmodel entity
-- @param  oldPos Vector  Original position (before viewmodel bobbing and swaying)
-- @param  oldAng Angle  Original angle (before viewmodel bobbing and swaying)
-- @param  pos Vector  Current position
-- @param  ang Angle  Current angle
-- @return Vector New position
-- @return Angle New angle
function CalcViewModelView( wep,  vm,  oldPos,  oldAng,  pos,  ang) end

--- GM:CanEditVariable
-- @usage server
-- Called when a variable is edited on an Entity (called by Edit Properties... menu), to determine if the edit should be permitted.
--
-- @param  ent Entity  The entity being edited
-- @param  ply Player  The player doing the editing
-- @param  key string  The name of the variable
-- @param  val string  The new value, as a string which will later be converted to its appropriate type
-- @param  editor table  The edit table defined in Entity:NetworkVar
-- @return boolean Return true to allow editing
function CanEditVariable( ent,  ply,  key,  val,  editor) end

--- GM:CanExitVehicle
-- @usage server
-- Determines if the player can exit the vehicle.
--
-- @param  veh Vehicle  The vehicle entity
-- @param  ply Player  The player
-- @return boolean True if the player can exit the vehicle.
function CanExitVehicle( veh,  ply) end

--- GM:CanPlayerEnterVehicle
-- @usage shared
-- Determines whether or not the player can enter the vehicle.
--
-- @param  player Player  The player
-- @param  vehicle Vehicle  The vehicle
-- @param  sRole string  Not sure what the point of this is
-- @return boolean Whether the player is allowed to enter the vehicle ( true ) or not ( false )
function CanPlayerEnterVehicle( player,  vehicle,  sRole) end

--- GM:CanPlayerSuicide
-- @usage server
-- Determines if the player can kill themselves using the concommands "kill" or "explode".
--
-- @param  player Player  The player
-- @return boolean True if they can suicide.
function CanPlayerSuicide( player) end

--- GM:CanPlayerUnfreeze
-- @usage server
-- Determines if the player can unfreeze the entity.
--
-- @param  player Player  The player
-- @param  entity Entity  The entity
-- @param  phys PhysObj  The physics object of the entity
-- @return boolean True if they can unfreeze.
function CanPlayerUnfreeze( player,  entity,  phys) end

--- GM:CaptureVideo
-- @usage menu
-- Called each frame to record demos to video using IVideoWriter.
--
function CaptureVideo() end

--- GM:ChatText
-- @usage client
-- Called when a message is printed to the chat box. Note, that this isn't working with player messages even though there are arguments for it.
--
-- @param  index number  The index of the player.
-- @param  name string  The name of the player.
-- @param  text string  The text that is being sent.
-- @param  type string  Chat filter type.
-- @return boolean Return true to suppress the chat message
function ChatText( index,  name,  text,  type) end

--- GM:ChatTextChanged
-- @usage client
-- Called whenever the content of the user's chat input box is changed.
--
-- @param  text string  The new contents of the input box
function ChatTextChanged( text) end

--- GM:CheckPassword
-- @usage server
-- Called when a non local player connects to allow the Lua system to check the password.
--
-- @param  steamID64 string  The 64bit Steam ID of the joining player, use util.SteamIDFrom64 to convert it to a "STEAM_0:" one.
-- @param  ipAddress string  The IP of the connecting client
-- @param  svPassword string  The current value of sv_password (the password set by the server)
-- @param  clPassword string  The password provided by the client
-- @param  name string  The name of the joining player
-- @return boolean If the hook returns false then the player is disconnected
-- @return string If returning false in the first argument, then this should be the disconnect message. This will default to "#GameUI_ServerRejectBadPassword", which is "Bad Password." translated to the client's language.
function CheckPassword( steamID64,  ipAddress,  svPassword,  clPassword,  name) end

--- GM:CloseDermaMenus
-- @usage client_m
-- Called when derma menus are closed with CloseDermaMenus.
--
function CloseDermaMenus() end

--- GM:ContextMenuOpen
-- @usage client
-- Called when the context menu is trying to be opened. Return false to disallow it.
--
-- @return boolean Allow menu to open
function ContextMenuOpen() end

--- GM:CreateClientsideRagdoll
-- @usage client
-- Called whenever an entity becomes a clientside ragdoll.
--
-- @param  entity Entity  The Entity that created the ragdoll
-- @param  ragdoll Entity  The ragdoll being created.
function CreateClientsideRagdoll( entity,  ragdoll) end

--- GM:CreateEntityRagdoll
-- @usage server
-- Called when a ragdoll of an entity has been created.
--
-- @param  owner Entity  Entity that owns the ragdoll
-- @param  ragdoll Entity  The ragdoll entity
function CreateEntityRagdoll( owner,  ragdoll) end

--- GM:CreateMove
-- @usage client
-- Allows you to change the players movements before they're sent to the server.
--
-- @param  cmd CUserCmd  Command data
-- @return boolean 
function CreateMove( cmd) end

--- GM:CreateTeams
-- @usage shared
-- Teams are created within this hook using team.SetUp.
--
function CreateTeams() end

--- GM:DoAnimationEvent
-- @usage shared
-- Called upon an animation event, this is the ideal place to call player animation functions such as Player:AddVCDSequenceToGestureSlot, Player:AnimRestartGesture and so on.
--
-- @param  ply Player  Player who is being animated
-- @param  event number  Animation event. See PLAYERANIMEVENT_ Enums
-- @param  data=0 number  The data for the event.
-- @return number The translated activity to use. See ACT_ Enums, return ACT_INVALID if you don't want to send an activity.
function DoAnimationEvent( ply,  event,  data) end

--- GM:DoPlayerDeath
-- @usage server
-- Handles the player's death.
--
-- @param  ply Player  The player
-- @param  attacker Entity  The entity that killed the player
-- @param  dmg CTakeDamageInfo  Damage info
function DoPlayerDeath( ply,  attacker,  dmg) end

--- GM:DrawDeathNotice
-- @usage client
-- This hook is called every frame to draw all of the current death notices.
--
-- @param  x number  X position to draw death notices as a ratio
-- @param  y number  Y position to draw death notices as a ratio
function DrawDeathNotice( x,  y) end

--- GM:DrawMonitors
-- @usage client
-- Called every frame before drawing the in-game monitors ( Breencast, in-game TVs, etc ), but doesn't seem to be doing anything, trying to render 2D or 3D elements fail.
--
function DrawMonitors() end

--- GM:DrawOverlay
-- @usage client_m
-- Called after all other 2D draw hooks are called. Draws over all VGUI Panels and HUDs.
--
function DrawOverlay() end

--- GM:DrawPhysgunBeam
-- @usage client
-- Allows you to override physgun beam drawing.
--
-- @param  ply Player  Physgun owner
-- @param  physgun Weapon  The physgun
-- @param  enabled boolean  Is the beam enabled
-- @param  target Entity  Entity we are aiming at
-- @param  bone number  ID of the bone we are aiming at
-- @param  hitPos Vector  Beam hit position relative to the entity
-- @return boolean Return false to hide default beam
function DrawPhysgunBeam( ply,  physgun,  enabled,  target,  bone,  hitPos) end

--- GM:EndEntityDriving
-- @usage shared
-- Called right before an entity stops driving. Overriding this hook will cause it to not call drive.End and the player will not stop driving.
--
-- @param  ent Entity  The entity being driven
-- @param  ply Player  The player driving the entity
function EndEntityDriving( ent,  ply) end

--- GM:EntityEmitSound
-- @usage shared
-- Called whenever a sound has been played.
--
-- @param  data table  Information about the played sound. Changes done to this table can be applied by returning true from this hook.See EmitSoundInfo structure.
-- @return boolean Return true to apply all changes done to the data table.Return false to prevent the sound from playing.Return nil or nothing to play the sound without altering it.
function EntityEmitSound( data) end

--- GM:EntityFireBullets
-- @usage shared
-- Called every time a bullet is fired from an entity.
--
-- @param  ent Entity  The entity that fired the bullet
-- @param  data table  The bullet data. See Bullet structure
-- @return boolean Return true to apply all changes done to the bullet table.Return false to suppress the bullet.
function EntityFireBullets( ent,  data) end

--- GM:EntityKeyValue
-- @usage shared
-- Called when a keyvalue is set on an entity. Return a string to override the value.
--
-- @param  ent Entity  Entity that the keyvalue is being set on
-- @param  key string  Key of the key/value pair
-- @param  value string  Value of the key/value pair
-- @return string If set, the value of the key-value pair will be overridden by this string.
function EntityKeyValue( ent,  key,  value) end

--- GM:EntityNetworkedVarChanged
-- @usage shared
-- Called when an NWVar is changed.
--
-- @param  ent Entity  The owner entity of changed NWVar
-- @param  name string  The name if changed NWVar
-- @param  oldval any  The old value of the NWVar
-- @param  newval any  The new value of the NWVar
function EntityNetworkedVarChanged( ent,  name,  oldval,  newval) end

--- GM:EntityRemoved
-- @usage shared
-- Called right before the removal of an entity.
--
-- @param  ent Entity  Entity being removed
function EntityRemoved( ent) end

--- GM:EntityTakeDamage
-- @usage server
-- Called when an entity takes damage. You can modify all parts of the damage info in this hook.
--
-- @param  target Entity  The entity taking damage
-- @param  dmg CTakeDamageInfo  Damage info
-- @return boolean Return true to completely block the damage event
function EntityTakeDamage( target,  dmg) end

--- GM:FindUseEntity
-- @usage shared
-- This hook polls the entity the player use action should be applied to.
--
-- @param  ply Player  The player who initiated the use action.
-- @param  defaultEnt Entity  The entity that was chosen by the engine.
-- @return Entity The entity to use instead of default entity
function FindUseEntity( ply,  defaultEnt) end

--- GM:FinishChat
-- @usage client
-- Runs when user cancels/finishes typing.
--
function FinishChat() end

--- GM:FinishMove
-- @usage shared
-- Called after GM:Move , applies all the changes from the CMoveData to the player.
--
-- @param  ply Player  Player
-- @param  mv CMoveData  Movement data
-- @return boolean If true, movement will be frozen for this player, i.e. suppress default engine behavior.
function FinishMove( ply,  mv) end

--- GM:ForceDermaSkin
-- @usage client
-- Returns the Derma skin to be used for panels by default. If nothing is returned the default skin will be used.
--
-- @return string Derma skin name
function ForceDermaSkin() end

--- GM:GameContentChanged
-- @usage menu
-- Called to refresh menu content once it has initialized or something has been mounted.
--
function GameContentChanged() end

--- GM:GetFallDamage
-- @usage server
-- Called when a player takes damage from falling, allows to override the damage.
--
-- @param  ply Player  The player
-- @param  speed number  The fall speed
-- @return number New fall damage
function GetFallDamage( ply,  speed) end

--- GM:GetGameDescription
-- @usage shared
-- Returns the text to be shown in the server browser as the game.
--
-- @return string description
function GetGameDescription() end

--- GM:GetMotionBlurValues
-- @usage client
-- Allows you to modify the Source Engine's motion blur shaders.
--
-- @param  horizontal number  The amount of horizontal blur.
-- @param  vertical number  The amount of vertical blur.
-- @param  forward number  The amount of forward/radial blur.
-- @param  rotational number  The amount of rotational blur.
-- @return number New amount of horizontal blur.
-- @return number New amount of vertical blur.
-- @return number New amount of forward/radial blur.
-- @return number New amount of rotational blur.
function GetMotionBlurValues( horizontal,  vertical,  forward,  rotational) end

--- GM:GetPreferredCarryAngles
-- @usage server
-- Called to determine preferred carry angles for the entity. It works for both, +use pickup and gravity gun pickup.
--
-- @param  ent Entity  The entity to generate carry angles for
-- @return Angle The preferred carry angles for the entity.
function GetPreferredCarryAngles( ent) end

--- GM:GetTeamColor
-- @usage client
-- Returns the color for the given entity's team. This is used in chat and deathnotice text.
--
-- @param  ent Entity  Entity
-- @return table Team Color
function GetTeamColor( ent) end

--- GM:GetTeamNumColor
-- @usage client
-- Returns the team color for the given team index.
--
-- @param  team number  Team index
-- @return table Team Color
function GetTeamNumColor( team) end

--- GM:GetVehicles
-- @usage client
-- Returns a table of vehicles.
--
-- @return table Vehicle table
function GetVehicles() end

--- GM:GrabEarAnimation
-- @usage shared
-- Override this hook to disable/change ear-grabbing in your gamemode.
--
-- @param  ply Player  Player
function GrabEarAnimation( ply) end

--- GM:GravGunOnDropped
-- @usage server
-- Called when an entity is released by a gravity gun.
--
-- @param  ply Player  Player who is wielding the gravity gun
-- @param  ent Entity  The entity that has been dropped
function GravGunOnDropped( ply,  ent) end

--- GM:GravGunOnPickedUp
-- @usage server
-- Called when an entity is picked up by a gravity gun.
--
-- @param  ply Player  The player wielding the gravity gun
-- @param  ent Entity  The entity that has been picked up by the gravity gun
function GravGunOnPickedUp( ply,  ent) end

--- GM:GravGunPickupAllowed
-- @usage shared
-- Returns whether or not a player is allowed to pick up an entity with the gravity gun. Return true to allow.
--
-- @param  ply Player  The player wielding the gravity gun
-- @param  ent Entity  The entity the player is attempting to pick up
-- @return boolean Allowed to pick up
function GravGunPickupAllowed( ply,  ent) end

--- GM:GravGunPunt
-- @usage shared
-- Called when an entity is about to be punted with the gravity gun (primary fire). Return true to allow and false to disallow.
--
-- @param  ply Player  The player wielding the gravity gun
-- @param  ent Entity  The entity the player is attempting to punt
-- @return boolean Allowed to punt
function GravGunPunt( ply,  ent) end

--- GM:GUIMouseDoublePressed
-- @usage client
-- Called when the mouse has been double clicked on any panel derived from CGModBase, such as the panel used by gui.EnableScreenClicker and the panel used by Panel:ParentToHUD.
--
-- @param  mouseCode number  The code of the mouse button pressed, see MOUSE_ Enums
-- @param  aimVector Vector  A normalized vector pointing in the direction the client has clicked
function GUIMouseDoublePressed( mouseCode,  aimVector) end

--- GM:GUIMousePressed
-- @usage client
-- Called whenever a players presses a mouse key on the context menu in Sandbox or on any panel derived from CGModBase, such as the panel used by gui.EnableScreenClicker and the panel used by Panel:ParentToHUD.
--
-- @param  mouseCode number  The key that the player pressed using MOUSE_ Enums.
-- @param  aimVector Vector  A normalized direction vector local to the camera. Internally, this is gui.ScreenToVector( gui.MousePos() ).
function GUIMousePressed( mouseCode,  aimVector) end

--- GM:GUIMouseReleased
-- @usage client
-- Called whenever a players releases a mouse key on the context menu in Sandbox or on any panel derived from CGModBase, such as the panel used by gui.EnableScreenClicker and the panel used by Panel:ParentToHUD.
--
-- @param  mouseCode number  The key the player released, see MOUSE_ Enums
-- @param  aimVector Vector  A normalized direction vector local to the camera. Internally this is gui.ScreenToVector( gui.MousePos() ).
function GUIMouseReleased( mouseCode,  aimVector) end

--- GM:HandlePlayerDriving
-- @usage shared
-- Allows to override player driving animations.
--
-- @param  ply Player  Player to process
-- @return boolean Return true if we've changed/set the animation, false otherwise
function HandlePlayerDriving( ply) end

--- GM:HandlePlayerDucking
-- @usage shared
-- Allows to override player crouch animations.
--
-- @param  ply Player  The player
-- @param  velocity number  Players velocity
-- @return boolean Return true if we've changed/set the animation, false otherwise
function HandlePlayerDucking( ply,  velocity) end

--- GM:HandlePlayerJumping
-- @usage shared
-- Allows to override player jumping animations.
--
-- @param  ply Player  The player
-- @param  velocity number  Players velocity
-- @return boolean Return true if we've changed/set the animation, false otherwise
function HandlePlayerJumping( ply,  velocity) end

--- GM:HandlePlayerLanding
-- @usage shared
-- Allows to override player landing animations.
--
-- @param  ply Player  The player
-- @param  velocity number  Players velocity
-- @param  onGround boolean  Was the player on ground?
-- @return boolean Return true if we've changed/set the animation, false otherwise
function HandlePlayerLanding( ply,  velocity,  onGround) end

--- GM:HandlePlayerNoClipping
-- @usage shared
-- Allows to override player noclip animations.
--
-- @param  ply Player  The player
-- @param  velocity number  Players velocity
-- @return boolean Return true if we've changed/set the animation, false otherwise
function HandlePlayerNoClipping( ply,  velocity) end

--- GM:HandlePlayerSwimming
-- @usage shared
-- Allows to override player swimming animations.
--
-- @param  ply Player  The player
-- @param  velocity number  Players velocity
-- @return boolean Return true if we've changed/set the animation, false otherwise
function HandlePlayerSwimming( ply,  velocity) end

--- GM:HandlePlayerVaulting
-- @usage shared
-- Allows to override player flying ( in mid-air, not noclipping ) animations.
--
-- @param  ply Player  The player
-- @param  velocity number  Players velocity
-- @return boolean Return true if we've changed/set the animation, false otherwise
function HandlePlayerVaulting( ply,  velocity) end

--- GM:HideTeam
-- @usage client
-- Hides the team selection panel.
--
function HideTeam() end

--- GM:HUDAmmoPickedUp
-- @usage client
-- Called when the client has picked up ammo. Override to disable default HUD notification.
--
-- @param  itemName string  Name of the item (ammo) picked up
-- @param  amount number  Amount of the item (ammo) picked up
function HUDAmmoPickedUp( itemName,  amount) end

--- GM:HUDDrawPickupHistory
-- @usage client
-- Renders the HUD pick-up history. Override to hide default or draw your own HUD.
--
function HUDDrawPickupHistory() end

--- GM:HUDDrawScoreBoard
-- @usage client
-- Called every frame to render the scoreboard.
--It is recommended to use Derma and VGUI for this job instead of this hook. Called right after GM:HUDPaint.
--
function HUDDrawScoreBoard() end

--- GM:HUDDrawTargetID
-- @usage client
-- Called from GM:HUDPaint to draw player info when you hover over a player with your crosshair or mouse.
--
function HUDDrawTargetID() end

--- GM:HUDItemPickedUp
-- @usage client
-- Called when an item has been picked up. Override to disable the default HUD notification.
--
-- @param  itemName string  Name of the picked up item
function HUDItemPickedUp( itemName) end

--- GM:HUDPaint
-- @usage client
-- Called whenever the HUD should be drawn. Called right before GM:HUDDrawScoreBoard and after GM:HUDPaintBackground.
--
function HUDPaint() end

--- GM:HUDPaintBackground
-- @usage client
-- Called after GM:HUDPaint when the HUD background is being drawn.
--Things rendered in this hook will always appear behind things rendered in GM:HUDPaint.
--
function HUDPaintBackground() end

--- GM:HUDShouldDraw
-- @usage client
-- Called when the Gamemode is about to draw a given element on the client's HUD (heads-up display).
--
-- @param  name string  The name of the HUD element. You can find a full list of HUD elements for this hook here.
-- @return boolean Return false to prevent the given element from being drawn on the client's screen.
function HUDShouldDraw( name) end

--- GM:HUDWeaponPickedUp
-- @usage client
-- Called when a weapon has been picked up. Override to disable the default HUD notification.
--
-- @param  weapon Weapon  The picked up weapon
function HUDWeaponPickedUp( weapon) end

--- GM:Initialize
-- @usage shared
-- Called after the gamemode loads and starts.
--
function Initialize() end

--- GM:InitPostEntity
-- @usage shared
-- Called after all the entities are initialized.
--
function InitPostEntity() end

--- GM:InputMouseApply
-- @usage client
-- Allows you to modify the supplied User Command with mouse input. This could be used to make moving the mouse do funky things to view angles.
--
-- @param  cmd CUserCmd  User command
-- @param  x number  The amount of mouse movement across the X axis this frame
-- @param  y number  The amount of mouse movement across the Y axis this frame
-- @param  ang Angle  The current view angle
-- @return boolean Return true if we modified something
function InputMouseApply( cmd,  x,  y,  ang) end

--- GM:IsSpawnpointSuitable
-- @usage server
-- Check if a player can spawn at a certain spawnpoint.
--
-- @param  ply Player  The player who is spawned
-- @param  spawnpoint Entity  The spawnpoint entity (on the map)
-- @param  makeSuitable boolean  If this is true, it'll kill any players blocking the spawnpoint
function IsSpawnpointSuitable( ply,  spawnpoint,  makeSuitable) end

--- GM:KeyPress
-- @usage shared
-- Called whenever a player pressed a key included within the IN keys.
--
-- @param  ply Player  The player pressing the key. If running client-side, this will always be LocalPlayer
-- @param  key number  The key that the player pressed using IN_ Enums.
function KeyPress( ply,  key) end

--- GM:KeyRelease
-- @usage shared
-- Runs when a IN key was released by a player.
--
-- @param  ply Entity  The player releasing the key
-- @param  key number  The key that the player released using IN_ Enums.
function KeyRelease( ply,  key) end

--- GM:MenuStart
-- @usage menu
-- Called when menu.lua has finished loading.
--
function MenuStart() end

--- GM:MouthMoveAnimation
-- @usage shared
-- Override this gamemode function to disable mouth movement when talking on voice chat.
--
-- @param  ply Player  Player in question
function MouthMoveAnimation( ply) end

--- GM:Move
-- @usage shared
-- The Move hook is called for you to manipulate the player's MoveData.
--
-- @param  ply Player  Player
-- @param  mv CMoveData  Movement information
-- @return boolean Return true to suppress default engine action
function Move( ply,  mv) end

--- GM:NeedsDepthPass
-- @usage client
-- Returning true in this hook will cause it to render depth buffers defined with render.GetResolvedFullFrameDepth.
--
-- @return boolean Render depth buffer
function NeedsDepthPass() end

--- GM:NetworkEntityCreated
-- @usage client
-- Called when an entity has been created over the network.
--
-- @param  ent Entity  Created entity
function NetworkEntityCreated( ent) end

--- GM:NetworkIDValidated
-- @usage server
-- Called when a player has been validated by Steam.
--
-- @param  name string  Player name
-- @param  steamID string  Player SteamID
function NetworkIDValidated( name,  steamID) end

--- GM:NotifyShouldTransmit
-- @usage client
-- Called whenever this entity changes its transmission state for this LocalPlayer, such as exiting or re entering the PVS.
--
-- @param  ent Entity  The entity that changed its transmission state.
-- @param  shouldtransmit boolean  True if we started transmitting to this client and false if we stopped.
function NotifyShouldTransmit( ent,  shouldtransmit) end

--- GM:OnAchievementAchieved
-- @usage client
-- Called when a player has achieved an achievement. You can get the name and other information from an achievement ID with the achievements library.
--
-- @param  ply Player  The player that earned the achievement
-- @param  achievement number  The index of the achievement
function OnAchievementAchieved( ply,  achievement) end

--- GM:OnChatTab
-- @usage client
-- Called when the local player presses TAB while having their chatbox opened.
--
-- @param  text string  The currently typed into chatbox text
-- @return string What should be placed into the chatbox instead of what currently is when player presses tab
function OnChatTab( text) end

--- GM:OnContextMenuClose
-- @usage client
-- Called when the context menu was closed.
--
function OnContextMenuClose() end

--- GM:OnContextMenuOpen
-- @usage client
-- Called when the context menu was opened.
--
function OnContextMenuOpen() end

--- GM:OnDamagedByExplosion
-- @usage server
-- Called when a player has been hurt by an explosion. Override to disable default sound effect.
--
-- @param  ply Player  Player who has been hurt
-- @param  dmginfo CTakeDamageInfo  Damage info from explsion
function OnDamagedByExplosion( ply,  dmginfo) end

--- GM:OnEntityCreated
-- @usage shared
-- Called right after the Entity has been made visible to Lua.
--
-- @param  entity Entity  The entity
function OnEntityCreated( entity) end

--- GM:OnGamemodeLoaded
-- @usage shared
-- Called when the gamemode is loaded.
--
function OnGamemodeLoaded() end

--- GM:OnLuaError
-- @usage menu
-- Called when a Lua error occurs, only works in the Menu realm.
--
-- @param  error string  The error that occurred.
-- @param  realm number  Where the Lua error took place
-- @param  name string  Title of the addon that is creating the Lua errors
-- @param  id number  Steam Workshop ID of the addon creating Lua errors, if it is an addon.
function OnLuaError( error,  realm,  name,  id) end

--- GM:OnNPCKilled
-- @usage server
-- Called whenever an NPC is killed.
--
-- @param  npc NPC  The killed NPC
-- @param  attacker Entity  The NPCs attacker, the entity that gets the kill credit, for example a player or an NPC.
-- @param  inflictor Entity  Death inflictor. The entity that did the killing. Not necessarily a weapon.
function OnNPCKilled( npc,  attacker,  inflictor) end

--- GM:OnPhysgunFreeze
-- @usage server
-- Called when a player freezes an entity with the Physgun.
--
-- @param  weapon Entity  The weapon that was used to freeze the entity.
-- @param  physobj PhysObj  PhysObj of the entity.
-- @param  ent Entity  The target entity.
-- @param  ply Player  The player who tried to freeze the entity.
-- @return boolean Allows you to override whether the player can freeze the entity
function OnPhysgunFreeze( weapon,  physobj,  ent,  ply) end

--- GM:OnPhysgunReload
-- @usage server
-- Called when a player reloads with the physgun. Override this to disable default unfreezing behavior.
--
-- @param  physgun Weapon  The physgun in question
-- @param  ply Player  The player wielding the physgun
-- @return boolean Whether the player can reload with the physgun or not
function OnPhysgunReload( physgun,  ply) end

--- GM:OnPlayerChangedTeam
-- @usage server
-- Called when a player has changed team using GM:PlayerJoinTeam.
--
-- @param  ply Player  Player who has changed team
-- @param  oldTeam number  Index of the team the player was originally in
-- @param  newTeam number  Index of the team the player has changed to
function OnPlayerChangedTeam( ply,  oldTeam,  newTeam) end

--- GM:OnPlayerChat
-- @usage client
-- Called whenever a player sends a chat message. For the serverside equivalent, see GM:PlayerSay.
--
-- @param  ply Player  The player
-- @param  text string  The message's text
-- @param  teamChat boolean  Is the player typing in team chat?
-- @param  isDead boolean  Is the player dead?
-- @return boolean Should the message be suppressed?
function OnPlayerChat( ply,  text,  teamChat,  isDead) end

--- GM:OnPlayerHitGround
-- @usage shared
-- Called when a player makes contact with the ground.
--
-- @param  player Entity  Player
-- @param  inWater boolean  Did the player land in water?
-- @param  onFloater boolean  Did the player land on an object floating in the water?
-- @param  speed number  The speed at which the player hit the ground
-- @return boolean Return true to suppress default action
function OnPlayerHitGround( player,  inWater,  onFloater,  speed) end

--- GM:OnReloaded
-- @usage shared
-- Called when gamemode has been reloaded by auto refresh.
--
function OnReloaded() end

--- GM:OnSpawnMenuClose
-- @usage client
-- Called when a player releases the "+menu" bind on their keyboard, which is bound to Q by default.
--
function OnSpawnMenuClose() end

--- GM:OnSpawnMenuOpen
-- @usage client
-- Called when a player presses the "+menu" bind on their keyboard, which is bound to Q by default.
--
function OnSpawnMenuOpen() end

--- GM:OnTextEntryGetFocus
-- @usage client
-- Called when a DTextEntry gets focus.
--
-- @param  panel Panel  The panel that got focus
function OnTextEntryGetFocus( panel) end

--- GM:OnTextEntryLoseFocus
-- @usage client
-- Called when DTextEntry loses focus.
--
-- @param  panel Panel  The panel that lost focus
function OnTextEntryLoseFocus( panel) end

--- GM:OnUndo
-- @usage client
-- Called when the player undoes something.
--
-- @param  name string  The name of the undo action
-- @param  customText string  The custom text for the undo, set by undo.SetCustomUndoText
function OnUndo( name,  customText) end

--- GM:OnViewModelChanged
-- @usage shared
-- Called when the player changes their weapon to another one - and their viewmodel model changes.
--
-- @param  viewmodel Entity  The viewmodel that is changing
-- @param  oldModel string  The old model
-- @param  newModel string  The new model
function OnViewModelChanged( viewmodel,  oldModel,  newModel) end

--- GM:PhysgunDrop
-- @usage shared
-- Called when a player drops an entity with the Physgun.
--
-- @param  ply Player  The player who dropped an entitiy
-- @param  ent Entity  The dropped entity
function PhysgunDrop( ply,  ent) end

--- GM:PhysgunPickup
-- @usage shared
-- Called whenever a player picks up an entity with the Physgun.
--
-- @param  player Player  The player that is picking up using the phys gun.
-- @param  entity Entity  The entity that is being picked up.
-- @return boolean Returns whether the player can pick up the entity or not.
function PhysgunPickup( player,  entity) end

--- GM:PlayerAuthed
-- @usage server
-- Called once when the player is authenticated.
--
-- @param  ply Player  The player
-- @param  steamid string  The player's SteamID
-- @param  uniqueid string  The player's UniqueID
function PlayerAuthed( ply,  steamid,  uniqueid) end

--- GM:PlayerBindPress
-- @usage client
-- Runs when a bind has been pressed. Allows to block commands.
--
-- @param  ply Player  The player who used the command; this will always be equal to LocalPlayer
-- @param  bind string  The bind command
-- @param  pressed boolean  If the bind was activated or deactivated
-- @return boolean Return true to prevent the bind
function PlayerBindPress( ply,  bind,  pressed) end

--- GM:PlayerButtonDown
-- @usage shared
-- Called when a player presses a button.
--
-- @param  ply Player  Player who has pressed button
-- @param  button number  Button code, see BUTTON_CODE_ Enums
function PlayerButtonDown( ply,  button) end

--- GM:PlayerButtonUp
-- @usage shared
-- Called when a player releases a button.
--
-- @param  ply Player  Player who has released button
-- @param  button number  Button code, see BUTTON_CODE_ Enums
function PlayerButtonUp( ply,  button) end

--- GM:PlayerCanHearPlayersVoice
-- @usage server
-- Decides whether a player can hear another player using voice chat.
--
-- @param  listener Player  The listening player.
-- @param  talker Player  The talking player.
-- @return boolean Return true if the listener should hear the talker, false if they shouldn't.
-- @return boolean 3D sound. If set to true, will fade out the sound the further away listener is from the talker, the voice will also be in stereo, and not mono.
function PlayerCanHearPlayersVoice( listener,  talker) end

--- GM:PlayerCanJoinTeam
-- @usage server
-- Returns whether or not a player is allowed to join a team
--
-- @param  ply Player  Player attempting to switch teams
-- @param  team number  Index of the team
-- @return boolean Allowed to switch
function PlayerCanJoinTeam( ply,  team) end

--- GM:PlayerCanPickupItem
-- @usage server
-- Returns whether or not a player is allowed to pick an item up.
--
-- @param  ply Player  Player attempting to pick up
-- @param  item Entity  The item the player is attempting to pick up
-- @return boolean Allow pick up
function PlayerCanPickupItem( ply,  item) end

--- GM:PlayerCanPickupWeapon
-- @usage server
-- Returns whether or not a player is allowed to pick up a weapon.
--
-- @param  ply Player  The player attempting to pick up the weapon
-- @param  wep Weapon  The weapon entity in question
-- @return boolean Allowed pick up or not
function PlayerCanPickupWeapon( ply,  wep) end

--- GM:PlayerCanSeePlayersChat
-- @usage server
-- Returns whether or not the player can see the other player's chat.
--
-- @param  text string  The chat text
-- @param  teamOnly boolean  If the message is team-only
-- @param  listener Player  The player receiving the message
-- @param  speaker Player  The player sending the message
-- @return boolean Can see other player's chat
function PlayerCanSeePlayersChat( text,  teamOnly,  listener,  speaker) end

--- GM:PlayerConnect
-- @usage shared
-- Executes when a player connects to the server.
--
-- @param  name string  Players name
-- @param  ip string  Players IP Address
function PlayerConnect( name,  ip) end

--- GM:PlayerDeath
-- @usage server
-- Called when a player is killed by Player:Kill or any other normal means, except for when the player is killed with Player:KillSilent.
--
-- @param  victim Player  The player who died
-- @param  inflictor Entity  Item used to kill the person
-- @param  attacker Entity  Player or entity that killed the victim
function PlayerDeath( victim,  inflictor,  attacker) end

--- GM:PlayerDeathSound
-- @usage server
-- Returns whether or not the default death sound should be muted.
--
-- @return boolean Mute death sound
function PlayerDeathSound() end

--- GM:PlayerDeathThink
-- @usage server
-- Called every think while the player is dead. The return value will determine if the player respawns.
--
-- @param  ply Player  The player affected in the hook.
-- @return boolean Allow spawn
function PlayerDeathThink( ply) end

--- GM:PlayerDisconnected
-- @usage server
-- Called when a player leaves the server.
--
-- @param  ply Player  the player
function PlayerDisconnected( ply) end

--- GM:PlayerDriveAnimate
-- @usage shared
-- Called to update the player's animation during a drive.
--
-- @param  ply Player  The driving player
function PlayerDriveAnimate( ply) end

--- GM:PlayerEndVoice
-- @usage client
-- Called when player stops using voice chat.
--
-- @param  ply Player  Player who stopped talking
function PlayerEndVoice( ply) end

--- GM:PlayerEnteredVehicle
-- @usage shared
-- Called when a player enters a vehicle. Note: although this hook is defined in the base gamemode as shared, it doesn't appear to be called clientside.
--
-- @param  ply Player  Player who entered vehicle
-- @param  veh Vehicle  Vehicle the player entered
-- @param  role number 
function PlayerEnteredVehicle( ply,  veh,  role) end

--- GM:PlayerFootstep
-- @usage shared
-- Called whenever a player steps. Return true to mute the normal sound.
--
-- @param  ply Player  The stepping player
-- @param  pos Vector  The position of the step
-- @param  foot number  Foot that is stepped. 0 for left, 1 for right
-- @param  sound string  Sound that is going to play
-- @param  volume number  Volume of the footstep
-- @param  filter CRecipientFilter  The Recipient filter of players who can hear the footstep
-- @return boolean Prevent default step sound
function PlayerFootstep( ply,  pos,  foot,  sound,  volume,  filter) end

--- GM:PlayerFrozeObject
-- @usage server
-- Called when a player freezes an object.
--
-- @param  ply Player  Player who has frozen an object
-- @param  ent Entity  The frozen object
-- @param  physobj PhysObj  The frozen physics object of the frozen entity ( For ragdolls )
function PlayerFrozeObject( ply,  ent,  physobj) end

--- GM:PlayerHurt
-- @usage server
-- Called when a player gets hurt.
--
-- @param  victim Player  Victim
-- @param  attacker Entity  Attacker Entity
-- @param  healthRemaining number  Remaining Health
-- @param  damageTaken number  Damage Taken
function PlayerHurt( victim,  attacker,  healthRemaining,  damageTaken) end

--- GM:PlayerInitialSpawn
-- @usage server
-- Called when the player spawns for the first time.
--
-- @param  player Player  The player who spawned.
function PlayerInitialSpawn( player) end

--- GM:PlayerJoinTeam
-- @usage server
-- Makes the player join a specified team. This is a convenience function that calls Player:SetTeam and runs the GM:OnPlayerChangedTeam hook.
--
-- @param  ply Player  Player to force
-- @param  team number  The team to put player into
function PlayerJoinTeam( ply,  team) end

--- GM:PlayerLeaveVehicle
-- @usage server
-- Called when a player leaves a vehicle.
--
-- @param  ply Player  Player who left a vehicle.
-- @param  veh Vehicle  Vehicle the player left.
function PlayerLeaveVehicle( ply,  veh) end

--- GM:PlayerLoadout
-- @usage server
-- Called to give players the default set of weapons.
--NOTE: This function may not work in your custom gamemode if you have overridden your GM:PlayerSpawn and you do not use self.BaseClass.PlayerSpawn or hook.Call.
--
-- @param  ply Player  Player to give weapons to.
function PlayerLoadout( ply) end

--- GM:PlayerNoClip
-- @usage shared
-- Called when a player tries to switch noclip mode.
--
-- @param  ply Player  The person who entered/exited noclip
-- @param  desiredState boolean  Represents the noclip state (on/off) the user will enter if this hook allows them to.
function PlayerNoClip( ply,  desiredState) end

--- GM:PlayerPostThink
-- @usage shared
-- Called after the player's think.
--
-- @param  ply Player  The player
function PlayerPostThink( ply) end

--- GM:PlayerRequestTeam
-- @usage server
-- Request a player to join the team. This function will check if the team is available to join or not.
--
-- @param  ply Player  The player to try to put into a team
-- @param  team number  Team to put the player into if the checks succeeded
function PlayerRequestTeam( ply,  team) end

--- GM:PlayerSay
-- @usage server
-- Called when a player dispatched a chat message. For the clientside equivalent, see GM:OnPlayerChat.
--
-- @param  sender Player  The player which sent the message.
-- @param  text string  The message's content
-- @param  teamChat boolean  Is team chat?
-- @return string What to show instead of original text. Set to "" to stop the message from displaying.
function PlayerSay( sender,  text,  teamChat) end

--- GM:PlayerSelectSpawn
-- @usage server
-- Called to determine a spawn point for a player to spawn at.
--
-- @param  ply Player  The player who needs a spawn point
-- @return Entity The spawnpoint entity to spawn the player at
function PlayerSelectSpawn( ply) end

--- GM:PlayerSelectTeamSpawn
-- @usage server
-- Find a team spawn point entity for this player.
--
-- @param  team number  Players team
-- @param  ply Player  The player
-- @return Entity The entity to use as a spawn point.
function PlayerSelectTeamSpawn( team,  ply) end

--- GM:PlayerSetHandsModel
-- @usage server
-- Called whenever view model hands needs setting a model. By default this calls PLAYER:GetHandsModel and if that fails, sets the hands model according to his player model.
--
-- @param  ply Player  The player whose hands needs a model set
-- @param  ent Entity  The hands to set model of
function PlayerSetHandsModel( ply,  ent) end

--- GM:PlayerSetModel
-- @usage server
-- Called whenever a player spawns and must choose a model. A good place to assign a model to a player.
--NOTE: This function may not work in your custom gamemode if you have overridden your GM:PlayerSpawn and you do not use self.BaseClass.PlayerSpawn or hook.Call.
--
-- @param  ply Player  The player being chosen
function PlayerSetModel( ply) end

--- GM:PlayerShouldTakeDamage
-- @usage server
-- Returns true if the player should take damage from the given attacker.
--
-- @param  ply Player  The player
-- @param  attacker Entity  The attacker
-- @return boolean Allow damage
function PlayerShouldTakeDamage( ply,  attacker) end

--- GM:PlayerShouldTaunt
-- @usage server
-- Allows to suppress player taunts.
--
-- @param  ply Player  Player who tried to taunt
-- @param  act number  Act ID of the taunt player tries to do, see ACT_ Enums
-- @return boolean Return false to disallow player taunting
function PlayerShouldTaunt( ply,  act) end

--- GM:PlayerSilentDeath
-- @usage server
-- Called when the player is killed by Player:KillSilent.
--The player is already considered dead when this hook is called.
--
-- @param  ply Player  The player
function PlayerSilentDeath( ply) end

--- GM:PlayerSpawn
-- @usage server
-- Called whenever a player spawns, including respawns.
--
-- @param  player Player  The player who spawned.
function PlayerSpawn( player) end

--- GM:PlayerSpawnAsSpectator
-- @usage server
-- Called to spawn the player as a spectator.
--
-- @param  ply Player  The player to spawn as a spectator
function PlayerSpawnAsSpectator( ply) end

--- GM:PlayerSpray
-- @usage server
-- Determines if the player can spray using the "impulse 201" console command.
--
-- @param  sprayer Player  The player
-- @return boolean Return false to allow spraying, return true to prevent spraying.
function PlayerSpray( sprayer) end

--- GM:PlayerStartTaunt
-- @usage server
-- Called when player starts taunting.
--
-- @param  ply Player  The player who is taunting
-- @param  act number  The sequence ID of the taunt
-- @param  length number  Length of the taunt
function PlayerStartTaunt( ply,  act,  length) end

--- GM:PlayerStartVoice
-- @usage client
-- Called when a player starts using voice chat.
--
-- @param  ply Player  Player who started using voice chat
function PlayerStartVoice( ply) end

--- GM:PlayerStepSoundTime
-- @usage shared
-- Allows you to override the time between footsteps.
--
-- @param  ply Player  Player who is walking
-- @param  type number  The type of footsteps, see STEPSOUNDTIME_ Enums
-- @param  walking boolean  Is the player walking or not ( +walk? )
-- @return number Time between footsteps, in ms
function PlayerStepSoundTime( ply,  type,  walking) end

--- GM:PlayerSwitchFlashlight
-- @usage server
-- Called whenever a player attempts to either turn on or off their flashlight, returning false will deny the change.
--
-- @param  ply Player  The player who attempts to change their flashlight state.
-- @param  enabled boolean  The new state the player requested, true for on, false for off.
-- @return boolean Can toggle the flashlight or not
function PlayerSwitchFlashlight( ply,  enabled) end

--- GM:PlayerSwitchWeapon
-- @usage shared
-- Called when a player switches their weapon.
--
-- @param  player Player  The player switching weapons.
-- @param  oldWeapon Weapon  The previous weapon.
-- @param  newWeapon Weapon  The weapon the player switched to.
-- @return boolean Return true to prevent weapon switch
function PlayerSwitchWeapon( player,  oldWeapon,  newWeapon) end

--- GM:PlayerTick
-- @usage shared
-- The Move hook is called for you to manipulate the player's CMoveData. This hook is called moments before GM:Move and GM:PlayerNoClip.
--
-- @param  player Entity  The player
-- @param  mv CMoveData  The current movedata for the player.
function PlayerTick( player,  mv) end

--- GM:PlayerTraceAttack
-- @usage shared
-- Called when a player has been hit by a trace and damaged (such as from a bullet). Returning true overrides the damage handling and prevents GM:ScalePlayerDamage from being called.
--
-- @param  ply Player  The player that has been hit
-- @param  dmginfo CTakeDamageInfo  The damage info of the bullet
-- @param  dir Vector  Normalized vector direction of the bullet's path
-- @param  trace table  The trace of the bullet's path, see TraceResult structure
-- @return boolean Override engine handling
function PlayerTraceAttack( ply,  dmginfo,  dir,  trace) end

--- GM:PlayerUnfrozeObject
-- @usage server
-- Called when a player unfreezes an object.
--
-- @param  ply Player  Player who has unfrozen an object
-- @param  ent Entity  The unfrozen object
-- @param  physobj PhysObj  The frozen physics object of the unfrozen entity ( For ragdolls )
function PlayerUnfrozeObject( ply,  ent,  physobj) end

--- GM:PlayerUse
-- @usage server
-- Triggered when the player presses use on an object. Continuously runs until USE is released but will not activate other Entities until the USE key is released; dependent on activation type of the Entity.
--
-- @param  ply Player  The player pressing the "use" key.
-- @param  ent Entity  The entity which the player is looking at / activating USE on.
-- @return boolean Returns true if they can activate, false if they're not allowed to USE the entity.
function PlayerUse( ply,  ent) end

--- GM:PopulateMenuBar
-- @usage client
-- Called when it's time to populate the context menu menu bar at the top.
--
-- @param  menubar Panel  The DMenuBar itself.
function PopulateMenuBar( menubar) end

--- GM:PopulateSTOOLMenu
-- @usage client
-- Called to populate the Scripted Tool menu.
--
function PopulateSTOOLMenu() end

--- GM:PopulateToolMenu
-- @usage client
-- Add the STOOLS to the tool menu. You want to call spawnmenu.AddToolMenuOption in this hook.
--
function PopulateToolMenu() end

--- GM:PostCleanupMap
-- @usage shared
-- Called right after the map has cleaned up (usually because game.CleanUpMap was called)
--
function PostCleanupMap() end

--- GM:PostDraw2DSkyBox
-- @usage client
-- Called right after the 2D skybox has been drawn - allowing you to draw over it.
--
function PostDraw2DSkyBox() end

--- GM:PostDrawEffects
-- @usage client
-- Called after rendering effects. This is where halos are drawn. Called just before GM:PreDrawHUD.
--
function PostDrawEffects() end

--- GM:PostDrawHUD
-- @usage client
-- Called after GM:PreDrawHUD, GM:HUDPaintBackground and GM:HUDPaint but before GM:DrawOverlay.
--
function PostDrawHUD() end

--- GM:PostDrawOpaqueRenderables
-- @usage client
-- Called after drawing opaque entities.
--
-- @param  bDrawingDepth boolean  Whether the current draw is writing depth.
-- @param  bDrawingSkybox boolean  Whether the current draw is drawing the skybox.
function PostDrawOpaqueRenderables( bDrawingDepth,  bDrawingSkybox) end

--- GM:PostDrawPlayerHands
-- @usage client
-- Called after the player hands are drawn.
--
-- @param  hands Entity  This is the gmod_hands entity.
-- @param  vm Entity  This is the view model entity.
-- @param  ply Player  The the owner of the view model.
-- @param  weapon Weapon  This is the weapon that is from the view model.
function PostDrawPlayerHands( hands,  vm,  ply,  weapon) end

--- GM:PostDrawSkyBox
-- @usage client
-- Called after drawing the skybox.
--
function PostDrawSkyBox() end

--- GM:PostDrawTranslucentRenderables
-- @usage client
-- Called after all translucent entities are drawn.
--
-- @param  bDrawingDepth boolean  Unknown
-- @param  bDrawingSkybox boolean  True if we are drawing skybox
function PostDrawTranslucentRenderables( bDrawingDepth,  bDrawingSkybox) end

--- GM:PostDrawViewModel
-- @usage client
-- Called after view model is drawn.
--
-- @param  viewmodel Entity  Players view model
-- @param  player Player  The owner of the weapon/view model
-- @param  weapon Weapon  The weapon the player is currently holding
function PostDrawViewModel( viewmodel,  player,  weapon) end

--- GM:PostGamemodeLoaded
-- @usage shared
-- Called after the gamemode has loaded.
--
function PostGamemodeLoaded() end

--- GM:PostPlayerDeath
-- @usage server
-- Called right after GM:DoPlayerDeath and GM:PlayerSilentDeath.
--The player is considered dead when this is hook is called, Player:Alive will return false.
--
-- @param  ply Player  The player
function PostPlayerDeath( ply) end

--- GM:PostPlayerDraw
-- @usage client
-- Called after the player was drawn.
--
-- @param  ply Player  The player that was drawn.
function PostPlayerDraw( ply) end

--- GM:PostProcessPermitted
-- @usage client
-- Allows you to suppress post processing effect drawing.
--
-- @param  ppeffect string  The classname of Post Processing effect
-- @return boolean Return true/false depending on whether this post process should be allowed
function PostProcessPermitted( ppeffect) end

--- GM:PostReloadToolsMenu
-- @usage client
-- Called right after the Lua Loaded tool menus are reloaded. This is a good place to set up any ControlPanels.
--
function PostReloadToolsMenu() end

--- GM:PostRender
-- @usage client
-- Called after the frame has been rendered.
--
function PostRender() end

--- GM:PostRenderVGUI
-- @usage client
-- Called after the VGUI has been drawn.
--
function PostRenderVGUI() end

--- GM:PreCleanupMap
-- @usage shared
-- Called right before the map cleans up (usually because game.CleanUpMap was called)
--
function PreCleanupMap() end

--- GM:PreDrawEffects
-- @usage client
-- Called just after GM:PreDrawViewModel and can technically be considered "PostDrawAllViewModels".
--
function PreDrawEffects() end

--- GM:PreDrawHalos
-- @usage client
-- Called before rendering the halos. This is the place to call halo.Add.
--
function PreDrawHalos() end

--- GM:PreDrawHUD
-- @usage client
-- Called before any of 2D drawing functions. Drawing anything in it seems to work incorrectly.
--
function PreDrawHUD() end

--- GM:PreDrawOpaqueRenderables
-- @usage client
-- Called before all opaque entities are drawn.
--
-- @param  isDrawingDepth boolean  Whether the current draw is writing depth.
-- @param  isDrawSkybox boolean  Whether the current draw is drawing the skybox.
-- @return boolean Return true to prevent opaque renderables from drawing.
function PreDrawOpaqueRenderables( isDrawingDepth,  isDrawSkybox) end

--- GM:PreDrawPlayerHands
-- @usage client
-- Called before the player hands are drawn.
--
-- @param  hands Entity  This is the gmod_hands entity before it is drawn.
-- @param  vm Entity  This is the view model entity before it is drawn.
-- @param  ply Player  The the owner of the view model.
-- @param  weapon Weapon  This is the weapon that is from the view model.
-- @return boolean Return true to prevent the viewmodel hands from rendering
function PreDrawPlayerHands( hands,  vm,  ply,  weapon) end

--- GM:PreDrawSkyBox
-- @usage client
-- Called before the sky box is drawn.
--
function PreDrawSkyBox() end

--- GM:PreDrawTranslucentRenderables
-- @usage client
-- Called before all the translucent entities are drawn.
--
-- @param  isDrawingDepth boolean  Whether the current draw is writing depth.
-- @param  isDrawSkybox boolean  Whether the current draw is drawing the skybow.
-- @return boolean Return true to prevent translucent renderables from drawing.
function PreDrawTranslucentRenderables( isDrawingDepth,  isDrawSkybox) end

--- GM:PreDrawViewModel
-- @usage client
-- Called before the view model has been drawn. This hook by default also calls this on weapons, so you can use WEAPON:PreDrawViewModel.
--
-- @param  vm Entity  This is the view model entity before it is drawn. On server-side, this entity is the predicted view model.
-- @param  ply Player  The the owner of the view model.
-- @param  weapon Weapon  This is the weapon that is from the view model.
function PreDrawViewModel( vm,  ply,  weapon) end

--- GM:PreGamemodeLoaded
-- @usage shared
-- Called before the gamemode is loaded.
--
function PreGamemodeLoaded() end

--- GM:PrePlayerDraw
-- @usage client
-- Called before the player is drawn.
--
-- @param  player Player  The player that is about to be drawn.
-- @return boolean Prevent default player rendering. Return true to hide the player.
function PrePlayerDraw( player) end

--- GM:PreReloadToolsMenu
-- @usage client
-- Called right before the Lua Loaded tool menus are reloaded.
--
function PreReloadToolsMenu() end

--- GM:PreRender
-- @usage client
-- Called before the renderer is about to start rendering the next frame.
--
-- @return boolean Return true to prevent all rendering. This can make the whole game stop rendering anything.
function PreRender() end

--- GM:PreventScreenClicks
-- @usage client
-- This will prevent IN_ATTACK from sending to server when player tries to shoot from C menu.
--
-- @return boolean Return true to prevent screen clicks
function PreventScreenClicks() end

--- GM:PropBreak
-- @usage shared
-- Called when a prop has been destroyed.
--
-- @param  attacker Player  The person who broke the prop.
-- @param  prop Entity  The entity that has been broken by the attacker.
function PropBreak( attacker,  prop) end

--- GM:RenderScene
-- @usage client
-- Render the scene. Used by the "Stereoscopy" Post-processing effect.
--
-- @param  origin Vector  View origin
-- @param  angles Angle  View angles
-- @param  fov number  View FOV
-- @return boolean Return true to override drawing the scene
function RenderScene( origin,  angles,  fov) end

--- GM:RenderScreenspaceEffects
-- @usage client
-- Used to render post processing effects.
--
function RenderScreenspaceEffects() end

--- GM:Restored
-- @usage shared
-- Called when the game is loaded from a saved game.
--
function Restored() end

--- GM:Saved
-- @usage shared
-- Called when the game is saved using source engine built-in save system.
--
function Saved() end

--- GM:ScaleNPCDamage
-- @usage server
-- Called when an NPC takes damage.
--
-- @param  npc NPC  The NPC that takes damage
-- @param  hitgroup number  The hitgroup (hitbox) enum where the player took damage. See HITGROUP_ Enums
-- @param  dmginfo CTakeDamageInfo  Damage info
function ScaleNPCDamage( npc,  hitgroup,  dmginfo) end

--- GM:ScalePlayerDamage
-- @usage shared
-- This hook allows you to change how much damage a player receives when one takes damage to a specific body part.
--
-- @param  ply Player  The player taking damage.
-- @param  hitgroup number  The hitgroup where the player took damage. See HITGROUP_ Enums
-- @param  dmginfo CTakeDamageInfo  The damage info.
-- @return boolean Return true to prevent damage that this hook is called for, stop blood particle effects and blood decals. It is possible to return true only on client ( This will work only in multiplayer ) to stop the effects but still take damage.
function ScalePlayerDamage( ply,  hitgroup,  dmginfo) end

--- GM:ScoreboardHide
-- @usage client
-- Called when player released the scoreboard button. ( TAB by default )
--
function ScoreboardHide() end

--- GM:ScoreboardShow
-- @usage client
-- Called when player presses the scoreboard button. ( TAB by default )
--
function ScoreboardShow() end

--- GM:SetPlayerSpeed
-- @usage shared
-- Sets player run and sprint speeds.
--
-- @param  ply Player  The player
-- @param  walkSpeed number  The walk speed
-- @param  runSpeed number  The run speed
function SetPlayerSpeed( ply,  walkSpeed,  runSpeed) end

--- GM:SetupMove
-- @usage shared
-- SetupMove is called before the engine process movements. This allows us to override the players movement.
--
-- @param  ply Player  The player whose movement we are about to process
-- @param  mv CMoveData  The move data to override/use
-- @param  cmd CUserCmd  The command data
function SetupMove( ply,  mv,  cmd) end

--- GM:SetupPlayerVisibility
-- @usage server
-- Allows you to add extra positions to the player's PVS. This is the place to call AddOriginToPVS.
--
-- @param  ply Player  The player
-- @param  viewEntity Entity  Players Player:GetViewEntity
function SetupPlayerVisibility( ply,  viewEntity) end

--- GM:SetupSkyboxFog
-- @usage client
-- Allows you to use render.Fog* functions to manipulate skybox fog.
--
-- @param  scale number  The scale of 3D skybox
-- @return boolean Return true to tell the engine that fog is set up
function SetupSkyboxFog( scale) end

--- GM:SetupWorldFog
-- @usage client
-- Allows you to use render.Fog* functions to manipulate world fog.
--
-- @return boolean Return true to tell the engine that fog is set up
function SetupWorldFog() end

--- GM:ShouldCollide
-- @usage shared
-- Called to decide whether a pair of entities should collide with each other. This is only called if Entity:SetCustomCollisionCheck was used on one or both entities.
--
-- @param  ent1 Entity  The first entity in the collision poll.
-- @param  ent2 Entity  The second entity in the collision poll.
-- @return boolean Whether the entities should collide.
function ShouldCollide( ent1,  ent2) end

--- GM:ShouldDrawLocalPlayer
-- @usage client
-- Called to determine if the LocalPlayer should be drawn.
--
-- @param  ply Player  The player
-- @return boolean True to draw the player, false to hide.
function ShouldDrawLocalPlayer( ply) end

--- GM:ShowHelp
-- @usage server
-- Called when a player executes gm_showhelp console command. ( Default bind is F1 )
--
-- @param  ply Player  Player who executed the command
function ShowHelp( ply) end

--- GM:ShowSpare1
-- @usage server
-- Called when a player executes gm_showspare1 console command. ( Default bind is F3 )
--
-- @param  ply Player  Player who executed the command
function ShowSpare1( ply) end

--- GM:ShowSpare2
-- @usage server
-- Called when a player executes gm_showspare2 console command. ( Default bind is F4 )
--
-- @param  ply Player  Player who executed the command
function ShowSpare2( ply) end

--- GM:ShowTeam
-- @usage server
-- Called when a player executes gm_showteam console command. ( Default bind is F2 )
--
-- @param  ply Player  Player who executed the command
function ShowTeam( ply) end

--- GM:ShutDown
-- @usage shared
-- Called whenever the lua environment is about to be shut down.
--
function ShutDown() end

--- GM:SpawniconGenerated
-- @usage client
-- Called when spawn icon is generated.
--
-- @param  lastmodel string  File path of previously generated model.
-- @param  imagename string  File path of the generated icon.
-- @param  modelsleft number  Amount of models left to generate.
function SpawniconGenerated( lastmodel,  imagename,  modelsleft) end

--- GM:StartChat
-- @usage client
-- Runs when the user tries to open the chat box.
--
-- @param  isTeamChat boolean  True if team chat or, false otherwise.
-- @return boolean Return true to hide the default chat box
function StartChat( isTeamChat) end

--- GM:StartCommand
-- @usage shared
-- Allows you to change the players inputs before they are processed by the server.
--This is basically a shared version of GM:CreateMove.
--
-- @param  ply Player  The player
-- @param  ucmd CUserCmd  The usercommand
function StartCommand( ply,  ucmd) end

--- GM:StartEntityDriving
-- @usage shared
-- Called right before an entity starts driving. Overriding this hook will cause it to not call drive/Start and the player will not begin driving the entity.
--
-- @param  ent Entity  The entity that is going to be driven
-- @param  ply Player  The player that is going to drive the entity
function StartEntityDriving( ent,  ply) end

--- GM:StartGame
-- @usage menu
-- Called when you start a new game via the menu.
--
function StartGame() end

--- GM:Think
-- @usage shared
-- Called every frame on client and every tick on server.
--
function Think() end

--- GM:Tick
-- @usage shared
-- Called every server tick. Serverside, this is similar to GM:Think.
--
function Tick() end

--- GM:TranslateActivity
-- @usage shared
-- Allows you to translate player activities.
--
-- @param  ply Player  The player
-- @param  act number  The activity. See ACT_ Enums
-- @return number The new, translated activity
function TranslateActivity( ply,  act) end

--- GM:UpdateAnimation
-- @usage shared
-- Animation updates (pose params etc) should be done here.
--
-- @param  ply Player  The player
-- @param  velocity number  Players velocity
-- @param  maxSeqGroundSpeed number  Velocity, at which animation will play at normal speed ( Playback Rate = 1 )
function UpdateAnimation( ply,  velocity,  maxSeqGroundSpeed) end

--- GM:VariableEdited
-- @usage server
-- Called when a variable is edited on an Entity (called by Edit Properties... menu)
--
-- @param  ent Entity  The entity being edited
-- @param  ply Player  The player doing the editing
-- @param  key string  The name of the variable
-- @param  val string  The new value, as a string which will later be converted to its appropriate type
-- @param  editor table  The edit table defined in Entity:NetworkVar
function VariableEdited( ent,  ply,  key,  val,  editor) end

--- GM:VehicleMove
-- @usage shared
-- Called when you are driving a vehicle. This hook works just like GM:Move.
--
-- @param  ply Player  Player who is driving the vehicle
-- @param  veh Vehicle  The vehicle being driven
-- @param  mv CMoveData  Move data
function VehicleMove( ply,  veh,  mv) end

--- GM:VGUIMousePressAllowed
-- @usage client_m
--  Arguments
-- @param  button number  The button that was pressed, see MOUSE_ Enums
-- @return boolean Return true if the mouse click should be ignored or not.
function VGUIMousePressAllowed( button) end

--- GM:VGUIMousePressed
-- @usage client_m
--  Arguments
-- @param  pnl Panel  Panel that currently has focus.
-- @param  mouseCode number  The key that the player pressed using MOUSE_ Enums.
function VGUIMousePressed( pnl,  mouseCode) end

--- GM:WeaponEquip
-- @usage server
-- Called as a weapon entity is picked up by a player.
--
-- @param  weapon Weapon  The equipped weapon.
function WeaponEquip( weapon) end

--- GM:WorkshopDownloadedFile
-- @usage menu
-- Called when an addon from the Steam workshop finishes downloading. Used by default to update details on the workshop downloading panel.
--
-- @param  id number  Workshop ID of addon.
-- @param  title string  Name of addon.
-- @param  authorid number  Seems to always be nil?
function WorkshopDownloadedFile( id,  title,  authorid) end

--- GM:WorkshopDownloadFile
-- @usage menu
-- Called when an addon from the Steam workshop begins downloading. Used by default to place details on the workshop downloading panel.
--
-- @param  id number  Workshop ID of addon.
-- @param  imageID number  ID of addon's preview image. For example, for Extended Spawnmenu addon, the image URL is http://cloud-4.steamusercontent.com/ugc/702859018846106764/9E7E1946296240314751192DA0AD15B6567FF92D/  So, the value of this argument would be 702859018846106764.
-- @param  title string  Name of addon.
-- @param  size number  File size of addon in bytes.
function WorkshopDownloadFile( id,  imageID,  title,  size) end

--- GM:WorkshopDownloadProgress
-- @usage menu
-- Called while an addon from the Steam workshop is downloading. Used by default to update details on the fancy workshop download panel.
--
-- @param  id number  Workshop ID of addon.
-- @param  imageID number  ID of addon's preview image. For example, for Extended Spawnmenu addon, the image URL is http://cloud-4.steamusercontent.com/ugc/702859018846106764/9E7E1946296240314751192DA0AD15B6567FF92D/  So, the value of this argument would be 702859018846106764.
-- @param  title string  Name of addon.
-- @param  downloaded number  Current bytes of addon downloaded.
-- @param  expected number  Expected file size of addon in bytes.
function WorkshopDownloadProgress( id,  imageID,  title,  downloaded,  expected) end

--- GM:WorkshopDownloadTotals
-- @usage menu
-- Called after GM:WorkshopStart.
--
-- @param  remain number  Remaining addons to download
-- @param  total number  Total addons needing to be downloaded
function WorkshopDownloadTotals( remain,  total) end

--- GM:WorkshopEnd
-- @usage menu
-- Called when downloading content from Steam workshop ends. Used by default to hide fancy workshop downloading panel.
--
function WorkshopEnd() end

--- GM:WorkshopStart
-- @usage menu
-- Called when downloading content from Steam workshop begins. Used by default to show fancy workshop downloading panel.
--
function WorkshopStart() end

--- GM:WorkshopSubscriptionsProgress
-- @usage menu
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param dt number 
-- @param i0 number 
function WorkshopSubscriptionsProgress(dt, i0) end

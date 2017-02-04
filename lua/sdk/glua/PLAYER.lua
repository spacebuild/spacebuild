---
-- @description Library Player
 module("Player")

--- Player:AccountID
-- @usage shared
-- Returns the player's AccountID aka 32bit SteamID.
--
-- @return number Player's 32bit SteamID aka AccountID.
function AccountID() end

--- Player:AddCleanup
-- @usage shared
-- Adds an entity to the players clean up list.
--NOTE: This function is only available in Sandbox and its derivatives.
--
-- @param  type string  Cleanup type
-- @param  ent Entity  Entity to add
function AddCleanup( type,  ent) end

--- Player:AddCount
-- @usage shared
-- Adds an entity to the total count of entities of same class.
--
-- @param  str string  Entity type
-- @param  ent Entity  Entity
function AddCount( str,  ent) end

--- Player:AddDeaths
-- @usage server
-- Add a certain amount to the player's death count
--
-- @param  count number  number of deaths to add
function AddDeaths( count) end

--- Player:AddFrags
-- @usage server
-- Add a certain amount to the player's frag count (or kills count)
--
-- @param  count number  number of frags to add
function AddFrags( count) end

--- Player:AddFrozenPhysicsObject
-- @usage server
-- Adds a entity to the players list of frozen objects.
--
-- @param  ent Entity  Entity
-- @param  physobj PhysObj  Physics object belonging to ent
function AddFrozenPhysicsObject( ent,  physobj) end

--- Player:AddPlayerOption
-- @usage client
-- Sets up the voting system for the player.
--This is a really barebone system. By calling this a vote gets started, when the player presses 0-9 the callback function gets called along with the key the player pressed. Use the draw callback to draw the vote panel.
--
-- @param  name string  Name of the vote
-- @param  timeout number  Time until the vote expires
-- @param  votecallback function  The function to be run when the player presses 0-9 while a vote is active.
-- @param  drawcallback function  Used to draw the vote panel.
function AddPlayerOption( name,  timeout,  votecallback,  drawcallback) end

--- Player:AddVCDSequenceToGestureSlot
-- @usage shared
-- Plays a sequence directly from a sequence number, similar to Player:AnimRestartGesture. This function has the advantage to play sequences that haven't been bound to an existing ACT_ Enums
--
-- @param  slot number  Gesture slot using GESTURE_SLOT_ Enums
-- @param  sequenceId number  The sequence ID to play, can be retrieved with Entity:LookupSequence.
-- @param  cycle number  The cycle to start the animation at, ranges from 0 to 1.
-- @param  loop boolean  If the animation should not loop. true = stops the animation, false = the animation keeps playing.
function AddVCDSequenceToGestureSlot( slot,  sequenceId,  cycle,  loop) end

--- Player:Alive
-- @usage shared
-- Checks if the player is alive.
--
-- @return boolean Whether the player is alive
function Alive() end

--- Player:AllowFlashlight
-- @usage shared
-- Sets if the player can toggle his flashlight. Function exists on both the server and client but has no effect when ran on the client.
--
-- @param  canFlashlight boolean  True allows flashlight toggling
function AllowFlashlight( canFlashlight) end

--- Player:AllowImmediateDecalPainting
-- @usage server
-- Lets the player spray his decal without delay
--
-- @param  allow boolean  Allow or disallow
function AllowImmediateDecalPainting( allow) end

--- Player:AnimResetGestureSlot
-- @usage shared
-- Resets player gesture in selected slot.
--
-- @param  slot number  Slot to reset. See the GESTURE_SLOT_ Enums.
function AnimResetGestureSlot( slot) end

--- Player:AnimRestartGesture
-- @usage shared
-- Restart a gesture on a player, within a gesture slot.
--
-- @param  slot number  Gesture slot using GESTURE_SLOT_ Enums
-- @param  activity number  The activity ( see ACT_ Enums ) or sequence that should be played
-- @param  bAutoKill boolean  Whether the animation should be automatically stopped. true = stops the animation, false = the animation keeps playing/looping
function AnimRestartGesture( slot,  activity,  bAutoKill) end

--- Player:AnimRestartMainSequence
-- @usage shared
-- Restarts the main animation on the player, has the same effect as calling Entity:SetCycle( 0 ).
--
function AnimRestartMainSequence() end

--- Player:AnimSetGestureSequence
-- @usage shared
-- Sets the sequence of the animation playing in the given gesture slot.
--
-- @param  slot number  The gesture slot. See GESTURE_SLOT_ Enums
-- @param  sequenceID number  Sequence ID to set.
function AnimSetGestureSequence( slot,  sequenceID) end

--- Player:AnimSetGestureWeight
-- @usage shared
-- Sets the weight of the animation playing in the given gesture slot.
--
-- @param  slot number  The gesture slot. See GESTURE_SLOT_ Enums
-- @param  weight number  The weight this slot should be set to. Value must be ranging from 0 to 1.
function AnimSetGestureWeight( slot,  weight) end

--- Player:Armor
-- @usage shared
-- Returns the player's armor.
--
-- @return number The player's armor.
function Armor() end

--- Player:Ban
-- @usage server
-- Bans the player from the server for a certain amount of minutes.
--
-- @param  minutes number  Duration of the ban in minutes (0 is permanent)
-- @param  kick=false boolean  Whether to kick the player after banning then or not
function Ban( minutes,  kick) end

--- Player:CanUseFlashlight
-- @usage shared
-- Returns true if the player's flashlight hasn't been disabled by  Player:AllowFlashlight
--
-- @return boolean canFlashlight
function CanUseFlashlight() end

--- Player:ChatPrint
-- @usage shared
-- Prints a string to the chatbox of the client.
--
-- @param  message string  String to be printed
function ChatPrint( message) end

--- Player:CheckLimit
-- @usage shared
-- Checks if the limit is hit or not. If it is, it will throw a notification saying so.
--
-- @param  str string  Limit type
-- @return boolean Returns true if limit is not hit, false if it is hit
function CheckLimit( str) end

--- Player:ConCommand
-- @usage shared
-- Runs the concommand on the player. This does not work on bots.
--
-- @param  command string  command to run
function ConCommand( command) end

--- Player:CreateRagdoll
-- @usage server
-- Creates the player's ragdoll entity.
--
--This is normally used when a player dies, to create their death ragdoll.
--
--The ragdoll will be created with the player's properties such as Position, Angles, PlayerColor, Velocity and Model.
--
--You can retrieve the entity this creates with Player:GetRagdollEntity.
--
function CreateRagdoll() end

--- Player:CrosshairDisable
-- @usage server
-- Disables a players crosshair.
--
function CrosshairDisable() end

--- Player:CrosshairEnable
-- @usage server
-- Enables crosshair of player.
--
function CrosshairEnable() end

--- Player:Crouching
-- @usage shared
-- Returns whether the player is crouching or not
--
-- @return boolean Whether the player is crouching
function Crouching() end

--- Player:Deaths
-- @usage shared
-- Returns the player's death count
--
-- @return number The number of deaths the player has had.
function Deaths() end

--- Player:DebugInfo
-- @usage server
-- Prints the players' name and position to the console.
--
function DebugInfo() end

--- Player:DetonateTripmines
-- @usage server
-- Detonates all tripmines belonging to the player.
--
function DetonateTripmines() end

--- Player:DoAnimationEvent
-- @usage shared
-- Sends a third person animation event to the player.
--
-- @param  data number  The data to send.
function DoAnimationEvent( data) end

--- Player:DoAttackEvent
-- @usage shared
-- Starts the player's attack animation. The attack animation is determined by the weapon's HoldType.
--
function DoAttackEvent() end

--- Player:DoCustomAnimEvent
-- @usage shared
-- Sends a specified third person animation event to the player.
--
-- @param  event number  The event to send. See PLAYERANIMEVENT_ Enums.
-- @param  data number  The data to send alongside the event.
function DoCustomAnimEvent( event,  data) end

--- Player:DoReloadEvent
-- @usage shared
-- Sends a third person reload animation event to the player.
--
function DoReloadEvent() end

--- Player:DoSecondaryAttack
-- @usage shared
-- Sends a third person secondary fire animation event to the player.
--
function DoSecondaryAttack() end

--- Player:DrawViewModel
-- @usage server
-- Show/Hide the player's weapon's viewmodel.
--
-- @param  draw boolean  Should draw
-- @param  vm=0 number  Which view model to show/hide, 0-2.
function DrawViewModel( draw,  vm) end

--- Player:DrawWorldModel
-- @usage server
-- Show/Hide the player's weapon's worldmodel.
--
-- @param  draw boolean  Should draw
function DrawWorldModel( draw) end

--- Player:DropNamedWeapon
-- @usage server
-- Drops the players' weapon of a specific class.
--
-- @param  class string  The class to drop.
function DropNamedWeapon( class) end

--- Player:DropObject
-- @usage server
-- Drops any object the player is currently holding with either gravitygun or +Use (E key)
--
function DropObject() end

--- Player:DropWeapon
-- @usage server
-- Forces the player to drop the specified weapon
--
-- @param  weapon Weapon  Weapon to be dropped
function DropWeapon( weapon) end

--- Player:EnterVehicle
-- @usage server
-- Enters the player into specified vehicle
--
-- @param  vehicle Vehicle  Vehicle the player will enter
function EnterVehicle( vehicle) end

--- Player:EquipSuit
-- @usage server
-- Equips the player with the HEV suit.
--
function EquipSuit() end

--- Player:ExitVehicle
-- @usage server
-- Makes the player exit the vehicle if they're in one.
--
function ExitVehicle() end

--- Player:Flashlight
-- @usage server
-- Enables/Disables the player's flashlight
--
-- @param  isOn boolean  Turns the flashlight on/off
function Flashlight( isOn) end

--- Player:FlashlightIsOn
-- @usage shared
-- Returns true if the player's flashlight is on.
--
-- @return boolean Whether the player's flashlight is on.
function FlashlightIsOn() end

--- Player:Frags
-- @usage shared
-- Returns the amount of kills a player has.
--
-- @return number kills
function Frags() end

--- Player:Freeze
-- @usage server
-- Freeze/Unfreezes the player. Frozen players cannot move, attack or turn around. Keybindings are still called. Similar to Player:Lock.
--
-- @param  frozen=false boolean  Whether the player should be frozen.
function Freeze( frozen) end

--- Player:GetActiveWeapon
-- @usage shared
-- Returns the player's active weapon.
--
-- @return Weapon The weapon the player is currently has equipped.
function GetActiveWeapon() end

--- Player:GetAimVector
-- @usage shared
-- Returns the direction that the player is aiming.
--
-- @return Vector The direction vector of players aim
function GetAimVector() end

--- Player:GetAllowFullRotation
-- @usage shared
-- Returns true if the players' model is allowed to rotate around the pitch and roll axis.
--
-- @return boolean Allowed
function GetAllowFullRotation() end

--- Player:GetAllowWeaponsInVehicle
-- @usage shared
-- Returns whether the player is allowed to use his weapons in a vehicle or not.
--
-- @return boolean Whether the player is allowed to use his weapons in a vehicle or not.
function GetAllowWeaponsInVehicle() end

--- Player:GetAmmoCount
-- @usage shared
-- Gets the amount of ammo the player has.
--
-- @param  ammotype any  The ammunition type. Can be either number ammo ID or string ammo name.
-- @return number The amount of ammo player has in reserve.
function GetAmmoCount( ammotype) end

--- Player:GetAvoidPlayers
-- @usage shared
-- Gets if the player will be pushed out of nocollided players.
--
-- @return boolean pushed
function GetAvoidPlayers() end

--- Player:GetCanWalk
-- @usage shared
-- Returns true if the player is able to walk using the (default) alt key.
--
-- @return boolean AbleToWalk
function GetCanWalk() end

--- Player:GetCanZoom
-- @usage shared
-- Determines whenever the player is allowed to use the zoom functionality.
--
-- @return boolean canZoom
function GetCanZoom() end

--- Player:GetClassID
-- @usage shared
-- Returns the player's class id.
--
-- @return number The player's class id.
function GetClassID() end

--- Player:GetCount
-- @usage shared
-- Gets total count of entities of same class.
--
-- @param  type string  Entity type to get count of.
-- @param  minus=0 number  If specified, it will reduce the counter by this value. Works only serverside.
function GetCount( type,  minus) end

--- Player:GetCrouchedWalkSpeed
-- @usage shared
-- Gets the crouched walk speed.
--
-- @return number Speed
function GetCrouchedWalkSpeed() end

--- Player:GetCurrentCommand
-- @usage shared
-- Returns the last command which was sent by the specified player. Can only be used in a Predicted Hook.
--
-- @return CUserCmd Last user commands
function GetCurrentCommand() end

--- Player:GetCurrentViewOffset
-- @usage shared
-- Gets the actual view offset which equals the difference between the players actual position and their view when standing.
--
-- @return Vector The actual view offset.
function GetCurrentViewOffset() end

--- Player:GetDrivingEntity
-- @usage shared
-- Gets the entity the player is currently driving.
--
-- @return Entity DriveEntity
function GetDrivingEntity() end

--- Player:GetDrivingMode
-- @usage shared
-- Returns driving mode of the player. See Entity Driving.
--
-- @return number The drive mode ID or 0 if player doesn't use the drive system.
function GetDrivingMode() end

--- Player:GetDuckSpeed
-- @usage shared
-- Returns a player's duck speed (in seconds)
--
-- @return number duckspeed
function GetDuckSpeed() end

--- Player:GetEyeTrace
-- @usage shared
-- Returns a table with information of what the player is looking at.
--
-- @return table Trace information, see TraceResult structure
function GetEyeTrace() end

--- Player:GetEyeTraceNoCursor
-- @usage shared
-- Returns the trace according to the players view direction, ignoring their mouse ( Holding C and moving the mouse in Sandbox ).
--
-- @return table Trace result. See TraceResult structure
function GetEyeTraceNoCursor() end

--- Player:GetFOV
-- @usage shared
-- Returns the FOV of the player.
--
-- @return number FOV
function GetFOV() end

--- Player:GetFriendStatus
-- @usage client
-- Returns the steam "relationship" towards the player.
--
-- @return string Should return one of four different things depending on their status on your friends list: "friend", "blocked", "none" or "requested".
function GetFriendStatus() end

--- Player:GetHands
-- @usage shared
-- Gets the hands entity of a player
--
-- @return Entity The hands entity if players has one
function GetHands() end

--- Player:GetHoveredWidget
-- @usage shared
-- Returns the widget the player is hovering with his mouse.
--
-- @return Entity The hovered widget.
function GetHoveredWidget() end

--- Player:GetHull
-- @usage shared
-- Gets the bottom base and the top base size of the player's hull.
--
-- @return Vector Player's hull bottom base size
-- @return Vector Player's hull top base size
function GetHull() end

--- Player:GetHullDuck
-- @usage shared
-- Gets the bottom base and the top base size of the player's crouch hull.
--
-- @return Vector Player's crouch hull bottom base size
-- @return Vector Player's crouch hull top base size
function GetHullDuck() end

--- Player:GetInfo
-- @usage server
-- Retrieves the value of a client-side ConVar
--
-- @param  cVarName string  The name of the client-side ConVar
-- @return string ConVar Value
function GetInfo( cVarName) end

--- Player:GetInfoNum
-- @usage server
-- Retrieves the numeric value of a client-side convar, returns nil if value is not convertible to a number.
--
-- @param  cVarName string  The name of the ConVar to query the value of
-- @param  default number  Default value if we failed to retrieve the number
-- @return number Clients console variable value
function GetInfoNum( cVarName,  default) end

--- Player:GetJumpPower
-- @usage shared
-- Returns the jump power of the player
--
-- @return number Jump power
function GetJumpPower() end

--- Player:GetLaggedMovementValue
-- @usage shared
-- Returns the timescale multiplier of the player movement.
--
-- @return number The timescale multiplier, defaults to 1.
function GetLaggedMovementValue() end

--- Player:GetMaxSpeed
-- @usage shared
-- Returns the player's maximum movement speed.
--
-- @return number The maximum movement speed the player can go at.
function GetMaxSpeed() end

--- Player:GetName
-- @usage shared
-- Returns the player's name, this is an alias of Player:Nick.
--
-- @return string The player's name.
function GetName() end

--- Player:GetNoCollideWithTeammates
-- @usage shared
-- Returns whenever the player is set not to collide with their teammates.
--
-- @return boolean noCollideWithTeammates
function GetNoCollideWithTeammates() end

--- Player:GetObserverMode
-- @usage shared
-- Returns the the observer mode of the player
--
-- @return number Observe mode of that player, see OBS_MODE_ Enums.
function GetObserverMode() end

--- Player:GetObserverTarget
-- @usage shared
-- Returns the entity the player is currently observing.
--
-- @return Entity The entity the player is currently spectating.
function GetObserverTarget() end

--- Player:GetPData
-- @usage shared
-- Returns a player's PData from the server's or client's SQL database. ( sv.db and cl.db respectively ) It is not networked!
--
-- @param  key any  Name of the PData key
-- @param  default any  Default value if PData key doesn't exist.
-- @return string Returned data
function GetPData( key,  default) end

--- Player:GetPlayerColor
-- @usage shared
-- Returns a player model's color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
--
-- @return Vector color
function GetPlayerColor() end

--- Player:GetPlayerInfo
-- @usage client
-- Returns a table containing player information.
--
-- @return table A table containing player information.
function GetPlayerInfo() end

--- Player:GetPreferredCarryAngles
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param of Entity 
function GetPreferredCarryAngles(of) end

--- Player:GetPressedWidget
-- @usage shared
-- Returns the widget entity the player is using.
--
-- @return Entity The pressed widget.
function GetPressedWidget() end

--- Player:GetPunchAngle
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Player:GetViewPunchAngles instead.
-- @return Angle The punch angle
function GetPunchAngle() end

--- Player:GetRagdollEntity
-- @usage shared
-- Returns players death ragdoll
--
-- @return Entity The ragdoll
function GetRagdollEntity() end

--- Player:GetRenderAngles
-- @usage shared
-- Returns the render angles for the player.
--
-- @return Angle The render angles of the player. Only yaw part of the angle seems to be present.
function GetRenderAngles() end

--- Player:GetRunSpeed
-- @usage shared
-- Returns the amount of speed the player runs at.
--
-- @return number runspeed
function GetRunSpeed() end

--- Player:GetShootPos
-- @usage shared
-- Returns the position of a Player's view
--
-- @return Vector aim pos
function GetShootPos() end

--- Player:GetStepSize
-- @usage shared
-- Returns the maximum height player can step onto.
--
-- @return number The maximum height player can get up onto without jumping, in hammer units.
function GetStepSize() end

--- Player:GetTimeoutSeconds
-- @usage server
-- Returns the number of seconds that the player has been timing out for. You can check if a player is timing out with Player:IsTimingOut.
--
-- @return number Timeout seconds.
function GetTimeoutSeconds() end

--- Player:GetTool
-- @usage shared
-- Returns TOOL table of players current tool, or of the one specified.
--
-- @param  mode=nil string  Classname of the tool to retrieve. ( Filename of the tool in gmod_tool/stools/ )
-- @return table TOOL table
function GetTool( mode) end

--- Player:GetUnDuckSpeed
-- @usage shared
-- Returns a player's unduck speed (in seconds)
--
-- @return number unduck speed
function GetUnDuckSpeed() end

--- Player:GetUserGroup
-- @usage shared
-- Returns the player's user group.
--
-- @return string The user group of the player.
function GetUserGroup() end

--- Player:GetVehicle
-- @usage shared
-- Gets the vehicle the player is driving, returns NULL ENTITY if the player is not driving.
--
-- @return Vehicle vehicle
function GetVehicle() end

--- Player:GetViewEntity
-- @usage shared
-- Returns the entity the player is using to see from (such as the player itself, the camera, or another entity).
--
-- @return Entity ent
function GetViewEntity() end

--- Player:GetViewModel
-- @usage shared
-- Returns the player's view model entity by the index.
--Each player has 3 view models by default, but only the first one is used.
--
-- @param  index=0 number  optional index of the view model to return, can range from 0 to 2
-- @return Entity The view model entity
function GetViewModel( index) end

--- Player:GetViewOffset
-- @usage shared
-- Returns the view offset of the player which equals the difference between the players actual position and their view.
--
-- @return Vector New view offset, must be local vector to players Entity:GetPos
function GetViewOffset() end

--- Player:GetViewOffsetDucked
-- @usage shared
-- Returns the view offset of the player which equals the difference between the players actual position and their view when ducked.
--
-- @return Vector New crouching view offset, must be local vector to players Entity:GetPos
function GetViewOffsetDucked() end

--- Player:GetViewPunchAngles
-- @usage shared
-- Returns players screen punch effect angle.
--
-- @return Angle The punch angle
function GetViewPunchAngles() end

--- Player:GetWalkSpeed
-- @usage shared
-- Returns a player's walk speed
--
-- @return number walk speed
function GetWalkSpeed() end

--- Player:GetWeapon
-- @usage shared
-- Returns the weapon for the specified class
--
-- @param  className string  Class name of weapon
-- @return Weapon The weapon for the specified class.
function GetWeapon( className) end

--- Player:GetWeaponColor
-- @usage shared
-- Returns a player's weapon color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
--
-- @return Vector color
function GetWeaponColor() end

--- Player:GetWeapons
-- @usage shared
-- Returns a table of the player's weapons.
--
-- @return table All the weapons the player currently has.
function GetWeapons() end

--- Player:Give
-- @usage server
-- Give the player a weapon
--
-- @param  weaponClassName string  Class name of weapon to give the player
-- @param  bNoAmmo=false boolean  Next Update ChangeThis feature is only available in the next update.Set to true to not give any ammo on weapon spawn. ( Empty clip AND no additional reserve ammo is given )
-- @return Weapon The weapon given to the player
function Give( weaponClassName,  bNoAmmo) end

--- Player:GiveAmmo
-- @usage server
-- Gives ammo to a player
--
-- @param  amount number  Amount of ammo
-- @param  type string  Type of ammo. This can also be a number for ammo ID, useful for custom ammo types.  You can find a list of default ammo types here.
-- @param  hidePopup boolean  Hide display popup when giving the ammo
-- @return number Ammo given.
function GiveAmmo( amount,  type,  hidePopup) end

--- Player:GodDisable
-- @usage server
-- Disables god mode on the player.
--
function GodDisable() end

--- Player:GodEnable
-- @usage server
-- Enables god mode on the player.
--
function GodEnable() end

--- Player:HasGodMode
-- @usage shared
-- Returns whether the player has god mode or not, contolled by Player:GodEnable and Player:GodDisable.
--
-- @return boolean Whether the player has god mode or not.
function HasGodMode() end

--- Player:HasWeapon
-- @usage shared
-- Returns if the player has the specified weapon
--
-- @param  className string  Class name of the weapon
-- @return boolean True if the player has the weapon
function HasWeapon( className) end

--- Player:InVehicle
-- @usage shared
-- Returns if the player is in a vehicle
--
-- @return boolean Whether the player is in a vehicle.
function InVehicle() end

--- Player:IPAddress
-- @usage server
-- Returns the player's IP address and connection port in ip:port form
--
-- @return string The player's IP address and connection port
function IPAddress() end

--- Player:IsAdmin
-- @usage shared
-- Returns whether the player is an admin or not
--
-- @return boolean True if the player is an admin
function IsAdmin() end

--- Player:IsBot
-- @usage shared
-- Returns if the player is an bot or not
--
-- @return boolean True if the player is a bot.
function IsBot() end

--- Player:IsConnected
-- @usage server
-- Returns true from the point when the player is sending client info but not fully in the game until they disconnect.
--
-- @return boolean isConnected
function IsConnected() end

--- Player:IsDrivingEntity
-- @usage shared
-- Used to find out if a player is currently 'driving' an entity (by which we mean 'right click > drive' ).
--
-- @return boolean A value representing whether or not the player is 'driving' an entity.
function IsDrivingEntity() end

--- Player:IsFrozen
-- @usage shared
-- Returns whether the players movement is currently frozen, contolled by Player:Freeze.
--
-- @return boolean Whether the players movement is currently frozen or not.
function IsFrozen() end

--- Player:IsFullyAuthenticated
-- @usage server
-- Returns whether the player identity was confirmed by the steam network.
--
-- @return boolean isAuthenticated
function IsFullyAuthenticated() end

--- Player:IsListenServerHost
-- @usage server
-- Returns if a player is the host of the current session.
--
-- @return boolean True if the player is the listen server host, false otherwise.
function IsListenServerHost() end

--- Player:IsMuted
-- @usage client
-- Returns whether or not the player is muted locally.
--
-- @return boolean isMuted
function IsMuted() end

--- Player:IsPlayingTaunt
-- @usage shared
-- Returns true if the player is playing a taunt.
--
-- @return boolean Whether the player is playing a taunt.
function IsPlayingTaunt() end

--- Player:IsSpeaking
-- @usage client
-- Returns whenever the player is heard by the local player.
--
-- @return boolean isSpeaking
function IsSpeaking() end

--- Player:IsSuitEquipped
-- @usage shared
-- Returns whenever the player is equipped with the suit item.
--
-- @return boolean Is the suit equipped or not.
function IsSuitEquipped() end

--- Player:IsSuperAdmin
-- @usage shared
-- Returns whether the player is a superadmin.
--
-- @return boolean True if the player is a superadmin.
function IsSuperAdmin() end

--- Player:IsTimingOut
-- @usage server
-- Returns true if the player is timing out (i.e. is losing connection), false otherwise.
--
-- @return boolean isTimingOut
function IsTimingOut() end

--- Player:IsTyping
-- @usage shared
-- Returns whether the player is typing in their chat.
--
-- @return boolean Whether the player is typing in their chat or not.
function IsTyping() end

--- Player:IsUserGroup
-- @usage shared
-- Returns true/false if the player is in specified group or not.
--
-- @param  groupname string  Group to check the player for.
-- @return boolean isInUserGroup
function IsUserGroup( groupname) end

--- Player:IsVoiceAudible
-- @usage client
-- Returns if the player can be heard by the local player.
--
-- @return boolean isAudible
function IsVoiceAudible() end

--- Player:IsWorldClicking
-- @usage shared
-- Returns if the player is in the context menu.
--
-- @return boolean Is the player world clicking or not.
function IsWorldClicking() end

--- Player:KeyDown
-- @usage shared
-- Gets whether a key is down
--
-- @param  key number  The key, see IN_ Enums
-- @return boolean isDown
function KeyDown( key) end

--- Player:KeyDownLast
-- @usage shared
-- Gets whether a key was down one tick ago.
--
-- @param  key number  The key, see IN_ Enums
-- @return boolean Is key down
function KeyDownLast( key) end

--- Player:KeyPressed
-- @usage shared
-- Gets whether a key was just pressed this tick
--
-- @param  key number  Corresponds to an IN_ Enums
-- @return boolean Was pressed or not
function KeyPressed( key) end

--- Player:KeyReleased
-- @usage shared
-- Gets whether a key was just released this tick
--
-- @param  key number  The key, see IN_ Enums
-- @return boolean Was released or not
function KeyReleased( key) end

--- Player:Kick
-- @usage server
-- Kicks the player from the server.
--
-- @param  reason="No reason given" string  Reason to show for disconnection. Only the first ~243 bytes are shown in the disconnect message box.
function Kick( reason) end

--- Player:Kill
-- @usage server
-- Kills a player and calls GM:PlayerDeath.
--
function Kill() end

--- Player:KillSilent
-- @usage server
-- Kills a player without notifying the rest of the server.
--
function KillSilent() end

--- Player:LagCompensation
-- @usage shared
-- This allows the server to mitigate the lag of the player by moving back all the entities that can be lag compensated to the time the player attacked with his weapon.
--
-- @param  lagCompensation boolean  The state of the lag compensation , true to enable and false to disable.
function LagCompensation( lagCompensation) end

--- Player:LastHitGroup
-- @usage server
-- Returns the hitgroup where the player was last hit.
--
-- @return number Hitgroup, see HITGROUP_ Enums
function LastHitGroup() end

--- Player:LimitHit
-- @usage shared
-- Shows "limit hit" notification in sandbox.
--
-- @param  type string  Type of hit limit
function LimitHit( type) end

--- Player:Lock
-- @usage server
-- Stops a player from using any inputs, such as moving and shooting. Similar to Player:Freeze but the player remains frozen/locked after death.
--
function Lock() end

--- Player:MotionSensorPos
-- @usage shared
-- Returns the position of a Kinect bone.
--
-- @param  bone number  Bone to get the position of. Must be from 0 to 19.
-- @return Vector Position of the bone.
function MotionSensorPos( bone) end

--- Player:Name
-- @usage shared
-- Returns the players name. Identical to Player:Nick and Player:GetName
--
-- @return string name
function Name() end

--- Player:Nick
-- @usage shared
-- Returns the player's nickname
--
-- @return string nickname
function Nick() end

--- Player:PacketLoss
-- @usage server
-- Returns the packet loss of the client. It is not networked so it only returns 0 when run clientside.
--
-- @return number name=packetsLost
function PacketLoss() end

--- Player:PhysgunUnfreeze
-- @usage shared
-- Unfreezes the props player is looking at. This is essentially the same as pressing reload with the physics gun, including double press for unfreeze all.
--
-- @return number Number of props unfrozen.
function PhysgunUnfreeze() end

--- Player:PickupObject
-- @usage server
-- This makes the player hold ( same as pressing E on a small prop ) the provided entity.
--
-- @param  entity Entity  Entity to pick up.
function PickupObject( entity) end

--- Player:Ping
-- @usage shared
-- Returns the player's ping to server.
--
-- @return number The player's ping.
function Ping() end

--- Player:PlayStepSound
-- @usage server
-- Plays the correct step sound according to what the player is staying on.
--
-- @param  volume number  Volume for the sound, in range from 0 to 1
function PlayStepSound( volume) end

--- Player:PrintMessage
-- @usage shared
-- Displays a message either in their chat, console, or center of the screen. See also PrintMessage.
--
-- @param  type number  Which type of message should be sent to the player (HUD_ Enums)
-- @param  message string  Message to be sent to the player
function PrintMessage( type,  message) end

--- Player:RemoveAllAmmo
-- @usage server
-- Removes all ammo from a certain player
--
function RemoveAllAmmo() end

--- Player:RemoveAllItems
-- @usage server
-- Removes all weapons and ammonition from the player.
--
function RemoveAllItems() end

--- Player:RemoveAmmo
-- @usage shared
-- Removes the amount of the specified ammo from the player.
--
-- @param  ammoCount number  The amount of ammunition to remove.
-- @param  ammoName string  The name of the ammunition to remove from. This can also be a number ammoID.
function RemoveAmmo( ammoCount,  ammoName) end

--- Player:RemovePData
-- @usage shared
-- Deletes a key from a player's data
--
-- @param  key any  Key to remove
-- @return boolean true is succeeded, false otherwise
function RemovePData( key) end

--- Player:RemoveSuit
-- @usage server
-- Strips the player's suit item.
--
function RemoveSuit() end

--- Player:ResetHull
-- @usage shared
-- Resets both normal and duck hulls to their default values.
--
function ResetHull() end

--- Player:Say
-- @usage server
-- Forces the player to say whatever the first argument is. Works on bots too.
--
-- @param  text string  The text to force the player to say.
-- @param  teamOnly=false boolean  Whether to send this message to our own team only.
function Say( text,  teamOnly) end

--- Player:ScreenFade
-- @usage server
-- Fades the screen
--
-- @param  Flags number  Fade flags defined with SCREENFADE_ Enums.
-- @param  Color=color_white number  The color of the screenfade
-- @param  FadeTime number  Fade(in/out) effect time
-- @param  FadeHold number  Fade hold time
function ScreenFade( Flags,  Color,  FadeTime,  FadeHold) end

--- Player:SelectWeapon
-- @usage server
-- Sets the active weapon of the player by its class name.
--
-- @param  className string  The class name of the weapon to switch to.The player must already have this weapon. You can use Player:Give if not.
function SelectWeapon( className) end

--- Player:SendHint
-- @usage server
-- Sends a hint to a player.
--
-- @param  name string  Name/class/index of the hint. The text of the hint will contain this value. ( "#Hint_" .. name ) An example is PhysgunFreeze.
-- @param  delay number  Delay in seconds before showing the hint
function SendHint( name,  delay) end

--- Player:SendLua
-- @usage server
-- Executes a simple Lua string on the player.
--
-- @param  script string  The script to execute.
function SendLua( script) end

--- Player:SetActiveWeapon
-- @usage server
-- Sets the player's active weapon.
--
-- @param  weapon Weapon  The weapon to equip
function SetActiveWeapon( weapon) end

--- Player:SetAllowFullRotation
-- @usage shared
-- Set if the players' model is allowed to rotate around the pitch and roll axis.
--
-- @param  Allowed boolean  Allowed to rotate
function SetAllowFullRotation( Allowed) end

--- Player:SetAllowWeaponsInVehicle
-- @usage server
-- Allows player to use his weapons in a vehicle. You need to call this before entering a vehicle.
--
-- @param  allow boolean  Show we allow player to use his weapons in a vehicle or not.
function SetAllowWeaponsInVehicle( allow) end

--- Player:SetAmmo
-- @usage shared
-- Sets the amount of of the specified ammo for the player.
--
-- @param  ammoCount number  The amount of ammunition to set.
-- @param  ammoType any  The ammunition type. Can be either number ammo ID or string ammo name.
function SetAmmo( ammoCount,  ammoType) end

--- Player:SetArmor
-- @usage server
-- Sets the player armor to the argument.
--
-- @param  Amount number  The amount that the player armor is going to be set to.
function SetArmor( Amount) end

--- Player:SetAvoidPlayers
-- @usage shared
-- Pushes the player away from another player whenever it's inside the other players bounding box.
--
-- @param  avoidPlayers boolean  Avoid or not avoid.
function SetAvoidPlayers( avoidPlayers) end

--- Player:SetCanWalk
-- @usage shared
-- Set if the player should be allowed to walk using the (default) alt key.
--
-- @param  abletowalk boolean  True allows the player to walk.
function SetCanWalk( abletowalk) end

--- Player:SetCanZoom
-- @usage server
-- Sets whether the player can use the HL2 suit zoom ("+zoom" bind) or not.
--
-- @param  canZoom boolean  Whether to make the player able or unable to zoom.
function SetCanZoom( canZoom) end

--- Player:SetClassID
-- @usage shared
-- Sets the player's class id.
--
-- @param  classID number  The class id the player is being set with.
function SetClassID( classID) end

--- Player:SetCrouchedWalkSpeed
-- @usage shared
-- Sets the crouched walk speed multiplier.
--
-- @param  speed number  The walk speed multiplier that crouch speed should be.
function SetCrouchedWalkSpeed( speed) end

--- Player:SetCurrentViewOffset
-- @usage shared
-- Sets the actual view offset which equals the difference between the players actual position and their view when standing.
--
-- @param  viewOffset Vector  The new view offset.
function SetCurrentViewOffset( viewOffset) end

--- Player:SetDeaths
-- @usage server
-- Sets a player's death count
--
-- @param  deathcount number  Number of deaths (positive or negative)
function SetDeaths( deathcount) end

--- Player:SetDrivingEntity
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  drivingEntity=NULL Entity  The entity the player should drive.
-- @param  drivingMode number  The driving mode index.
function SetDrivingEntity( drivingEntity,  drivingMode) end

--- Player:SetDSP
-- @usage shared
-- Applies the specified sound filter to the player.
--
-- @param  soundFilter number  The index of the sound filter to apply.  Pick from the list of DSP's.
-- @param  fastReset boolean  If set to true the sound filter will be removed faster.
function SetDSP( soundFilter,  fastReset) end

--- Player:SetDuckSpeed
-- @usage shared
-- Sets how quickly a player ducks.
--
-- @param  duckSpeed number  How quickly the player will duck.
function SetDuckSpeed( duckSpeed) end

--- Player:SetEyeAngles
-- @usage shared
-- Sets the angle of the player's view (may rotate body too if angular difference is large)
--
-- @param  ang Angle  Angle to set the view to
function SetEyeAngles( ang) end

--- Player:SetFOV
-- @usage shared
-- Set a player's FOV (Field Of View) over a certain amount of time.
--
-- @param  fov number  the angle of perception (FOV). Set to 0 to return to default user FOV. ( Which is ranging from 75 to 90, depending on user settings )
-- @param  time number  the time it takes to transition to the FOV expressed in a floating point.
function SetFOV( fov,  time) end

--- Player:SetFrags
-- @usage server
-- Sets a player's frags (kills)
--
-- @param  fragcount number  Number of frags (positive or negative)
function SetFrags( fragcount) end

--- Player:SetHands
-- @usage shared
-- Sets the hands entity of a player.
--
-- @param  hands Entity  The hands entity to set
function SetHands( hands) end

--- Player:SetHoveredWidget
-- @usage shared
-- Sets the widget that is currently hovered by the player's mouse.
--
-- @param  widget=NULL Entity  The widget entity that the player is hovering.
function SetHoveredWidget( widget) end

--- Player:SetHull
-- @usage shared
-- Sets the mins and maxs of the AABB of the players collision.
--
-- @param  hullMins Vector  The min coordinates of the hull.
-- @param  hullMaxs Vector  The max coordinates of the hull.
function SetHull( hullMins,  hullMaxs) end

--- Player:SetHullDuck
-- @usage shared
-- Sets the mins and maxs of the AABB of the players collision when ducked.
--
-- @param  hullMins Vector  The min coordinates of the hull.
-- @param  hullMaxs Vector  The max coordinates of the hull.
function SetHullDuck( hullMins,  hullMaxs) end

--- Player:SetJumpPower
-- @usage shared
-- Sets the jump power, eg. the velocity the player will applied to when he jumps.
--
-- @param  jumpPower number  The new jump velocity.
function SetJumpPower( jumpPower) end

--- Player:SetLaggedMovementValue
-- @usage server
-- Slows down the player movement simulation by the timescale, this is used internally in the HL2 weapon stripping sequence.
--
-- @param  timescale number  The timescale multiplier.
function SetLaggedMovementValue( timescale) end

--- Player:SetMaxSpeed
-- @usage shared
-- Sets the maximum speed which the player can move at.
--
-- @param  walkSpeed number  The maximum speed.
function SetMaxSpeed( walkSpeed) end

--- Player:SetMuted
-- @usage client
-- Sets if the player should be muted locally.
--
-- @param  mute boolean  Mute or unmute.
function SetMuted( mute) end

--- Player:SetNoCollideWithTeammates
-- @usage server
-- Sets whenever the player should not collide with their teammates.
--
-- @param  shouldNotCollide boolean  True to disable, false to enable collission.
function SetNoCollideWithTeammates( shouldNotCollide) end

--- Player:SetNoTarget
-- @usage server
-- Sets the players visibility towards NPCs.
--
-- @param  visibility boolean  The visibility.
function SetNoTarget( visibility) end

--- Player:SetObserverMode
-- @usage shared
-- Sets the players observer mode.
--
-- @param  observeMode number  Observe mode using OBS_MODE_ Enums.
function SetObserverMode( observeMode) end

--- Player:SetPData
-- @usage shared
-- Sets a player's PData from the server's or client's SQL database ( sv.db and cl.db respectively ), It is not networked!
--
-- @param  key any  Name of the PData key
-- @param  value any  Value to write to the key (must be an SQL valid data type, such as a string or integer)
-- @return boolean Whether the operation was successful or not
function SetPData( key,  value) end

--- Player:SetPlayerColor
-- @usage shared
-- Sets the player model's color. The part of the model that is colored is determined by the model itself, and is different for each model.
--
-- @param  Color Vector  This is the color to be set. The format is Vector(r,g,b), and each color should be between 0 and 1.
function SetPlayerColor( Color) end

--- Player:SetPressedWidget
-- @usage shared
-- Sets the widget that is currently in use by the player's mouse.
--
-- @param  pressedWidget=NULL Entity  The widget the player is currently using.
function SetPressedWidget( pressedWidget) end

--- Player:SetRenderAngles
-- @usage shared
-- Sets the render angles of a player.
--
-- @param  ang Angle  The new render angles to set
function SetRenderAngles( ang) end

--- Player:SetRunSpeed
-- @usage shared
-- Sets the run speed eg. the speed when sprinting.
--
-- @param  runSpeed number  The new run speed.
function SetRunSpeed( runSpeed) end

--- Player:SetStepSize
-- @usage shared
-- Sets the maximum height a player can step onto without jumping.
--
-- @param  stepHeight number  The new maximum height the player can step onto without jumping
function SetStepSize( stepHeight) end

--- Player:SetSuppressPickupNotices
-- @usage shared
-- Sets whenever to suppress the pickup notification for the player.
--
-- @param  doSuppress boolean  Whenever to suppress the notice or not.
function SetSuppressPickupNotices( doSuppress) end

--- Player:SetTeam
-- @usage server
-- Sets the player to the chosen team.
--
-- @param  Team number  The team that the player is being set to.
function SetTeam( Team) end

--- Player:SetUnDuckSpeed
-- @usage shared
-- Sets how quickly a player un-ducks
--
-- @param  UnDuckSpeed number  How quickly the player will un-duck
function SetUnDuckSpeed( UnDuckSpeed) end

--- Player:SetupHands
-- @usage server
-- Sets up the players view model hands. Calls GM:PlayerSetHandsModel to set the model of the hands.
--
-- @param  ent Entity  If the player is spectating an entity, this should be the entity the player is spectating, so we can use its hands model instead.
function SetupHands( ent) end

--- Player:SetUserGroup
-- @usage server
-- Sets the usergroup of the player.
--
-- @param  groupName string  The user group of the player.
function SetUserGroup( groupName) end

--- Player:SetViewEntity
-- @usage server
-- Attaches the players view to the position and angles of the specified entity.
--
-- @param  viewEntity Entity  The entity to attach the player view to.
function SetViewEntity( viewEntity) end

--- Player:SetViewOffset
-- @usage shared
-- Sets the desired view offset which equals the difference between the players actual position and their view when standing.
--
-- @param  viewOffset Vector  The new desired view offset when standing.
function SetViewOffset( viewOffset) end

--- Player:SetViewOffsetDucked
-- @usage shared
-- Sets the desired view offset which equals the difference between the players actual position and their view when crouching.
--
-- @param  viewOffset Vector  The new desired view offset when crouching.
function SetViewOffsetDucked( viewOffset) end

--- Player:SetViewPunchAngles
-- @usage shared
-- Sets client's view punch. See Player:ViewPunch
--
-- @param  punchAngle Angle  The angle to set.
function SetViewPunchAngles( punchAngle) end

--- Player:SetWalkSpeed
-- @usage shared
-- Sets the walk speed eg. the speed when normally walking.
--
-- @param  walkSpeed number  The new walk speed.
function SetWalkSpeed( walkSpeed) end

--- Player:SetWeaponColor
-- @usage shared
-- Sets the player weapon's color. The part of the model that is colored is determined by the model itself, and is different for each model.
--
-- @param  Color Vector  This is the color to be set. The format is Vector(r,g,b), and each color should be between 0 and 1.
function SetWeaponColor( Color) end

--- Player:ShouldDrawLocalPlayer
-- @usage client
-- Polls the engine to request if the player should be drawn at the time the function is called.
--
-- @return boolean shouldDraw
function ShouldDrawLocalPlayer() end

--- Player:ShouldDropWeapon
-- @usage server
-- Sets whether the player's current weapon should drop on death.
--
-- @param  drop boolean  Whether to drop the player's current weapon or not
function ShouldDropWeapon( drop) end

--- Player:ShowProfile
-- @usage client
-- Opens the player steam profile page in the steam overlay browser.
--
function ShowProfile() end

--- Player:SimulateGravGunDrop
-- @usage server
-- Signals the entity that it was dropped by the gravity gun.
--
-- @param  ent Entity  Entity that was dropped.
function SimulateGravGunDrop( ent) end

--- Player:SimulateGravGunPickup
-- @usage server
-- Signals the entity that it was picked up by the gravity gun. This call is only required if you want to simulate the situation of picking up objects.
--
-- @param  ent Entity  The entity picked up
function SimulateGravGunPickup( ent) end

--- Player:Spectate
-- @usage server
-- Sets the spectate mode of the player.
--
-- @param  spectateMode number  Spectate mode, see OBS_MODE_ Enums.
function Spectate( spectateMode) end

--- Player:SpectateEntity
-- @usage server
-- Makes the player spectate the entity
--
-- @param  entity Entity  Entity to spectate.
function SpectateEntity( entity) end

--- Player:SprayDecal
-- @usage server
-- Makes a player spray their decal.
--
-- @param  sprayOrigin Vector  The location to spray from
-- @param  sprayEndPos Vector  The location to spray to
function SprayDecal( sprayOrigin,  sprayEndPos) end

--- Player:SprintDisable
-- @usage server
-- Disables the sprint on the player. Not working! Use Player:SetRunSpeed instead.
--
function SprintDisable() end

--- Player:SprintEnable
-- @usage server
-- Enables the sprint on the player. Not working! Use Player:SetRunSpeed instead.
--
function SprintEnable() end

--- Player:StartSprinting
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function StartSprinting() end

--- Player:StartWalking
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function StartWalking() end

--- Player:SteamID
-- @usage shared
-- Returns the player's SteamID. In singleplayer, this will be STEAM_ID_PENDING serverside.
--
-- @return string SteamID
function SteamID() end

--- Player:SteamID64
-- @usage shared
-- Returns the player's 64bit SteamID aka CommunityID.
--
-- @return string Player's 64bit SteamID aka CommunityID.
function SteamID64() end

--- Player:StopSprinting
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function StopSprinting() end

--- Player:StopWalking
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function StopWalking() end

--- Player:StopZooming
-- @usage server
-- Turns off the zoom mode of the player.
--
function StopZooming() end

--- Player:StripAmmo
-- @usage server
-- Removes all ammo from the player.
--
function StripAmmo() end

--- Player:StripWeapon
-- @usage server
-- Removes the specified weapon class from a certain player
--
-- @param  weapon string  The weapon class to remove
function StripWeapon( weapon) end

--- Player:StripWeapons
-- @usage server
-- Removes all weapons from a certain player
--
function StripWeapons() end

--- Player:SuppressHint
-- @usage server
-- Prevents a hint from showing up.
--
-- @param  name string  Hint name/class/index to prevent from showing up
function SuppressHint( name) end

--- Player:SwitchToDefaultWeapon
-- @usage server
-- Attempts to switch the player weapon to the one specified in the "cl_defaultweapon" convar, if the player does not own the specified weapon nothing will happen.
--
function SwitchToDefaultWeapon() end

--- Player:Team
-- @usage shared
-- Returns the player's team ID.
--
-- @return number The player's team's index number, as in the TEAM_ Enums or a custom team defined in team.SetUp.
function Team() end

--- Player:TimeConnected
-- @usage server
-- Returns the time in second since the player connected.
--
-- @return number connectTime
function TimeConnected() end

--- Player:TraceHullAttack
-- @usage server
-- Performs a trace hull and applies damage to the entities hit, returns the first entity hit.
--
-- @param  startPos Vector  The start position of the hull trace.
-- @param  endPos Vector  The end position of the hull trace.
-- @param  mins Vector  The minimum coordinates of the hull.
-- @param  maxs Vector  The maximum coordinates of the hull.
-- @param  damage number  The damage to be applied.
-- @param  damageFlags Vector  Bitflag specifying the damage type, see DMG_ Enums.
-- @param  damageForce number  The force to be applied to the hit object.
-- @param  damageAllNPCs boolean  Whether to apply damage to all hit NPCs or not.
-- @return Entity The hit entity
function TraceHullAttack( startPos,  endPos,  mins,  maxs,  damage,  damageFlags,  damageForce,  damageAllNPCs) end

--- Player:TranslateWeaponActivity
-- @usage shared
-- Translates ACT_ Enums according to the holdtype of players currently held weapon.
--
-- @param  act number  The initial ACT_ Enums
-- @return number Translated ACT_ Enums
function TranslateWeaponActivity( act) end

--- Player:UnfreezePhysicsObjects
-- @usage shared
-- Unfreezes all objects the player has frozen with their Physics Gun. Same as double pressing R while holding Physics Gun.
--
function UnfreezePhysicsObjects() end

--- Player:UniqueID
-- @usage shared
-- 
--
--WARNING
--
--This function has collisions, where more than one player has the same UniqueID. It is highly recommended to use Player:AccountID, Player:SteamID or Player:SteamID64 instead, which are guaranteed to be unique to each player.
--
-- @return number The player's Unique ID
function UniqueID() end

--- Player:UniqueIDTable
-- @usage shared
-- Returns a table that will stay allocated for the specific player between connects until the server shuts down. Note, that this table is not synchronized between client and server.
--
-- @param  key any  Unique table key.
-- @return table The table that contains any info you have put in it.
function UniqueIDTable( key) end

--- Player:UnLock
-- @usage server
-- Unlocks the player movement if locked previously. 
--Will disable godmode for the player if locked previously.
--
function UnLock() end

--- Player:UnSpectate
-- @usage server
-- Stops the player from spectating another entity.
--
function UnSpectate() end

--- Player:UserID
-- @usage shared
-- Returns the player's ID.
--
-- @return number The player's user ID
function UserID() end

--- Player:ViewPunch
-- @usage shared
-- Simulates a push on the client's screen.
--
-- @param  PunchAngle Angle  The angle in which to push the player's screen.
function ViewPunch( PunchAngle) end

--- Player:ViewPunchReset
-- @usage shared
-- Resets the player's view punch ( Player:ViewPunch ) effect back to normal.
--
-- @param  tolerance=0 number  Reset all ViewPunch below this threshold.
function ViewPunchReset( tolerance) end

--- Player:VoiceVolume
-- @usage client
-- Returns the players voice volume as a normal number. Doesn't work on local player unless the voice_loopback convar is set to 1.
--
-- @return number The voice volume.
function VoiceVolume() end

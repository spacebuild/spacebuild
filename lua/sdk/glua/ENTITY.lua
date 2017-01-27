---
-- @description Library Entity
 module("Entity")

--- Entity:Activate
-- @usage shared
-- Activates the entity. This needs to be used on some entities (like constraints) after being spawned.
--
function Activate() end

--- Entity:AddCallback
-- @usage shared
-- Add a callback function to a specific event. This is used instead of hooks to avoid calling empty functions unnecessarily.
--
-- @param  hook string  The hook name to hook onto. See Entity Callbacks
-- @param  func function  The function to call
-- @return number The callback ID that was just added, returns nothing if the passed callback function was invalid or when asking for a non-existent hook.
function AddCallback( hook,  func) end

--- Entity:AddEffects
-- @usage shared
-- Applies an engine effect to an entity.
--
-- @param  effect number  The effect to apply, see EF_ Enums.
function AddEffects( effect) end

--- Entity:AddEFlags
-- @usage shared
-- Adds engine flags.
--
-- @param  flag number  Engine flag to add, see EFL_ Enums
function AddEFlags( flag) end

--- Entity:AddFlags
-- @usage shared
-- Adds flags to the entity.
--
-- @param  flag number  Flag to add, see FL_ Enums
function AddFlags( flag) end

--- Entity:AddGesture
-- @usage server
-- Adds a gesture animation to the entity and plays it.
--See Entity:AddGestureSequence and Entity:AddLayeredSequence for functions that takes sequences instead of ACT_ Enums.
--
-- @param  activity number  The activity to play as the gesture. See ACT_ Enums.
-- @param  autokill=true boolean 
-- @return number Layer ID of the started gesture, used to manipulate the played gesture by other functions.
function AddGesture( activity,  autokill) end

--- Entity:AddGestureSequence
-- @usage server
-- Adds a gesture animation to the entity and plays it.
--See Entity:AddGesture for a function that takes ACT_ Enums.
--See also Entity:AddLayeredSequence.
--
-- @param  sequence number  The sequence ID to play as the gesture. See Entity:LookupSequence.
-- @param  autokill=true boolean 
-- @return number Layer ID of the started gesture, used to manipulate the played gesture by other functions.
function AddGestureSequence( sequence,  autokill) end

--- Entity:AddLayeredSequence
-- @usage server
-- Adds a gesture animation to the entity and plays it.
--See Entity:AddGestureSequence for a function that doesn't take priority.
--See Entity:AddGesture for a function that takes ACT_ Enums.
--
-- @param  sequence number  The sequence ID to play as the gesture. See Entity:LookupSequence.
-- @param  priority number 
-- @return number Layer ID of created layer
function AddLayeredSequence( sequence,  priority) end

--- Entity:AddSolidFlags
-- @usage shared
-- Adds solid flag(s) to the entity.
--
-- @param  flags number  The flag(s) to apply, see FSOLID_ Enums.
function AddSolidFlags( flags) end

--- Entity:AddToMotionController
-- @usage shared
-- Adds a PhysObject to the entity's motion controller so that ENTITY:PhysicsSimulate will be called for given PhysObject as well.
--
-- @param  physObj PhysObj  The PhysObj to add to the motion controller.
function AddToMotionController( physObj) end

--- Entity:AlignAngles
-- @usage shared
-- Returns an angle based on the ones inputted that you can use to align an object.
--
-- @param  from Angle  The angle you want to align from
-- @param  to Angle  The angle you want to align to
-- @return Angle The resulting aligned angle
function AlignAngles( from,  to) end

--- Entity:BecomeRagdollOnClient
-- @usage client
-- Spawns a clientside ragdoll for the entity, positioning it in place of the original entity, and makes the entity invisible. It doesn't preserve flex values (face posing) as CSRagdolls don't support flex.
--
-- @return CSEnt The created ragdoll.
function BecomeRagdollOnClient() end

--- Entity:Blocked
-- @usage server
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  entity Entity  The entity that is blocking us
function Blocked( entity) end

--- Entity:BodyTarget
-- @usage server
-- Returns a centered vector of this entity, NPCs use this internally to aim at their targets.
--
-- @param  origin Vector  The vector of where the the attack comes from.
-- @param  noisy=false boolean  Decides if it should return the centered vector with a random offset to it.
-- @return Vector The centered vector.
function BodyTarget( origin,  noisy) end

--- Entity:BoneHasFlag
-- @usage shared
-- Returns whether the entity's bone has the flag or not.
--
-- @param  boneID number  Bone ID to test flag of.
-- @param  flag number  The flag to test, see BONE_ Enums
-- @return boolean Whether the bone has that flag or not
function BoneHasFlag( boneID,  flag) end

--- Entity:BoneLength
-- @usage shared
-- This function takes the boneID and returns the length of it in an unrounded decimal
--
-- @param  boneID number  The ID of the bone you want the length of. You may want to get the length of the next bone ( boneID + 1 ) for decent results
-- @return number The length of the bone
function BoneLength( boneID) end

--- Entity:BoundingRadius
-- @usage shared
-- Returns the distance between the center of the bounding box and the furthest bounding box corner.
--
-- @return number The radius of the bounding box.
function BoundingRadius() end

--- Entity:CallOnRemove
-- @usage shared
-- Causes a specified function to be run if the entity is removed by any means.
--
-- @param  identifier string  Identifier of the function within CallOnRemove
-- @param  removeFunc function  Function to be called on remove
-- @param  argn... vararg  Optional arguments to pass to removeFunc. Do note that the first argument passed to the function will always be the entity being removed, and the arguments passed on here start after that.
function CallOnRemove( identifier,  removeFunc,  argn...) end

--- Entity:ClearPoseParameters
-- @usage shared
-- Resets all pose parameters such as aim_yaw, aim_pitch and rotation.
--
function ClearPoseParameters() end

--- Entity:CollisionRulesChanged
-- @usage shared
-- Declares that the collision rules of the entity have changed, and subsequent calls for GM:ShouldCollide with this entity may return a different value than they did previously.
--
function CollisionRulesChanged() end

--- Entity:CreatedByMap
-- @usage server
-- Returns whether the entity was created by map or not.
--
-- @return boolean Is created by map?
function CreatedByMap() end

--- Entity:CreateParticleEffect
-- @usage client
-- Creates a clientside particle system attached to the entity.
--
-- @param  particle string  The particle name to create
-- @param  attachment number  Attachment ID to attach the particle to
-- @param  options=nil table  A table of tables ( IDs 1 to 64 ) having the following structure:   number attachtype - The particle attach type. See PATTACH_ Enums. Default: PATTACH_ABSORIGIN  Entity entity - The parent entity? Default: NULL  Vector position - The offset position for given control point. Default: nil
-- @return CNewParticleEffect The created particle system.
function CreateParticleEffect( particle,  attachment,  options) end

--- Entity:CreateShadow
-- @usage shared
-- Draws the shadow of an entity.
--
function CreateShadow() end

--- Entity:DeleteOnRemove
-- @usage server
-- Whenever the entity is removed, entityToRemove will be removed also.
--
-- @param  entityToRemove Entity  The entity to be removed
function DeleteOnRemove( entityToRemove) end

--- Entity:DestroyShadow
-- @usage client
-- Removes the shadow for the entity.
--
function DestroyShadow() end

--- Entity:DisableMatrix
-- @usage client
-- Disables an active matrix.
--
-- @param  matrixType string  The name of the matrix type to disable.  The only known matrix type is "RenderMultiply".
function DisableMatrix( matrixType) end

--- Entity:DispatchTraceAttack
-- @usage shared
-- Performs a trace attack.
--
-- @param  damageInfo CTakeDamageInfo  The damage to apply.
-- @param  traceRes table  Trace result to use to deal damage. See TraceResult structure
-- @param  dir=traceRes.HitNormal Vector  Direction of the attack.
function DispatchTraceAttack( damageInfo,  traceRes,  dir) end

--- Entity:DontDeleteOnRemove
-- @usage server
-- This removes the argument entity from an ent's list of entities to 'delete on remove'
--
-- @param  entityToUnremove Entity  The entity to be removed from the list of entities to delete
function DontDeleteOnRemove( entityToUnremove) end

--- Entity:DrawModel
-- @usage client
-- Draws the entity or model.
--
function DrawModel() end

--- Entity:DrawShadow
-- @usage shared
-- Sets whether an entity's shadow should be drawn.
--
-- @param  shouldDraw boolean  True to enable, false to disable shadow drawing.
function DrawShadow( shouldDraw) end

--- Entity:DropToFloor
-- @usage server
-- Move an entity down until it collides with something.
--
function DropToFloor() end

--- Entity:DTVar
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  Type string  The type of the DTVar being set up. It can be one of the following: 'Int', 'Float', 'Vector', 'Angle', 'Bool', 'Entity' or 'String'
-- @param  ID number  The ID of the DTVar. Can be between 0 and 3
-- @param  Name string  Name by which you will refer to DTVar. It must be a valid variable name. (No spaces!)
function DTVar( Type,  ID,  Name) end

--- Entity:EmitSound
-- @usage shared
-- Plays a sound on an entity. If run clientside, the sound will only be heard locally.
--
-- @param  soundName string  The name of the sound to be played.
-- @param  soundLevel=75 number  A modifier for the distance this sound will reach, acceptable range is 0 to 511. 100 means no adjustment to the level. See SNDLVL_ Enums
-- @param  pitchPercent=100 number  The pitch applied to the sound. The acceptable range is from 0 to 255. 100 means the pitch is not changed.
-- @param  volume=1 number  The volume, from 0 to 1.
-- @param  channel=CHAN_AUTO number  The sound channel , see CHAN_ Enums    NOTE  For weapons, the default is CHAN_WEAPON. 
function EmitSound( soundName,  soundLevel,  pitchPercent,  volume,  channel) end

--- Entity:EnableConstraints
-- @usage server
-- Toggles the constraints of this ragdoll entity on and off.
--
-- @param  toggleConstraints boolean  Set to true to enable the constraints and false to disable them.
function EnableConstraints( toggleConstraints) end

--- Entity:EnableCustomCollisions
-- @usage shared
-- Flags an entity as using custom lua defined collisions. Fixes entities having spongy player collisions or not hitting traces, such as after Entity:PhysicsFromMesh
--
-- @param  useCustom boolean  True to flag this entity
function EnableCustomCollisions( useCustom) end

--- Entity:EnableMatrix
-- @usage client
-- Can be used to apply a custom VMatrix to the entity, mostly used for scaling the model by a Vector.
--
-- @param  matrixType string  The name of the matrix type.  The only implemented matrix type is "RenderMultiply".
-- @param  matrix VMatrix  The matrix to apply before drawing the entity.
function EnableMatrix( matrixType,  matrix) end

--- Entity:EntIndex
-- @usage shared
-- Gets the unique entity index of an entity.
--
-- @return number The index of the entity. -1 for clientside-only or serverside-only entities.
function EntIndex() end

--- Entity:Extinguish
-- @usage server
-- Extinguishes the entity if it is on fire.
--Has no effect if called inside EntityTakeDamage (and the attacker is the flame that's hurting the entity)
--
function Extinguish() end

--- Entity:EyeAngles
-- @usage shared
-- Returns the direction a player/npc/ragdoll is looking as a world-oriented angle.
--
-- @return Angle eyeAng
function EyeAngles() end

--- Entity:EyePos
-- @usage shared
-- Returns the position of an Player/NPC's view, or two vectors for ragdolls (one for each eye)
--
-- @return Vector View position of the entity. This will be be position of the first eye for ragdoll.
-- @return Vector For a ragdoll, this is the position of the second eye.
function EyePos() end

--- Entity:FindBodygroupByName
-- @usage shared
-- Searches for bodygroup with given name.
--
-- @param  name string  The bodygroup name to search for.
-- @return number Bodygroup ID, -1 if not found
function FindBodygroupByName( name) end

--- Entity:FindTransitionSequence
-- @usage shared
-- Returns a transition from the given start and end sequence.
--
-- @param  currentSequence number  The currently playing sequence
-- @param  goalSequence number  The goal sequence.
-- @return number The transition sequence, -1 if not available.
function FindTransitionSequence( currentSequence,  goalSequence) end

--- Entity:Fire
-- @usage server
-- Fires an entity's input. You can find inputs for most entities on the Valve Developer Wiki
--
-- @param  input string  The name of the input to fire
-- @param  param="" string  The value to give to the input, can also be a number.
-- @param  delay=0 number  Delay in seconds before firing
function Fire( input,  param,  delay) end

--- Entity:FireBullets
-- @usage shared
-- Fires a bullet.
--
-- @param  bulletInfo table  The bullet data to be used. See the Bullet structure.
-- @param  suppressHostEvents=false boolean  Has the effect of encasing the FireBullets call in SuppressHostEvents, only works in multiplayer.
function FireBullets( bulletInfo,  suppressHostEvents) end

--- Entity:FollowBone
-- @usage shared
-- Makes an entity follow another entity's bone.
--
-- @param  parent=NULL Entity  The entity to follow the bone of. If unset, removes the FollowBone effect.
-- @param  boneid number  The bone to follow
function FollowBone( parent,  boneid) end

--- Entity:ForcePlayerDrop
-- @usage shared
-- Forces the Entity to be dropped, when it is being held by a player's gravitygun or physgun.
--
function ForcePlayerDrop() end

--- Entity:FrameAdvance
-- @usage shared
-- Advances the cycle of an animated entity by the given delta. Since cycle is a value between 0 and 1, delta should be as well.
--
-- @param  delta number  Amount to advance frame by.
function FrameAdvance( delta) end

--- Entity:GetAbsVelocity
-- @usage shared
-- Returns the velocity of the entity, in coordinates relative to the world.
--
-- @return Vector The absolute velocity
function GetAbsVelocity() end

--- Entity:GetAngles
-- @usage shared
-- Gets the angles of given entity.
--
-- @return Angle The angles of the entity.
function GetAngles() end

--- Entity:GetAnimInfo
-- @usage shared
-- Returns a table containing the number of frames, flags, name, and FPS of an entity's animation ID.
--
-- @param  animIndex number  The animation ID to look up
-- @return table Information about the animation
function GetAnimInfo( animIndex) end

--- Entity:GetAnimTime
-- @usage client
-- Returns the last time the entity had an animation update. Returns 0 if the entity doesn't animate.
--
-- @return number The last time the entity had an animation update.
function GetAnimTime() end

--- Entity:GetAttachment
-- @usage shared
-- Gets the orientation and position of the attachment by its ID.
--
-- @param  attachmentId number  The internal ID of the attachment.
-- @return table The angle and position of the attachment. See the AngPos structure. Most notably, the table contains the keys "Ang" and "Pos".
function GetAttachment( attachmentId) end

--- Entity:GetAttachments
-- @usage shared
-- Returns a table containing all attachments of the given entitys model.
--Returns an empty table or nil in case it's model has no attachments.
--
-- @return table Attachment data. See AttachmentData structure.
function GetAttachments() end

--- Entity:GetBaseVelocity
-- @usage shared
-- Returns the base velocity of the entity. "Velocity of the thing we're standing on".
--
-- @return Vector The base velocity
function GetBaseVelocity() end

--- Entity:GetBloodColor
-- @usage server
-- Returns the blood color of this entity. This can be set with Entity:SetBloodColor.
--
-- @return number Color from BLOOD_COLOR_ Enums
function GetBloodColor() end

--- Entity:GetBodygroup
-- @usage shared
-- Gets the exact value for specific bodygroup of given entity.
--
-- @param  id number  The id of bodygroup to get value of. Starts from 0.
-- @return number Current bodygroup. Starts from 0.
function GetBodygroup( id) end

--- Entity:GetBodygroupCount
-- @usage shared
-- Returns the count of possible values for this bodygroup.
--
-- @param  bodygroup number  The ID of bodygroup to retrieve count of.
-- @return number Count of values of passed bodygroup.
function GetBodygroupCount( bodygroup) end

--- Entity:GetBodygroupName
-- @usage shared
-- Gets the name of specific bodygroup for given entity.
--
-- @param  id number  The id of bodygroup to get the name of.
-- @return string The name of the bodygroup
function GetBodygroupName( id) end

--- Entity:GetBodyGroups
-- @usage shared
-- Returns a list of all attachments of the entity.
--
-- @return table List of bodygroups as a table of tables if the entity can have bodygroups. See BodyGroupData structure
function GetBodyGroups() end

--- Entity:GetBoneController
-- @usage shared
-- Returns the value of the bone controller with the specified ID.
--
-- @param  boneID number  ID of the bone controller. Goes from 0 to 3.
-- @return number The value set on the bone controller.
function GetBoneController( boneID) end

--- Entity:GetBoneCount
-- @usage shared
-- Returns the amount of bones in the entity.
--Returns nil for entity types that have no model associated ( such as point entities ) and for ones with invalid models.
--
-- @return number The amount of bones in given entity
function GetBoneCount() end

--- Entity:GetBoneMatrix
-- @usage shared
-- Returns the matrix ( position / rotation transform ) of a given bone entity.
--
-- @param  boneID number  The bone to retrieve matrix of.   Bones clientside and serverside will differ
-- @return VMatrix The matrix
function GetBoneMatrix( boneID) end

--- Entity:GetBoneName
-- @usage shared
-- Returns name of given bone id.
--
-- @param  index number  ID of bone to lookup name of
-- @return string The name of given bone
function GetBoneName( index) end

--- Entity:GetBoneParent
-- @usage shared
-- Returns parent bone of given bone.
--
-- @param  bone number  The bode ID of the bone to get parent of
-- @return number Parent bone ID
function GetBoneParent( bone) end

--- Entity:GetBonePosition
-- @usage shared
-- Returns the position and angle of the given attachment, relative to the world.
--
-- @param  boneIndex number  The bone index of the given attachment. See Entity:LookupBone.
-- @return Vector The bone's position relative to the world.
-- @return Angle The bone's angle relative to the world.
function GetBonePosition( boneIndex) end

--- Entity:GetBrushPlane
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param 3A number 
-- @return Vector 
-- @return Vector 
-- @return number 
function GetBrushPlane(3A) end

--- Entity:GetBrushPlaneCount
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @return number 
function GetBrushPlaneCount() end

--- Entity:GetChildBones
-- @usage shared
-- Returns ids of child bones of given bone.
--
-- @param  boneid number  Bone id to lookup children of
-- @return table A table of bone ids
function GetChildBones( boneid) end

--- Entity:GetChildren
-- @usage shared
-- Gets the children of the entity - that is, every entity whose parent is this entity.
--
-- @return table Children entities
function GetChildren() end

--- Entity:GetClass
-- @usage shared
-- Returns the classname of a entity. This is often the name of the Lua file or folder containing the files for the entity
--
-- @return string The entity's classname
function GetClass() end

--- Entity:GetCollisionBounds
-- @usage shared
-- Returns an entity's collision bounding box. In most cases, this will return the same bounding box as Entity:GetModelBounds unless the entity does not have a physics mesh or it has a PhysObj different from the default.
--
-- @return Vector The minimum vector of the collision bounds
-- @return Vector The maximum vector of the collision bounds
function GetCollisionBounds() end

--- Entity:GetCollisionGroup
-- @usage shared
-- Returns the entity's collision group
--
-- @return number The collision group. See COLLISION_GROUP_ Enums
function GetCollisionGroup() end

--- Entity:GetColor
-- @usage shared
-- Returns the color the entity is set to.
--
-- @return table The color of the entity as a Color structure.
function GetColor() end

--- Entity:GetConstrainedEntities
-- @usage server
-- Returns the two entities involved in a constraint ent
--
-- @return Entity ent1
-- @return Entity ent2
function GetConstrainedEntities() end

--- Entity:GetConstrainedPhysObjects
-- @usage server
-- Returns the two entities physobjects involved in a constraint ent
--
-- @return PhysObj phys1
-- @return PhysObj phys2
function GetConstrainedPhysObjects() end

--- Entity:GetCreationID
-- @usage server
-- Returns entity's creation ID. Unlike Entity:EntIndex or Entity:MapCreationID, it will always increase and old values won't be reused.
--
-- @return number The creation ID
function GetCreationID() end

--- Entity:GetCreationTime
-- @usage shared
-- Returns the time the entity was created on, relative to CurTime.
--
-- @return number The time the entity was created on.
function GetCreationTime() end

--- Entity:GetCreator
-- @usage server
-- Gets the creator of the SENT.
--
-- @return Player The creator
function GetCreator() end

--- Entity:GetCustomCollisionCheck
-- @usage shared
-- Returns whether this entity uses custom collision check set by Entity:SetCustomCollisionCheck.
--
-- @return boolean Whether this entity uses custom collision check or not
function GetCustomCollisionCheck() end

--- Entity:GetCycle
-- @usage shared
-- Returns the frame of the currently played sequence.
--
-- @return number The frame of the currently played sequence
function GetCycle() end

--- Entity:GetDTAngle
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 63.  Specifies what key to grab from datatable.
-- @return Angle Requested angle.
function GetDTAngle( key) end

--- Entity:GetDTBool
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 63.  Specifies what key to grab from datatable.
-- @return boolean Requested boolean.
function GetDTBool( key) end

--- Entity:GetDTEntity
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 63.  Specifies what key to grab from datatable.
-- @return Entity Requested entity.
function GetDTEntity( key) end

--- Entity:GetDTFloat
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 63.  Specifies what key to grab from datatable.
-- @return number Requested float.
function GetDTFloat( key) end

--- Entity:GetDTInt
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 63.  Specifies what key to grab from datatable.
-- @return number Requested integer.
function GetDTInt( key) end

--- Entity:GetDTString
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 3.  Specifies what key to grab from datatable.
-- @return string Requested string.
function GetDTString( key) end

--- Entity:GetDTVector
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 63.  Specifies what key to grab from datatable.
-- @return Vector Requested vector.
function GetDTVector( key) end

--- Entity:GetEffects
-- @usage shared
-- Returns a bit flag of all engine effect flags of the entity.
--
-- @return number Engine effect flags, see EF_ Enums
function GetEffects() end

--- Entity:GetEFlags
-- @usage shared
-- Returns a bit flag of all engine flags of the entity.
--
-- @return number Engine flags, see EFL_ Enums
function GetEFlags() end

--- Entity:GetElasticity
-- @usage shared
-- Returns the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
--
-- @return number elasticity
function GetElasticity() end

--- Entity:GetFlags
-- @usage shared
-- Returns all flags of given entity.
--
-- @return number Flags of given entity as a bitflag, see FL_ Enums
function GetFlags() end

--- Entity:GetFlexBounds
-- @usage shared
-- Returns acceptable value range for the flex.
--
-- @param  flex number  The ID of the flex to look up bounds of
-- @return number The minimum value for this flex
-- @return number The maximum value for this flex
function GetFlexBounds( flex) end

--- Entity:GetFlexIDByName
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  name string  The name of the flex to get the ID of
-- @return number The ID of given flex
function GetFlexIDByName( name) end

--- Entity:GetFlexName
-- @usage shared
-- Returns flex name.
--
-- @param  id number  The flex id to look up name of
-- @return string The flex name
function GetFlexName( id) end

--- Entity:GetFlexNum
-- @usage shared
-- Returns the number of flexes this entity has.
--
-- @return number The number of flexes.
function GetFlexNum() end

--- Entity:GetFlexScale
-- @usage shared
-- Returns the flex scale of the entity.
--
-- @return number The flex scale
function GetFlexScale() end

--- Entity:GetFlexWeight
-- @usage shared
-- Returns current weight ( value ) of the flex.
--
-- @param  flex number  The ID of the flex to get weight of
-- @return number The current weight of the flex
function GetFlexWeight( flex) end

--- Entity:GetForward
-- @usage shared
-- Returns the forward vector of the entity, as a normalized direction vector
--
-- @return Vector forwardDir
function GetForward() end

--- Entity:GetFriction
-- @usage server
-- Returns how much friction an entity has. Entities default to 1 (100%) and can be higher or even negative.
--
-- @return number friction
function GetFriction() end

--- Entity:GetGravity
-- @usage shared
-- Gets the gravity multiplier of the entity.
--
-- @return number gravityMultiplier
function GetGravity() end

--- Entity:GetGroundEntity
-- @usage shared
-- Returns the object the entity is standing on.
--
-- @return Entity The ground entity.
function GetGroundEntity() end

--- Entity:GetGroundSpeedVelocity
-- @usage server
-- Returns the entity's ground speed velocity, which is based on the entity's walk/run speed and/or the ground speed of their sequence ( Entity:GetSequenceGroundSpeed ). Will return an empty Vector if the entity isn't moving on the ground.
--
-- @return Vector The ground speed velocity.
function GetGroundSpeedVelocity() end

--- Entity:GetHitBoxBone
-- @usage shared
-- Gets the bone of a hit box
--
-- @param  hitbox number  The number of the hit box
-- @param  group number  The number of the hit box group
-- @return number The number of the bone
function GetHitBoxBone( hitbox,  group) end

--- Entity:GetHitboxBone
-- @usage server
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetHitBoxBone instead.
function GetHitboxBone() end

--- Entity:GetHitBoxBounds
-- @usage shared
-- Gets the bounding box of a hit box
--
-- @param  hitbox number  The number of the hitbox
-- @param  group number  The group of the hitbox
-- @return Vector hit box mins
-- @return Vector hit box maxs
function GetHitBoxBounds( hitbox,  group) end

--- Entity:GetHitBoxCount
-- @usage shared
-- Gets how many hit boxes are in a given hit box group
--
-- @param  group number  The number of the hit box group
-- @return number The number of hit boxes.
function GetHitBoxCount( group) end

--- Entity:GetHitBoxGroupCount
-- @usage shared
-- Returns the number of hit box groups that an entity has.
--
-- @return number number of hit box groups
function GetHitBoxGroupCount() end

--- Entity:GetHitboxSet
-- @usage shared
-- Returns entitys current hit box set
--
-- @return number The current hit box id
-- @return string The current hit boxes name
function GetHitboxSet() end

--- Entity:GetHitboxSetCount
-- @usage shared
-- Returns the amount of hitbox sets in the entity.
--
-- @return number The amount of hitbox sets in the entity.
function GetHitboxSetCount() end

--- Entity:GetInternalVariable
-- @usage shared
-- An interface for accessing internal key values on entities.
--This function returns variables created with DEFINE_KEYFIELD in c++ entities.
--
-- @param  VariableName string  Name of variable corresponding to an entity save value.
-- @return any The internal variable value
function GetInternalVariable( VariableName) end

--- Entity:GetKeyValues
-- @usage server
-- Returns a table containing all key values the entity has.
--
-- @return table A table of key values.
function GetKeyValues() end

--- Entity:GetLayerCycle
-- @usage server
-- Returns the animation cycle/frame for given layer.
--
-- @param  layerID number  The Layer ID
-- @return number The animation cycle/frame for given layer.
function GetLayerCycle( layerID) end

--- Entity:GetLayerDuration
-- @usage server
-- Returns the duration of given layer.
--
-- @param  layerID number  The Layer ID
-- @return number The duration of the layer
function GetLayerDuration( layerID) end

--- Entity:GetLayerWeight
-- @usage server
-- Returns the current weight of the layer. See Entity:SetLayerWeight for more information.
--
-- @param  layerID number  The Layer ID
-- @return number The current weight of the layer
function GetLayerWeight( layerID) end

--- Entity:GetLocalAngles
-- @usage shared
-- Returns the rotation of the entity relative to its parent entity.
--
-- @return Angle Relative angle
function GetLocalAngles() end

--- Entity:GetLocalAngularVelocity
-- @usage shared
-- Returns the non-VPhysics angular velocity of the entity relative to its parent entity.
--
-- @return Angle The velocity
function GetLocalAngularVelocity() end

--- Entity:GetLocalPos
-- @usage shared
-- Returns entity's position relative to it's parent.
--
-- @return Vector Relative position
function GetLocalPos() end

--- Entity:GetManipulateBoneAngles
-- @usage shared
-- Gets the entity's angle manipulation of the given bone. This is relative to the default angle, so the angle is zero when unmodified.
--
-- @param  boneID number  The bone's ID
-- @return Angle The entity's angle manipulation of the given bone.
function GetManipulateBoneAngles( boneID) end

--- Entity:GetManipulateBoneJiggle
-- @usage shared
-- Validation required.
--This page contains eventual incorrect information and requires validation.
-- @param  boneID number  The bone ID
-- @return number Returns a value ranging from 0 to 255 depending on the value set with Entity:ManipulateBoneJiggle.
function GetManipulateBoneJiggle( boneID) end

--- Entity:GetManipulateBonePosition
-- @usage shared
-- Gets the entity's position manipulation of the given bone. This is relative to the default position, so it is zero when unmodified.
--
-- @param  boneId number  The bone's ID
-- @return Vector The entity's position manipulation of the given bone.
function GetManipulateBonePosition( boneId) end

--- Entity:GetManipulateBoneScale
-- @usage shared
-- Gets the entity's scale manipulation of the given bone. Normal scale is Vector( 1, 1, 1 )
--
-- @param  boneID number  The bone's ID
-- @return Vector The entity's scale manipulation of the given bone
function GetManipulateBoneScale( boneID) end

--- Entity:GetMaterial
-- @usage shared
-- Returns the material override for this entity.
--
-- @return string material
function GetMaterial() end

--- Entity:GetMaterials
-- @usage shared
-- Returns all materials of the entity's model.
--
-- @return table A table containing full paths to the materials of the model.
function GetMaterials() end

--- Entity:GetMaterialType
-- @usage server
-- Returns the surface index (from MAT_ Enums) of this entity.
--
-- @return number surface index
function GetMaterialType() end

--- Entity:GetMaxHealth
-- @usage shared
-- Returns the max health that the entity was given. It can be set via Entity:SetMaxHealth.
--
-- @return number Max health.
function GetMaxHealth() end

--- Entity:GetModel
-- @usage shared
-- Gets the model of given entity.
--
-- @return string The entity's model.
function GetModel() end

--- Entity:GetModelBounds
-- @usage shared
-- Returns the entity's bounding box. Seems to be the same as calling Entity:OBBMins and Entity:OBBMaxs, however, if the model has been scaled using Entity:SetModelScale, it will return the model's original and unmodified mins and maxs.
--
-- @return Vector The minimum vector of the bounds
-- @return Vector The maximum vector of the bounds
function GetModelBounds() end

--- Entity:GetModelPhysBoneCount
-- @usage client
-- Gets the physics bone count of the entity's model.
--
-- @return number How many physics bones exist on the model.
function GetModelPhysBoneCount() end

--- Entity:GetModelRadius
-- @usage shared
-- Gets the models radius.
--
-- @return number The radius of the model
function GetModelRadius() end

--- Entity:GetModelRenderBounds
-- @usage shared
-- Validation required.
--This page contains eventual incorrect information and requires validation.
-- @return Vector The minimum vector of the bounds
-- @return Vector The maximum vector of the bounds
function GetModelRenderBounds() end

--- Entity:GetModelScale
-- @usage shared
-- Gets the selected entity's model scale.
--
-- @return number Scale of that entity's model.
function GetModelScale() end

--- Entity:GetMomentaryRotButtonPos
-- @usage server
-- Returns the amount a momentary_rot_button entity is turned based on the given Angle turnAngle. 0 meaning completely turned closed, 1 meaning completely turned open.
--
-- @param  turnAngle Angle  The angle of rotation to compare against. Usually should be Entity:GetAngles
-- @return number The amount the momentary_rot_button is turned, ranging from 0 to 1.
function GetMomentaryRotButtonPos( turnAngle) end

--- Entity:GetMoveCollide
-- @usage shared
-- Returns the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
--
-- @return number The move collide type, see MOVECOLLIDE_ Enums
function GetMoveCollide() end

--- Entity:GetMoveParent
-- @usage shared
-- Identical to Entity:GetParent, there's no distinction between parent and movement parent in the engine.
--
-- @return Entity The movement parent of this entity.
function GetMoveParent() end

--- Entity:GetMoveType
-- @usage shared
-- Returns the entity's movetype
--
-- @return number Move type. See MOVETYPE_ Enums
function GetMoveType() end

--- Entity:GetName
-- @usage server
-- Returns the mapping name of this entity.
--
-- @return string The name of the Entity
function GetName() end

--- Entity:GetNetworkAngles
-- @usage client
-- Gets networked angles for entity.
--
-- @return Angle angle
function GetNetworkAngles() end

--- Entity:GetNetworkedAngle
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetNWAngle instead.
-- @param  key string  The key that is associated with the value
-- @param  fallback=Angle( 0, 0, 0 ) Angle  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return Angle The retrieved value
function GetNetworkedAngle( key,  fallback) end

--- Entity:GetNetworkedBool
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetNWBool instead.
-- @param  key string  The key that is associated with the value
-- @param  fallback=false boolean  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return boolean The retrieved value
function GetNetworkedBool( key,  fallback) end

--- Entity:GetNetworkedEntity
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetNWEntity instead.
-- @param  key string  The key that is associated with the value
-- @param  fallback=NULL Entity  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return Entity The retrieved value
function GetNetworkedEntity( key,  fallback) end

--- Entity:GetNetworkedFloat
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetNWFloat instead.
-- @param  key string  The key that is associated with the value
-- @param  fallback=0 number  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return number The retrieved value
function GetNetworkedFloat( key,  fallback) end

--- Entity:GetNetworkedInt
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetNWInt instead.
-- @param  key string  The key that is associated with the value
-- @param  fallback=0 number  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return number The retrieved value
function GetNetworkedInt( key,  fallback) end

--- Entity:GetNetworkedString
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetNWString instead.
-- @param  key string  The key that is associated with the value
-- @param  fallback="" string  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return string The retrieved value
function GetNetworkedString( key,  fallback) end

--- Entity:GetNetworkedVarProxy
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using Entity:GetNWVarProxy instead.
-- @param  name string  The name of the NWVar to get callback of.
-- @return function The callback of given NWVar, if any.
function GetNetworkedVarProxy( name) end

--- Entity:GetNetworkedVarTable
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using Entity:GetNWVarTable instead.
-- @return table Key-Value table of all networked variables.
function GetNetworkedVarTable() end

--- Entity:GetNetworkedVector
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:GetNWVector instead.
-- @param  key string  The key that is associated with the value
-- @param  fallback=Vector( 0, 0, 0 ) Vector  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return Vector The retrieved value
function GetNetworkedVector( key,  fallback) end

--- Entity:GetNetworkOrigin
-- @usage shared
-- Gets networked origin for entity.
--
-- @return Vector origin
function GetNetworkOrigin() end

--- Entity:GetNoDraw
-- @usage shared
-- Returns if the entity's rendering and transmitting has been disabled.
--
-- @return boolean Whether the entity's rendering and transmitting has been disabled.
function GetNoDraw() end

--- Entity:GetNumBodyGroups
-- @usage shared
-- Returns the body group count of the entity.
--
-- @return number Amount of bodygroups the entitys model has
function GetNumBodyGroups() end

--- Entity:GetNumPoseParameters
-- @usage shared
-- Returns the number of pose parameters this entity has.
--
-- @return number Amount of pose parameters the entity has
function GetNumPoseParameters() end

--- Entity:GetNWAngle
-- @usage shared
-- Retrieves a networked angle value at specified index on the entity that is set by Entity:SetNWAngle.
--
-- @param  key string  The key that is associated with the value
-- @param  fallback=Angle( 0, 0, 0 ) Angle  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return Angle The retrieved value
function GetNWAngle( key,  fallback) end

--- Entity:GetNWBool
-- @usage shared
-- Retrieves a networked boolean value at specified index on the entity that is set by Entity:SetNWBool.
--
-- @param  key string  The key that is associated with the value
-- @param  fallback=false boolean  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return boolean The retrieved value
function GetNWBool( key,  fallback) end

--- Entity:GetNWEntity
-- @usage shared
-- Retrieves a networked entity value at specified index on the entity that is set by Entity:SetNWEntity.
--
-- @param  key string  The key that is associated with the value
-- @param  fallback=NULL Entity  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return Entity The retrieved value
function GetNWEntity( key,  fallback) end

--- Entity:GetNWFloat
-- @usage shared
-- Retrieves a networked float value at specified index on the entity that is set by Entity:SetNWFloat.
--
-- @param  key string  The key that is associated with the value
-- @param  fallback=0 number  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return number The retrieved value
function GetNWFloat( key,  fallback) end

--- Entity:GetNWInt
-- @usage shared
-- Retrieves a networked integer (whole number) value that was previously set by Entity:SetNWInt.
--
-- @param  key string  The key that is associated with the value
-- @param  fallback=0 number  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return number The retrieved value
function GetNWInt( key,  fallback) end

--- Entity:GetNWString
-- @usage shared
-- Retrieves a networked string value at specified index on the entity that is set by Entity:SetNWString.
--
-- @param  key string  The key that is associated with the value
-- @param  fallback="" string  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return string The retrieved value
function GetNWString( key,  fallback) end

--- Entity:GetNWVarProxy
-- @usage shared
-- Returns callback function for given NWVar of this entity.
--
-- @param  name string  The name of the NWVar to get callback of.
-- @return function The callback of given NWVar, if any.
function GetNWVarProxy( name) end

--- Entity:GetNWVarTable
-- @usage shared
-- Returns all the networked variables in an entity.
--
-- @return table Key-Value table of all networked variables.
function GetNWVarTable() end

--- Entity:GetNWVector
-- @usage shared
-- Retrieves a networked vector value at specified index on the entity that is set by Entity:SetNWVector.
--
-- @param  key string  The key that is associated with the value
-- @param  fallback=Vector( 0, 0, 0 ) Vector  The value to return if we failed to retrieve the value. ( If it isn't set )
-- @return Vector The retrieved value
function GetNWVector( key,  fallback) end

--- Entity:GetOwner
-- @usage shared
-- Returns the owner entity of this entity. See Entity:SetOwner for more info.
--
-- @return Entity The owner entity of this entity.
function GetOwner() end

--- Entity:GetParent
-- @usage shared
-- Returns the parent entity of this entity.
--
-- @return Entity parentEntity
function GetParent() end

--- Entity:GetParentAttachment
-- @usage shared
-- Returns the attachment index of the entity's parent. Returns 0 if the entity is not parented to a specific attachment or if it isn't parented at all.
--
-- @return number The parented attachment index
function GetParentAttachment() end

--- Entity:GetParentPhysNum
-- @usage shared
-- If the entity is parented to an entity that has a model with multiple physics objects (like a ragdoll), this is used to retrieve what physics object number the entity is parented to on it's parent.
--
-- @return number The physics object id
function GetParentPhysNum() end

--- Entity:GetPersistent
-- @usage shared
-- Returns true if the entity is persistent.
--
-- @return boolean Whether the entity is persistent.
function GetPersistent() end

--- Entity:GetPhysicsAttacker
-- @usage server
-- Returns player who is claiming kills of physics damage the entity deals.
--
-- @param  timeLimit number  The time to check if the entity was still a proper physics attacker.    NOTE  Some entities such as the Combine Ball disregard the time limit and always return the physics attacker. 
-- @return Player The player. If entity that was set is not a player, it will return NULL entity.
function GetPhysicsAttacker( timeLimit) end

--- Entity:GetPhysicsObject
-- @usage shared
-- Returns the entity's physics object, if the entity has physics.
--
-- @return PhysObj The entity's physics object.
function GetPhysicsObject() end

--- Entity:GetPhysicsObjectCount
-- @usage shared
-- Returns the number of physics objects an entity has (usually 1 for non-ragdolls)
--
-- @return number numObjects
function GetPhysicsObjectCount() end

--- Entity:GetPhysicsObjectNum
-- @usage shared
-- Returns a specific physics object from an entity with multiple (ragdolls)
--
-- @param  physNum number  The number corresponding to the physobj to grab. Starts at 0
-- @return PhysObj The physics object
function GetPhysicsObjectNum( physNum) end

--- Entity:GetPlaybackRate
-- @usage shared
-- Returns the playback rate of the main sequence on this entity, with 1.0 being the default speed.
--
-- @return number The playback rate.
function GetPlaybackRate() end

--- Entity:GetPos
-- @usage shared
-- Gets the position of entity in world.
--
-- @return Vector The position of the entity.
function GetPos() end

--- Entity:GetPoseParameter
-- @usage shared
-- Returns the pose parameter value
--
-- @param  name string  Pose parameter name to look up
-- @return number Value of given pose parameter.   NOTE  This value will be from 0 - 1 on client and from minimum range to maximum range on server! (Entity:GetPoseParameterRange) 
function GetPoseParameter( name) end

--- Entity:GetPoseParameterName
-- @usage shared
-- Returns name of given pose parameter
--
-- @param  id number  Id of the pose paremeter
-- @return string Name of given pose parameter
function GetPoseParameterName( id) end

--- Entity:GetPoseParameterRange
-- @usage shared
-- Returns pose parameter range
--
-- @param  id number  Pose parameter ID to look up
-- @return number The minimum value
-- @return number The maximum value
function GetPoseParameterRange( id) end

--- Entity:GetPredictable
-- @usage client
-- Returns whether this entity is predictable or not.
--
-- @return boolean Whether this entity is predictable or not.
function GetPredictable() end

--- Entity:GetRagdollOwner
-- @usage shared
-- Returns the entity which the ragdoll came from. The opposite of Player:GetRagdollEntity.
--
-- @return Entity The entity who owns the ragdoll.
function GetRagdollOwner() end

--- Entity:GetRenderAngles
-- @usage client
-- Returns the entity's render angles, set by Entity:SetRenderAngles in a drawing hook.
--
-- @return Angle The entitys render angles
function GetRenderAngles() end

--- Entity:GetRenderBounds
-- @usage client
-- Returns render bounds of the entity. Can be overridden by Entity:SetRenderBounds.
--
-- @return Vector The minimum vector of the bounds
-- @return Vector The maximum vector of the bounds.
function GetRenderBounds() end

--- Entity:GetRenderFX
-- @usage shared
-- Returns current render FX of the entity.
--
-- @return number The current render FX of the entity. See kRenderFx_ Enums
function GetRenderFX() end

--- Entity:GetRenderGroup
-- @usage client
-- Returns the render group of the entity.
--
-- @return number The render group. See RENDERGROUP_ Enums
function GetRenderGroup() end

--- Entity:GetRenderMode
-- @usage shared
-- Returns the render mode of the entity.
--
-- @return number The render Mode. See RENDERMODE_ Enums
function GetRenderMode() end

--- Entity:GetRenderOrigin
-- @usage client
-- Returns the entity's render origin, set by Entity:SetRenderOrigin in a drawing hook.
--
-- @return Vector The entitys render origin
function GetRenderOrigin() end

--- Entity:GetRight
-- @usage shared
-- Returns the rightward vector of the entity, as a normalized direction vector
--
-- @return Vector rightDir
function GetRight() end

--- Entity:GetRotatedAABB
-- @usage shared
-- Returns the min and max of the entity's axis-aligned bounding box.
--
-- @param  min Vector  Minimum extent of the bounding box.
-- @param  max Vector  Maximum extent of the bounding box.
-- @return Vector Minimum extent of the AABB
-- @return Vector Maximum extent of the AABB
function GetRotatedAABB( min,  max) end

--- Entity:GetSaveTable
-- @usage shared
-- Returns a table of save values for an entity.
--
-- @return table A table containing all save values in key/value format.
function GetSaveTable() end

--- Entity:GetSequence
-- @usage shared
-- Return the index of the model sequence that is currently active for the entity.
--
-- @return number The index of the model sequence.
function GetSequence() end

--- Entity:GetSequenceActivity
-- @usage shared
-- Return activity id out of sequence id. Opposite of Entity:SelectWeightedSequence.
--
-- @param  seq number  The sequence ID
-- @return number The activity ID, ie ACT_ Enums
function GetSequenceActivity( seq) end

--- Entity:GetSequenceActivityName
-- @usage shared
-- Returns the activity name for the given sequence id.
--
-- @param  sequenceId number  The sequence id.
-- @return string The ACT_ Enums as a string, returns "Not Found!" with an invalid sequence and "No model!" when no model is set.
function GetSequenceActivityName( sequenceId) end

--- Entity:GetSequenceCount
-- @usage shared
-- Returns the amount of sequences ( animations ) the entity's model has.
--
-- @return number The amount of sequences ( animations ) the entity's model has.
function GetSequenceCount() end

--- Entity:GetSequenceGroundSpeed
-- @usage shared
-- Returns the ground speed of the entity's sequence.
--
-- @param  sequenceId number  The sequence ID.
-- @return number The ground speed of this sequence.
function GetSequenceGroundSpeed( sequenceId) end

--- Entity:GetSequenceInfo
-- @usage shared
-- Returns a table of information about an entity's sequence.
--
-- @param  sequenceId number  The sequence id of the entity.
-- @return table Table of information about the entity's sequence.
function GetSequenceInfo( sequenceId) end

--- Entity:GetSequenceList
-- @usage shared
-- Returns a list of all sequences ( animations ) the model has.
--
-- @return table The list of all sequences ( animations ) the model has. The indices start with 0!
function GetSequenceList() end

--- Entity:GetSequenceMoveDist
-- @usage server
-- Returns an entity's sequence move distance (the change in position over the course of the entire sequence).
--
-- @param  sequenceId number  The sequence index.
-- @return number The move distance of the sequence.
function GetSequenceMoveDist( sequenceId) end

--- Entity:GetSequenceMoveYaw
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param GJ number 
-- @return number 
function GetSequenceMoveYaw(GJ) end

--- Entity:GetSequenceName
-- @usage shared
-- Return the name of the sequence for the index provided.
--Refer to Entity:GetSequence to find the current active sequence on this entity.
--
-- @param  index number  The index of the sequence to look up.
-- @return string Name of the sequence.
function GetSequenceName( index) end

--- Entity:GetShouldPlayPickupSound
-- @usage shared
-- Returns true or false depending on whether or not the entity plays a physics contact sound when being picked up by a player.
--
-- @return boolean True if it plays the pickup sound, false or nil otherwise.
function GetShouldPlayPickupSound() end

--- Entity:GetShouldServerRagdoll
-- @usage shared
-- Returns if entity should create a server ragdoll on death or a client one.
--
-- @return boolean Returns true if ragdoll will be created on server, false if on client
function GetShouldServerRagdoll() end

--- Entity:GetSkin
-- @usage shared
-- Returns the skin index of the current skin.
--
-- @return number skinIndex
function GetSkin() end

--- Entity:GetSolid
-- @usage shared
-- Returns solid type of an entity.
--
-- @return number The solid type. See the SOLID_ Enums.
function GetSolid() end

--- Entity:GetSolidFlags
-- @usage shared
-- Returns solid flag(s) of an entity.
--
-- @return number The flag(s) of the enrity, see FSOLID_ Enums.
function GetSolidFlags() end

--- Entity:GetSpawnEffect
-- @usage shared
-- Returns if we should show a spawn effect on this entity.
--
-- @return boolean The flag to allow or disallow the spawn effect.
function GetSpawnEffect() end

--- Entity:GetSpawnFlags
-- @usage shared
-- Returns the bitwise spawn flags used by the entity.
--
-- @return number The spawn flags of the entity
function GetSpawnFlags() end

--- Entity:GetSubMaterial
-- @usage shared
-- Returns the material override for the given index.
--
-- @param  index number  The index of the sub material. Starts with 0.
-- @return string The material that overrides this index, if any.
function GetSubMaterial( index) end

--- Entity:GetSubModels
-- @usage shared
-- Returns a list of models included into the entity's model in the .qc file.
--
-- @return table The list of models included into the entity's model in the .qc file.
function GetSubModels() end

--- Entity:GetTable
-- @usage shared
-- Returns the table that contains all values saved within the entity.
--
-- @return table entTable
function GetTable() end

--- Entity:GetTouchTrace
-- @usage shared
-- Returns the last trace used in the collision callbacks such as ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch.
--
-- @return table The TraceResult structure
function GetTouchTrace() end

--- Entity:GetTransmitWithParent
-- @usage shared
-- Returns true if the TransmitWithParent flag is set or not.
--
-- @return boolean Is the TransmitWithParent flag is set or not
function GetTransmitWithParent() end

--- Entity:GetUnFreezable
-- @usage server
-- Returns if the entity is unfreezable, meaning it can't be frozen with the physgun. By default props are freezable, so this function will typically return nil.
--
-- @return boolean True if the entity is unfreezable, false or nil otherwise.
function GetUnFreezable() end

--- Entity:GetUp
-- @usage shared
-- Returns the upward vector of the entity, as a normalized direction vector
--
-- @return Vector upDir
function GetUp() end

--- Entity:GetVar
-- @usage shared
-- Retrieves a value from entitys Entity:GetTable.
--
-- @param  name string  Name of variable to retrieve
-- @param  default any  A default value to fallback to if we couldn't retrieve the value from entity
-- @return any Retrieved value
function GetVar( name,  default) end

--- Entity:GetVelocity
-- @usage shared
-- Returns the directional velocity of the entity.
--
-- @return Vector velocity
function GetVelocity() end

--- Entity:GetWorkshopID
-- @usage server
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
-- @return number The workshop ID
function GetWorkshopID() end

--- Entity:GibBreakClient
-- @usage shared
-- Causes the entity to break into its current models gibs, if it has any.
--
-- @param  force Vector  The force to apply to the created gibs
function GibBreakClient( force) end

--- Entity:GibBreakServer
-- @usage shared
-- Causes the entity to break into its current models gibs, if it has any.
--
-- @param  force Vector  The force to apply to the created gibs
function GibBreakServer( force) end

--- Entity:HasBoneManipulations
-- @usage shared
-- Returns whether or not the entity has a bone which is manipulated using either Entity:ManipulateBonePosition, Entity:ManipulateBoneAngles, or Entity:ManipulateBoneJiggle.
--
-- @return boolean True if the entity has a manipulated bone, false otherwise.
function HasBoneManipulations() end

--- Entity:HasFlexManipulatior
-- @usage shared
-- Returns whether or not the the entity has had flex manipulations performed with Entity:SetFlexWeight or Entity:SetFlexScale.
--
-- @return boolean True if the entity has flex manipulations, false otherwise.
function HasFlexManipulatior() end

--- Entity:HasSpawnFlags
-- @usage shared
-- Returns whether this entity has the specified spawnflags bits set.
--
-- @param  spawnFlags number  The spawnflag bits to check, see SF_ Enums.
-- @return boolean Whether the entity has that spawnflag set or not.
function HasSpawnFlags( spawnFlags) end

--- Entity:HeadTarget
-- @usage server
-- Returns the position of the head of this entity, NPCs use this internally to aim at their targets.
--
-- @param  origin Vector  The vector of where the attack comes from.
-- @return Vector The head position.
function HeadTarget( origin) end

--- Entity:Health
-- @usage shared
-- Returns the health of the entity.
--
-- @return number health
function Health() end

--- Entity:Ignite
-- @usage server
-- Sets the entity on fire.
--
-- @param  length number  How long to keep the entity ignited. Not supplying this argument will not ignite the entity at all.
-- @param  radius number  The radius of the ignition, will ignite everything around the entity that is in this radius.
function Ignite( length,  radius) end

--- Entity:InitializeAsClientEntity
-- @usage client
-- Initializes this entity as being clientside only.
--Only works on entities fully created clientside, and as such it has currently no use due to the lack of clientside ents.Create
--
function InitializeAsClientEntity() end

--- Entity:Input
-- @usage server
-- Fires input to the entity with the ability to make another entity responsible. Similar to Entity:Fire
--
-- @param  input string  The name of the input to fire
-- @param  activator Entity  The entity that is directly responsible
-- @param  inflictor Entity  The entity that is indirectly responsible (often a player)
-- @param  param=nil any  The value to give to the input. Can be a String, Float or Integer
function Input( input,  activator,  inflictor,  param) end

--- Entity:InstallDataTable
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function InstallDataTable() end

--- Entity:InvalidateBoneCache
-- @usage client
-- Resets the entity's bone cache values in order to prepare for a model change.
--
function InvalidateBoneCache() end

--- Entity:IsConstrained
-- @usage shared
-- Returns true if the entity has constraints attached to it
--
-- @return boolean Whether the entity is constrained or not.
function IsConstrained() end

--- Entity:IsConstraint
-- @usage server
-- Returns if entity is constraint or not
--
-- @return boolean Is the entity a constraint or not
function IsConstraint() end

--- Entity:IsDormant
-- @usage shared
-- Returns whether the entity is dormant or not. Client/server entities become dormant when they leave the PVS on the server. Client side entities can decide for themselves whether to become dormant. This mainly applies to PVS.
--
-- @return boolean Whether the entity is dormant or not.
function IsDormant() end

--- Entity:IsEffectActive
-- @usage shared
-- Returns whether an entity has engine effect applied or not.
--
-- @param  effect number  The effect to check for, see EF_ Enums.
-- @return boolean whether an entity has the engine effect applied or not.
function IsEffectActive( effect) end

--- Entity:IsEFlagSet
-- @usage shared
-- Checks if given flag is set or not.
--
-- @param  flag number  The engine flag to test, see EFL_ Enums
-- @return boolean Is set or not
function IsEFlagSet( flag) end

--- Entity:IsFlagSet
-- @usage shared
-- Checks if given flag(s) is set or not.
--
-- @param  flag number  The engine flag(s) to test, see FL_ Enums
-- @return boolean Is set or not
function IsFlagSet( flag) end

--- Entity:IsInWorld
-- @usage server
-- Returns whether the entity is inside a wall or outside of the map.
--
-- @return boolean Is the entity in world
function IsInWorld() end

--- Entity:IsLagCompensated
-- @usage server
-- Returns whether the entity is lag compensated or not.
--
-- @return boolean Whether the entity is lag compensated or not.
function IsLagCompensated() end

--- Entity:IsLineOfSightClear
-- @usage shared
-- Returns true if the target is in line of sight.
--
-- @param  target Vector  The target to test. You can also supply an Entity instead of a Vector
-- @return boolean Returns true if the line of sight is clear
function IsLineOfSightClear( target) end

--- Entity:IsNPC
-- @usage shared
-- Checks if the entity is an NPC or not.
--
-- @return boolean Whether the entity is an NPC.
function IsNPC() end

--- Entity:IsOnFire
-- @usage shared
-- Returns whether the entity is on fire.
--
-- @return boolean Whether the entity is on fire or not.
function IsOnFire() end

--- Entity:IsOnGround
-- @usage shared
-- Returns whether the entity is on ground or not.
--
-- @return boolean Whether the entity is on ground or not.
function IsOnGround() end

--- Entity:IsPlayer
-- @usage shared
-- Checks if the entity is a player or not.
--
-- @return boolean Whether the entity is a player.
function IsPlayer() end

--- Entity:IsPlayerHolding
-- @usage server
-- Returns true if the entity is being held by a player. Either by Physics gun, Gravity gun or Use-key.
--
-- @return boolean IsBeingHeld
function IsPlayerHolding() end

--- Entity:IsPlayingGesture
-- @usage server
-- Returns whether there's a gesture is given activity being played.
--
-- @param  activity number  The activity to test. See ACT_ Enums.
-- @return boolean Whether there's a gesture is given activity being played.
function IsPlayingGesture( activity) end

--- Entity:IsRagdoll
-- @usage shared
-- Checks if the entity is a ragdoll.
--
-- @return boolean Is ragdoll or not
function IsRagdoll() end

--- Entity:IsSolid
-- @usage shared
-- Returns if the entity is solid or not.
--Very useful for determining if the entity is a trigger or not.
--
-- @return boolean Whether the entity is solid or not.
function IsSolid() end

--- Entity:IsValid
-- @usage shared
-- Returns whether the entity is a valid entity or not.
--
-- @return boolean true if the entity is valid, false otherwise
function IsValid() end

--- Entity:IsValidLayer
-- @usage server
-- Returns whether the given layer ID is valid and exists on this entity.
--
-- @param  layerID number  The Layer ID
-- @return boolean Whether the given layer ID is valid and exists on this entity.
function IsValidLayer( layerID) end

--- Entity:IsVehicle
-- @usage shared
-- Checks if the entity is a vehicle or not.
--
-- @return boolean Whether the entity is a vehicle.
function IsVehicle() end

--- Entity:IsWeapon
-- @usage shared
-- Checks if the entity is a weapon or not.
--
-- @return boolean Whether the entity is a weapon
function IsWeapon() end

--- Entity:IsWidget
-- @usage shared
-- Returns whether the entity is a widget or not.
--
-- @return boolean Whether the entity is a widget or not.
function IsWidget() end

--- Entity:IsWorld
-- @usage shared
-- Returns if the entity is the map's Entity[0] worldspawn
--
-- @return boolean isWorld
function IsWorld() end

--- Entity:LocalToWorld
-- @usage shared
-- Converts a vector local to an entity into a worldspace vector
--
-- @param  lpos Vector  The local vector
-- @return Vector The translated to world coordinates vector
function LocalToWorld( lpos) end

--- Entity:LocalToWorldAngles
-- @usage shared
-- Converts a local angle (local to the entity) to a world angle.
--
-- @param  ang Angle  The local angle
-- @return Angle The world angle
function LocalToWorldAngles( ang) end

--- Entity:LookupAttachment
-- @usage shared
-- Gets the attachment index of the given attachment name, returns nothing if the attachment does not exist.
--
-- @param  attachmentName string  The name of the attachment.
-- @return number attachmentIndex
function LookupAttachment( attachmentName) end

--- Entity:LookupBone
-- @usage shared
-- Gets the bone index of the given bone name, returns nothing if the bone does not exist.
--
-- @param  boneName string  The name of the bone. Common generic bones ( for player models and some HL2 models ):   ValveBiped.Bip01_Head1  ValveBiped.Bip01_Spine  ValveBiped.Anim_Attachment_RH  Common hand bones (left hand equivalents also available, replace _R_ with _L_)   ValveBiped.Bip01_R_Hand  ValveBiped.Bip01_R_Forearm  ValveBiped.Bip01_R_Foot  ValveBiped.Bip01_R_Thigh  ValveBiped.Bip01_R_Calf  ValveBiped.Bip01_R_Shoulder  ValveBiped.Bip01_R_Elbow
-- @return number Index of the given bone name
function LookupBone( boneName) end

--- Entity:LookupSequence
-- @usage shared
-- Returns sequence ID from its name.
--
-- @param  name string  Sequence name
-- @return number Sequence ID for that name. This will differ for models with same sequence names. Will be -1 whether the sequence is invalid.
-- @return number The sequence duration, will be 0 whether the sequence is invalid.
function LookupSequence( name) end

--- Entity:MakePhysicsObjectAShadow
-- @usage shared
-- Turns the Entity:GetPhysicsObject into a physics shadow.
--It's used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.
--
-- @param  allowPhysicsMovement boolean  Whether to allow the physics shadow to move under stress.
-- @param  allowPhysicsRotation boolean  Whether to allow the physics shadow to rotate under stress.
function MakePhysicsObjectAShadow( allowPhysicsMovement,  allowPhysicsRotation) end

--- Entity:ManipulateBoneAngles
-- @usage shared
-- Sets custom bone angles.
--
-- @param  boneID number  Index of the bone you want to manipulate
-- @param  ang Angle  Angle to apply.  The angle is relative to the original bone angle, not relative to the world or the entity.
function ManipulateBoneAngles( boneID,  ang) end

--- Entity:ManipulateBoneJiggle
-- @usage shared
-- Manipulates the bone's jiggle value(s).
--
-- @param  boneID number  Index of the bone you want to manipulate.
-- @param  amount number  0 = No Jiggle  1 = Jiggle
function ManipulateBoneJiggle( boneID,  amount) end

--- Entity:ManipulateBonePosition
-- @usage shared
-- Sets custom bone offsets.
--
-- @param  boneID number  Index of the bone you want to manipulate
-- @param  pos Vector  Position vector to apply  Note that the position is relative to the original bone position, not relative to the world or the entity.
function ManipulateBonePosition( boneID,  pos) end

--- Entity:ManipulateBoneScale
-- @usage shared
-- Sets custom bone scale.
--
-- @param  boneID number  Index of the bone you want to manipulate
-- @param  scale Vector  Scale vector to apply.  Note that the scale is relative to the original bone scale, not relative to the world or the entity.
function ManipulateBoneScale( boneID,  scale) end

--- Entity:MapCreationID
-- @usage server
-- Returns entity's map creation ID. Unlike Entity:EntIndex or Entity:GetCreationID, it will always be the same on same map, no matter how much you clean up or restart it.
--
-- @return number The map creation ID or -1 if the entity is not compiled into the map.
function MapCreationID() end

--- Entity:MarkShadowAsDirty
-- @usage client
-- Refreshes the shadow of the entity.
--
function MarkShadowAsDirty() end

--- Entity:MuzzleFlash
-- @usage shared
-- Fires the muzzle flash effect of the weapon the entity is carrying. This only creates a light effect and is often called alongside Weapon:SendWeaponAnim
--
function MuzzleFlash() end

--- Entity:NearestPoint
-- @usage shared
-- Performs a Ray OBBox intersection from the given position to the origin of the OBBox with the entity and returns the hit position on the OBBox
--
-- @param  position Vector  The vector to start the intersection from.
-- @return Vector The nearest hit point of the entity's bounding box in world coordinates.
function NearestPoint( position) end

--- Entity:NetworkVar
-- @usage shared
-- Creates a network variable on the entity and adds Set/Get functions for it. This function should only be called in ENTITY:SetupDataTables.
--
-- @param  type string  Either of:   "String"  "Bool"  "Float"  "Int"  "Vector"  "Angle"  "Entity"
-- @param  slot number  Each network var has to have a unique slot. The slot is per type - so you can have an int in slot 0, a bool in slot 0 and a float in slot 0 etc.  The max slots right now are 32 - so you should pick a number between 0 and 31. An exception to this is strings which has a max slots of 4.
-- @param  name string  The name will affect how you access it. If you call it "Foo" you would add two new functions on your entity - SetFoo and GetFoo. So be careful that what you call it won't collide with any existing functions (don't call it "Pos" for example).
-- @param  extended=nil table  A table of extended information. KeyName If the table contains a "KeyName" key the value can be set using Entity:SetKeyValue. This is useful if you're making an entity that you want to be loaded in a map. The sky entity uses this. Edit  The edit key lets you mark this variable as editable. See Editable Entities for more information.
function NetworkVar( type,  slot,  name,  extended) end

--- Entity:NetworkVarNotify
-- @usage shared
-- Creates a callback that will execute when the given network variable changes - that is, when the Set<name> function is run.
--
-- @param  name string  Name of variable to track changes of
-- @param  callback function  The function to call when the variable changes. It is passed 4 arugments:   Entity entity - Entity whos variable changed (This will be variable called "self" in ENT:CallBack format.)  string name - Name of changed variable  any old - Old/current variable value  any new - New variable value that it was set to
function NetworkVarNotify( name,  callback) end

--- Entity:NextThink
-- @usage shared
-- In the case of a scripted entity, this will cause the next ENTITY:Think event to be run at the given time.
--
-- @param  timestamp number  The relative to CurTime timestamp, at which the next think should occur.
function NextThink( timestamp) end

--- Entity:OBBCenter
-- @usage shared
-- Returns the center of an entity's bounding box as a local vector.
--
-- @return Vector OBBCenter
function OBBCenter() end

--- Entity:OBBMaxs
-- @usage shared
-- Returns the highest corner of an entity's bounding box as a local vector.
--
-- @return Vector The local position of the highest corner of the entity's oriented bounding box.
function OBBMaxs() end

--- Entity:OBBMins
-- @usage shared
-- Returns the lowest corner of an entity's bounding box as a local vector.
--
-- @return Vector The local position of the lowest corner of the entity's oriented bounding box.
function OBBMins() end

--- Entity:ObjectCaps
-- @usage shared
-- Returns the entity's capabilities as a bitfield.
--In the engine this function is mostly used to check the use type, the save/restore system and level transitions flags.
--
-- @return number The bitfield, a combination of the FCAP_ flags.
function ObjectCaps() end

--- Entity:OnGround
-- @usage shared
-- Returns true if the entity is on the ground, and false if it isn't.
--
-- @return boolean Whether the entity is on the ground or not.
function OnGround() end

--- Entity:PassesDamageFilter
-- @usage server
-- Tests whether the damage passes the entity filter.
--
-- @param  dmg CTakeDamageInfo  The damage info to test
-- @return boolean Whether the damage info passes the entity filter.
function PassesDamageFilter( dmg) end

--- Entity:PassesFilter
-- @usage server
-- Tests whether the entity passes the entity filter.
--
-- @param  caller Entity  The initiator of the test.  For example the trigger this filter entity is used in.
-- @param  ent Entity  The entity to test against the entity filter.
-- @return boolean Whether the entity info passes the entity filter.
function PassesFilter( caller,  ent) end

--- Entity:PhysicsDestroy
-- @usage shared
-- Destroys the current physics object of an entity.
--
function PhysicsDestroy() end

--- Entity:PhysicsFromMesh
-- @usage shared
-- Initializes the physics mesh of the entity from a triangle soup defined by a table of vertices. The resulting mesh is hollow, may contain holes, and always has a volume of 0.
--
-- @param  vertices table  A table consisting of MeshVertex structure (only the pos element is taken into account). Every 3 vertices define a triangle in the physics mesh.
function PhysicsFromMesh( vertices) end

--- Entity:PhysicsInit
-- @usage shared
-- Initializes the physics object of the entity using its current model. Deletes the previous physics object if there was any.
--
-- @param  solidType number  The solid type of the physics object to create, see SOLID_ Enums. Should be SOLID_VPHYSICS in most cases.
function PhysicsInit( solidType) end

--- Entity:PhysicsInitBox
-- @usage shared
-- Makes the physics object of the entity a AABB.
--
-- @param  mins Vector  The minimum position of the box.
-- @param  maxs Vector  The maximum position of the box.
function PhysicsInitBox( mins,  maxs) end

--- Entity:PhysicsInitConvex
-- @usage shared
-- Initializes the physics mesh of the entity with a convex mesh defined by a table of points. The resulting mesh is the convex hull of all the input points.
--
-- @param  points table  A table of Vectors, in local coordinates, to be used in the computation of the convex mesh. Order does not matter.
function PhysicsInitConvex( points) end

--- Entity:PhysicsInitMultiConvex
-- @usage shared
-- An advanced version of Entity:PhysicsInitConvex which initializes a physics object from multiple convex meshes.
--
-- @param  vertices table  A table consisting of tables of Vectors. Each sub-table defines a set of points to be used in the computation of one convex mesh.
function PhysicsInitMultiConvex( vertices) end

--- Entity:PhysicsInitShadow
-- @usage shared
-- Removes the old Entity:GetPhysicsObject and initializes it as a physics shadow.
--It's used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.
--
-- @param  allowPhysicsMovement boolean  Whether to allow the physics shadow to move under stress.
-- @param  allowPhysicsRotation boolean  Whether to allow the physics shadow to rotate under stress.
function PhysicsInitShadow( allowPhysicsMovement,  allowPhysicsRotation) end

--- Entity:PhysicsInitSphere
-- @usage shared
-- Makes the physics object of the entity a sphere.
--
-- @param  radius number  The radius of the sphere.
-- @param  physmat string  Physical Material. From this list: Valve Developer
function PhysicsInitSphere( radius,  physmat) end

--- Entity:PhysWake
-- @usage shared
-- Wakes up the entity's physics object
--
function PhysWake() end

--- Entity:PlayScene
-- @usage server
-- Makes the entity play a .vcd scene.
--
-- @param  scene string  Filepath to scene
-- @param  delay=0 number  Delay in seconds until the scene starts playing.
function PlayScene( scene,  delay) end

--- Entity:PointAtEntity
-- @usage server
-- Changes an entities angles so that it faces the target entity.
--
-- @param  target Entity  The entity to face.
function PointAtEntity( target) end

--- Entity:PrecacheGibs
-- @usage server
-- Precaches gibs for the entity. This is required for Entity:GibBreakServer and Entity:GibBreakClient to work.
--
function PrecacheGibs() end

--- Entity:RagdollSolve
-- @usage server
-- Normalizes the ragdoll. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
--
function RagdollSolve() end

--- Entity:RagdollStopControlling
-- @usage server
-- Sets the function to build the ragdoll. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
--
function RagdollStopControlling() end

--- Entity:RagdollUpdatePhysics
-- @usage server
-- Makes the physics objects follow the set bone positions. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
--
-- @param  unknown number  Probably the physics object to update
function RagdollUpdatePhysics( unknown) end

--- Entity:Remove
-- @usage shared
-- Removes the entity it is used on.
--
function Remove() end

--- Entity:RemoveAllDecals
-- @usage shared
-- Removes all decals from the entities surface.
--
function RemoveAllDecals() end

--- Entity:RemoveAllGestures
-- @usage server
-- Removes and stops all gestures.
--
function RemoveAllGestures() end

--- Entity:RemoveCallOnRemove
-- @usage shared
-- Removes the CallOnRemove'd function referred to by identifier
--
-- @param  identifier string  Identifier of the function within CallOnRemove
function RemoveCallOnRemove( identifier) end

--- Entity:RemoveEffects
-- @usage shared
-- Removes an engine effect applied to an entity.
--
-- @param  effect number  The effect to remove, see EF_ Enums.
function RemoveEffects( effect) end

--- Entity:RemoveEFlags
-- @usage shared
-- Removes specified engine flag
--
-- @param  flag number  The flag to remove, see EFL_ Enums
function RemoveEFlags( flag) end

--- Entity:RemoveFlags
-- @usage shared
-- Removes specified flag(s) from the entity
--
-- @param  flag number  The flag(s) to remove, see FL_ Enums
function RemoveFlags( flag) end

--- Entity:RemoveFromMotionController
-- @usage shared
-- Removes a PhysObject from the entity's motion controller so that ENTITY:PhysicsSimulate will no longer be called for given PhysObject.
--
-- @param  physObj PhysObj  The PhysObj to remove from the motion controller.
function RemoveFromMotionController( physObj) end

--- Entity:RemoveGesture
-- @usage server
-- Removes and stop the gesture with given activity.
--
-- @param  activity number  The activity remove. See ACT_ Enums.
function RemoveGesture( activity) end

--- Entity:RemoveSolidFlags
-- @usage shared
-- Removes solid flag(s) from the entity.
--
-- @param  flags number  The flag(s) to remove, see FSOLID_ Enums.
function RemoveSolidFlags( flags) end

--- Entity:ResetSequence
-- @usage shared
-- Plays an animations on the entity. This may not always work on engine entities.
--
-- @param  seq number  Sequence ID to play. See Entity:LookupSequence.
function ResetSequence( seq) end

--- Entity:ResetSequenceInfo
-- @usage shared
-- Reset entity sequence info such as playback rate, ground speed, last event check, etc.
--
function ResetSequenceInfo() end

--- Entity:Respawn
-- @usage server
-- Makes the entity/weapon respawn.
--
function Respawn() end

--- Entity:RestartGesture
-- @usage server
-- Restarts the entity's animation gesture. If the given gesture is already playing, it will reset it and play it from the beginning.
--
-- @param  activity number  The activity number to send to the entity. See ACT_ Enums and Entity:GetSequenceActivity
-- @param  addIfMissing=true boolean  Add/start the gesture to if it has not been yet started.
-- @param  autokill=true boolean 
function RestartGesture( activity,  addIfMissing,  autokill) end

--- Entity:SelectWeightedSequence
-- @usage shared
-- Returns sequence ID corresponding to given activity id. Opposite of Entity:GetSequenceActivity. Similar to Entity:LookupSequence
--
-- @param  act number  The activity ID, see ACT_ Enums.
-- @return number The sequence ID
function SelectWeightedSequence( act) end

--- Entity:SelectWeightedSequenceSeeded
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  act number 
-- @param  seed number 
-- @return number 
function SelectWeightedSequenceSeeded( act,  seed) end

--- Entity:SendViewModelMatchingSequence
-- @usage shared
-- Sends sequence animation to the view model. It is recommended to use this for view model animations, instead of Entity:ResetSequence.
--
-- @param  seq number  The sequence ID returned by Entity:LookupSequence or Entity:SelectWeightedSequence.
function SendViewModelMatchingSequence( seq) end

--- Entity:SequenceDuration
-- @usage shared
-- Returns length of currently played sequence.
--
-- @param  seqid=nil number  A sequence ID to return the length specific sequence of instead of the entity's main/currently playing sequence.
-- @return number The length of the sequence
function SequenceDuration( seqid) end

--- Entity:SetAbsVelocity
-- @usage shared
-- Sets the entity's velocity.
--
-- @param  vel Vector  The new velocity to set.
function SetAbsVelocity( vel) end

--- Entity:SetAngles
-- @usage shared
-- Sets the angles of the entity.
--
-- @param  angles Angle  The new angles.
function SetAngles( angles) end

--- Entity:SetAnimation
-- @usage shared
-- Sets a player's third-person animation. Mainly used by Weapons to start the player's weapon attack and reload animations.
--
-- @param  playerAnim number  Player animation, see PLAYER_ Enums.
function SetAnimation( playerAnim) end

--- Entity:SetAnimTime
-- @usage client
-- Sets the time (relative to CurTime) of the current animation frame, which is used to determine Entity:GetCycle.
--
-- @param  time number  The current animation time.
function SetAnimTime( time) end

--- Entity:SetAttachment
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using Entity:SetParent instead.
-- @param  ent Entity  The entity to attach/parent to
-- @param  attachment number  The attachment ID to parent to
function SetAttachment( ent,  attachment) end

--- Entity:SetAutomaticFrameAdvance
-- @usage shared
-- Toggles automatic frame advancing for animated sequences on an entity.
--This has the same effect as setting the AutomaticFrameAdvance property.
--
-- @param  bUsingAnim boolean  Whether or not to set automatic frame advancing.
function SetAutomaticFrameAdvance( bUsingAnim) end

--- Entity:SetBloodColor
-- @usage server
-- Sets the blood color this entity uses.
--
-- @param  bloodColor number  An integer corresponding to BLOOD_COLOR_ Enums.
function SetBloodColor( bloodColor) end

--- Entity:SetBodygroup
-- @usage shared
-- Sets an entities' bodygroup.
--
-- @param  bodygroup number  The id of the bodygroup you're setting. Starts from 0.
-- @param  value number  The value you're setting the bodygroup to. Starts from 0.
function SetBodygroup( bodygroup,  value) end

--- Entity:SetBodyGroups
-- @usage shared
-- Sets the bodygroups from a string.
--
-- @param  bodygroups string  Bodygroups to set. Format is just like Panel:SetModel's third argument.
function SetBodyGroups( bodygroups) end

--- Entity:SetBoneController
-- @usage shared
-- Sets the specified value on the bone controller with the given ID of this entity, it's used in HL1 to change the head rotation of NPCs, turret aiming and so on.
--
-- @param  boneControllerID number  The ID of the bone controller to set the value to.  Goes from 0 to 3.
-- @param  value number  The value to set on the specified bone controller.
function SetBoneController( boneControllerID,  value) end

--- Entity:SetBoneMatrix
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  boneid number 
-- @param  matrix VMatrix 
function SetBoneMatrix( boneid,  matrix) end

--- Entity:SetBonePosition
-- @usage client
-- Sets the bone position and angles.
--
-- @param  bone number  The bone ID to manipulate
-- @param  pos Vector  The position to set
-- @param  ang Angle  The angles to set
function SetBonePosition( bone,  pos,  ang) end

--- Entity:SetCollisionBounds
-- @usage shared
-- Sets the collision bounds for the entity, which are used for triggers ( Entity:SetTrigger, ENTITY:Touch ), determining if rendering is necessary clientside, and collision ( If Entity:SetSolid set as SOLID_BBOX ).
--
-- @param  mins Vector  The minimum vector of the bounds. The vector must be smaller than second argument on all axises.
-- @param  maxs Vector  The maximum vector of the bounds. The vector must be bigger than first argument on all axises.
function SetCollisionBounds( mins,  maxs) end

--- Entity:SetCollisionBoundsWS
-- @usage shared
-- Sets the collision bounds for the entity, which are used for triggers ( Entity:SetTrigger, ENTITY:Touch ), determining if rendering is necessary clientside, and collision ( If Entity:SetSolid set as SOLID_BBOX ).
--
-- @param  vec1 Vector  The first vector of the bounds.
-- @param  vec2 Vector  The second vector of the bounds.
function SetCollisionBoundsWS( vec1,  vec2) end

--- Entity:SetCollisionGroup
-- @usage shared
-- Sets the entity's collision group.
--
-- @param  group number  Collision group of the entity, see COLLISION_GROUP_ Enums
function SetCollisionGroup( group) end

--- Entity:SetColor
-- @usage shared
-- Sets the color of an entity.
--
-- @param  color table  The color to set. Uses the Color structure.
function SetColor( color) end

--- Entity:SetCreator
-- @usage server
-- Sets the creator of the SENT.
--
-- @param  ply Player  The creator
function SetCreator( ply) end

--- Entity:SetCustomCollisionCheck
-- @usage shared
-- Marks the entity to call GM:ShouldCollide.
--
-- @param  enable boolean  Enable or disable the custom collision check
function SetCustomCollisionCheck( enable) end

--- Entity:SetCycle
-- @usage shared
-- Sets the progress of the current animation to a specific value between 0 and 1.
--
-- @param  value number  The desired cycle value
function SetCycle( value) end

--- Entity:SetDTAngle
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 31.
-- @param  ang Angle  The angle to write on the entity's datatable.
function SetDTAngle( key,  ang) end

--- Entity:SetDTBool
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 31.
-- @param  bool boolean  The boolean to write on the entity's metatable.
function SetDTBool( key,  bool) end

--- Entity:SetDTEntity
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 31.
-- @param  ent Entity  The entity to write on this entity's datatable.
function SetDTEntity( key,  ent) end

--- Entity:SetDTFloat
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 31.
-- @param  float number  The float to write on the entity's datatable.
function SetDTFloat( key,  float) end

--- Entity:SetDTInt
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 31.
-- @param  integer number  The integer to write on the entity's datatable.
function SetDTInt( key,  integer) end

--- Entity:SetDTString
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 3.
-- @param  str string  The string to write on the entity's datatable, can't be more than 512 characters per string.
function SetDTString( key,  str) end

--- Entity:SetDTVector
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  key number  Goes from 0 to 31.
-- @param  vec Vector  The vector to write on the entity's datatable.
function SetDTVector( key,  vec) end

--- Entity:SetElasticity
-- @usage shared
-- Sets the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.
--
-- @param  elasticity number  The elasticity to set.
function SetElasticity( elasticity) end

--- Entity:SetEntity
-- @usage shared
-- Allows you to set the Start or End entity attachment for the rope.
--
-- @param  name string  The name of the variable to modify.  Accepted names are StartEntity and EndEntity.
-- @param  entity Entity  The entity to apply to the specific attachment.
function SetEntity( name,  entity) end

--- Entity:SetEyeTarget
-- @usage shared
-- Sets the position an entity's eyes look toward.
--
-- @param  pos Vector  The world position the entity is looking toward.
function SetEyeTarget( pos) end

--- Entity:SetFlexScale
-- @usage shared
-- Sets the flex scale of the entity.
--
-- @param  scale number  The new flex scale to set to
function SetFlexScale( scale) end

--- Entity:SetFlexWeight
-- @usage shared
-- Sets the flex weight.
--
-- @param  flex number  The ID of the flex to modify weight of
-- @param  weight number  The new weight to set
function SetFlexWeight( flex,  weight) end

--- Entity:SetFriction
-- @usage server
-- Sets how much friction an entity has when sliding against a surface. Entities default to 1 (100%) and can be higher or even negative.
--
-- @param  friction number  Friction multiplier
function SetFriction( friction) end

--- Entity:SetGravity
-- @usage shared
-- Sets the gravity multiplier of the entity.
--
-- @param  gravityMultiplier number  Value which specifies the gravity multiplier.
function SetGravity( gravityMultiplier) end

--- Entity:SetGroundEntity
-- @usage shared
-- Sets the ground the entity is standing on.
--
-- @param  ground Entity  The ground entity.
function SetGroundEntity( ground) end

--- Entity:SetHealth
-- @usage shared
-- Sets the health of the entity.
--
-- @param  newHealth number  New health value.
function SetHealth( newHealth) end

--- Entity:SetHitboxSet
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param xk number 
function SetHitboxSet(xk) end

--- Entity:SetIK
-- @usage client
-- Enables or disable the inverse kinematic usage of this entity.
--
-- @param  useIK boolean  The state of the IK.
function SetIK( useIK) end

--- Entity:SetKeyValue
-- @usage shared
-- Sets key value for the entity.
--
-- @param  key string  The key
-- @param  value string  The value
function SetKeyValue( key,  value) end

--- Entity:SetLagCompensated
-- @usage server
-- This allows the entity to be lag compensated during Player:LagCompensation.
--
-- @param  enable boolean  Whether the entity should be lag compensated or not.
function SetLagCompensated( enable) end

--- Entity:SetLayerBlendIn
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  layerID number  The Layer ID
-- @param  blendIn number 
function SetLayerBlendIn( layerID,  blendIn) end

--- Entity:SetLayerBlendOut
-- @usage server
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  layerID number  The Layer ID
-- @param  blendOut number 
function SetLayerBlendOut( layerID,  blendOut) end

--- Entity:SetLayerCycle
-- @usage server
-- Sets the animation cycle/frame of given layer.
--
-- @param  layerID number  The Layer ID
-- @param  duration number  The new animation cycle/frame for given layer.
function SetLayerCycle( layerID,  duration) end

--- Entity:SetLayerDuration
-- @usage server
-- Sets the duration of given layer. This internally overrides the Entity:SetLayerPlaybackRate.
--
-- @param  layerID number  The Layer ID
-- @param  duration number  The new duration of the layer in seconds.
function SetLayerDuration( layerID,  duration) end

--- Entity:SetLayerLooping
-- @usage server
-- Sets whether the layer should loop or not.
--
-- @param  layerID number  The Layer ID
-- @param  loop boolean  Whether the layer should loop or not.
function SetLayerLooping( layerID,  loop) end

--- Entity:SetLayerPlaybackRate
-- @usage server
-- Sets the layer player back rate. See also Entity:SetLayerDuration.
--
-- @param  layerID number  The Layer ID
-- @param  rate number  The new playback rate.
function SetLayerPlaybackRate( layerID,  rate) end

--- Entity:SetLayerPriority
-- @usage server
-- Sets the priority of given layer.
--
-- @param  layerID number  The Layer ID
-- @param  priority number  The new priority of the layer.
function SetLayerPriority( layerID,  priority) end

--- Entity:SetLayerWeight
-- @usage server
-- Sets the layer weight. This influences how strongly the animation should be overriding the normal animations of the entity.
--
-- @param  layerID number  The Layer ID
-- @param  weight number  The new layer weight.
function SetLayerWeight( layerID,  weight) end

--- Entity:SetLegacyTransform
-- @usage client
-- This forces an entity to use the bone transformation behaviour from versions prior to 14.07.08.
--This behaviour affects Entity:EnableMatrix and Entity:SetModelScale and is incorrect, therefore this function be used exclusively as a quick fix for old scripts that rely on it.
--
-- @param  enabled boolean  Whether the entity should use the old bone transformation behaviour or not.
function SetLegacyTransform( enabled) end

--- Entity:SetLocalAngles
-- @usage shared
-- Sets angles relative to angles of Entity:GetParent
--
-- @param  ang Angle  The local angle
function SetLocalAngles( ang) end

--- Entity:SetLocalAngularVelocity
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  angVel Angle 
function SetLocalAngularVelocity( angVel) end

--- Entity:SetLocalPos
-- @usage shared
-- Sets local position relative to the parented position. This is for use with Entity:SetParent to offset position.
--
-- @param  pos Vector  The local position
function SetLocalPos( pos) end

--- Entity:SetLocalVelocity
-- @usage shared
-- Sets the entity's local velocity. Same as Entity:SetAbsVelocity, but clamps given velocity, and is not recommended to be used because of that.
--
-- @param  velocity Vector  The velocity the entity will be set with.
function SetLocalVelocity( velocity) end

--- Entity:SetLOD
-- @usage client
-- Sets the Level Of Detail model to use with this entity. This may not work for all models if the model doesn't include any LOD sub models.
--
-- @param  lod=-1 number  The Level Of Detail model ID to use. -1 leaves the engine to automatically set the Level of Detail.  The Level Of Detail may range from 0 to 8, with 0 being the highest quality and 8 the lowest.
function SetLOD( lod) end

--- Entity:SetMaterial
-- @usage shared
-- Sets the rendering material override of the entity.
--
-- @param  materialName string  New material name.
-- @param  forceMaterial=false boolean  Use it if you wish to apply material other than VertexLitGeneric (such as tools/toolswhite).
function SetMaterial( materialName,  forceMaterial) end

--- Entity:SetMaxHealth
-- @usage server
-- Sets the maximum health for entity. Note, that you can still set entity's health above this amount with Entity:SetHealth.
--
-- @param  maxhealth number  What the max health should be
function SetMaxHealth( maxhealth) end

--- Entity:SetModel
-- @usage shared
-- Sets the model of the entity.
--
-- @param  modelName string  New model value.
function SetModel( modelName) end

--- Entity:SetModelName
-- @usage shared
-- Sets the model name returned by Entity:GetModel. Does not actually alter the entity's model.
--
-- @param  model string  The new model name
function SetModelName( model) end

--- Entity:SetModelScale
-- @usage shared
-- Scales the model of the entity, if the entity is a Player or an NPC the hitboxes will be scaled as well.
--
-- @param  scale number  A float to scale the model by
-- @param  deltaTime=0 number  Transition time of the scale change, set to 0 to modify the scale right away.
function SetModelScale( scale,  deltaTime) end

--- Entity:SetMoveCollide
-- @usage server
-- Sets the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?
--
-- @param  moveCollideType number  The move collide type, see MOVECOLLIDE_ Enums
function SetMoveCollide( moveCollideType) end

--- Entity:SetMoveParent
-- @usage shared
-- Sets the Movement Parent of an entity to another entity. Similar to Entity:SetParent, except the object's coordinates are not translated automatically before parenting.
--
-- @param  Parent Entity  The entity to change this entity's Movement Parent to.
function SetMoveParent( Parent) end

--- Entity:SetMoveType
-- @usage shared
-- Sets the entitys movetype.
--
-- @param  movetype number  The new movetype, see MOVETYPE_ Enums
function SetMoveType( movetype) end

--- Entity:SetName
-- @usage server
-- Sets the mapping name of the entity.
--
-- @param  mappingName string  The name to set for the entity.
function SetName( mappingName) end

--- Entity:SetNetworkAngles
-- @usage client
-- Alters networked entity angles.
--
-- @param  angle Angle 
function SetNetworkAngles( angle) end

--- Entity:SetNetworkedAngle
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:SetNWAngle instead.
-- @param  key string  The key to associate the value with
-- @param  value=Angle( 0, 0, 0 ) Angle  The value to set
function SetNetworkedAngle( key,  value) end

--- Entity:SetNetworkedBool
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:SetNWBool instead.
-- @param  key string  The key to associate the value with
-- @param  value=false boolean  The value to set
function SetNetworkedBool( key,  value) end

--- Entity:SetNetworkedEntity
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:SetNWEntity instead.
-- @param  key string  The key to associate the value with
-- @param  value=NULL Entity  The value to set
function SetNetworkedEntity( key,  value) end

--- Entity:SetNetworkedFloat
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:SetNWFloat instead.
-- @param  key string  The key to associate the value with
-- @param  value=0 number  The value to set
function SetNetworkedFloat( key,  value) end

--- Entity:SetNetworkedInt
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:SetNWInt instead.
-- @param  key string  The key to associate the value with
-- @param  value=0 number  The value to set
function SetNetworkedInt( key,  value) end

--- Entity:SetNetworkedNumber
-- @usage shared
-- Sets a networked number at the specified index on the entity.
--
-- @param  index any  The index that the value is stored in.
-- @param  number number  The value to network.
function SetNetworkedNumber( index,  number) end

--- Entity:SetNetworkedString
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:SetNWString instead.
-- @param  key string  The key to associate the value with
-- @param  value="" string  The value to set
function SetNetworkedString( key,  value) end

--- Entity:SetNetworkedVarProxy
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using Entity:SetNWVarProxy instead.
-- @param  name string  The name of the NWVar to add callback for.
-- @param  callback function  The function to be called when the NWVar changes.
function SetNetworkedVarProxy( name,  callback) end

--- Entity:SetNetworkedVector
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should use Entity:SetNWVector instead.
-- @param  key string  The key to associate the value with
-- @param  value=Vector( 0, 0, 0 ) Vector  The value to set
function SetNetworkedVector( key,  value) end

--- Entity:SetNetworkOrigin
-- @usage shared
-- Virtually changes entity position for clients.
--
-- @param  origin Vector 
function SetNetworkOrigin( origin) end

--- Entity:SetNextClientThink
-- @usage client
-- Sets the next time the clientside ENTITY:Think is called.
--
-- @param  nextthink number  The next time, relative to CurTime, to execute the ENTITY:Think clientside.
function SetNextClientThink( nextthink) end

--- Entity:SetNoDraw
-- @usage shared
-- Sets if the entity's model should render at all
--
-- @param  shouldNotDraw boolean  true disables drawing
function SetNoDraw( shouldNotDraw) end

--- Entity:SetNotSolid
-- @usage shared
-- Sets whether the entity is solid or not.
--
-- @param  IsNotSolid boolean  True will make the entity not solid, false will make it solid.
function SetNotSolid( IsNotSolid) end

--- Entity:SetNWAngle
-- @usage shared
-- Sets a networked angle value on the entity.
--
-- @param  key string  The key to associate the value with
-- @param  value Angle  The value to set
function SetNWAngle( key,  value) end

--- Entity:SetNWBool
-- @usage shared
-- Sets a networked boolean value on the entity.
--
-- @param  key string  The key to associate the value with
-- @param  value boolean  The value to set
function SetNWBool( key,  value) end

--- Entity:SetNWEntity
-- @usage shared
-- Sets a networked entity value on the entity.
--
-- @param  key string  The key to associate the value with
-- @param  value Entity  The value to set
function SetNWEntity( key,  value) end

--- Entity:SetNWFloat
-- @usage shared
-- Sets a networked float (number) value on the entity.
--
-- @param  key string  The key to associate the value with
-- @param  value number  The value to set
function SetNWFloat( key,  value) end

--- Entity:SetNWInt
-- @usage shared
-- Sets a networked integer (whole number) value on the entity.
--
-- @param  key string  The key to associate the value with
-- @param  value number  The value to set
function SetNWInt( key,  value) end

--- Entity:SetNWString
-- @usage shared
-- Sets a networked string value on the entity.
--
-- @param  key string  The key to associate the value with
-- @param  value string  The value to set, up to 199 characters.
function SetNWString( key,  value) end

--- Entity:SetNWVarProxy
-- @usage shared
-- Sets a function to be called when the NWVar changes.
--
-- @param  name string  The name of the NWVar to add callback for.
-- @param  callback function  The function to be called when the NWVar changes. It has 3 arguments: Entity ent - The entity string name - Name of the NWVar that has changed any oldval - The old value any newval - The new value  
function SetNWVarProxy( name,  callback) end

--- Entity:SetNWVector
-- @usage shared
-- Sets a networked vector value on the entity.
--
-- @param  key string  The key to associate the value with
-- @param  value Vector  The value to set
function SetNWVector( key,  value) end

--- Entity:SetOwner
-- @usage shared
-- Sets the owner of this entity, disabling all physics interaction with it.
--
-- @param  owner=NULL Entity  The entity to be set as owner.
function SetOwner( owner) end

--- Entity:SetParent
-- @usage shared
-- Sets the parent of this entity.
--
-- @param  parent Entity  The entity to parent to. Setting this to nil will clear the parent.
-- @param  attachmentId=-1 number  The attachment id to use when parenting, defaults to -1 or whatever the parent had set previously.    NOTE  You must call Entity:SetMoveType( MOVETYPE_NONE ) on the child for this argument to have any effect! 
function SetParent( parent,  attachmentId) end

--- Entity:SetParentPhysNum
-- @usage shared
-- Sets the parent of an entity to another entity with the given physics bone number. Similar to Entity:SetParent, except it is parented to a physbone. This function is useful mainly for ragdolls.
--
-- @param  bone number  Physics bone number to attach to. Use 0 for objects with only one physics bone. (See Entity:GetPhysicsObjectNum)
function SetParentPhysNum( bone) end

--- Entity:SetPersistent
-- @usage shared
-- Sets whether or not the given entity is persistent, it will be saved on server shutdown and loaded back when the server starts up.
--
-- @param  persist boolean  Whether or not the entity is persistent.
function SetPersistent( persist) end

--- Entity:SetPhysConstraintObjects
-- @usage server
-- When called on a constraint entity, sets the two physics objects to be constrained.
--
-- @param  Phys1 PhysObj  The first physics object to be constrained.
-- @param  Phys2 PhysObj  The second physics object to be constrained.
function SetPhysConstraintObjects( Phys1,  Phys2) end

--- Entity:SetPhysicsAttacker
-- @usage server
-- Sets the player who gets credit if this entity kills something with physics damage within the time limit.
--
-- @param  ent Player  Player who gets the kills. Setting this to a non-player entity will not work.
-- @param  timeLimit=5 number  Time in seconds until the entity forgets its physics attacker and prevents it from getting the kill credit.
function SetPhysicsAttacker( ent,  timeLimit) end

--- Entity:SetPlaybackRate
-- @usage shared
-- Allows you to set how fast an entity's animation will play, with 1.0 being the default speed.
--
-- @param  fSpeed number  How fast the animation will play.
function SetPlaybackRate( fSpeed) end

--- Entity:SetPos
-- @usage shared
-- Moves the entity to the specified position.
--
-- @param  position Vector  The position to move the entity to.
function SetPos( position) end

--- Entity:SetPoseParameter
-- @usage shared
-- Sets the specified pose parameter to the specified value.
--
-- @param  poseName string  Name of the pose parameter.
-- @param  poseValue number  The value to set the pose to.
function SetPoseParameter( poseName,  poseValue) end

--- Entity:SetPredictable
-- @usage client
-- Sets whether an entity should be predictable or not.
--When an entity is set as predictable, its DT vars can be changed during predicted hooks. This is useful for entities which can be controlled by player input.
--
-- @param  setPredictable boolean  whether to make this entity predictable or not.
function SetPredictable( setPredictable) end

--- Entity:SetPreventTransmit
-- @usage server
-- Prevents the server from sending any further information about the entity to a player.
--
-- @param  player Player  The player to stop networking the entity to.
-- @param  stopTransmitting boolean  true to stop the entity from networking, false to make it network again.
function SetPreventTransmit( player,  stopTransmitting) end

--- Entity:SetRagdollAng
-- @usage server
-- Sets the bone angles. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
--
-- @param  boneid number  Bone ID
-- @param  pos Angle  Angle to set
function SetRagdollAng( boneid,  pos) end

--- Entity:SetRagdollBuildFunction
-- @usage server
-- Sets the function to build the ragdoll. This is used alongside Kinect, for more info see ragdoll_motion entity.
--
-- @param  func function  The build function. This function has one argument:   Entity ragdoll - The ragdoll to build
function SetRagdollBuildFunction( func) end

--- Entity:SetRagdollPos
-- @usage server
-- Sets the bone position. This is used alongside Kinect in Entity:SetRagdollBuildFunction, for more info see ragdoll_motion entity.
--
-- @param  boneid number  Bone ID
-- @param  pos Vector  Position to set
function SetRagdollPos( boneid,  pos) end

--- Entity:SetRenderAngles
-- @usage client
-- Sets the render angles of the Entity.
--
-- @param  newAngles Angle  The new render angles to be set to.
function SetRenderAngles( newAngles) end

--- Entity:SetRenderBounds
-- @usage client
-- Sets the render bounds for the entity. For world space coordinates see Entity:SetRenderBoundsWS.
--
-- @param  mins Vector  The minimum corner of the bounds, relative to origin of the entity.
-- @param  maxs Vector  The maximum corner of the bounds, relative to origin of the entity.
-- @param  add=Vector( 0, 0, 0 ) Vector  If defined, adds this vector to maxs and subtracts this vector from mins.
function SetRenderBounds( mins,  maxs,  add) end

--- Entity:SetRenderBoundsWS
-- @usage client
-- Sets the render bounds for the entity in world space coordinates. For relative coordinates see Entity:SetRenderBounds.
--
-- @param  mins Vector  The minimum corner of the bounds, relative to origin of the world/map.
-- @param  maxs Vector  The maximum corner of the bounds, relative to origin of the world/map.
-- @param  add=Vector( 0, 0, 0 ) Vector  If defined, adds this vector to maxs and subtracts this vector from mins.
function SetRenderBoundsWS( mins,  maxs,  add) end

--- Entity:SetRenderClipPlane
-- @usage client
-- Used to specify a plane, past which an object will be visually clipped.
--
-- @param  planeNormal Vector  The normal of the plane. Anything behind the normal will be clipped.
-- @param  planePosition number  The position of the plane.
function SetRenderClipPlane( planeNormal,  planePosition) end

--- Entity:SetRenderClipPlaneEnabled
-- @usage client
-- Enables the use of clipping planes to "cut" objects.
--
-- @param  enabled boolean  Enable or disable clipping planes
function SetRenderClipPlaneEnabled( enabled) end

--- Entity:SetRenderFX
-- @usage shared
-- Sets entity's render FX.
--
-- @param  renderFX number  The new render FX to set, see kRenderFx_ Enums
function SetRenderFX( renderFX) end

--- Entity:SetRenderMode
-- @usage shared
-- Sets the render mode of the entity.
--
-- @param  renderMode number  New render mode to set, see RENDERMODE_ Enums.
function SetRenderMode( renderMode) end

--- Entity:SetRenderOrigin
-- @usage client
-- Set the origin in which the Entity will be drawn from.
--
-- @param  newOrigin Vector  The new origin in world coordinates where the Entity's model will now be rendered from.
function SetRenderOrigin( newOrigin) end

--- Entity:SetSaveValue
-- @usage shared
-- Sets a save value for an entity.
--
-- @param  name string  Name of the save value to set
-- @param  value any  Value to set
function SetSaveValue( name,  value) end

--- Entity:SetSequence
-- @usage shared
-- Sets the entity's model sequence. If the specified sequence is already active, the animation will not be restarted. See also Entity:ResetSequence.
--
-- @param  sequenceId number  The sequence to play. If set to a string the function will automatically call Entity:LookupSequence to retrieve the sequence ID as a number.
function SetSequence( sequenceId) end

--- Entity:SetShouldPlayPickupSound
-- @usage shared
-- Sets whether or not the entity should make a physics contact sound when it's been picked up by a player.
--
-- @param  playsound boolean  True to play the pickup sound, false or nil otherwise.
function SetShouldPlayPickupSound( playsound) end

--- Entity:SetShouldServerRagdoll
-- @usage shared
-- Sets if entity should create a server ragdoll on death or a client one.
--
-- @param  serverragdoll boolean  Set true if ragdoll should be created on server, false if on client
function SetShouldServerRagdoll( serverragdoll) end

--- Entity:SetSkin
-- @usage shared
-- Sets the skin of the entity.
--
-- @param  skinIndex number  Index of the skin to use.
function SetSkin( skinIndex) end

--- Entity:SetSolid
-- @usage shared
-- Sets the solidity of an entity.
--
-- @param  solid_type number  The solid type. See the SOLID_ Enums.
function SetSolid( solid_type) end

--- Entity:SetSolidFlags
-- @usage shared
-- Sets solid flag(s) for the entity.
--
-- @param  flags number  The flag(s) to set, see FSOLID_ Enums.
function SetSolidFlags( flags) end

--- Entity:SetSpawnEffect
-- @usage shared
-- Sets whether the entity should use a spawn effect. See also: Entity:GetSpawnEffect
--
-- @param  spawnEffect boolean  Sets if we should show a spawn effect.
function SetSpawnEffect( spawnEffect) end

--- Entity:SetSubMaterial
-- @usage shared
-- Overrides a single material on the model of this entity.
--
-- @param  index=nil number  Index of the material to override, starts with 0. Indexes are by Entity:GetMaterials, but you have to subtract 1 from them.  If called with no arguments, all sub materials will be reset.
-- @param  material=nil string  The material to override the default one with. Set to nil to revert to default material.
function SetSubMaterial( index,  material) end

--- Entity:SetTable
-- @usage shared
-- Changes the table that can be accessed by indexing an entity. Each entity starts with its own table by default.
--
-- @param  tab table  Table for the entity to use
function SetTable( tab) end

--- Entity:SetTransmitWithParent
-- @usage shared
-- When this flag is set the entity will only transmit to the player when its parent is transmitted. This is useful for things like viewmodel attachments since without this flag they will transmit to everyone (and cause the viewmodels to transmit to everyone too).
--
-- @param  onoff boolean  Will set the TransmitWithParent flag on or off
function SetTransmitWithParent( onoff) end

--- Entity:SetTrigger
-- @usage server
-- Marks the entity as a trigger, so it will generate ENTITY:StartTouch, ENTITY:Touch and ENTITY:EndTouch callbacks
--
-- @param  maketrigger boolean  Make the entity trigger or not
function SetTrigger( maketrigger) end

--- Entity:SetUnFreezable
-- @usage server
-- Sets whether an entity can be unfrozen, meaning that it cannot be unfrozen using the physgun.
--
-- @param  freezable boolean  True to make the entity unfreezable, false or nil otherwise.
function SetUnFreezable( freezable) end

--- Entity:SetupBones
-- @usage client
-- Forces the entity to reconfigure its bones. You might need to call this after changing your model's scales or when manually drawing the entity multiple times at different positions.
--
function SetupBones() end

--- Entity:SetupPhonemeMappings
-- @usage client
-- Initializes the class names of an entity's phoneme mappings (mouth movement data). This is called by default with argument "phonemes" when a flex-based entity (such as an NPC) is created.
--
-- @param  fileRoot string  The file prefix of the phoneme mappings (relative to "garrysmod/expressions/").
function SetupPhonemeMappings( fileRoot) end

--- Entity:SetUseType
-- @usage server
-- Sets the use type of an entity, affecting how often ENTITY:Use will be called for Lua entities.
--
-- @param  useType number  The use type to apply to the entity. See USE_ Enums
function SetUseType( useType) end

--- Entity:SetVar
-- @usage shared
-- Allows to quickly set variable to entitys Entity:GetTable.
--
-- @param  name string  Name of variable to set
-- @param  value any  Value to set the variable to
function SetVar( name,  value) end

--- Entity:SetVelocity
-- @usage shared
-- Sets an entity's velocity with a given vector velocity.
--Note: If applied to player, it will ADD velocity, not SET it.
--
-- @param  velocity Vector  The new velocity to set
function SetVelocity( velocity) end

--- Entity:SetWeaponModel
-- @usage shared
-- Sets the model and associated weapon to this viewmodel entity.
--
-- @param  viewModel string  The model string to give to this viewmodel.  Example: "models/weapons/c_smg1.mdl"
-- @param  weapon=NULL Weapon  The weapon entity to associate this viewmodel to.
function SetWeaponModel( viewModel,  weapon) end

--- Entity:SkinCount
-- @usage shared
-- Returns the amount of skins the entity has.
--
-- @return number skinCount
function SkinCount() end

--- Entity:SnatchModelInstance
-- @usage client
-- Moves the model instance from the source entity to this entity. This can be used to transfer decals that have been applied on one entity to another.
--
-- @param  srcEntity Entity  Entity to move the model instance from.
-- @return boolean Whether the operation was successful or not
function SnatchModelInstance( srcEntity) end

--- Entity:Spawn
-- @usage shared
-- Initializes the entity and starts its networking.
--
function Spawn() end

--- Entity:StartLoopingSound
-- @usage shared
-- The function seems to be broken.
--
-- @param  sound string  Sound to play
-- @return number The ID number of started sound.
function StartLoopingSound( sound) end

--- Entity:StartMotionController
-- @usage shared
-- Starts a motion controller in the physics engine tied to this entity's PhysObj, which enables the use of ENTITY:PhysicsSimulate.
--
function StartMotionController() end

--- Entity:StopAndDestroyParticles
-- @usage client
-- Stops all particle effects parented to the entity and immediately destroys them.
--
function StopAndDestroyParticles() end

--- Entity:StopLoopingSound
-- @usage shared
-- The function seems to be broken.
--
-- @param  id number  The sound ID returned by Entity:StartLoopingSound
function StopLoopingSound( id) end

--- Entity:StopMotionController
-- @usage shared
-- Stops the motion controller created with Entity:StartMotionController.
--
function StopMotionController() end

--- Entity:StopParticleEmission
-- @usage client
-- Stops all particle effects parented to the entity.
--
function StopParticleEmission() end

--- Entity:StopParticles
-- @usage shared
-- Stops any attached to the entity .pcf particles using ParticleEffectAttach.
--
function StopParticles() end

--- Entity:StopParticlesNamed
-- @usage client
-- Stops all particle effects parented to the entity with given name.
--
-- @param  name string  The name of the particle to stop.
function StopParticlesNamed( name) end

--- Entity:StopParticlesWithNameAndAttachment
-- @usage client
-- Stops all particle effects parented to the entity with given name on given attachment.
--
-- @param  name string  The name of the particle to stop.
-- @param  attachment number  The attachment of the entity to stop particles on.
function StopParticlesWithNameAndAttachment( name,  attachment) end

--- Entity:StopSound
-- @usage shared
-- Stops emitting the given sound from the entity.
--
-- @param  fileName string  Path to the sound file
function StopSound( fileName) end

--- Entity:TakeDamage
-- @usage server
-- Applies the specified amount of damage to the entity.
--
-- @param  damageAmount number  The amount of damage to be applied.
-- @param  attacker Entity  The entity that initiated the attack that caused the damage.
-- @param  inflictor Entity  The entity that applied the damage, eg. a weapon.
function TakeDamage( damageAmount,  attacker,  inflictor) end

--- Entity:TakeDamageInfo
-- @usage server
-- Applies the damage specified by the damage info to the entity.
--
-- @param  damageInfo CTakeDamageInfo  The damage to apply.
function TakeDamageInfo( damageInfo) end

--- Entity:TakePhysicsDamage
-- @usage server
-- Applies physics damage to the entity
--
-- @param  dmginfo CTakeDamageInfo  The damage to apply
function TakePhysicsDamage( dmginfo) end

--- Entity:TestPVS
-- @usage server
-- Check if the given position or entity is within this entity's PVS.
--
-- @param  testPoint any  Entity or Vector to test against. If an entity is given, this function will test using its bounding box.
-- @return boolean True if the testPoint is within our PVS.
function TestPVS( testPoint) end

--- Entity:TranslateBoneToPhysBone
-- @usage shared
-- Gets the phys bone for a bone
--
-- @param  bone number  The number of the bone
-- @return number The number of the phys bone
function TranslateBoneToPhysBone( bone) end

--- Entity:TranslatePhysBoneToBone
-- @usage shared
-- Gets the bone number corresponding to a physics bone.
--
-- @param  physNum number  Number of the physics object
-- @return number boneNum
function TranslatePhysBoneToBone( physNum) end

--- Entity:Use
-- @usage server
-- Activates the entity, as if a player pressed the Use key (Default E) on it.
--
-- @param  Activator Player  The player to credit with activating the entity.
-- @param  Caller Entity  Used when an entity instead of a player should trigger the use.
-- @param  UseType number  The type of use to trigger. See USE_ Enums
-- @param  Integer number  You can usually set this to 1.
function Use( Activator,  Caller,  UseType,  Integer) end

--- Entity:UseClientSideAnimation
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
function UseClientSideAnimation() end

--- Entity:UseTriggerBounds
-- @usage shared
-- Enables or disables trigger bounds.
--
-- @param  enable boolean  Should we enable or disable the bounds.
-- @param  bloat=0 number  The distance/size of the trigger bounds.
function UseTriggerBounds( enable,  bloat) end

--- Entity:ViewModelIndex
-- @usage shared
-- Returns the index of this view model, it can be used to identify which one of the player's view models this entity is.
--
-- @return number View model index, ranges from 0 to 2, nil if the entity is not a view model
function ViewModelIndex() end

--- Entity:Visible
-- @usage server
-- Returns true if the provided entity is visible from the passed entity.
--
-- @param  Entity Entity  Entity to check for visibility to.
-- @return boolean If the entities can see each other.
function Visible( Entity) end

--- Entity:VisibleVec
-- @usage server
-- Returns true if supplied vector is visible from the entity's line of sight.
--
-- @param  pos Vector  The position to check for visibility
-- @return boolean Within line of sight
function VisibleVec( pos) end

--- Entity:WaterLevel
-- @usage shared
-- Returns an integer that represents how deep in water the entity is.
--
-- @return number The water level.
function WaterLevel() end

--- Entity:Weapon_SetActivity
-- @usage shared
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  act number  See ACT_ Enums
-- @param  duration number  Scales playback rate
function Weapon_SetActivity( act,  duration) end

--- Entity:Weapon_TranslateActivity
-- @usage shared
-- Calls and returns WEAPON:TranslateActivity on the weapon the entity ( player or NPC ) carries.
--
-- @param  act number  The activity to translate
-- @return number The translated activity
function Weapon_TranslateActivity( act) end

--- Entity:WorldSpaceAABB
-- @usage shared
-- Returns two vectors representing the minimum and maximum extent of the entity's bounding box.
--
-- @return Vector The minimum vector for the entity's bounding box.
-- @return Vector The maximum vector for the entity's bounding box.
function WorldSpaceAABB() end

--- Entity:WorldSpaceCenter
-- @usage shared
-- Returns the center of the entity according to its collision model.
--
-- @return Vector pos
function WorldSpaceCenter() end

--- Entity:WorldToLocal
-- @usage shared
-- Converts a worldspace vector into a vector local to an entity
--
-- @param  wpos Vector  The world vector
-- @return Vector The local vector
function WorldToLocal( wpos) end

--- Entity:WorldToLocalAngles
-- @usage shared
-- Converts world angles to local angles ( local to the entity )
--
-- @param  ang Angle  The world angles
-- @return Angle The local angles
function WorldToLocalAngles( ang) end

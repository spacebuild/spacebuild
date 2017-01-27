---
-- @description Library duplicator
 module("duplicator")

--- duplicator.Allow
-- @usage shared
-- Allow this entity to be duplicated
--
-- @param  classname string  An entity's classname
function Allow( classname) end

--- duplicator.ApplyBoneModifiers
-- @usage server
-- Calls every function registered with duplicator.RegisterBoneModifier on each bone the ent has.
--
-- @param  ply Player  The player whose entity this is
-- @param  ent Entity  The entity in question
function ApplyBoneModifiers( ply,  ent) end

--- duplicator.ApplyEntityModifiers
-- @usage server
-- Calls every function registered with duplicator.RegisterEntityModifier on the entity.
--
-- @param  ply Player  The player whose entity this is
-- @param  ent Entity  The entity in question
function ApplyEntityModifiers( ply,  ent) end

--- duplicator.ClearEntityModifier
-- @usage server
-- Clears/removes the chosen entity modifier from the entity.
--
-- @param  ent Entity  The entity the modification is stored on
-- @param  key any  The key of the stored entity modifier
function ClearEntityModifier( ent,  key) end

--- duplicator.Copy
-- @usage server
-- Copies the entity, and all of its constraints and entities, then returns them in a table.
--
-- @param  ent Entity  The entity to duplicate. The function will automatically copy all constrained entities.
-- @param  tableToAdd={} table  A preexisting table to add entities and constraints in from.  Uses the same table format as the table returned from this function.
-- @return table A table containing duplication info which includes the following members:  table Entities  table Constraints  Vector Mins  Vector Maxs  The values of Mins & Maxs from the table are returned from duplicator.WorkoutSize
function Copy( ent,  tableToAdd) end

--- duplicator.CopyEnts
-- @usage server
-- Copies the passed table of entities to save for later.
--
-- @param  ents table  A table of entities to save/copy.
-- @return table A table containing duplication info which includes the following members:  table Entities  table Constraints  Vector Mins  Vector Maxs
function CopyEnts( ents) end

--- duplicator.CopyEntTable
-- @usage server
-- Returns a table with some entity data that can be used to create a new entity with duplicator.CreateEntityFromTable
--
-- @param  ent Entity  The entity table to save
-- @return table See EntityCopyData structure
function CopyEntTable( ent) end

--- duplicator.CreateConstraintFromTable
-- @usage server
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  constraint table  Saved/copied constraint table
-- @param  entityList table  The list of entities that are to be constrained
-- @return Entity The newly created constraint entity
function CreateConstraintFromTable( constraint,  entityList) end

--- duplicator.CreateEntityFromTable
-- @usage server
-- "Create an entity from a table." 
--This creates an entity using the data in EntTable.
--If an entity factory has been registered for the entity's Class, it will be called. 
--Otherwise, duplicator.GenericDuplicatorFunction will be called instead.
--
-- @param  ply Player  The player who wants to create something
-- @param  entTable table  The duplication data to build the entity with. See EntityCopyData structure
-- @return Entity The newly created entity
function CreateEntityFromTable( ply,  entTable) end

--- duplicator.DoBoneManipulator
-- @usage server
-- "Restores the bone's data."
--Loops through Bones and calls Entity:ManipulateBoneScale, Entity:ManipulateBoneAngles and Entity:ManipulateBonePosition on ent with the table keys and the subtable values s, a and p respectively.
--
-- @param  ent Entity  The entity to be bone manipulated
-- @param  bones table  Table with a BoneManipulationData structure for every bone (that has manipulations applied) using the bone ID as the table index.
function DoBoneManipulator( ent,  bones) end

--- duplicator.DoFlex
-- @usage server
-- Restores the flex data using Entity:SetFlexWeight and Entity:SetFlexScale
--
-- @param  ent Entity  The entity to restore the flexes on
-- @param  flex table  The flexes to restore
-- @param  scale=nil number  The flex scale to apply. (Flex scale is unchanged if omitted)
function DoFlex( ent,  flex,  scale) end

--- duplicator.DoGeneric
-- @usage server
-- "Applies generic every-day entity stuff for ent from table data."
--Depending on the values of Model, Angle, Pos, Skin, Flex, Bonemanip, ModelScale, ColGroup, Name, and BodyG (table of multiple values) in the data table, this calls Entity:SetModel, Entity:SetAngles, Entity:SetPos, Entity:SetSkin, duplicator.DoFlex, duplicator.DoBoneManipulator, Entity:SetModelScale, Entity:SetCollisionGroup, Entity:SetName, Entity:SetBodygroup on ent.
--If ent has a RestoreNetworkVars function, it is called with data.DT.
--
-- @param  ent Entity  The entity to be applied upon
-- @param  data table  The data to be applied onto the entity
function DoGeneric( ent,  data) end

--- duplicator.DoGenericPhysics
-- @usage server
-- "Applies bone data, generically."
--If data contains a PhysicsObjects table, it moves, re-angles and if relevent freezes all specified bones, first converting from local coordinates to world coordinates.
--
-- @param  ent Entity  The entity to be applied upon
-- @param  ply=nil Player  The player who owns the entity. Unused in function as of early 2013
-- @param  data table  The data to be applied onto the entity
function DoGenericPhysics( ent,  ply,  data) end

--- duplicator.FindEntityClass
-- @usage shared
-- Returns the entity class factory registered with duplicator.RegisterEntityClass.
--
-- @param  name string  The name of the entity class factory
-- @return table Is compromised of the following members:  function Func - The function that creates the entity  table Args - Arguments to pass to the function
function FindEntityClass( name) end

--- duplicator.GenericDuplicatorFunction
-- @usage server
-- "Generic function for duplicating stuff" 
--This is called when duplicator.CreateEntityFromTable can't find an entity factory to build with. It calls duplicator.DoGeneric and duplicator.DoGenericPhysics to apply standard duplicator stored things such as the model and position.
--
-- @param  ply Player  The player who wants to create something
-- @param  data table  The duplication data to build the entity with
-- @return Entity The newly created entity
function GenericDuplicatorFunction( ply,  data) end

--- duplicator.GetAllConstrainedEntitiesAndConstraints
-- @usage server
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ent Entity  The entity to start from
-- @param  entStorageTable table  The table the entities will be inserted into
-- @param  constraintStorageTable table  The table the constraints will be inserted into
-- @return table entStorageTable
-- @return table constraintStorageTable
function GetAllConstrainedEntitiesAndConstraints( ent,  entStorageTable,  constraintStorageTable) end

--- duplicator.IsAllowed
-- @usage shared
-- Returns whether the entity can be duplicated or not
--
-- @param  classname string  An entity's classname
-- @return boolean Returns true if the entity can be duplicated (nil otherwise)
function IsAllowed( classname) end

--- duplicator.Paste
-- @usage server
-- "Given entity list and constraint list, create all entities and return their tables"
--
-- @param  Player Player  The player who wants to create something
-- @param  EntityList table  A table of duplicator data to create the entities from
-- @param  ConstraintList table  A table of duplicator data to create the constraints from
function Paste( Player,  EntityList,  ConstraintList) end

--- duplicator.RegisterBoneModifier
-- @usage shared
-- Registers a function to be called on each of an entity's bones when duplicator.ApplyBoneModifiers is called.
--
-- @param  key any  The type of the key doesn't appear to matter, but it is preferable to use a string.
-- @param  boneModifier function  Function called on each bone that an ent has. Called during duplicator.ApplyBoneModifiers. Function parameters are:   Player ply  Entity ent  number boneID  PhysObj bone  table data    The data table that is passed to boneModifier is set with duplicator.StoreBoneModifier
function RegisterBoneModifier( key,  boneModifier) end

--- duplicator.RegisterConstraint
-- @usage shared
-- Register a function used for creating a duplicated constraint.
--
-- @param  name string  The unique name of new constraint
-- @param  callback function  Function to be called when this constraint is created
-- @param  ... any  Arguments passed to the callback function
function RegisterConstraint( name,  callback,  ...) end

--- duplicator.RegisterEntityClass
-- @usage shared
-- This allows you to specify a specific function to be run when your SENT is pasted with the duplicator, instead of relying on the generic automatic functions.
--
-- @param  name string  The ClassName of the entity you wish to register a factory for
-- @param  func function  The factory function you want to have called. It should have the arguments (Player, ...) where ... is whatever arguments you request to be passed.
-- @param  args vararg  A list of arguments you want passed from the duplication data table.
function RegisterEntityClass( name,  func,  args) end

--- duplicator.RegisterEntityModifier
-- @usage shared
-- This allows you to register tweaks to entities. For instance, if you were making an "unbreakable" addon, you would use this to enable saving the "unbreakable" state of entities between duplications. 
--This function registers a piece of generic code that is run on all entities with this modifier. In order to have it actually run, use duplicator.StoreEntityModifier.
--
-- @param  name string  An identifier for your modification. This is not limited, so be verbose. "Person's 'Unbreakable' mod" is far less likely to cause conflicts than "unbreakable"
-- @param  func function  The function to be called for your modification. It should have the arguments (Player, Entity, Data), where data is what you pass to duplicator.StoreEntityModifier.
function RegisterEntityModifier( name,  func) end

--- duplicator.RemoveMapCreatedEntities
-- @usage server
-- Help to remove certain map created entities before creating the saved entities
--This is obviously so we don't get duplicate props everywhere.
--It should be called before calling Paste.
--
function RemoveMapCreatedEntities() end

--- duplicator.SetLocalAng
-- @usage shared
-- "When a copy is copied it will be translated according to these.
--If you set them - make sure to set them back to 0 0 0!"
--
-- @param  v Angle  The angle to offset all pastes from
function SetLocalAng( v) end

--- duplicator.SetLocalPos
-- @usage shared
-- "When a copy is copied it will be translated according to these.
--If you set them - make sure to set them back to 0 0 0!"
--
-- @param  v Vector  The position to offset all pastes from
function SetLocalPos( v) end

--- duplicator.StoreBoneModifier
-- @usage server
-- Stores bone mod data for a registered bone modification function
--
-- @param  ent Entity  The entity to add bone mod data to
-- @param  boneID number  The bone ID.  See Entity:GetPhysicsObjectNum
-- @param  key any  The key for the bone modification
-- @param  data table  The bone modification data that is passed to the bone modification function
function StoreBoneModifier( ent,  boneID,  key,  data) end

--- duplicator.StoreEntityModifier
-- @usage server
-- Stores an entity modifier into an entity for saving
--
-- @param  entity Entity  The entity to store modifier in
-- @param  name string  Unique modifier name
-- @param  data table  Modifier data
function StoreEntityModifier( entity,  name,  data) end

--- duplicator.WorkoutSize
-- @usage server
-- "Work out the AABB size"
--
-- @param  Ents table  A table of entity duplication datums.
function WorkoutSize( Ents) end

---
-- @description Library constraint
 module("constraint")

--- constraint.AddConstraintTable
-- @usage server
-- Stores information about constraints in an entity's table.
--
-- @param  ent1 Entity  The entity to store the information on.
-- @param  constrt Entity  The constraint to store in the entity's table.
-- @param  ent2=nil Entity  Optional. If different from ent1, the info will also be stored in the table for this entity.
-- @param  ent3=nil Entity  Optional. Same as ent2.
-- @param  ent4=nil Entity  Optional. Same as ent2.
function AddConstraintTable( ent1,  constrt,  ent2,  ent3,  ent4) end

--- constraint.AddConstraintTableNoDelete
-- @usage server
-- Stores info about the constraints on the entity's table. The only difference between this and constraint.AddConstraintTable is that the constraint does not get deleted when the entity is removed.
--
-- @param  ent1 Entity  The entity to store the information on.
-- @param  constrt Entity  The constraint to store in the entity's table.
-- @param  ent2=nil Entity  Optional. If different from ent1, the info will also be stored in the table for this entity.
-- @param  ent3=nil Entity  Optional. Same as ent2.
-- @param  ent4=nil Entity  Optional. Same as ent2.
function AddConstraintTableNoDelete( ent1,  constrt,  ent2,  ent3,  ent4) end

--- constraint.AdvBallsocket
-- @usage server
-- Creates an advanced ballsocket (ragdoll) constraint.
--
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls)
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls)
-- @param  LPos1 Vector 
-- @param  LPos2 Vector 
-- @param  forcelimit number  Amount of force until it breaks (0 = unbreakable)
-- @param  torquelimit number  Amount of torque (rotation speed) until it breaks (0 = unbreakable)
-- @param  xmin number 
-- @param  ymin number 
-- @param  zmin number 
-- @param  xmax number 
-- @param  ymax number 
-- @param  zmax number 
-- @param  xfric number 
-- @param  yfric number 
-- @param  zfric number 
-- @param  onlyrotation number 
-- @param  nocollide number  Whether the entities should be no-collided.
-- @return Entity Constraint. Will return false if the constraint could not be created.
function AdvBallsocket( Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  forcelimit,  torquelimit,  xmin,  ymin,  zmin,  xmax,  ymax,  zmax,  xfric,  yfric,  zfric,  onlyrotation,  nocollide) end

--- constraint.Axis
-- @usage server
-- Creates an axis constraint.
--
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity.
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls)
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls)
-- @param  LPos1 Vector 
-- @param  LPos2 Vector 
-- @param  forcelimit number  Amount of force until it breaks (0 = unbreakable)
-- @param  torquelimit number  Amount of torque (rotation speed) until it breaks (0 = unbreakable)
-- @param  friction number 
-- @param  nocollide number  Whether the entities should be no-collided.
-- @param  LocalAxis Vector  If you include the LocalAxis then LPos2 will not be used in the final constraint. However, LPos2 is still a required argument.
-- @param  DontAddTable boolean  Whether or not to add the constraint info on the entity table. See constraint.AddConstraintTable.
-- @return Entity Constraint. Will return false if the constraint could not be created.
function Axis( Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  forcelimit,  torquelimit,  friction,  nocollide,  LocalAxis,  DontAddTable) end

--- constraint.Ballsocket
-- @usage server
-- Creates a ballsocket joint.
--
-- @param  Ent1 Entity  First entity
-- @param  Ent2 Entity  Second entity
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls)
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls)
-- @param  LocalPos Vector  Centerposition of the joint, relative to the second entity.
-- @param  forcelimit number  Amount of force until it breaks (0 = unbreakable)
-- @param  torquelimit number  Amount of torque (rotation speed) until it breaks (0 = unbreakable)
-- @param  nocollide number  Whether the entities should be nocollided
-- @return Entity Constraint. Will return false if the constraint could not be created.
function Ballsocket( Ent1,  Ent2,  Bone1,  Bone2,  LocalPos,  forcelimit,  torquelimit,  nocollide) end

--- constraint.CanConstrain
-- @usage server
-- Basic checks to make sure that the specified entity and bone are valid. Returns false if we should not be constraining the entity.
--
-- @param  ent Entity  The entity to check
-- @param  bone number  The bone of the entity to check (use 0 for mono boned ents)
-- @return boolean shouldConstrain
function CanConstrain( ent,  bone) end

--- constraint.CreateKeyframeRope
-- @usage server
-- Creates a rope without any constraint
--
-- @param  pos Vector 
-- @param  width number 
-- @param  material string 
-- @param  Constraint Entity 
-- @param  Ent1 Entity 
-- @param  LPos1 Vector 
-- @param  Bone1 number 
-- @param  Ent2 Entity 
-- @param  LPos2 Vector 
-- @param  Bone2 number 
-- @param  kv table 
-- @return Entity rope
function CreateKeyframeRope( pos,  width,  material,  Constraint,  Ent1,  LPos1,  Bone1,  Ent2,  LPos2,  Bone2,  kv) end

--- constraint.CreateStaticAnchorPoint
-- @usage server
-- Creates an invisible, non-moveable anchor point in the world to which things can be attached.
--
-- @param  pos Vector  The position to spawn the anchor at
-- @return Entity anchor
-- @return PhysObj physicsObject,
-- @return number bone
-- @return Vector LPos
function CreateStaticAnchorPoint( pos) end

--- constraint.Elastic
-- @usage server
-- Creates an elastic constraint.
--
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls)
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls)
-- @param  LPos1 Vector  Position of first end of the rope. Local to Ent1.
-- @param  LPos2 Vector  Position of second end of the rope. Local to Ent2.
-- @param  constant number 
-- @param  damping number 
-- @param  rdamping number 
-- @param  material string  The material of the rope.
-- @param  width number  Width of rope.
-- @param  stretchonly boolean 
-- @return Entity Constraint. Will return false if the constraint could not be created.
-- @return Entity rope. Will return nil if the constraint could not be created.
function Elastic( Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  constant,  damping,  rdamping,  material,  width,  stretchonly) end

--- constraint.Find
-- @usage server
-- Returns the constraint of a specified type between two entities, if it exists
--
-- @param  ent1 Entity  The first entity to check
-- @param  ent2 Entity  The second entity to check
-- @param  type string  The constraint type to look for (eg. "Weld", "Elastic", "NoCollide")
-- @param  bone1 number  The bone number for the first entity (0 for monoboned entities)
-- @param  bone2 number  The bone number for the second entity
-- @return Entity constraint
function Find( ent1,  ent2,  type,  bone1,  bone2) end

--- constraint.FindConstraint
-- @usage server
-- Returns the first constraint of a specific type directly connected to the entity found
--
-- @param  ent Entity  The entity to check
-- @param  type string  The type of constraint (eg. "Weld", "Elastic", "NoCollide")
-- @return table The constraint table, set with constraint.AddConstraintTable
function FindConstraint( ent,  type) end

--- constraint.FindConstraintEntity
-- @usage server
-- Returns the other entity involved in the first constraint of a specific type directly connected to the entity
--
-- @param  ent Entity  The entity to check
-- @param  type string  The type of constraint (eg. "Weld", "Elastic", "NoCollide")
-- @return Entity The other entity.
function FindConstraintEntity( ent,  type) end

--- constraint.FindConstraints
-- @usage server
-- Returns a table of all constraints of a specific type directly connected to the entity
--
-- @param  ent Entity  The entity to check
-- @param  type string  The type of constraint (eg. "Weld", "Elastic", "NoCollide")
-- @return table All the constraints of this entity.
function FindConstraints( ent,  type) end

--- constraint.ForgetConstraints
-- @usage server
-- Make this entity forget any constraints it knows about. Note that this will not actually remove the constraints.
--
-- @param  ent Entity  The entity that will forget its constraints.
function ForgetConstraints( ent) end

--- constraint.GetAllConstrainedEntities
-- @usage server
-- Returns a table of all entities recursively constrained to an entitiy.
--
-- @param  ent Entity  The entity to check
-- @param  ResultTable=nil table  Table used to return result. Optional.
-- @return table A table containing all of the constrained entities. This includes all entities constrained to entities constrained to the supplied entity, etc.
function GetAllConstrainedEntities( ent,  ResultTable) end

--- constraint.GetTable
-- @usage server
-- Returns a table of all constraints directly connected to the entity
--
-- @param  ent Entity  The entity to check
-- @return table A list of all constraints connected to the entity.
function GetTable( ent) end

--- constraint.HasConstraints
-- @usage server
-- Returns true if the entity has constraints attached to it
--
-- @param  ent Entity  The entity to check
-- @return boolean Whether the entity has any constraints or not.
function HasConstraints( ent) end

--- constraint.Hydraulic
-- @usage server
-- Creates a Hydraulic constraint.
--
-- @param  pl Player  The player that will be used to call numpad.OnDown.
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity.
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls),
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls).
-- @param  LPos1 Vector 
-- @param  LPos2 Vector 
-- @param  Length1 number 
-- @param  Length2 number 
-- @param  width number  The width of the rope.
-- @param  key number  The key binding, corresponding to an KEY_ Enums
-- @param  fixed number  Whether the hydraulic is fixed.
-- @param  speed number 
-- @param  material string  The material of the rope.
-- @return Entity Constraint. Will return false if the constraint could not be created.
-- @return Entity rope. Will return nil if the constraint could not be created.
-- @return Entity controller. Can return nil depending on how the constraint was created. Will return nil if the constraint could not be created.
-- @return Entity slider. Can return nil depending on how the constraint was created. Will return nil if the constraint could not be created.
function Hydraulic( pl,  Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  Length1,  Length2,  width,  key,  fixed,  speed,  material) end

--- constraint.Keepupright
-- @usage server
-- Creates a keep upright constraint.
--
-- @param  ent Entity  The entity to keep upright
-- @param  ang Angle  The angle defined as "upright"
-- @param  bone number  The bone of the entity to constrain (0 for boneless)
-- @param  angularLimit number  Basically, the strength of the constraint
-- @return Entity The created constraint, if any
function Keepupright( ent,  ang,  bone,  angularLimit) end

--- constraint.Motor
-- @usage server
-- Creates a motor constraint.
--
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity.
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls)
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls)
-- @param  LPos1 Vector 
-- @param  LPos2 Vector 
-- @param  friction number 
-- @param  torque number 
-- @param  forcetime number 
-- @param  nocollide number  Whether the entities should be no-collided.
-- @param  toggle number  Whether the constraint is on toggle.
-- @param  pl Player  The player that will be used to call numpad.OnDown and numpad.OnUp.
-- @param  forcelimit number  Amount of force until it breaks (0 = unbreakable)
-- @param  numpadkey_fwd number  The key binding for "forward", corresponding to an KEY_ Enums
-- @param  numpadkey_bwd number  The key binding for "backwards", corresponding to an KEY_ Enums
-- @param  direction number 
-- @param  LocalAxis Vector 
-- @return Entity Constraint. Will return false if the constraint could not be created.
-- @return Entity axis. Will return nil if the constraint could not be created.
function Motor( Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  friction,  torque,  forcetime,  nocollide,  toggle,  pl,  forcelimit,  numpadkey_fwd,  numpadkey_bwd,  direction,  LocalAxis) end

--- constraint.Muscle
-- @usage server
-- Creates a muscle constraint.
--
-- @param  pl Player  The player that will be used to call numpad.OnDown.
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity.
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls)
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls)
-- @param  LPos1 Vector 
-- @param  LPos2 Vector 
-- @param  Length1 number 
-- @param  Length2 number 
-- @param  width number  Width of the rope.
-- @param  key number  The key binding, corresponding to an KEY_ Enums
-- @param  fixed number  Whether the constraint is fixed.
-- @param  period number 
-- @param  amplitude number 
-- @param  starton boolean 
-- @param  material string  Material of the rope.
-- @return Entity Constraint. Will return false if the constraint could not be created.
-- @return Entity rope. Will return nil if the constraint could not be created.
-- @return Entity controller. Will return nil if the constraint could not be created.
-- @return Entity slider. Will return nil if the fixed argument is not 1 or if the constraint could not be created.
function Muscle( pl,  Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  Length1,  Length2,  width,  key,  fixed,  period,  amplitude,  starton,  material) end

--- constraint.NoCollide
-- @usage server
-- Creates an no-collide "constraint". Disables collision between two entities.
--
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity.
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls).
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls).
-- @return Entity Constraint. Will return false if the constraint could not be created.
function NoCollide( Ent1,  Ent2,  Bone1,  Bone2) end

--- constraint.Pulley
-- @usage server
-- Creates a pulley constraint.
--
-- @param  Ent1 Entity 
-- @param  Ent4 Entity 
-- @param  Bone1 number 
-- @param  Bone4 number 
-- @param  LPos1 Vector 
-- @param  LPos4 Vector 
-- @param  WPos2 Vector 
-- @param  WPos3 Vector 
-- @param  forcelimit number  Amount of force until it breaks (0 = unbreakable)
-- @param  rigid boolean  Whether the constraint is rigid.
-- @param  width number  Width of the rope.
-- @param  material string  Material of the rope.
-- @return Entity Constraint. Will return false if the constraint could not be created.
function Pulley( Ent1,  Ent4,  Bone1,  Bone4,  LPos1,  LPos4,  WPos2,  WPos3,  forcelimit,  rigid,  width,  material) end

--- constraint.RemoveAll
-- @usage server
-- Attempts to remove all constraints associated with an entity
--
-- @param  ent Entity  The entity to check
-- @return boolean removedConstraints
-- @return number constraintsRemoved
function RemoveAll( ent) end

--- constraint.RemoveConstraints
-- @usage server
-- Attempts to remove all constraints of a specified type associated with an entity
--
-- @param  ent Entity  The entity to check
-- @param  type string  The constraint type to remove (eg. "Weld", "Elastic", "NoCollide")
-- @return boolean Whether we removed any constraints or not
-- @return number The amount of constraints removed
function RemoveConstraints( ent,  type) end

--- constraint.Rope
-- @usage server
-- Creates a rope constraint - with rope!
--
-- @param  Ent1 Entity  First entity
-- @param  Ent2 number  Second entity
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls)
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls)
-- @param  LPos1 Vector  Position of first end of the rope. Local to Ent1.
-- @param  LPos2 Vector  Position of second end of the rope. Local to Ent2.
-- @param  length number  Length of the rope.
-- @param  addlength number  Amount to add to the length of the rope. Works as it does in the Rope tool.
-- @param  forcelimit number  Amount of force until it breaks (0 = unbreakable).
-- @param  width number  Width of the rope.
-- @param  material string  Material of the rope.
-- @param  rigid boolean  Whether the constraint is rigid.
-- @return Entity Constraint. Will be a keyframe_rope if you roping to the same bone on the same entity. Will return false if the constraint could not be created.
-- @return Entity rope. Will return nil if "Constraint" is a keyframe_rope or if the constraint could not be created.
function Rope( Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  length,  addlength,  forcelimit,  width,  material,  rigid) end

--- constraint.Slider
-- @usage server
-- Creates a slider constraint.
--
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity.
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls),
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls).
-- @param  LPos1 Vector 
-- @param  LPos2 Vector 
-- @param  width number  The width of the rope.
-- @param  material string  The material of the rope.
-- @return Entity Constraint. Will return false if the constraint could not be created.
-- @return Entity rope. Will return nil if the constraint could not be created.
function Slider( Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  width,  material) end

--- constraint.Weld
-- @usage server
-- Creates a weld constraint
--
-- @param  ent1 Entity  The first entity
-- @param  ent2 Entity  The second entity
-- @param  bone1 number  The bonenumber of the first entity (0 for monoboned entities)
-- @param  bone2 number  The bonenumber of the second entity
-- @param  forcelimit number  The amount of force appliable to the constraint before it will break (0 is never)
-- @param  nocollide boolean  Should ent1 be nocollided to ent2 via this constraint
-- @param  deleteent1onbreak boolean  If true, when ent2 is removed, ent1 will also be removed
-- @return Entity constraint
function Weld( ent1,  ent2,  bone1,  bone2,  forcelimit,  nocollide,  deleteent1onbreak) end

--- constraint.Winch
-- @usage server
-- Creates a Winch constraint.
--
-- @param  pl Player  The player that will be used to call numpad.OnDown and numpad.OnUp.
-- @param  Ent1 Entity  First entity.
-- @param  Ent2 Entity  Second entity.
-- @param  Bone1 number  Bone of first entity (0 for non-ragdolls),
-- @param  Bone2 number  Bone of second entity (0 for non-ragdolls).
-- @param  LPos1 Vector 
-- @param  LPos2 Vector 
-- @param  width number  The width of the rope.
-- @param  key number  The key binding for "forward", corresponding to an KEY_ Enums
-- @param  key number  The key binding for "backwards", corresponding to an KEY_ Enums
-- @param  fwd_speed number  Forward speed.
-- @param  bwd_speed number  Backwards speed.
-- @param  material string  The material of the rope.
-- @param  toggle boolean  Whether the winch should be on toggle.
-- @return Entity Constraint. Can return nil. Will return false if the constraint could not be created.
-- @return Entity rope. Will return nil if the constraint could not be created.
-- @return Entity controller. Can return nil.
function Winch( pl,  Ent1,  Ent2,  Bone1,  Bone2,  LPos1,  LPos2,  width,  key,  key,  fwd_speed,  bwd_speed,  material,  toggle) end

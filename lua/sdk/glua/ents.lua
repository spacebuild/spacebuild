---
-- @description Library ents
 module("ents")

--- ents.Create
-- @usage server
-- Starts creating an entity.
--
-- @param  class string  The classname of the entity to create
-- @return Entity The created entity
function Create( class) end

--- ents.CreateClientProp
-- @usage client
-- Creates a clientside only prop. See also ClientsideModel.
--
-- @param  model="models/error.mdl" string  The model for the entity to be created.  BUG: Has to be precached with util.PrecacheModel if not precached previously by engine or other means.
-- @return Entity Created entity.
function CreateClientProp( model) end

--- ents.FindByClass
-- @usage shared
-- Gets all entities with the given class, supports wildcards. This works internally by iterating over ents.GetAll.
--
-- @param  class string  The class of the entities to find.
-- @return table A table containing all found entities
function FindByClass( class) end

--- ents.FindByClassAndParent
-- @usage shared
-- Finds all entities that are of given class and are children of given entity. This works internally by iterating over ents.GetAll.
--
-- @param  class string  The class of entities to search for
-- @param  parent Entity  Parent of entities that are being searched for
-- @return table A table of found entities or nil if none are found
function FindByClassAndParent( class,  parent) end

--- ents.FindByModel
-- @usage shared
-- Gets all entities with the given model, supports wildcards. This works internally by iterating over ents.GetAll.
--
-- @param  model string  The model of the entities to find.
-- @return table A table of all found entities.
function FindByModel( model) end

--- ents.FindByName
-- @usage shared
-- Gets all entities with the given hammer targetname. This works internally by iterating over ents.GetAll.
--
-- @param  name string  The targetname to look for
-- @return table A table of all found entities
function FindByName( name) end

--- ents.FindInBox
-- @usage shared
-- Gets all entities within the specified box.
--
-- @param  boxMins Vector  The box minimum.
-- @param  boxMaxs Vector  The box maximum.
-- @return table A table of all found entities. Has a limit of 512 entities.
function FindInBox( boxMins,  boxMaxs) end

--- ents.FindInCone
-- @usage shared
-- Performs a ents.FindInBox and returns all entities within the specified cone.
--
-- @param  origin Vector  The "tip" of the cone.
-- @param  normal Vector  Direction of the cone.
-- @param  radius number  The height of the cone.
-- @param  angle number  The angle of the cone.
-- @return table A table of all found entities. Has a limit of 512 entities.
function FindInCone( origin,  normal,  radius,  angle) end

--- ents.FindInPVS
-- @usage server
-- Finds all entities that lie within a PVS.
--
-- @param  viewPoint any  Entity or Vector to find entities within the PVS of. If a player is given, this function will use the player's view entity.
-- @return table The found entities.
function FindInPVS( viewPoint) end

--- ents.FindInSphere
-- @usage shared
-- Gets all entities within the specified sphere.
--
-- @param  origin Vector  Center of the sphere.
-- @param  radius number  Radius of the sphere.
-- @return table A table of all found entities. Has a limit of 1024 entities.
function FindInSphere( origin,  radius) end

--- ents.FireTargets
-- @usage server
-- Fires a use event.
--
-- @param  target string  Name of the target entity
-- @param  activator Entity  Activator of the event
-- @param  caller Entity  Caller of the event.
-- @param  usetype number  Use type. See the USE_ Enums.
-- @param  value number 
function FireTargets( target,  activator,  caller,  usetype,  value) end

--- ents.GetAll
-- @usage shared
-- Returns a table of all existing entities.
--
-- @return table Table of all existing entities.
function GetAll() end

--- ents.GetByIndex
-- @usage shared
-- Returns an entity by its index. Same as Entity.
--
-- @param  entIdx number  The index of the entity.
-- @return Entity The entity if it exists.
function GetByIndex( entIdx) end

--- ents.GetMapCreatedEntity
-- @usage server
-- Returns entity that has given Entity:MapCreationID.
--
-- @param  id number  Entity's creation id
-- @return Entity Found entity
function GetMapCreatedEntity( id) end

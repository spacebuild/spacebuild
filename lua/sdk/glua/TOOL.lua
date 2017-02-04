---
-- @description Library Tool
 module("Tool")

--- Tool:ClearObjects
-- @usage shared
-- Clears all objects previously set with Tool:SetObject.
--
function ClearObjects() end

--- Tool:GetBone
-- @usage shared
-- Retrieves a physics bone number previously stored using Tool:SetObject.
--
-- @param  id number  The id of the object which was set in Tool:SetObject.
function GetBone( id) end

--- Tool:GetClientInfo
-- @usage shared
-- Attempts to grab a clientside tool ConVar.
--
-- @param  name string  Name of the convar to retrieve. The function will automatically add the "mytoolfilename_" part to it.
-- @return string The value of the requested ConVar.
function GetClientInfo( name) end

--- Tool:GetClientNumber
-- @usage shared
-- Attempts to grab a clientside tool ConVar.
--
-- @param  name string  Name of the convar to retrieve. The function will automatically add the "mytoolfilename_" part to it.
-- @param  default=0 number  The default value to return in case the lookup fails.
-- @return number The value of the requested ConVar.
function GetClientNumber( name,  default) end

--- Tool:GetEnt
-- @usage shared
-- Retrieves an Entity previously stored using Tool:SetObject.
--
-- @param  id number  The id of the object which was set in Tool:SetObject.
function GetEnt( id) end

--- Tool:GetOperation
-- @usage shared
-- Returns the current operation of the tool set by Tool:SetOperation.
--
-- @return number The current operation the tool is at.
function GetOperation() end

--- Tool:GetOwner
-- @usage shared
-- Returns the owner of this tool.
--
-- @return Entity Player using the tool
function GetOwner() end

--- Tool:GetServerInfo
-- @usage shared
-- Attempts to grab a serverside tool ConVar.
--This will not do anything on client, despite the function being defined shared.
--
-- @param  name string  Name of the convar to retrieve. The function will automatically add the "mytoolfilename_" part to it.
-- @return string The value of the requested ConVar.
function GetServerInfo( name) end

--- Tool:GetStage
-- @usage shared
-- Returns the current stage of the tool set by Tool:SetStage.
--
-- @return number The current stage of the current operation the tool is at.
function GetStage() end

--- Tool:NumObjects
-- @usage shared
-- Returns the amount of stored objects ( Entitys ) the tool has.
--
-- @return number The amount of stored objects, or Tool:GetStage clientide.
function NumObjects() end

--- Tool:SetObject
-- @usage shared
-- Stores an Entity for later use in the tool.
--
-- @param  id number  The id of the object to store.
-- @param  ent Entity  The entity to store.
-- @param  pos Vector  The position to store.     NOTE  this position is in global space and is internally converted to local space relative to the object, so when you retrieve it later it will be corrected to the object's new position 
-- @param  phys PhysObj  The physics object to store.
-- @param  bone number  The hit bone to store.
-- @param  norm Vector  The hit normal to store.
function SetObject( id,  ent,  pos,  phys,  bone,  norm) end

--- Tool:SetOperation
-- @usage shared
-- Sets the current operation of the tool. Does nothing clientside. See also Tool:SetStage.
--
-- @param  operation number  The new operation ID to set.
function SetOperation( operation) end

--- Tool:SetStage
-- @usage shared
-- Sets the current stage of the tool. Does nothing clientside.
--
-- @param  stage number  The new stage to set.
function SetStage( stage) end

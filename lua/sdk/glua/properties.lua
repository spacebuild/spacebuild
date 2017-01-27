---
-- @description Library properties
 module("properties")

--- properties.Add
-- @usage shared
-- Add properties to the properties module
--
-- @param  name string  A unique name used to identify the property
-- @param  propertyData table  A table that defines the property. Uses the following properties:   string MenuLabel - Label to show on opened menu  string MenuIcon - Icon to show on opened menu for this item  function Filter( ent ) - Return true if we should show a menu for this entity  function Action( ent ) - On menu choice selected  number Order - The order in which it should be shown on the menu  function Receive( len, ply ) - A message has been received from the clientside version  boolean PrependSpacer - (Optional, default is false)Add a spacer before the option in the properties menu  function MenuOpen( data, option, ent, tr ) - (Optional)Called after the menu option was added for modification  function OnCreate( data, option ) - (Optional)Called after MenuOpen
function Add( name,  propertyData) end

--- properties.GetHovered
-- @usage shared
-- Returns an entity player is hovering over with his cursor.
--
-- @param  pos Vector  Eye position of local player, Entity:EyePos
-- @param  aimVec Vector  Aim vector of local player, Player:GetAimVector
-- @return Entity The hovered entity
function GetHovered( pos,  aimVec) end

--- properties.OnScreenClick
-- @usage shared
-- Checks if player hovers over any entities and open a properties menu for it.
--
-- @param  eyepos Vector  The eye pos of a player
-- @param  eyevec Vector  The aim vector of a player
function OnScreenClick( eyepos,  eyevec) end

--- properties.OpenEntityMenu
-- @usage shared
-- Opens properties menu for given entity.
--
-- @param  ent Entity  The entity to open menu for
-- @param  tr table  The trace that is passed as second argument to Action callback of a property
function OpenEntityMenu( ent,  tr) end

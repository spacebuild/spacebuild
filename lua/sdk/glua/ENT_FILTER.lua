---
-- @description Library ENT_FILTER
 module("ENT_FILTER")

--- ENT_FILTER:PassesDamageFilter
-- @usage server
-- Called by Entity:PassesDamageFilter and engine entities to determine whether an entity passes this filter's damage filter.
--
-- @param  dmg CTakeDamageInfo  Damage to test.
-- @return boolean Whether the entity passes the damage filter ( true ) or not. ( false )
function PassesDamageFilter( dmg) end

--- ENT_FILTER:PassesFilter
-- @usage server
-- Called by Entity:PassesFilter and engine entities to determine whether an entity passes this filter's filter.
--
-- @param  trigger Entity  The 'caller' entity, the one that wants to know if the entity passes the filter
-- @param  ent Entity  The entity in question that is being tested
-- @return boolean Whether the entity passes the filter ( true ) or not ( false )
function PassesFilter( trigger,  ent) end

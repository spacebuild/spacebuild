---
-- @description Library widgets
 module("widgets")

--- widgets.PlayerTick
-- @usage shared
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ply Player  The player
-- @param  mv CMoveData  Player move data
function PlayerTick( ply,  mv) end

--- widgets.RenderMe
-- @usage client
-- Renders a widget. Normally you won't need to call this.
--
-- @param  ent Entity  Widget entity to render
function RenderMe( ent) end

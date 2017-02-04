---
-- @description Library halo
 module("halo")

--- halo.Add
-- @usage client
-- Applies a "halo" glow effect to one or multiple entities.
--
-- @param  entities table  A table of entities to add the halo effect to
-- @param  color table  The desired color of the halo.
-- @param  blurX=2 number  The strength of the halo's blur on the x axis.
-- @param  blurY=2 number  The strength of the halo's blur on the y axis.
-- @param  passes=1 number  The number of times the halo should be drawn per frame. Increasing this may hinder player FPS.
-- @param  additive=true boolean  Sets the render mode of the halo to additive.
-- @param  ignoreZ=false boolean  Renders the halo through anything when set to true.
function Add( entities,  color,  blurX,  blurY,  passes,  additive,  ignoreZ) end

--- halo.Render
-- @usage client
-- Renders a halo according to the specified table, only used internally, called from a PostDrawEffects hook added by the halo library
--
-- @param  entry table  Table with info about the halo to draw.
function Render( entry) end

--- halo.RenderedEntity
-- @usage client
-- Returns the entity the halo library is currently rendering the halo for.
--
-- @return Entity If set, the currently rendered entity by the halo library.
function RenderedEntity() end

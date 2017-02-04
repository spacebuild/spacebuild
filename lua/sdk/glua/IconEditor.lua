---
-- @description Library IconEditor
 module("IconEditor")

--- IconEditor:AboveLayout
-- @usage client
-- Applies the top-down view camera settings for the model in the DAdjustableModelPanel.
--
function AboveLayout() end

--- IconEditor:BestGuessLayout
-- @usage client
-- Applies the best camera settings for the model in the DAdjustableModelPanel, using the values returned by PositionSpawnIcon.
--
function BestGuessLayout() end

--- IconEditor:FillAnimations
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ent Entity  The entity being rendered within the model panel.
function FillAnimations( ent) end

--- IconEditor:FullFrontalLayout
-- @usage client
-- Applies the front view camera settings for the model in the DAdjustableModelPanel.
--
function FullFrontalLayout() end

--- IconEditor:OriginLayout
-- @usage client
-- Places the camera at the origin (0,0,0), relative to the entity, in the DAdjustableModelPanel.
--
function OriginLayout() end

--- IconEditor:Refresh
-- @usage client
-- Updates the internal DAdjustableModelPanel and SpawnIcon.
--
function Refresh() end

--- IconEditor:RenderIcon
-- @usage client
-- Re-renders the SpawnIcon.
--
function RenderIcon() end

--- IconEditor:RightLayout
-- @usage client
-- Applies the right side view camera settings for the model in the DAdjustableModelPanel.
--
function RightLayout() end

--- IconEditor:SetDefaultLighting
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function SetDefaultLighting() end

--- IconEditor:SetFromEntity
-- @usage client
-- Sets the editor's model and icon from an entity. Alternative to IconEditor:SetIcon, with uses a SpawnIcon.
--
-- @param  ent Entity  The entity to retrieve the model and skin from.
function SetFromEntity( ent) end

--- IconEditor:SetIcon
-- @usage client
-- Sets the SpawnIcon to modify. You should call Panel:Refresh immediately after this, as the user will not be able to make changes to the icon beforehand.
--
-- @param  icon Panel  The SpawnIcon object to be modified.
function SetIcon( icon) end

--- IconEditor:UpdateEntity
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  ent Entity  The entity being rendered within the model panel.
function UpdateEntity( ent) end

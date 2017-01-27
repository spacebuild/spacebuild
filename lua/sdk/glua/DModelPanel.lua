---
-- @description Library DModelPanel
 module("DModelPanel")

--- DModelPanel:DrawModel
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function DrawModel() end

--- DModelPanel:GetAmbientLight
-- @usage client
-- Returns the ambient lighting used on the rendered entity.
--
-- @return table The color of the ambient lighting.
function GetAmbientLight() end

--- DModelPanel:GetAnimated
-- @usage client
-- Returns whether or not the panel entity should be animated when the default DModelPanel:LayoutEntity function is called.
--
-- @return boolean True if the panel entity can be animated with Entity:SetSequence directly, false otherwise.
function GetAnimated() end

--- DModelPanel:GetAnimSpeed
-- @usage client
-- Returns the animation speed of the panel entity, see DModelPanel:SetAnimSpeed.
--
-- @return number The animation speed.
function GetAnimSpeed() end

--- DModelPanel:GetCamPos
-- @usage client
-- Returns the position of the model viewing camera.
--
-- @return Vector The position of the camera.
function GetCamPos() end

--- DModelPanel:GetColor
-- @usage client
-- Returns the color of the rendered entity.
--
-- @return table The color of the entity, see Color structure.
function GetColor() end

--- DModelPanel:GetEntity
-- @usage client
-- Returns the entity being rendered by the model panel.
--
-- @return CSEnt The rendered entity (client-side)
function GetEntity() end

--- DModelPanel:GetFOV
-- @usage client
-- Returns the FOV (field of view) the camera is using.
--
-- @return number The FOV of the camera.
function GetFOV() end

--- DModelPanel:GetLookAng
-- @usage client
-- Returns the angles of the model viewing camera. Is nil until changed with DModelPanel:SetLookAng.
--
-- @return Angle The angles of the camera.
function GetLookAng() end

--- DModelPanel:GetLookAt
-- @usage client
-- Returns the position the viewing camera is pointing toward.
--
-- @return Vector The position the camera is pointing toward.
function GetLookAt() end

--- DModelPanel:GetModel
-- @usage client
-- Gets the model of the rendered entity.
--
-- @return string The model of the rendered entity.
function GetModel() end

--- DModelPanel:LayoutEntity
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  entity Entity  The entity that is being rendered.
function LayoutEntity( entity) end

--- DModelPanel:PostDrawModel
-- @usage client
-- Called when the entity of the DModelPanel was drawn.
--
-- @param  ent Entity  The clientside entity of the DModelPanel that has been drawn.
function PostDrawModel( ent) end

--- DModelPanel:PreDrawModel
-- @usage client
-- Called before the entity of the DModelPanel is drawn.
--
-- @param  ent Entity  The clientside entity of the DModelPanel that has been drawn.
-- @return boolean Return false to stop the entity from being drawn. This will also cause DModelPanel:PostDrawModel to stop being called.
function PreDrawModel( ent) end

--- DModelPanel:RunAnimation
-- @usage client
-- This function is used in the DModelPanel:LayoutEntity. It will set the active model to the last set animation using Entity:SetSequence. By default, it is the walking animation.
--
function RunAnimation() end

--- DModelPanel:SetAmbientLight
-- @usage client
-- Sets the ambient lighting used on the rendered entity.
--
-- @param  color table  The color of the ambient lighting.
function SetAmbientLight( color) end

--- DModelPanel:SetAnimated
-- @usage client
-- Sets whether or not to animate the entity when the default DModelPanel:LayoutEntity is called.
--
-- @param  animated boolean  True to animate, false otherwise.
function SetAnimated( animated) end

--- DModelPanel:SetAnimSpeed
-- @usage client
-- Sets the speed used by DModelPanel:RunAnimation to advance frame on an entity sequence.
--
-- @param  animSpeed number  The animation speed.
function SetAnimSpeed( animSpeed) end

--- DModelPanel:SetCamPos
-- @usage client
-- Sets the position of the camera.
--
-- @param  pos Vector  The position to set the camera at.
function SetCamPos( pos) end

--- DModelPanel:SetColor
-- @usage client
-- Sets the color of the rendered entity.
--
-- @param  color table  The render color of the entity.
function SetColor( color) end

--- DModelPanel:SetDirectionalLight
-- @usage client
-- Sets the directional lighting used on the rendered entity.
--
-- @param  direction number  The light direction, see BOX_ Enums.
-- @param  color table  The color of the directional lighting.
function SetDirectionalLight( direction,  color) end

--- DModelPanel:SetEntity
-- @usage client
-- Sets the entity to be rendered by the model panel.
--
-- @param  ent Entity  The new panel entity.
function SetEntity( ent) end

--- DModelPanel:SetFOV
-- @usage client
-- Sets the panel camera's FOV (field of view).
--
-- @param  fov number  The field of view value.
function SetFOV( fov) end

--- DModelPanel:SetLookAng
-- @usage client
-- Sets the angles of the camera.
--
-- @param  ang Angle  The angles to set the camera to.
function SetLookAng( ang) end

--- DModelPanel:SetLookAt
-- @usage client
-- Makes the panel's camera face the given position.
--
-- @param  pos Vector  The position to orient the camera toward.
function SetLookAt( pos) end

--- DModelPanel:SetModel
-- @usage client
-- Sets the model of the rendered entity.
--
-- @param  model string  The model to apply to the entity
function SetModel( model) end

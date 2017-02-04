---
-- @description Library DAdjustableModelPanel
 module("DAdjustableModelPanel")

--- DAdjustableModelPanel:CaptureMouse
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function CaptureMouse() end

--- DAdjustableModelPanel:FirstPersonControls
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function FirstPersonControls() end

--- DAdjustableModelPanel:GetFirstPerson
-- @usage client
-- Gets whether mouse and keyboard-based adjustment of the perspective has been enabled. See DAdjustableModelPanel:SetFirstPerson for more information.
--
-- @return boolean Whether first person controls are enabled. See DAdjustableModelPanel:FirstPersonControls.
function GetFirstPerson() end

--- DAdjustableModelPanel:SetFirstPerson
-- @usage client
-- Enables mouse and keyboard-based adjustment of the perspective.
--
-- @param  enable boolean  Whether to enable/disable first person controls. See DAdjustableModelPanel:FirstPersonControls.
function SetFirstPerson( enable) end

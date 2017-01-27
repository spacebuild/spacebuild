---
-- @description Library ControlPresets
 module("ControlPresets")

--- ControlPresets:AddConVar
-- @usage client
-- Adds a convar to be managed by this control.
--
-- @param  convar string  The convar to add.
function AddConVar( convar) end

--- ControlPresets:GetConVars
-- @usage client
-- Get a list of all Console Variables being managed by this panel.
--
-- @return table numbered table of convars
function GetConVars() end

--- ControlPresets:SetLabel
-- @usage client
-- Set the name label text.
--
-- @param  name string  The text to put in the label
function SetLabel( name) end

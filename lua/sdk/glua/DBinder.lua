---
-- @description Library DBinder
 module("DBinder")

--- DBinder:GetSelectedNumber
-- @usage client
-- Gets the code of the key currently bound by the DBinder. Same as DBinder:GetValue.
--
-- @return number The key code of the bound key. See KEY_ Enums.
function GetSelectedNumber() end

--- DBinder:GetValue
-- @usage client
-- Gets the code of the key currently bound by the DBinder. Same as DBinder:GetSelectedNumber.
--
-- @return number The key code of the bound key. See KEY_ Enums.
function GetValue() end

--- DBinder:SetSelected
-- @usage client
-- Sets the current key bound by the DBinder, and updates the button's text.
--
-- @param  keyCode number  The key code of the key to bind. See KEY_ Enums.
function SetSelected( keyCode) end

--- DBinder:SetSelectedNumber
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  keyCode number  The key code of the key to bind. See KEY_ Enums.
function SetSelectedNumber( keyCode) end

--- DBinder:SetValue
-- @usage client
-- Alias of DBinder:SetSelected.
--
-- @param  keyCode number  The key code of the key to bind. See KEY_ Enums.
function SetValue( keyCode) end

--- DBinder:UpdateText
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
function UpdateText() end

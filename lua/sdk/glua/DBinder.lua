--[[============================================================================
  Project spacebuild                                                           =
  Copyright Spacebuild project (http://github.com/spacebuild)                  =
                                                                               =
  Licensed under the Apache License, Version 2.0 (the "License");              =
   you may not use this file except in compliance with the License.            =
   You may obtain a copy of the License at                                     =
                                                                               =
  http://www.apache.org/licenses/LICENSE-2.0                                   =
                                                                               =
  Unless required by applicable law or agreed to in writing, software          =
  distributed under the License is distributed on an "AS IS" BASIS,            =
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.     =
  See the License for the specific language governing permissions and          =
   limitations under the License.                                              =
  ============================================================================]]

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

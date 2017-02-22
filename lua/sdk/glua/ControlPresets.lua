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

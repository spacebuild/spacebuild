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
-- @description Library ContextBase
 module("ContextBase")

--- ContextBase:ControlValues
-- @usage client
-- Called by spawnmenu functions (when creating a context menu) to fill this control with data.
--
-- @param  contextData table  A two-membered table:   string convar - The console variable to use. Calls ContextBase:SetConVar.  string label - The text to display inside the control's label.
function ControlValues( contextData) end

--- ContextBase:ConVar
-- @usage client
-- Returns the ConVar for the panel to change/handle, set by ContextBase:SetConVar
--
-- @return string The ConVar for the panel to change.
function ConVar() end

--- ContextBase:SetConVar
-- @usage client
-- Sets the ConVar for the panel to change/handle.
--
-- @param  cvar string  The ConVar for the panel to change.
function SetConVar( cvar) end

--- ContextBase:TestForChanges
-- @usage client
-- You should override this function and use it to check whether your convar value changed.
--
function TestForChanges() end

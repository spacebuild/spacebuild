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

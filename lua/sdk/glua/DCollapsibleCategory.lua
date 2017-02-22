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
-- @description Library DCollapsibleCategory
 module("DCollapsibleCategory")

--- DCollapsibleCategory:GetExpanded
-- @usage client
-- Returns whether the DCollapsibleCategory is expanded or not.
--
-- @return boolean If expanded it will return true.
function GetExpanded() end

--- DCollapsibleCategory:OnToggle
-- @usage client
-- Called by DCollapsibleCategory:Toggle.
--
function OnToggle() end

--- DCollapsibleCategory:SetAnimTime
-- @usage client
-- Sets the time in seconds it takes to expand the DCollapsibleCategory
--
-- @param  time number  The time in seconds it takes to expand
function SetAnimTime( time) end

--- DCollapsibleCategory:SetContents
-- @usage client
-- Sets the contents of the DCollapsibleCategory.
--
-- @param  pnl Panel  The panel, containing the contents for the DCollapsibleCategory, mostly an DScrollPanel
function SetContents( pnl) end

--- DCollapsibleCategory:SetExpanded
-- @usage client
-- Sets whether the DCollapsibleCategory is expanded or not upon opening the container
--
-- @param  expanded=true boolean  Whether it shall be expanded or not by default
function SetExpanded( expanded) end

--- DCollapsibleCategory:SetLabel
-- @usage client
-- Sets the name of the DCollapsibleCategory.
--
-- @param  label string  The label/name of the DCollapsibleCategory.
function SetLabel( label) end

--- DCollapsibleCategory:Toggle
-- @usage client
-- Toggles the expanded state of the DCollapsibleCategory.
--
function Toggle() end

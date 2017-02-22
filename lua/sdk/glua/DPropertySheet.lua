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
-- @description Library DPropertySheet
 module("DPropertySheet")

--- DPropertySheet:AddSheet
-- @usage client
-- Adds a new tab.
--
-- @param  name string  Name of the tab
-- @param  pnl Panel  Panel to be used as contents of the tab. This normally should be a DPanel
-- @param  icon=nil string  Icon for the tab. This will ideally be a silkicon, but any material name can be used.
-- @param  noStretchX=false boolean  Should DPropertySheet try to fill itself with given panel horizontally.
-- @param  noStretchY=false boolean  Should DPropertySheet try to fill itself with given panel vertically.
-- @param  tooltip=nil string  Tooltip for the tab when user hovers over it with his cursor
-- @return table A table containing the created DTab on its "Tab" key.
function AddSheet( name,  pnl,  icon,  noStretchX,  noStretchY,  tooltip) end

--- DPropertySheet:SetFadeTime
-- @usage client
-- Sets the amount of time (in seconds) it takes to fade between tabs.
--
-- @param  time=0.1 number  The amount of time it takes (in seconds) to fade between tabs.
function SetFadeTime( time) end

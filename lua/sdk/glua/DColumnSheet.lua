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
-- @description Library DColumnSheet
 module("DColumnSheet")

--- DColumnSheet:AddSheet
-- @usage client
-- Adds a new column/tab.
--
-- @param  name string  Name of the column/tab
-- @param  pnl Panel  Panel to be used as contents of the tab. This normally would be a DPanel
-- @param  icon=nil string  Icon for the tab. This will ideally be a silkicon, but any material name can be used.
function AddSheet( name,  pnl,  icon) end

--- DColumnSheet:SetActiveButton
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  active Panel  The button to make active button
function SetActiveButton( active) end

--- DColumnSheet:UseButtonOnlyStyle
-- @usage client
-- Makes the tabs/buttons show only the image and no text.
--
function UseButtonOnlyStyle() end

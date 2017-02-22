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
-- @description Library menubar
 module("menubar")

--- menubar.Init
-- @usage client
-- Creates the menu bar ( The bar at the top of the screen when holding C or Q in sandbox ) and docks it to the top of the screen. It will not appear.
--Calling this multiple times will NOT remove previous panel.
--
function Init() end

--- menubar.IsParent
-- @usage client
-- Checks if the supplied panel is parent to the menubar
--
-- @param  pnl Panel  The panel to check
-- @return boolean Is parent or not
function IsParent( pnl) end

--- menubar.ParentTo
-- @usage client
-- Parents the menubar to the panel and displays the menubar.
--
-- @param  pnl Panel  The panel to parent to
function ParentTo( pnl) end

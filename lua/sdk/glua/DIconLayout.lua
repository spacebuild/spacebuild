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
-- @description Library DIconLayout
 module("DIconLayout")

--- DIconLayout:Layout
-- @usage client
-- Resets layout vars before calling Panel:InvalidateLayout. This is called when children are added or removed, and must be called when the spacing, border or layout direction is changed.
--
function Layout() end

--- DIconLayout:SetBorder
-- @usage client
-- Sets the internal border (padding) within the DIconLayout. This will not change its size, only the positioning of children. You must call DIconLayout:Layout in order for the changes to take effect.
--
-- @param  width number  The border (padding) inside the DIconLayout.
function SetBorder( width) end

--- DIconLayout:SetSpaceX
-- @usage client
-- Sets the horizontal (x) spacing between children within the DIconLayout. You must call DIconLayout:Layout in order for the changes to take effect.
--
-- @param  xSpacing number  The width of the gap between child objects.
function SetSpaceX( xSpacing) end

--- DIconLayout:SetSpaceY
-- @usage client
-- Sets the vertical (y) spacing between children within the DIconLayout. You must call DIconLayout:Layout in order for the changes to take effect.
--
-- @param  ySpacing number  The vertical gap between rows in the DIconLayout.
function SetSpaceY( ySpacing) end

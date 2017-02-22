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
-- @description Library gui
 module("gui")

--- gui.ActivateGameUI
-- @usage client_m
-- Opens the game menu overlay.
--
function ActivateGameUI() end

--- gui.EnableScreenClicker
-- @usage client
-- Enables the mouse cursor without restricting player movement, like using Sandbox's Context Menu
--
-- @param  enabled boolean  Whether the cursor should be enabled or not. (true = enable, false = disable)
function EnableScreenClicker( enabled) end

--- gui.HideGameUI
-- @usage client_m
-- Hides the game menu overlay.
--
function HideGameUI() end

--- gui.InternalCursorMoved
-- @usage client_m
-- Simulates a mouse move with the given deltas.
--
-- @param  deltaX number  The movement delta on the x axis.
-- @param  deltaY number  The movement delta on the y axis.
function InternalCursorMoved( deltaX,  deltaY) end

--- gui.InternalKeyCodePressed
-- @usage client_m
-- Simulates a key press for the given key.
--
-- @param  key number  The key, see KEY_ Enums.
function InternalKeyCodePressed( key) end

--- gui.InternalKeyCodeReleased
-- @usage client_m
-- Simulates a key release for the given key.
--
-- @param  key number  The key, see KEY_ Enums.
function InternalKeyCodeReleased( key) end

--- gui.InternalKeyCodeTyped
-- @usage client_m
-- Simulates a key type typing to the specified key.
--
-- @param  key number  The key, see KEY_ Enums.
function InternalKeyCodeTyped( key) end

--- gui.InternalKeyTyped
-- @usage client_m
-- Simulates an ASCII symbol writing.
--Use to write text in the chat or in VGUI.
--Doesn't work while the main menu is open!
--
-- @param  code number  ASCII code of symbol, see http://www.mikroe.com/img/publication/spa/pic-books/programming-in-basic/chapter/04/fig4-24.gif
function InternalKeyTyped( code) end

--- gui.InternalMouseDoublePressed
-- @usage client_m
-- Simulates a double mouse key press for the given mouse key.
--
-- @param  key number  The key, see MOUSE_ Enums.
function InternalMouseDoublePressed( key) end

--- gui.InternalMousePressed
-- @usage client_m
-- Simulates a mouse key press for the given mouse key.
--
-- @param  key number  The key, see MOUSE_ Enums.
function InternalMousePressed( key) end

--- gui.InternalMouseReleased
-- @usage client_m
-- Simulates a mouse key release for the given mouse key.
--
-- @param  key number  The key, see MOUSE_ Enums.
function InternalMouseReleased( key) end

--- gui.InternalMouseWheeled
-- @usage client_m
-- Simulates a mouse wheel scroll with the given delta.
--
-- @param  delta number  The amount of scrolling to simulate.
function InternalMouseWheeled( delta) end

--- gui.IsConsoleVisible
-- @usage client_m
-- Returns whether the console is visible or not.
--
-- @return boolean Whether the console is visible or not.
function IsConsoleVisible() end

--- gui.IsGameUIVisible
-- @usage client_m
-- Returns whenever the game menu overlay ( main menu ) is open or not.
--
-- @return boolean Whenever the game menu overlay ( main menu ) is open or not
function IsGameUIVisible() end

--- gui.MousePos
-- @usage client_m
-- Returns the cursor's position on the screen
--
-- @return number mouseX
-- @return number mouseY
function MousePos() end

--- gui.MouseX
-- @usage client_m
-- Returns x component of the mouse position.
--
-- @return number mouseX
function MouseX() end

--- gui.MouseY
-- @usage client_m
-- Returns y component of the mouse position.
--
-- @return number mouseY
function MouseY() end

--- gui.OpenURL
-- @usage client_m
-- Opens specified URL in the steam overlay browser. The URL has to start with either http:// or https://
--
-- @param  url string  URL to open
function OpenURL( url) end

--- gui.ScreenToVector
-- @usage client
-- Converts the specified screen position to a direction vector local to the player's view.
--
-- @param  x number  X coordinate on the screen.
-- @param  y number  Y coordinate on the screen.
-- @return Vector Direction
function ScreenToVector( x,  y) end

--- gui.SetMousePos
-- @usage client_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Use input.SetCursorPos instead.
-- @param  mouseX number  The X coordinate to move the cursor to.
-- @param  mouseY number  The Y coordinate to move the cursor to.
function SetMousePos( mouseX,  mouseY) end

--- gui.ShowConsole
-- @usage menu
-- Shows console in the game UI.
--
function ShowConsole() end

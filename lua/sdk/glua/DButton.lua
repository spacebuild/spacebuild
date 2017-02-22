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
-- @description Library DButton
 module("DButton")

--- DButton:GetDrawBorder
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
-- @return boolean 
function GetDrawBorder() end

--- DButton:IsDown
-- @usage client
-- Returns true if the DButton is currently depressed (a user is clicking on it).
--
-- @return boolean Whether or not the button is depressed.
function IsDown() end

--- DButton:SetConsoleCommand
-- @usage client
-- Sets a console command to be called when the button is clicked.
--
-- @param  command string  The console command to be called.
-- @param  args string  The arguments for the command.
function SetConsoleCommand( command,  args) end

--- DButton:SetDisabled
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Use DButton:SetEnabled instead
-- @param  disable boolean  true to disable the button, false to enable it.
function SetDisabled( disable) end

--- DButton:SetDrawBorder
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
-- @param  draw boolean 
function SetDrawBorder( draw) end

--- DButton:SetEnabled
-- @usage client
-- Sets whether or not the DButton is enabled.
--
-- @param  enable boolean  true to enable the button, false to disable it.
function SetEnabled( enable) end

--- DButton:SetImage
-- @usage client
-- Sets an image to be displayed as the button's background.
--
-- @param  img=nil string  The image file to use, relative to /materials. If this is nil, the image background is removed.
function SetImage( img) end

--- DButton:UpdateColours
-- @usage client
-- A hook called from within DLabel's PANEL:ApplySchemeSettings to determine the color of the text on display.
--
-- @param  skin table  A table supposed to contain the color values listed above.
function UpdateColours( skin) end

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
-- @description Library DColorMixer
 module("DColorMixer")

--- DColorMixer:GetAlphaBar
-- @usage client
-- Return true if alpha bar is shown, false if not.
--
-- @return boolean Return true if shown, false if not.
function GetAlphaBar() end

--- DColorMixer:GetColor
-- @usage client
-- Returns the current selected color.
--
-- @return table The current selected color as a Color structure.
function GetColor() end

--- DColorMixer:GetPalette
-- @usage client
-- Return true if palette is shown, false if not.
--
-- @return boolean Return true if shown, false if not.
function GetPalette() end

--- DColorMixer:GetWangs
-- @usage client
-- Return true if the wangs are shown, false if not.
--
-- @return boolean Return true if shown, false if not.
function GetWangs() end

--- DColorMixer:SetAlphaBar
-- @usage client
-- Show/Hide the alpha bar in DColorMixer
--
-- @param  show boolean  Show / Hide the alpha bar
function SetAlphaBar( show) end

--- DColorMixer:SetColor
-- @usage client
-- Sets the color of DColorMixer
--
-- @param  color table  The color to set. See Color
function SetColor( color) end

--- DColorMixer:SetPalette
-- @usage client
-- Show or hide the palette panel
--
-- @param  enabled boolean  Show or hide the palette panel?
function SetPalette( enabled) end

--- DColorMixer:SetWangs
-- @usage client
-- Show / Hide the colors indicators in DColorMixer
--
-- @param  show boolean  Show / Hide the colors indicators
function SetWangs( show) end

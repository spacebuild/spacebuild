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
-- @description Library DLabel
 module("DLabel")

--- DLabel:DoClick
-- @usage client
-- This can be overridden; by default, it calls DLabel:Toggle.
--
function DoClick() end

--- DLabel:GetDisabled
-- @usage client
-- DLabel
-- @return boolean The disabled state of the label.
function GetDisabled() end

--- DLabel:GetFont
-- @usage client
-- DLabel
-- @return string The name of the font in use.
function GetFont() end

--- DLabel:GetIsToggle
-- @usage client
-- Returns whether the toggle functionality is enabled for a label. Set with DLabel:SetIsToggle.
--
-- @return boolean Whether or not toggle functionality is enabled.
function GetIsToggle() end

--- DLabel:GetToggle
-- @usage client
-- Returns the current toggle state of the label. This can be set with DLabel:SetToggle and toggled with DLabel:Toggle.
--
-- @return boolean The current toggle state.
function GetToggle() end

--- DLabel:OnToggled
-- @usage client
-- Called when the toggle state of the label is changed by DLabel:Toggle.
--
-- @param  toggleState boolean  The new toggle state.
function OnToggled( toggleState) end

--- DLabel:SetAutoStretchVertical
-- @usage client
-- Automatically adjusts the height of the label dependent of the height of the text inside of it.
--
-- @param  stretch boolean  Whenever to stretch the label vertically or not.
function SetAutoStretchVertical( stretch) end

--- DLabel:SetBright
-- @usage client
-- Sets the color of the text to the bright text color defined in the skin.
--
-- @param  bright boolean  Whenever to set the text to bright or not.
function SetBright( bright) end

--- DLabel:SetDark
-- @usage client
-- Sets the color of the text to the dark text color defined in the skin.
--
-- @param  dark boolean  Whenever to set the text to dark or not.
function SetDark( dark) end

--- DLabel:SetDisabled
-- @usage client
-- Sets the disabled state of the DLabel.
--
-- @param  disable boolean  true to disable the DLabel, false to enable it.
function SetDisabled( disable) end

--- DLabel:SetFont
-- @usage client
--  Arguments
-- @param  fontName string  The name of the font. See here for a list of existing fonts.  Alternatively, use surface.CreateFont to create your own custom font.
function SetFont( fontName) end

--- DLabel:SetIsToggle
-- @usage client
-- Enables or disables toggle functionality for a label. Retrieved with DLabel:GetIsToggle.
--
-- @param  allowToggle boolean  Whether or not to enable toggle functionality.
function SetIsToggle( allowToggle) end

--- DLabel:SetText
-- @usage client
-- Set the Text of the DLabel VGUI element.
--
-- @param  text string  The text.
function SetText( text) end

--- DLabel:SetTextColor
-- @usage client
-- Sets the text color for the DLabel.
--
-- @param  color table  The text color. Uses the Color structure.
function SetTextColor( color) end

--- DLabel:SetToggle
-- @usage client
-- Sets the toggle state of the label. This can be retrieved with DLabel:GetToggle and toggled with DLabel:Toggle.
--
-- @param  toggleState boolean  The toggle state to be set.
function SetToggle( toggleState) end

--- DLabel:Toggle
-- @usage client
-- Toggles the label's state. This can be set and retrieved with DLabel:SetToggle and DLabel:GetToggle.
--
function Toggle() end

--- DLabel:UpdateColours
-- @usage client
-- A hook called from within DLabel:ApplySchemeSettings to determine the color of the text on display.
--
-- @param  skin table  A table supposed to contain the color values listed above.
function UpdateColours( skin) end

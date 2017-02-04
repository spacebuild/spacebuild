---
-- @description Library DTextEntry
 module("DTextEntry")

--- DTextEntry:AllowInput
-- @usage client
-- Called whenever the value of the panel has been updated (whether by user input or otherwise).
--
-- @param  char string  The last character entered into the panel.
-- @return boolean Return true to prevent the value from changing, false to allow it.
function AllowInput( char) end

--- DTextEntry:CheckNumeric
-- @usage client
-- Returns whether a string is numeric or not.
--Always returns false if the DTextEntry:SetNumeric is set to false.
--
-- @param  strValue string  The string to check.
-- @return boolean Whether the string is numeric or not.
function CheckNumeric( strValue) end

--- DTextEntry:GetCursorColor
-- @usage client
-- Returns the cursor color of a DTextEntry.
--
-- @return table The color of the cursor as a Color structure.
function GetCursorColor() end

--- DTextEntry:GetNumeric
-- @usage client
-- Returns whether only numeric characters (123456789.-) can be entered into the DTextEntry.
--
-- @return boolean Whether the DTextEntry is numeric or not.
function GetNumeric() end

--- DTextEntry:GetTextColor
-- @usage client
-- Returns the text color of a DTextEntry.
--
-- @return table The color of the text as a Color structure.
function GetTextColor() end

--- DTextEntry:GetUpdateOnType
-- @usage client
-- Returns whether the DTextEntry is set to run DTextEntry:OnValueChange every time a character is typed or deleted or only when Enter is pressed.
--
-- @return boolean 
function GetUpdateOnType() end

--- DTextEntry:IsEditing
-- @usage client
-- Returns whether this DTextEntry is being edited or not. (i.e. has focus)
--
-- @return boolean Whether this DTextEntry is being edited or not
function IsEditing() end

--- DTextEntry:OnChange
-- @usage client
-- Called internally by DTextEntry:OnTextChanged when the user modifies the text in the DTextEntry.
--
function OnChange() end

--- DTextEntry:OnEnter
-- @usage client
-- Called whenever enter is pressed on a DTextEntry.
--
function OnEnter() end

--- DTextEntry:OnKeyCodeTyped
-- @usage client
-- Called whenever a valid character is typed while the text entry is focused.
--
-- @param  keyCode number  They key code of the key pressed, see KEY_ Enums.
-- @return boolean Whether you've handled the key press. Returning true prevents the default text entry behavior from occurring.
function OnKeyCodeTyped( keyCode) end

--- DTextEntry:OnTextChanged
-- @usage client
-- This is an internal function or feature.
--This means you will be able to use it, but you really shouldn't.
-- @param  noMenuRemoval boolean  Determines whether to remove the autocomplete menu (false) or not (true).
function OnTextChanged( noMenuRemoval) end

--- DTextEntry:OnValueChange
-- @usage client
-- Called internally when the text in the DTextEntry changes.
--
-- @param  value string  The DTextEntry text.
function OnValueChange( value) end

--- DTextEntry:SetFont
-- @usage client
-- Changes the font of the DTextEntry.
--
-- @param  font string  The name of the font to be changed to.
function SetFont( font) end

--- DTextEntry:SetNumeric
-- @usage client
-- Sets whether or not to decline non-numeric characters as input.
--
-- @param  numericOnly boolean  Whether to accept only numeric characters.
function SetNumeric( numericOnly) end

--- DTextEntry:SetUpdateOnType
-- @usage client
-- Sets whether we should fire DTextEntry:OnValueChange every time we type or delete a character or only when Enter is pressed.
--
-- @param  updateOnType boolean 
function SetUpdateOnType( updateOnType) end

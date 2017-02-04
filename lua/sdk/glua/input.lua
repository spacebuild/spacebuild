---
-- @description Library input
 module("input")

--- input.CheckKeyTrapping
-- @usage client_m
-- Returns the last key captured by key trapping.
--
-- @return number The key, see KEY_ Enums
function CheckKeyTrapping() end

--- input.GetCursorPos
-- @usage client_m
-- Returns the cursor's position on the screen
--
-- @return number mouseX
-- @return number mouseY
function GetCursorPos() end

--- input.GetKeyName
-- @usage client_m
-- Gets the name of the button index.
--
-- @param  button number  The button, see BUTTON_CODE_ Enums.
-- @return string Button name
function GetKeyName( button) end

--- input.IsButtonDown
-- @usage client_m
-- Gets whether the specified button code is down.
--
-- @param  button number  The button, valid values are in the range of BUTTON_CODE_ Enums.
-- @return boolean Is the button down
function IsButtonDown( button) end

--- input.IsControlDown
-- @usage client_m
-- Returns whether a control key is being pressed
--
-- @return boolean Is Ctrl key down or not
function IsControlDown() end

--- input.IsKeyDown
-- @usage client_m
-- Gets whether a key is down
--
-- @param  key number  The key, see KEY_ Enums.
-- @return boolean Is the key down
function IsKeyDown( key) end

--- input.IsKeyTrapping
-- @usage client_m
-- Returns whether key trapping is activate and the next key press will be captured.
--
-- @return boolean Whether key trapping active or not
function IsKeyTrapping() end

--- input.IsMouseDown
-- @usage client_m
-- Gets whether a mouse button is down
--
-- @param  mouseKey number  The key, see MOUSE_ Enums
-- @return boolean Is the key down
function IsMouseDown( mouseKey) end

--- input.IsShiftDown
-- @usage client_m
-- Gets whether a shift key is being pressed
--
-- @return boolean isDown
function IsShiftDown() end

--- input.LookupBinding
-- @usage client_m
-- Gets the match uppercase key for the specified binding.
--
-- @param  binding string  The binding name
-- @param  exact=false boolean  True if the binding should match exactly
-- @return string The first key found with that binding or no value
function LookupBinding( binding,  exact) end

--- input.LookupKeyBinding
-- @usage client_m
-- Returns the bind string that the given key is bound to.
--
-- @param  key number  Key from KEY_ Enums
-- @return string The bind string of the given key.
function LookupKeyBinding( key) end

--- input.SetCursorPos
-- @usage client_m
-- Sets the cursor's position on the screen, relative to the topleft corner of the window
--
-- @param  mouseX number  X coordinate for mouse position
-- @param  mouseY number  Y coordinate for mouse position
function SetCursorPos( mouseX,  mouseY) end

--- input.StartKeyTrapping
-- @usage client_m
-- Begins waiting for a key to be pressed so we can save it for input.CheckKeyTrapping. Used by the DBinder VGUI element.
--
function StartKeyTrapping() end

--- input.WasKeyPressed
-- @usage client_m
-- Returns whether a key was initially pressed in the same frame this function was called.
--
-- @param  key number  The key, see KEY_ Enums.
-- @return boolean True if the key was initially pressed the same frame that this function was called, false otherwise.
function WasKeyPressed( key) end

--- input.WasKeyReleased
-- @usage client_m
-- Returns whether a key was released in the same frame this function was called.
--
-- @param  key number  The key, see KEY_ Enums.
-- @return boolean True if the key was released the same frame that this function was called, false otherwise.
function WasKeyReleased( key) end

--- input.WasKeyTyped
-- @usage client_m
-- Returns whether the key is being held down or not.
--
-- @param  key number  The key to test, see KEY_ Enums
-- @return boolean Whether the key is being held down or not.
function WasKeyTyped( key) end

--- input.WasMouseDoublePressed
-- @usage client_m
-- Returns whether a mouse key was double pressed in the same frame this function was called.
--If this function returns true, input.WasMousePressed will return false.
--
-- @param  button number  The mouse button to test, see MOUSE_ Enums
-- @return boolean Whether the mouse key was double pressed or not.
function WasMouseDoublePressed( button) end

--- input.WasMousePressed
-- @usage client_m
-- Returns whether a mouse key was initially pressed in the same frame this function was called.
--If input.WasMouseDoublePressed returns true, this function will return false.
--
-- @param  key number  The key, see MOUSE_ Enums
-- @return boolean True if the mouse key was initially pressed the same frame that this function was called, false otherwise.
function WasMousePressed( key) end

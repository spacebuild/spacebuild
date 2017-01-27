---
-- @description Library chat
 module("chat")

--- chat.AddText
-- @usage client
-- Adds text to the local player's chat box (which only they can read).
--
-- @param  arguments vararg  The arguments. Arguments can be:   table - Color structure. Will set the color for all following strings until the next Color argument.  string - Text to be added to the chat box.  Player - Adds the name of the player in the player's team color to the chat box.  any - Any other type, such as Entity will be converted to string and added as text.
function AddText( arguments) end

--- chat.Close
-- @usage client
-- Closes the chat window.
--
function Close() end

--- chat.GetChatBoxPos
-- @usage client
-- Returns the chatbox position.
--
-- @return number The X coordinate of the chatbox's position.
-- @return number The Y coordinate of the chatbox's position.
function GetChatBoxPos() end

--- chat.GetChatBoxSize
-- @usage client
-- Returns the chatbox size.
--
-- @return number The width of the chatbox.
-- @return number The height of the chatbox.
function GetChatBoxSize() end

--- chat.Open
-- @usage client
-- Opens the chat window.
--
-- @param  mode number  If equals 1, opens public chat, otherwise opens team chat
function Open( mode) end

--- chat.PlaySound
-- @usage client
-- Plays the chat "tick" sound.
--
function PlaySound() end

---
-- @description Library usermessage
 module("usermessage")

--- usermessage.GetTable
-- @usage shared
-- Returns a table of every usermessage hook
--
-- @return table hooks
function GetTable() end

--- usermessage.Hook
-- @usage shared
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using net library instead
-- @param  name string  The message name to hook to.
-- @param  callback function  The function to be called if the specified message was received. Parameters (Optional):   bf_read msg  vararg preArgs
-- @param  preArgs=nil vararg  Arguments that are passed to the callback function when the hook is called. *ring ring*
function Hook( name,  callback,  preArgs) end

--- usermessage.IncomingMessage
-- @usage shared
-- Called by the engine when a usermessage arrives, this method calls the hook function specified by usermessage.Hook if any.
--
-- @param  name string  The message name.
-- @param  msg bf_read  The message.
function IncomingMessage( name,  msg) end

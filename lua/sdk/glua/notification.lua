---
-- @description Library notification
 module("notification")

--- notification.AddLegacy
-- @usage client_m
-- Adds a standard notification to your screen.
--
-- @param  Text string  The string to display
-- @param  Type number  Determines the method for displaying the notification. See the NOTIFY_ Enums
-- @param  Length number  The number of seconds to display the notification for
function AddLegacy( Text,  Type,  Length) end

--- notification.AddProgress
-- @usage client_m
-- Adds a notification with an animated progress bar.
--
-- @param  id any  Can be any type. It's used as an index.
-- @param  strText string  The text to show
function AddProgress( id,  strText) end

--- notification.Kill
-- @usage client_m
-- Removes the notification after 0.8 seconds.
--
-- @param  uid any  The unique ID of the notification
function Kill( uid) end

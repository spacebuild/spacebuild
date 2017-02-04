---
-- @description Library timer
 module("timer")

--- timer.Adjust
-- @usage shared_m
-- Adjusts the timer if the timer with the given identifier exists.
--
-- @param  identifier any  Identifier of the timer to adjust.
-- @param  delay number  The delay interval in seconds.
-- @param  repetitions number  Repetitions. Use 0 for infinite.
-- @param  func function  The new function.
-- @return boolean true if succeeded
function Adjust( identifier,  delay,  repetitions,  func) end

--- timer.Check
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
function Check() end

--- timer.Create
-- @usage shared_m
-- Creates a new timer.
--
-- @param  identifier string  Identifier of the timer to create. Must be unique.
-- @param  delay number  The delay interval in seconds. If the delay is too small, the timer will fire on the next frame/tick.
-- @param  repetitions number  The number of times to repeat the timer. Enter 0 for infinite repetitions.
-- @param  func function  Function called when timer has finished the countdown.
function Create( identifier,  delay,  repetitions,  func) end

--- timer.Destroy
-- @usage shared_m
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--You should be using timer.Remove instead.
-- @param  identifier string  Identifier of the timer to destroy.
function Destroy( identifier) end

--- timer.Exists
-- @usage shared_m
-- Returns whenever the given timer exists or not.
--
-- @param  identifier string  Identifier of the timer.
-- @return boolean Returns true if the timer exists, false if it doesn't
function Exists( identifier) end

--- timer.Pause
-- @usage shared_m
-- Pauses the given timer.
--
-- @param  identifier any  Identifier of the timer.
-- @return boolean false if the timer didn't exist or was already paused, true otherwise.
function Pause( identifier) end

--- timer.Remove
-- @usage shared_m
-- Stops and removes the timer.
--
-- @param  identifier string  Identifier of the timer to remove.
function Remove( identifier) end

--- timer.RepsLeft
-- @usage shared_m
-- Returns amount of repetitions/executions left before the timer destroys itself.
--
-- @param  identifier any  Identifier of the timer.
-- @return number The amount of executions left.
function RepsLeft( identifier) end

--- timer.Simple
-- @usage shared_m
-- Runs the given function after a specified delay.
--
-- @param  delay number  How long until the function should be ran (in seconds).
-- @param  func function  The function to run after the specified delay.
function Simple( delay,  func) end

--- timer.Start
-- @usage shared_m
-- Restarts the given timer.
--
-- @param  identifier any  Identifier of the timer.
-- @return boolean true if the timer exists, false if it doesn't.
function Start( identifier) end

--- timer.Stop
-- @usage shared_m
-- Stops the given timer.
--
-- @param  identifier any  Identifier of the timer.
-- @return boolean false if the timer didn't exist or was already stopped, true otherwise.
function Stop( identifier) end

--- timer.TimeLeft
-- @usage shared_m
-- Returns amount of time left (in seconds) before the timer executes its function.
--
-- @param  identifier any  Identifier of the timer.
-- @return number The amount of time left (in seconds).
function TimeLeft( identifier) end

--- timer.Toggle
-- @usage shared_m
-- Runs either timer.Pause or timer.UnPause based on the timer's current status.
--
-- @param  identifier any  Identifier of the timer.
-- @return boolean status of the timer.
function Toggle( identifier) end

--- timer.UnPause
-- @usage shared_m
-- Unpauses the timer.
--
-- @param  identifier any  Identifier of the timer.
-- @return boolean false if the timer didn't exist or was already running, true otherwise.
function UnPause( identifier) end

---
-- @description Library coroutine
 module("coroutine")

--- coroutine.create
-- @usage shared_m
-- Creates a coroutine of the given function.
--
-- @param  func function  The function for the coroutine to use
-- @return thread coroutine
function create( func) end

--- coroutine.resume
-- @usage shared_m
-- Resumes the given coroutine and passes the given vararg to either the function arguments or the coroutine.yield that is inside that function and returns whatever yield is called with the next time or by the final return in the function.
--
-- @param  coroutine thread  Coroutine to resume.
-- @param  args vararg  Arguments to be returned by coroutine.yield.
-- @return boolean If the executed thread code had no errors occur within it.
-- @return vararg If an error occured, this will be a string containing the error message. Otherwise, this will be arguments that were yielded.
function resume( coroutine,  args) end

--- coroutine.running
-- @usage shared_m
-- Returns the active coroutine or nil if we are not within a coroutine.
--
-- @return thread coroutine
function running() end

--- coroutine.status
-- @usage shared_m
-- Returns the status of the coroutine passed to it, the possible statuses are "suspended", "running", and "dead".
--
-- @param  coroutine thread  Coroutine to check the status of.
-- @return string status
function status( coroutine) end

--- coroutine.wait
-- @usage shared
-- Yield's the coroutine for so many seconds before returning.
--
-- @param  seconds number  The number of seconds to wait
function wait( seconds) end

--- coroutine.wrap
-- @usage shared_m
-- Returns a function which calling is equivalent with calling coroutine.resume with the coroutine and all extra parameters.
--
-- @param  coroutine function  Coroutine to resume.
-- @return function func
function wrap( coroutine) end

--- coroutine.yield
-- @usage shared_m
-- Pauses the active coroutine and passes all additional variables to the call of coroutine.resume that resumed the coroutine last time, and returns all additional variables that were passed to the previous call of resume.
--
-- @param  returnValue vararg  Arguments to be returned by the last call of coroutine.resume
-- @return vararg Arguments that were set previously by coroutine.resume
function yield( returnValue) end

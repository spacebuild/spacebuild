---
-- @description Library debug
 module("debug")

--- debug.debug
-- @usage shared_m
-- Enters an interactive mode with the user, running each string that the user enters. Using simple commands and other debug facilities, the user can inspect global and local variables, change their values, evaluate expressions, and so on. A line containing only the word cont finishes this function, so that the caller continues its execution.
--
function debug() end

--- debug.getfenv
-- @usage shared_m
-- Returns the environment of the passed object. This can be set with debug.setfenv
--
-- @param  object table  Object to get environment of
-- @return table Environment
function getfenv( object) end

--- debug.gethook
-- @usage shared_m
-- Returns the current hook settings of the passed thread. The thread argument can be omitted. This is unrelated to gamemode hooks. More information on hooks can be found at http://www.lua.org/pil/23.2.html
--
-- @param  thread=nil thread  Which thread to retrieve its hook from
-- @return function Hook function
-- @return string Hook mask
-- @return number Hook count
function gethook( thread) end

--- debug.getinfo
-- @usage shared_m
-- Returns debug information about a function.
--
-- @param  funcOrStackLevel function  Takes either a function or a stack level as an argument (stack level 0 always corresponds to the debug.getinfo call).  Returns useful information about that function in a table.
-- @param  fields="flnSu" string  A string whose characters specify the information to be retrieved. f - Populates the func field. l - Populates the currentline field. n - Populates the name and namewhat fields - only works if stack level is passed rather than function pointer. S - Populates the location fields (lastlinedefined, linedefined, short_src, source and what). u - Populates the argument and upvalue fields (isvararg, nparams, nups)  
-- @return table A table as a DebugInfo structure containing information about the function you passed.
function getinfo( funcOrStackLevel,  fields) end

--- debug.getlocal
-- @usage shared_m
-- Gets the name and value of a local variable indexed from the level
--
-- @param  thread=Current thread thread  The thread
-- @param  level number  The level above the thread. 0 = the function that was called (most always this function)'s arguments 1 = the thread that had called this function. 2 = the thread that had called the function that started the thread that called this function.  A function defined in Lua can also be passed as the level. The index will specify the parameter's name to be returned (a parameter will have a value of nil).
-- @param  index number  The variable's index you want to get. 1 = the first local defined in the thread 2 = the second local defined in the thread  etc...
-- @return string The name of the variable Sometimes this will be "(*temporary)" if the local variable had no name.    NOTE  Variables with names starting with ( are internal variables. 
-- @return any The value of the local variable.
function getlocal( thread,  level,  index) end

--- debug.getmetatable
-- @usage shared_m
-- Returns the metatable of an object. This function ignores the metatable's __metatable field.
--
-- @param  object any  The object to retrieve the metatable from.
-- @return table The metatable of the given object.
function getmetatable( object) end

--- debug.getregistry
-- @usage shared_m
-- Returns the internal Lua registry table.
--
-- @return table Registry
function getregistry() end

--- debug.getupvalue
-- @usage shared_m
-- Used for getting variable values in an index from the passed function
--
-- @param  func function  Function to get the upvalue indexed from
-- @param  index number  The index from func
-- @return string The function returns nil if there is no upvalue with the given index, otherwise the name of the upvalue is returned
-- @return any Value of the upvalue.
function getupvalue( func,  index) end

--- debug.setfenv
-- @usage shared_m
-- Sets the environment of the passed object.
--
-- @param  object table  Object to set environment of
-- @param  env table  Environment to set
-- @return table The object
function setfenv( object,  env) end

--- debug.sethook
-- @usage shared_m
-- Sets the given function as a Lua hook. This is completely different to gamemode hooks. The thread argument can be completely omitted and calling this function with no arguments will remove the current hook. This is used by default for infinite loop detection. More information on hooks can be found at http://www.lua.org/pil/23.2.html
--
-- @param  thread thread  Thread to set the hook on. This argument can be omited
-- @param  hook function  Function for the hook to call
-- @param  mask string  The hook's mask
-- @param  count number  How often to call the hook (in instructions). 0 for every instruction
function sethook( thread,  hook,  mask,  count) end

--- debug.setlocal
-- @usage shared_m
-- Sets a local variable's value.
--
-- @param  thread=Current Thread thread  The thread
-- @param  level number  The level above the thread. 0 is the function that was called (most always this function)'s arguments 1 is the thread that had called this function.  2 is the thread that had called the function that started the thread that called this function.
-- @param  index number  The variable's index you want to get. 1 = the first local defined in the thread  2 = the second local defined in the thread
-- @param  value=nil any  The value to set the local to
-- @return string The name of the local variable if the local at the index exists, otherwise nil is returned.
function setlocal( thread,  level,  index,  value) end

--- debug.setmetatable
-- @usage shared_m
-- Sets the table's metatable.
--
-- @param  object table  The table to set the metatable for.
-- @param  metatable table  The metatable to set for the table.  If metatable is nil, then the object's metatable is removed.
-- @return table object is returned
function setmetatable( object,  metatable) end

--- debug.setupvalue
-- @usage shared_m
-- Sets the variable indexed from func
--
-- @param  func function  The function to index the upvalue from
-- @param  index number  The index from func
-- @param  val=nil any  The value to set the upvalue to.
-- @return string Returns nil if there is no upvalue with the given index, otherwise it returns the upvalue's name.
function setupvalue( func,  index,  val) end

--- debug.Trace
-- @usage shared_m
-- Prints out the lua function call stack to the console.
--
function Trace() end

--- debug.traceback
-- @usage shared_m
-- Returns a full execution stack trace.
--
-- @param  thread=current thread thread  Thread (ie. error object from xpcall error handler) to build traceback for.
-- @param  message=nil string  Appended at the beginning of the traceback.
-- @param  level=1 number  Which level to start the traceback.
-- @return string A dump of the execution stack.
function traceback( thread,  message,  level) end

--- debug.upvalueid
-- @usage shared_m
-- Returns an unique identifier for the upvalue indexed from func
--
-- @param  func function  The function to index the upvalue from
-- @param  index number  The index from func
-- @return userdata A unique identifier
function upvalueid( func,  index) end

--- debug.upvaluejoin
-- @usage shared_m
-- Make the n1-th upvalue of the Lua closure f1 refer to the n2-th upvalue of the Lua closure f2.
--
-- @param  f1 function 
-- @param  n1 number 
-- @param  f2 function 
-- @param  n2 number 
function upvaluejoin( f1,  n1,  f2,  n2) end

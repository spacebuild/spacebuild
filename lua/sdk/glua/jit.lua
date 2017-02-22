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
-- @description Library jit
 module("jit")

--- jit.arch
-- @usage shared_m
-- No description
function arch() end

--- jit.attach
-- @usage shared_m
-- You can attach callbacks to a number of compiler events with jit.attach. The callback can be called:
--
-- @param  callback function  The callback function. The arguments passed to the callback depend on the event being reported:  "bc":  function func - The function that's just been recorded  "trace":  string what - description of the trace event: "flush", "start", "stop", "abort". Available for all events. number tr - The trace number. Not available for flush. function func - The function being traced. Available for start and abort. number pc - The program counter - the bytecode number of the function being recorded (if this a Lua function). Available for start and abort. number otr - start: the parent trace number if this is a side trace, abort: abort code string oex - start: the exit number for the parent trace, abort: abort reason (string)  "record":  number tr - The trace number. Not available for flush. function func - The function being traced. Available for start and abort. number pc - The program counter - the bytecode number of the function being recorded (if this a Lua function). Available for start and abort. number depth - The depth of the inlining of the current bytecode.  "texit":  number tr - The trace number. Not available for flush. number ex - The exit number number ngpr - The number of general-purpose and floating point registers that are active at the exit.  number nfpr - The number of general-purpose and floating point registers that are active at the exit.
-- @param  event string  The event to hook into.
function attach( callback,  event) end

--- jit.flush
-- @usage shared_m
-- Flushes the whole cache of compiled code.
--
function flush() end

--- jit.off
-- @usage shared_m
-- Disables LuaJIT Lua compilation.
--
function off() end

--- jit.on
-- @usage shared_m
-- Enables LuaJIT Lua compilation.
--
function on() end

--- jit.opt.start
-- @usage shared_m
-- JIT compiler optimization control. The opt sub-module provides the backend for the -O command line LuaJIT option.
--You can also use it programmatically, e.g.:
--
-- @param  args vararg 
function opt.start( args) end

--- jit.os
-- @usage shared_m
-- No description
function os() end

--- jit.status
-- @usage shared_m
-- Returns the status of the JIT compiler and the current optimizations enabled.
--
-- @return boolean Is JIT enabled
-- @return any Strings for CPU-specific features and enabled optimizations
function status() end

--- jit.util.funcbc
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  func function  Function to retrieve bytecode from.
-- @param  pos number  Position of the bytecode to retrieve.
-- @return number bytecode instruction
-- @return number bytecode opcode
function util.funcbc( func,  pos) end

--- jit.util.funcinfo
-- @usage shared_m
-- Retrieves LuaJIT information about a given function, similarly to debug.getinfo. Possible table fields:
--
-- @param  func function  Function to retrieve info about.
-- @param  pos=0 number 
-- @return table Information about the supplied function.
function util.funcinfo( func,  pos) end

--- jit.util.funck
-- @usage shared_m
-- Gets a constant at a certain index in a function.
--
-- @param  func function  Function to get constant from
-- @param  index number  Constant index (counting down from the top of the function at -1)
-- @return any the constant found
function util.funck( func,  index) end

--- jit.util.funcuvname
-- @usage shared_m
-- Does the exact same thing as debug.getupvalue except it only returns the name, not the name and the object. The upvalue index also starts at 0 rather than 1, so doing jit.util.funcuvname(func, 0) will get you the same name as debug.getupvalue(func, 1)
--
-- @param  func function  function to retrieve upvalue name from
-- @param  index number  upvalue index
-- @return string upvalue name
function util.funcuvname( func,  index) end

--- jit.util.ircalladdr
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  index number 
-- @return number address
function util.ircalladdr( index) end

--- jit.util.traceexitstub
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  exitno number  exit number to retrieve exit stub address from (gotten via jit.attach with the texit event)
-- @return number exitstub trace address
function util.traceexitstub( exitno) end

--- jit.util.traceinfo
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  trace number  trace index to retrieve info for (gotten via jit.attach)
-- @return table trace info
function util.traceinfo( trace) end

--- jit.util.traceir
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  tr number 
-- @param  index number 
-- @return number m
-- @return number ot
-- @return number op1
-- @return number op2
-- @return number prev
function util.traceir( tr,  index) end

--- jit.util.tracek
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  tr number 
-- @param  index number 
-- @return any k
-- @return number t
-- @return number slot; optional
function util.tracek( tr,  index) end

--- jit.util.tracemc
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  tr number 
-- @return string mcode
-- @return number address
-- @return number loop
function util.tracemc( tr) end

--- jit.util.tracesnap
-- @usage shared_m
-- This article is a stub.
--Please help the Garry's Mod wiki by adding to it.
-- @param  tr number  trace index to retrieve snapshot for (gotten via jit.attach)
-- @param  sn number  snapshot index for trace (starting from 0 to nexit - 1, nexit gotten via jit.util.traceinfo)
-- @return table snapshot
function util.tracesnap( tr,  sn) end

--- jit.version
-- @usage shared_m
-- No description
function version() end

--- jit.version_num
-- @usage shared_m
-- No description
function version_num() end

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
-- @description Library DHTML
 module("DHTML")

--- DHTML:AddFunction
-- @usage client
-- Defines a Javascript function that when called will call a Lua callback.
--
-- @param  library string  Library name of the JS function you are defining.
-- @param  name string  Name of the JS function you are defining.
-- @param  callback function  Function called when the JS function is called. Arguments passed to the JS function will be passed here.
function AddFunction( library,  name,  callback) end

--- DHTML:Call
-- @usage client
-- Runs/Executes a string as JavaScript code.
--
-- @param  js string  Specify JavaScript code to be executed.
function Call( js) end

--- DHTML:ConsoleMessage
-- @usage client
-- Called when the page inside the DHTML window runs console.log. This can also be called within the Lua environment to emulate console.log. If the contained message begins with RUNLUA: the following text will be executed as code within the Lua environment (this is how Lua is called from DHTML windows).
--
-- @param  msg string  The message to be logged (or Lua code to be executed; see above).
function ConsoleMessage( msg) end

--- DHTML:GetAllowLua
-- @usage client
-- Returns if the loaded page can run Lua code, set by DHTML:SetAllowLua
--
-- @return boolean Whether or not Lua code can be called from the loaded page.
function GetAllowLua() end

--- DHTML:SetAllowLua
-- @usage client
-- Determines whether the loaded page can run Lua code or not. See DHTML for how to run Lua from a DHTML window.
--
-- @param  allow=false boolean  Whether or not to allow Lua.
function SetAllowLua( allow) end

--- DHTML:SetScrollbars
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--Broken. Use the CSS overflow rule instead.
-- @param  show boolean  True if scrollbars should be visible.
function SetScrollbars( show) end

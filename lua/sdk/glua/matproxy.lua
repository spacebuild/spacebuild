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
-- @description Library matproxy
 module("matproxy")

--- matproxy.Add
-- @usage client
-- Adds a material proxy.
--
-- @param  MatProxyData table  The information about the proxy. See MatProxyData structure
function Add( MatProxyData) end

--- matproxy.Call
-- @usage client
-- Called by the engine from OnBind
--
-- @param  uname string 
-- @param  mat IMaterial 
-- @param  ent Entity 
function Call( uname,  mat,  ent) end

--- matproxy.Init
-- @usage client
-- Called by the engine from OnBind
--
-- @param  name string 
-- @param  uname string 
-- @param  mat IMaterial 
-- @param  values table 
function Init( name,  uname,  mat,  values) end

--- matproxy.ShouldOverrideProxy
-- @usage client
-- Called by engine, returns true if we're overriding a proxy
--
-- @param  name string  The name of proxy in question
-- @return boolean Are we overriding it?
function ShouldOverrideProxy( name) end

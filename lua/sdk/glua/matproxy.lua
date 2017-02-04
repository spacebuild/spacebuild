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

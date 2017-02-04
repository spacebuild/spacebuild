---
-- @description Library package
 module("package")

--- package.seeall
-- @usage shared_m
-- Sets a metatable for module with its __index field referring to the global environment, so that this module inherits values from the global environment. To be used as an option to module.
--
-- @param  module table  The module table to be given a metatable
function seeall( module) end

--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 2/11/12
-- Time: 11:13
-- To change this template use File | Settings | File Templates.
--

local setmetatable = setmetatable
local pairs = pairs
local rawset = rawset

module("readOnlyList")

local list = {}
list.__index = list

function list:__newindex(key, value)
   return
end

function list:register(name, value)
   if not self[name] then
       rawset(self, name, value)
   end
end

function list:get(name)
    return self[name]
end

local addons
function list:getaddons()
   addons = {}
   for k, v in pairs(self) do
      if k ~= "register" and k ~= "get" and k ~= "getaddons" then
         addons[k] = v
       end
   end
   return addons
end

function create()
    local tmp = {}
    setmetatable(tmp, list)
    return tmp
end
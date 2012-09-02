include("sb/addons/spacebuild.lua");

local A = ADDON
local sb = sb;

local oldConstruct = A.construct
function A:construct(config)
    oldConstruct(self, config)
end
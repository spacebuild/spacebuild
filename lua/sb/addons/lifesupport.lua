include("sb/addons/base_addon.lua");

local A = ADDON
local sb = sb;

local oldConstruct = A.construct
function A:construct(config)
    oldConstruct(self, config)
    self.version = 0.1
    self.name = "Life Support"
end


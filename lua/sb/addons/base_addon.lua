-- Lua Specific
local string = string
-- Addon specific
local A = ADDON
local sb = sb;

local generated_key
local EMPTY_TABLE = {}

function A:construct(config)
    -- Basic implementation: override in your own addon
    self.hidden = true
    self.active = false
    self.version = 1
    self.name = "Base Addon"
    self.config = config or EMPTY_TABLE
end

function A:isActive()
    return self.active
end

function A:start()
    -- Basic implementation: override in your own addon
    self.active = true
end

function A:stop()
    -- Basic implementation: override in your own addon
    self.active = false
end

function A:isHidden()
    return self.hidden
end

function A:setHidden(hidden)
    self.hidden = hidden
end

function A:getVersion()
    return self.version
end

function A:getName()
    return self.name
end

function A:getConfig()
    return self.config
end

function A:setConfig(config)
    self.config = config
end

function A:getDependancies()
    return EMPTY_TABLE
end

--This requires a name to be set, if the name remains the default, this will cause conflicts!!
function A:getSyncKey()
    --Since the name shouldn't change we are only going to generate it once!!
    if not generated_key then
        generated_key = 23
        for k, v in self.name do
            generated_key = generated_key * (string.byte(v) - 64) -- A = 65, a = 97
        end
        generated_key = generated_key + string.len(self.name)
        --generated_key = generated_key %  2,147,483,647 --We don't want more then a LONG INTEGER
        generated_key = generated_key % 32, 767 --We don't want more then a SHORT INTEGER
    end
    return generated_key;
end